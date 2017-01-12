from posthaste import PostHaste
from posthaste.email_alert import send_alert
import os, sys
from check_activity import load_login
import summary_updater_metadata
import psycopg2
from datetime import datetime


S_VAR_TAB = {'wind direction': 'wind speed'}

class updateSummaries (object):
    """
    for updating summary tables in the imiq database
    """
    
    ## location of local sql scripts
    sql_rt = summary_updater_metadata.sql_rt
    
    ## information on tables and functions for each variable
    metadata = summary_updater_metadata.metadata
    
    
    def __init__ (self, login, var, sources):
        """
        Class initialiser 
        
        inputs:
            login: path to login credidentials, a yaml file <string>
            var: a variable in metadata <string>
            source: list of source ids
        
        """
        self.host, self.db, self.user, self.pswd = load_login(login)
        self.var = var
        self.sources = sources
        self.errors = []
        self.varids = {}
        self.ignore_sites = []
        self.log = []
        
        
        
    def set_varid (self, src, var):
        """
        set variable ids for a source id manually 
        
        inputs:
            src: a source id <int>
            var: varids <list if ints>
            
        
        """
        self.varids[src] = var
        
    def initilize_varids(self, use_vars = []):
        """
        initilize varids from seriescatalogue on imiq
        """
        
        sql = """
        select distinct(variableid) from tables.seriescatalog 
        where sourceid = SOURCE_ID and lower(variablename) like 'VAR' and
              not variableunitsid = 137
              """
        for source in self.sources:
            s_set = False
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.sql = sql.replace('SOURCE_ID', str(source))\
                       .replace('VAR',self.var)
            s.run()
            if len(s.as_DataFrame()) == 0:
                continue
            elif len(s.as_DataFrame()) != 1:
                # do i know which var to use?
                l = s.as_DataFrame().values.T.tolist()[0]
                for i in l:
                    #~ print i, s_set
                    if i in use_vars and s_set == False:
                        self.varids[source] = [i]
                        s_set = True
                    elif i in use_vars and s_set != False:
                        self.varids[source] = self.varids[source] + [i]
                msg = 'Source ' + str(source) +\
                                'has more that one possible variable'
                self.errors.append(msg)
                continue
            varid = int(s.as_DataFrame()[0])
            self.varids[source] = [varid]
            
    def get_secondary_varid (self, source, secondary_var):
        """
        get a secondary var id
        """
        
        sql = """
        select distinct(variableid) from tables.seriescatalog 
        where sourceid = SOURCE_ID and lower(variablename) like 'VAR' and
              not variableunitsid = 137
              """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('SOURCE_ID', str(source))\
                   .replace('VAR',secondary_var)
        s.run()
        if len(s.as_DataFrame()) == 0:
            msg = 'Source ' + str(source) + 'has no possible secondary ' + \
            'variable for ' + secondary_var
            self.errors.append(msg)
            return 'Null'

        elif len(s.as_DataFrame()) != 1:
            msg = 'Source ' + str(source) + 'has more that one possible ' + \
                'secondary variable for ' + secondary_var
            self.errors.append(msg)
            return 'Null'
        varid = int(s.as_DataFrame()[0])
        return varid
      
    def get_siteids(self, source):
        """
        returns imiq sitids for an imiq source
        
        inputs:
            source: a sourceid <int>
            
        outputs: 
            returns list of siteids <list of ints>
        """
        
        sql = """
        SELECT distinct siteid from tables.seriescatalog where sourceid =  SRCID
              """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('SRCID', str(source))
        s.run()
        return s.as_DataFrame()[0].tolist()
              
    def get_source_count_from_datavalues_table (self, time, srcid, varid):
        """
            get the number of values in a "datavalues" table on imiq for a 
        given source
        
        inputs:
            time: 'daily' or 'hourly' <string>
            srcid: a source id <int>
            varid: a variable id <int>
            
        outputs:
            returns count >= 0 <int>
        """
        c = 0
        for site in self.get_siteids(srcid):
            c += self.get_site_count_from_datavalues_table(time, site, varid)
        return c
        
    def get_site_count_from_datavalues_table (self, time, siteid, varid):
        """
            get the number of values in a "datavalues" table on imiq for a 
        given source
        
        inputs:
            time: 'daily' or 'hourly' <string>
            siteid: a site id <int>
            varid: a variable id <int>
            
        outputs:
            returns count >= 0 <int>
        """
        sql = """
        select count(*) from tables.TABLE
        where siteid = SITEID and originalvariableid=VARID
        """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('TABLE', self.metadata[self.var][time]['table'])\
                   .replace('SITEID', str(siteid))\
                   .replace('VARID', str(varid))

        s.run()
        return int(s.as_DataFrame()[0])
        
        
    def delete_source_from_datavalues_table (self, time, srcid, varid):
        """
        delete values in a "datavalues" table on imiq, for a given source
        
        inputs:
            time: 'daily' or 'hourly' <string>
            srcid: a source id <int>
            varid: a variable id <int>
        """
        for site in self.get_siteids(srcid):
            self.delete_site_from_datavalues_table(time, site, varid)
        
    def delete_site_from_datavalues_table (self, time, siteid, varid):
        """
        delete values in a "datavalues" table on imiq, for a given source
        
        inputs:
            time: 'daily' or 'hourly' <string>
            siteid: a site id <int>
            varid: a variable id <int>
        """
        
        sql = """
        delete from tables.TABLE where siteid = SITEID 
                                       and originalvariableid=VARID
        """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('TABLE', self.metadata[self.var][time]['table'])\
                   .replace('SITEID', str(siteid))\
                   .replace('VARID', str(varid))

        s.run()
        
    def update_db_functions (self):
        """
        update the instert funcion on the database from local sources
        """
        # update main functions
        for time in ['daily','hourly']:
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.open(self.metadata[self.var][time]['sql'])
            s.run()
        # update any 'extra' functions
        if 'component functions' in self.metadata[self.var].keys():
            for func in self.metadata[self.var]['component functions']:
                s = PostHaste(self.host,self.db,self.user,self.pswd)
                s.open(func)
                s.run()
                
    def excute_db_function (self, time, siteid, varid, s_varid = None):
        """
        excute an insert function on the database
        
        inputs:
            time: 'daily' or 'hourly' <string>
            siteid: a site id <int>
            varid: a variable id <int>
        """
        
        sql = """
        select tables.FUNCTION(SITE, VAR);
              """
        # secondary var neede
        if not s_varid is None:
            sql = """
                select tables.FUNCTION(SITE, VAR, S_VAR);
              """
              

        if siteid in self.ignore_sites:
            print "ignoring site:", siteid, "var:", varid
            return 
        try:
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.sql = sql\
                   .replace('FUNCTION', self.metadata[self.var][time]['fn'])\
                   .replace('SITE', str(siteid))\
                   .replace('VAR', str(varid)).replace('S_VAR',str(s_varid))
            s.run()
        except psycopg2.DataError:
            print "cannot execute:", siteid, "var:", varid
            return
    
    def update_datavalues_tables (self, intervals = ['daily','hourly']):
        """
        update the data values tables for sources
        
        
        """
        for source in self.sources:
            try:
                source_vars = self.varids[source]
            except KeyError:
                continue
            for varid in source_vars:
                self.log.append( str(source) + ', ' + str(varid))
                print self.log[-1]
                for time in intervals:
                    
                    init_count = self.get_source_count_from_datavalues_table(time, 
                                                                            source,
                                                                            varid)
                    
                    self.log.append('-- ' + str(time) + ' init count:' + str(init_count))
                    print self.log[-1]
                    ## check if secondary var needed
                    if self.var in S_VAR_TAB.keys():
                        s_var = S_VAR_TAB[self.var]
                    
                        self.update_dv_table(time, self.get_siteids(source),
                                            varid, s_varid)
                    else:
                        self.update_dv_table(time, self.get_siteids(source),
                                            varid)
                    
                    post_count = self.get_source_count_from_datavalues_table(time, 
                                                                             source,
                                                                             varid)
                    self.log.append('-- ' + str(time) + ' post count:' + str(post_count))
                    print self.log[-1]
                    if post_count < init_count:
                        print " -- ERR: LESS"
                        self.errors.append('Source ' +str(source) + "failure")
    
    def update_dv_table (self, time, sites, varid, s_varid = None):
        """
        """
        for site in sites:
            self.log.append('---- ' + str(site) + ', ' + str(varid))
            print self.log[-1]
            self.delete_site_from_datavalues_table(time, site, varid)
            self.excute_db_function(time, site, varid, s_varid)
                    
    def create_new_summary_tables (self):
        """
        create a new summary table on imiq
        """
        for table in self.metadata[self.var]['summaries']:
            self.log.append('updating table: ' + str(table) )
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            print self.log[-1]
            s.open(table)
            s.run()
            
        
                    
                

def main ():
    from posthaste.clite import CLIte
    flags = CLIte(['--login'],['--variable','--sourceids',
                               '--varid','--siteids','--ignore', 
                               '--email', '--intervals', '--use_vars',
                               '--DV_tables_only'])
    
    
    start = datetime.now()
    
    ERROR = None
    
    try:
        use_vars = []
        if not flags['--use_vars'] is None:
            use_vars = [int(i) for i in flags['--use_vars'][1:-1].split(',')]
        
        intervals = ['daily','hourly']
        if not flags['--intervals'] is None:
            itemp = [i for i in flags['--intervals'][1:-1].split(',')]
            print itemp
            for i in itemp:
                if i not in intervals:
                    raise ValueError, "Input Intervals must be in ['daily','hourly']" 
            intervals = itemp
            
        
        
        try:
            srcids = [int(i) for i in flags['--sourceids'][1:-1].split(',')]
        except:
            srcids = []
        update = updateSummaries(flags['--login'], flags['--variable'], srcids)
        #range(248,258+1) + [29,30,31,34,223, 145, 144] + [ 209, 202, 1, 203, 182, 182, 35, 213]) 
        if not flags['--ignore'] is None:
            update.ignore_sites = [int(i) for i in flags['--ignore'][1:-1].split(',')]
        
        
        
        # get var ids to update
        update.initilize_varids(use_vars)
        # update the database functions from local sources
        update.update_db_functions()
        # update datavalues tables
        update.update_datavalues_tables(intervals)
        #~ print update.errors
        update.log.append('DataValues Updated')
        print update.log[-1]
        if not '--DV_tables_only' is None:
            update.log.append('Updating summary tables')
            print update.log[-1]
            update.create_new_summary_tables()
        print update.errors 
    except StandardError as e:
        ERROR = e
    
    
    
    
    time =  datetime.now() - start
    print 'elapsed time:', str(time)
    if not flags['--email'] is None :
        if not ERROR is None:
            sub = "Imiq Summary Update, crashed"
            msg = str(ERROR) + '\n\n'
            msg += 'Log:\n'
            try:
                for l in update.log:
                    msg += '  ' + str(l) 
            except StandardError as e:
                msg += '  updater object not created \n'
                msg += str(e)
            
            msg +=  '\n\nelapsed time:' + str(time) 
        else:
            sub =  'Imiq Summary Update, complete'
            msg = str(flags['--variable']) + ' summaries updated for sources: ' + str(srcids) + '\n\n' 
            msg += "Errors:\n"
            msg += str(update.errors) +' \n\n'
            msg += 'Log:\n'
            for l in update.log:
                msg += '  ' + str(l) 
            msg += '\n\nelapsed time:' + str(time)
        send_alert(flags['--email'],flags['--email'], sub , msg)
                 

if __name__ == "__main__":
    main()
        
            
            
        
        
