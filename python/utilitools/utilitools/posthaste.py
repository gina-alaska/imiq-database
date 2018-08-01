"""
PostHaste
---------

    Class & utility for running sql quries and scripts from python on a 
postgress database

Rawser Spicer
version: 1.3.0
updated: 2017/08/22
    
changelog:
    1.3.0: split form imiq_database python utilities, and added simple CLI 
    utility
    
    1.2.0: added load_login; added data method to PostHaste
    1.1.0: added async features
    1.0.0: main features work
    
"""
from connection import Connection
from pandas import DataFrame
import yaml

UTF_8_STR = '\xef\xbb\xbf'

class PostHaste (object):
    """Class for running sql quries and scripts from python on a postgress
    database
    """
    
    def __init__ (self, host, database, user, passwd, dry_run = False):
        """Class for running sql quries and scripts from python on a postgress
        database
        
        Prameters
        ---------
        host: str
            hostname of database server
        database: str
            name of database to connect to
        user: str
            a user on the database
        passwd: str
            password for user
        dry_run: Bool, defaults False
            if set to True the run, and run_async will not excute scripts
            
        Attributes
        ----------
        user: str
            user on db on host
        host: str
            hostname of postgress server
        db: str
            database on server
        sql: str
            sql snippet or script to run
        table: list
            results of sql script are stored here 
        testing:
            if set to True the run, and run_async will not excute scripts
        """
        self.user , self.passwd = user, passwd
        self.host = host
        self.db = database
        #~ self.delimiter = ','
        self.sql = ""
        self.table = []
        self.testing = dry_run
    
    def open (self, sql_file):
        """Open a sql script to run. Puts contents of file in sql attribute
        
        Parameters
        ----------
        sql_file: path
            path to a postgress sql file
        """
        fd = open(sql_file, 'r')
        sql = fd.read()
        fd.close()
        self.sql = sql.replace(UTF_8_STR, "") 
        
    def run (self):
        """Run the sql script in sql attribute. Will execute the script and 
        then commit any changes to database. Results of script will be put in
        to table attribute. If testing is true, does nothing.
        """
        if self.testing:
            return
        conn = Connection(self.db, self.host, self.user, self.passwd)
        conn.execute(self.sql)
        self.table = conn.fetch()
        conn.commit()
    
    def run_async (self):
        """Run the sql script in sql attribute asynconslouy. Will execute the
        script and  then commit any changes to database. Results of script
        will be put into table attribute. If testing is true, does nothing.
        """
        if self.testing:
            return
        conn = Connection(self.db, self.host, self.user, self.passwd, True)
        conn.execute(self.sql)
        self.table = conn.fetch()
        
    def parse_sql (self):
        """parse sql attribute script to find column names.
        
        returns
        -------
        str, list
            'UNPARSEABLE', []: if script cannot be parsed
            'IMPLICIT', [schema, table]: if all columns are required
            'EXPLICIT', rows: if certant rows are required
        """
        sql = self.sql.lower()
        
        split = sql.split('from')
        select = split[0]
        rows = [r.strip().replace(')','').replace('(','') for r in \
                                    select.split('select')[1].split(',')]
        
        #~ print rows
        if len(rows) != 1 and '*' in rows:
            return 'UNPARSEABLE', []
        elif len(rows) == 1 and '*' in rows:
            schema, table = split[1].lstrip().split(' ')[0].split('.')
            return 'IMPLICIT', [schema, table]
        else:
            return 'EXPLICIT', rows
        
        
    
    def get_headers (self, table, schema = 'TABLES'):
        """get the header colmns of a table, from database. Sets sql 
        attribute to sql used to get headers, and table attribue to table 
        retured
        
        Parameters
        ----------
        table: str
            the table name
        schema: str, default TABLES
            schema on database. I.E tables, views, etc
            
        Retunrs 
        -------
        list
            header columns as list
        """
        get_headers = ("SELECT * FROM information_schema.columns WHERE "
                        "table_schema = " + schema + " AND "
                        "table_name  = " + table + "")
        b_sql, b_table, self.sql = self.sql, self.table, get_headers 
        self.run()
        self.sql = b_sql
        headers = self.as_DataFrame()[3].tolist()
        self.table = b_table

        return headers
        
    def as_DataFrame (self):
        """returns contents of self.table as pandas DataFrame
        
        Returns
        -------
        pandas.dataframe
            contents of self.table as pandas DataFrame
        """
        return DataFrame(self.table)
        
    def as_named_DataFrame (self):
        """returns contents of self.table as pandas DataFrame with 
        column names if possible.
        
        Returns
        -------
        pandas.dataframe
            contents of self.table as pandas DataFrame
        """
        if self.sql == "":
            return DataFrame([])
        flag, values = self.parse_sql()
        try:
            if flag == 'EXPLICIT':
                return DataFrame(self.table, columns = values)
            elif flag == 'IMPLICIT':
                schema = "'" + values[0] + "'"
                table = "'" + values[1] + "'"
                return DataFrame(self.table,columns=self.get_headers(table,schema))
            else:
                return self.as_DataFrame()
        except AssertionError:
            return self.as_DataFrame()
            
    def data(self):
        """alais for as_named_DataFrame
        
        Returns
        -------
        pandas.dataframe
            contents of self.table as pandas DataFrame
        """
        return self.as_named_DataFrame()
                                           
                                           
def load_login (fname):                                 
    """load login from yaml file with login info
    
    Parameters
    ----------
    fname, path
        path to yaml file
    """
    with open(fname, 'r') as f:
        login = yaml.load(f)
    return login['host'], login['database'], login['user'], login['password']  
    
UTILITY_HELP_STR = """This utility runs sql scripts for a postgress database

Use: 
    python posthaste.py --login=<path to login yml file> 
        --script=<path to sql script> --save=<file to save results in | None>
"""
    
def utility():
    """This utility runs sql scripts for a postgress database.
    """
    import clite
    
    try:
        arguments = clite.CLIte(['--login', '--script', '--save'])
    except (clite.CLIteHelpRequestedError, clite.CLIteMandatoryError):
        print UTILITY_HELP_STR
        return
        
    host, db, user, pswd = load_login(arguments['--login'])
    PH = PostHaste(host, db, user, pswd)
    PH.open(arguments['--script'])
    PH.run()
    
    try:
        dataframe = PH.as_named_DataFrame()
    except ValueError:
        #no schema defined in script
        dataframe = PH.as_DataFrame()
    except IndexError:
        dataframe = 'None'
    
    print dataframe
    
    if arguments['--save'] == 'None':
       return 
    
    dataframe.to_csv(arguments['--save'])
    
if __name__ == "__main__":
    utility()

