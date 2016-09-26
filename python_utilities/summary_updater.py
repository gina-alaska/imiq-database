from posthaste import PostHaste
import os, sys
from check_activity import load_login


class updateSummaries (object):
    """ Class doc """
    
    sql_rt = os.path.join('sql','update_summaries')
    functions = {"wind speed":{
                                'daily': {
                                    'table': 'daily_windspeeddatavalues',
                                    'fn': 'uspgetdailywindspeed2',
                                    'sql': os.path.join(sql_rt, 'insert', 
                                                    'daily_windspeed.sql'),
                                         },
                                "hourly": {
                                    'table': 'hourly_windspeeddatavalues',
                                    'fn': 'uspgethourlywindspeed2',
                                    'sql': os.path.join(sql_rt, 'insert', 
                                                'hourly_windspeed.sql'),
                                          }
                               },
                }
                
    summary_tables = {
            "wind speed": 
                [os.path.join(sql_rt, 'create', 'create_daily_windspeed.sql'),
                 os.path.join(sql_rt, 'create', 'create_hourly_windspeed.sql')],
            }
    
    
    def __init__ (self, login, var, sources):
        """ Class initialiser """
        self.host, self.db, self.user, self.pswd = load_login(login)
        self.var = var
        self.sources = sources
        self.errors = []
        self.varids = {}
        
    def set_varid (self, src, var):
        """
        for setting varids 
        """
        self.varids[src] = var
        
    def initilize_varids(self):
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
        """
        sql = """
        select count(*) from tables.TABLE
        where siteid in (select siteid from tables.sites where sourceid = SRCID)
            and originalvariableid=VARID
        """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('TABLE', self.functions[self.var][time]['table'])\
                   .replace('SRCID', str(srcid))\
                   .replace('VARID', str(varid))

        s.run()
        return int(s.as_DataFrame()[0])
        
    def delete_source_from_datavalues_table (self, time, srcid, varid):
        sql = """
        delete from tables.TABLE
        where siteid in (select siteid from tables.sites where sourceid = SRCID)
            and originalvariableid=VARID
        """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('TABLE', self.functions[self.var][time]['table'])\
                   .replace('SRCID', str(srcid))\
                   .replace('VARID', str(varid))

        s.run()
        
    def update_db_functions (self):
        for time in ['daily','hourly']:
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.open(self.functions[self.var][time]['sql'])
            s.run()
            
    def excute_db_function (self, time, siteid, varid):
        sql = """
        select tables.FUNCTION(SITE, VAR);
              """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('FUNCTION', self.functions[self.var][time]['fn'])\
                   .replace('SITE', str(siteid))\
                   .replace('VAR', str(varid))
        s.run()
    
    def update_datavalues_tables (self):
        """ Function doc """
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
        """ Function doc """
        for table in self.summary_tables[self.var]:
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.open(table)
            s.run()
            
        
                    
                
                
                
                
                
if __name__ == "__main__":
    login = sys.argv[1]
    update = updateSummaries(login, 'wind speed', range(248,258+1) + [29,30,31,34,223, 145, 144] + [ 209, 202, 1, 203, 182, 182, 35, 213]) 
    
    update.initilize_varids()
    update.update_db_functions()
    update.update_datavalues_tables()
    #~ print update.errors
    update.create_new_summary_tables()
    print update.errors
        
            
            
        
        
