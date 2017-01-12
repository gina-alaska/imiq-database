"""
posthaste.py
Rawser Spicer
version: 1.1.0

    a class for running postgreSQL quires in python
    
changelog:
    1.1.0: added async features
    1.0.0: main features work
    
"""
from connection import Connection
#~ from datetime import datetime 
#~ from os import makedirs
from pandas import DataFrame
#~ import smtplib
#~ from email.mime.text import MIMEText

UTF_8_STR = '\xef\xbb\xbf'

class PostHaste (object):
    """ Class for maning postgress sql quires in python """
    
    def __init__ (self, host, database, user, passwd):
        """
        sets up the connection info
        
        arguments:
            host: host name of database <string>
            database: database name <string>
            user: user on database <string>
            passwd: pass word of user <string>
        """
        self.user , self.passwd = user, passwd
        self.host = host
        self.db = database
        self.delimiter = ','
        self.sql = ""
        self.table = []
    
    def open (self, sql_file):
        """
        Open a sql script to run. puts contents of file in self.sql
        
        argumnets:
            sql_file: name of a .sql file <string>

        """
        fd = open(sql_file, 'r')
        sql = fd.read()
        fd.close()
        self.sql = sql.replace(UTF_8_STR, "") 
        
    def run (self):
        """ 
            Run the sql scripn in self.sql. Will execute the script and then 
        commit any changes to database.
        """
        conn = Connection(self.db, self.host, self.user, self.passwd)
        conn.execute(self.sql)
        self.table = conn.fetch()
        conn.commit()
    
    def run_async (self):
        """  Run the sql scripn in self.sql. Will execute the script
        asynconslouy.
        """
        conn = Connection(self.db, self.host, self.user, self.passwd, True)
        conn.execute(self.sql)
        self.table = conn.fetch()
        
    def parse_sql (self):
        """
        parse self.sql script to find column names
        
        returns:
            'UNPARSEABLE', []: if script cannot be parsed
            'IMPLICIT', [schema, table]: if all columns are required
            'EXPLICIT', rows: if certant rows are required
            
        """
        sql = self.sql.lower()
        
        split = sql.split('from')
        select = split[0]
        rows = [r.strip().replace(')','').replace('(','') for r in \
                                    select.split('select')[1].split(',')]
        
        if len(rows) != 1 and '*' in rows:
            return 'UNPARSEABLE', []
        elif len(rows) == 1 and '*' in rows:
            schema, table = split[1].lstrip().split(' ')[0].split('.')
            return 'IMPLICIT', [schema, table]
        else:
            return 'EXPLICIT', rows
        
        
    
    def get_headers (self, table, schema = 'TABLES'):
        """
        get the header colmns of a table
        
        arguments:
            table: the table name <string>
            schema: schema on database <string>
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
        """
        returns contents of self.table as pandas DataFrame
        """
        return DataFrame(self.table)
        
    def as_named_DataFrame (self):
        """
            returns contents of self.table as pandas DataFrame with 
        column names if possible.
        """
        if self.sql == "":
            return DataFrame([])
            
        
        flag, values = self.parse_sql()
        if flag == 'EXPLICIT':
            return DataFrame(self.table, columns = values)
        elif flag == 'IMPLICIT':
            schema = "'" + values[0] + "'"
            table = "'" + values[1] + "'"
            return DataFrame(self.table,columns=self.get_headers(table,schema))
        else:
            return self.as_DataFrame()
                                                                

