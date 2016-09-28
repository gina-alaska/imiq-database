from posthaste import PostHaste
import os, sys
from check_activity import load_login


class updateSummaries (object):
    """
    for updating summary tables in the imiq database
    """
    
    ## location of local sql scripts
    sql_rt = os.path.join('sql','update_summaries')
    
    ## information on tables and functions for each variable
    metadata = {
        "wind speed":{
            'daily': {
                'table': 'daily_windspeeddatavalues',
                'fn': 'uspgetdailywindspeed2',
                'sql': os.path.join(sql_rt, 'insert', 'daily_windspeed.sql'),
                     },
            "hourly": {
                'table': 'hourly_windspeeddatavalues',
                'fn': 'uspgethourlywindspeed2',
                'sql': os.path.join(sql_rt, 'insert', 'hourly_windspeed.sql'),
                      },
            "summaries": 
                [os.path.join(sql_rt, 'create', 'create_daily_windspeed.sql'),
                 os.path.join(sql_rt, 'create', 'create_hourly_windspeed.sql')]
           },
                
    }
    
    
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
        SELECT siteid from tables.sites where sourceid = SRCID
              """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('SRCID', str(source))
        s.run()
        return s.as_DataFrame()[0].tolist()
              
    def get_count_from_datavalues_table (self, time, srcid, varid):
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
        
        sql = """
        select count(*) from tables.TABLE
        where siteid in (select siteid from tables.sites where sourceid = SRCID)
            and originalvariableid=VARID
        """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('TABLE', self.metadata[self.var][time]['table'])\
                   .replace('SRCID', str(srcid))\
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
        
        sql = """
        delete from tables.TABLE
        where siteid in (select siteid from tables.sites where sourceid = SRCID)
            and originalvariableid=VARID
        """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('TABLE', self.metadata[self.var][time]['table'])\
                   .replace('SRCID', str(srcid))\
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
                
                init_count = self.get_count_from_datavalues_table(time, source,
                                                                    varid)
                print source, varid
                print '--', time,' init count:',  init_count
                
                self.delete_source_from_datavalues_table(time, source, varid)
                
                for site in self.get_siteids(source):
                    self.excute_db_function(time, site, varid)
                
                post_count = self.get_count_from_datavalues_table(time, source,
                                                                    varid)
                print '--', time,' post count:',  post_count
                if post_count < init_count:
                    print " -- ERR: LESS"
                    self.errors.append('Source ' +str(source) + "failure")
                    
                    
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
    flags = CLIte(['--login','--variable','--sourceids'])
    
    srcids = [int(i) for i in flags['--sourceids'][1:-1].split(',')]
    update = updateSummaries(flags['--login'], flags['--variable'], srcids)
    #range(248,258+1) + [29,30,31,34,223, 145, 144] + [ 209, 202, 1, 203, 182, 182, 35, 213]) 
    
    update.initilize_varids()
    update.update_db_functions()
    update.update_datavalues_tables()
    #~ print update.errors
    update.create_new_summary_tables()
    print update.errors             
                

if __name__ == "__main__":
    main()
        
            
            
        
        
