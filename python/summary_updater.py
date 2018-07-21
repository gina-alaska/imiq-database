"""
summary updater.py
    for updating imiq summary tables
    
    
version 2.0.0
updated: 2017-04-17

changelog:
    2.0.0: changed the way the utility works greatly simplifying interface.
        Variables are now updated by source and not site. Calls to stored 
        procedures in database are no longer used, and updates to 
        datavalues tables are preformed by insert scripts. 
    1.1.0: added materialized views support
    1.0.1: fixed bugs in function names
    1.0.0: working code
"""
import os, sys
from datetime import datetime
from importlib import import_module

#~ import psycopg2

from posthaste import PostHaste
from posthaste.email_alert import send_alert
from check_activity import load_login


## map alternate names to names imiq uses
map_to_canon_name = {
    'air temperature':'airtemp',
    'air temp':'airtemp',
    'airtemp':'airtemp',
    'precipitation':'precip',
    'precip':'precip',
    'snow depth': 'snowdepth',
    'snowdepth': 'snowdepth',
    'snow water eqivalent':'swe',
    'swe':'swe',
    'windspeed': 'windspeed',
    'wind speed': 'windspeed',
}

class SummaryError(Exception):
    """Exception class for this utility
    """
    pass

class UpdateSummary (object):
    """
    for updating summary tables in the imiq database
    """
    def __init__ (self, login, var, sources):
        """
        Class initialiser 
        
        Parameters
        ----------
        login: path
            path to login credidentials, a yaml file <string>
        var: string
            a variable name in the map_to_canon_name dict
        sources: list of source ids
        
        """
        self.host, self.db, self.user, self.pswd = load_login(login)
        self.var = map_to_canon_name[var.lower()]
        self.snippets = self.get_var_snippets()
        self.sources = sources
        #~ self.errors = [] # Just use the log
        self.log = []

    def get_var_snippets (self):
        """get the snipptes for the var were updating
        
        Returns
        -------
        the module with the snippets
        """
        return import_module("summary_updater_snippets."+self.var)
              
    def count_source (self, sourceid, time_frame):
        """count a sources datavalues for a time frame
        
        Parameters
        ----------
        sourceid: int
            a source id
        time_frame: str
            'hourly' or 'daily'
            
        Returns
        -------
        int
            the count of  the rows
        """
        snippets = self.get_time_frame_snippets(time_frame)
        
        table = snippets.table_name
        varid = snippets.source_tokens[sourceid]["__VARIABLEID__"]
        
        sql = """
        select count(*) from tables.TABLE where originalvariableid = VARID
        """
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('TABLE', table).replace('VARID', str(varid))

        s.run()
        
        self.log.append('Number rows in ' + table + ' for ' +\
            str(sourceid) + ' is ' + str(int(s.as_DataFrame()[0])))
        print self.log[-1]
        return int(s.as_DataFrame()[0])
            
    def refresh_summary_tables (self, tables = []):
        """refresh summary table on imiq
        
        Parameters
        ----------
        tables: list
            list of materialized views on imiq
        """
        for table in tables:
            self.log.append('refreshing summary: ' + str(table))
            print self.log[-1]
            
            s = PostHaste(self.host,self.db,self.user,self.pswd)
            s.sql = "REFRESH MATERIALIZED VIEW tables." + table
            s.run()
         
    def refresh (self, time_frame):
        """decides which materialized views to refresh and refreshes them
        
        Parameters
        ----------
        time_frame: str
            'hourly' or 'daily+' or 'all'
        """
        summary_tables = self.snippets.summary_tables
        if time_frame == "hourly":
            self.refresh_summary_tables(summary_tables[0]) 
        elif time_frame == "daily+":
            self.refresh_summary_tables(summary_tables[1:]) 
        elif time_frame == "all":
            self.refresh_summary_tables(summary_tables) 
        else:
            raise SummaryError, "refresh: Vaild Time Frame not provided"
            
    def get_time_frame_snippets (self, time_frame):
        """ get the snippets asscoiated with a time frame
        
        Parameters
        ----------
        time_frame: str
            'hourly' or 'daily'
        
        Returns
        -------
        module of snippets
        
        Raises
        ------
        SummaryError if snippets cannot be found for a variable or time frame
        """
        try:
            if time_frame == 'daily':
                return self.snippets.daily
            elif time_frame == 'hourly':
                return self.snippets.hourly
            else:
                raise SummaryError, \
                    "get_time_frame_snippets: Vaild Time Frame not provided"
        except AttributeError:
            raise SummaryError, self.var + " does not have " +\
                time_frame + " snippets"
    
    def add_source (self, sourceid, time_frame):
        """Add a source to the imiq summary table for a time frame
        
        Parameters
        ----------
        sourceid: int
            a source id
        time_frame: str
            'hourly' or 'daily'
        """
        snippets = self.get_time_frame_snippets(time_frame)
            
        tokens = snippets.source_tokens[sourceid]
        snippet = snippets.source_to_snippet[sourceid][0]
        insert_sql = snippets.insert_sql
        
        for token in tokens:
            snippet = snippet.replace(token, str(tokens[token]))
        
        insert = insert_sql.replace('__SNIPPET__', snippet )
        self.log.append("Script used: " + insert)
        print self.log[-1]
        
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = insert
        s.run()
        
        
            
    def delete_source (self, sourceid, time_frame):
        """delets a source from the imiq summary table for a time frame
        
        Parameters
        ----------
        sourceid: int
            a source id
        time_frame: str
            'hourly' or 'daily'
        """
        snippets = self.get_time_frame_snippets(time_frame)
        
        table = snippets.table_name
        varid = snippets.source_tokens[sourceid]["__VARIABLEID__"]
        
        sql = "delete from tables.TABLE where originalvariableid = VARID"
        s = PostHaste(self.host,self.db,self.user,self.pswd)
        s.sql = sql.replace('VARID', str(varid)).replace("TABLE",table)
        s.run()
        
        self.log.append('Deleted source ' + str(sourceid) + ' from ' + table)
        print self.log[-1]
            
    def update_source (self, sourceid, time_frame):
        """deletes and then adds a source to the imiq summary tables for 
        a time frame
        
        Parameters
        ----------
        sourceid: int
            a source id
        time_frame: str
            'hourly' or 'daily' 
        """
        self.log.append("Updaing " + time_frame +\
            " for source " + str(sourceid))
        print self.log[-1]
        
        init = self.count_source (sourceid, time_frame)
        self.delete_source(sourceid, time_frame)
        self.add_source(sourceid, time_frame)
        post = self.count_source (sourceid, time_frame)
        
        self.log.append('Number new values is ' + str(post - init))
        print self.log[-1]
        
        
    def update_all (self, time_frame):
        """updates all sources for a time frame
        
        Parameters
        ----------
        time_frame: str
            'hourly' or 'daily'
        """
        self.log.append("Updating all " + time_frame)
        print self.log[-1]
        for source in self.sources:
            self.update_source(source, time_frame)
            
        
        
            
        
def return_list(string, dtype, sep = ',', start_char = '[', end_char=']' ):
    """make a list from a string
    
    Parametes
    ---------
    string: str
        a list in string form
    dtpye: type
        a python type
    sep: str
        the seperator (',')
    start_char: str
        the starting character ('[')
    end_char: str
        the end character (']')
        
    returns
    ------
    list
    """
    print string
    string = string.replace(start_char,'').replace(end_char,'')
    return [dtype(i) for i in string.split(',')]


def summary_updater (login, variable, sources):
    """updates a summary for a variable and sources on imiq
    
    Parameters
    ----------
    variable: 
    sources: list of ints
        sources in imiq
    variable: str
        a variable name in the map_to_canon_name dict
    sources: list of source ids
    """
    start = datetime.now()
    
    update = UpdateSummary(login, variable, sources)
    
    try:
        update.update_all('hourly')
        update.refresh('hourly')
    except SummaryError as e:
        update.log.append("Hourly not updated as " + str(e))
        print update.log[-1]
    
    update.update_all('daily')
    update.refresh('daily+')
    
    update.log.append("Total runtime: " + str(datetime.now() - start))
    print update.log[-1]
                

def main ():
    """interface to cli
    """
    from posthaste.clite import CLIte
    flags = CLIte(['--login','--variable','--sourceids'], ['--email',])
        
    srcids = return_list(flags['--sourceids'], int)
    summary_updater(flags['--login'], flags['--variable'], srcids)
        
    
    ## TODO: add back email feature
    #~ if not flags['--email'] is None :
        #~ if not ERROR is None:
            #~ sub = "Imiq Summary Update, crashed"
            #~ msg = str(ERROR) + '\n\n'
            #~ msg += 'Log:\n'
            #~ try:
                #~ for l in update.log:
                    #~ msg += '  ' + str(l) 
            #~ except StandardError as e:
                #~ msg += '  updater object not created \n'
                #~ msg += str(e)
            
            #~ msg +=  '\n\nelapsed time:' + str(time) 
        #~ else:
            #~ sub =  'Imiq Summary Update, complete'
            #~ msg = str(flags['--variable']) + ' summaries updated for sources: ' + str(srcids) + '\n\n' 
            #~ msg += "Errors:\n"
            #~ msg += str(update.errors) +' \n\n'
            #~ msg += 'Log:\n'
            #~ for l in update.log:
                #~ msg += '  ' + str(l)  +'\n'
            #~ msg += '\n\nelapsed time:' + str(time)
        #~ send_alert(flags['--email'],flags['--email'], sub , msg)
                 
## main if called as utility
if __name__ == "__main__":
    main()
        
            
            
        
        
