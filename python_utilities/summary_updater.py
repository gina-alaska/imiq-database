from posthaste import PostHaste
import os, sys
from check_activity import load_login
import summary_updater_metadata

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
        
        
        
    def set_varid (self, src, var):
        """
        set variable ids for a source id manually 
        
        inputs:
            src: a source id <int>
            var: varids <list if ints>
            
        
        """
        self.varids[src] = var
        
    def initilize_varids(self):
        """
        initilize varids from seriescatalogue on imiq
        """
        
        sql = """
        select distinct(variableid) from tables.seriescatalog 
        where sourceid = SOURCE_ID and lower(variablename) like 'VAR'
              """
        for source in self.sources:
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.sql = sql.replace('SOURCE_ID', str(source))\
                       .replace('VAR',self.var)
            s.run()
            if len(s.as_DataFrame()) == 0:
                continue
            elif len(s.as_DataFrame()) != 1:
                msg = 'Source ' + str(source) +\
                                'has more that one possible variable'
                self.errors.append(msg)
                continue
            varid = int(s.as_DataFrame()[0])
            self.varids[source] = varid
      
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
        #~ sql = """
        #~ select count(*) from tables.TABLE
        #~ where siteid in (select siteid from tables.sites where sourceid = SRCID)
            #~ and originalvariableid=VARID
        #~ """
        #~ s = PostHaste(self.host,self.db,self.user,self.pswd)
        #~ s.sql = sql.replace('TABLE', self.metadata[self.var][time]['table'])\
                   #~ .replace('SRCID', str(srcid))\
                   #~ .replace('VARID', str(varid))

        #~ s.run()
        #~ return int(s.as_DataFrame()[0])
        
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
        for time in ['daily','hourly']:
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.open(self.metadata[self.var][time]['sql'])
            s.run()
            
    def excute_db_function (self, time, siteid, varid):
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
        if siteid in self.ignore_sites:
            print "ignoring site:", siteid, "var:", varid
            return 
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('FUNCTION', self.metadata[self.var][time]['fn'])\
                   .replace('SITE', str(siteid))\
                   .replace('VAR', str(varid))
        s.run()
    
    def update_datavalues_tables (self):
        """
        update the data values tables for sources
        
        
        """
        for source in self.sources:
            try:
                varid = self.varids[source]
            except KeyError:
                #~ print source, 'No Vars'
                continue
            for time in ['daily','hourly']:
                
                init_count = self.get_source_count_from_datavalues_table(time, 
                                                                        source,
                                                                        varid)
                print source, varid
                print '--', time,' init count:',  init_count
                
                #~ self.delete_source_from_datavalues_table(time, source, varid)
                
                #~ for site in self.get_siteids(source):
                    #~ self.excute_db_function(time, site, varid)
                self.update_dv_table(time, self.get_siteids(source), varid)
                
                post_count = self.get_source_count_from_datavalues_table(time, 
                                                                         source,
                                                                         varid)
                print '--', time,' post count:',  post_count
                if post_count < init_count:
                    print " -- ERR: LESS"
                    self.errors.append('Source ' +str(source) + "failure")
    
    def update_dv_table (self, time, sites, varid):
        """
        """
        for site in sites:
            print '----',site, varid
            self.delete_site_from_datavalues_table(time, site, varid)
            self.excute_db_function(time, site, varid)
                    
    def create_new_summary_tables (self):
        """
        create a new summary table on imiq
        """
        for table in self.metadata[self.var]['summaries']:
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.open(table)
            s.run()
            
        
                    
                

def main ():
    from clite import CLIte
    flags = CLIte(['--login'],['--variable','--sourceids',
                                                        '--varid','--siteids','--ignore'])
    
    
    
         
    
    
    srcids = [int(i) for i in flags['--sourceids'][1:-1].split(',')]
    update = updateSummaries(flags['--login'], flags['--variable'], srcids)
    #range(248,258+1) + [29,30,31,34,223, 145, 144] + [ 209, 202, 1, 203, 182, 182, 35, 213]) 
    if not flags['--ignore'] is None:
        update.ignore_sites = [int(i) for i in flags['--ignore'][1:-1].split(',')]
    update.initilize_varids()
    update.update_db_functions()
    update.update_datavalues_tables()
    #~ print update.errors
    update.create_new_summary_tables()
    print update.errors             
                

if __name__ == "__main__":
    main()
        
            
            
        
        
