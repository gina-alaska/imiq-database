"""
posthaste.py

    a class for running postgreSQL quires in python
"""
from connection import Connection
#~ from datetime import datetime 
#~ from os import makedirs
from pandas import DataFrame
#~ import smtplib
#~ from email.mime.text import MIMEText

UTF_8_STR = '\xef\xbb\xbf'

class PostHaste (object):
    """ Class doc """
    
    def __init__ (self, host, database, user, passwd):
        """ Class initialiser """
        self.user , self.passwd = user, passwd
        self.host = host
        self.db = database
        self.delimiter = ','
    
    def open (self, sql_file):
        """ Function doc """
        fd = open(sql_file, 'r')
        sql = fd.read()
        fd.close()
        self.sql = sql.replace(UTF_8_STR, "") 
        
    def run (self):
        """ Function doc """
        conn = Connection(self.db, self.host, self.user, self.passwd)
        conn.execute(self.sql)
        self.table = conn.fetch()
        conn.commit()
        
    def parse_sql (self):
        """ Function doc """
        sql = self.sql.lower()
        
        split = sql.split('from')
        select = split[0]
        rows = [r.strip().replace(')','').replace('(','') for r in select.split('select')[1].split(',')]
        
        
        
        if len(rows) != 1 and '*' in rows:
            return 'UNPARSEABLE', []
        elif len(rows) == 1 and '*' in rows:
            schema, table = split[1].lstrip().split(' ')[0].split('.')
            return 'IMPLICIT', [schema, table]
        else:
            return 'EXPLICIT', rows
        
        
    
    def get_headers (self, table, schema = 'TABLES'):
        """ Function doc """
        get_headers = ("SELECT * FROM information_schema.columns WHERE "
                        "table_schema = " + schema + " AND "
                        "table_name  = " + table + "")
        b_sql, b_table, self.sql = self.sql, self.table, get_headers 
        self.run()
        self.sql = b_sql
        headers = s.as_dataframe()[3].tolist()
        self.table = b_table

        return headers
        
    def as_DataFrame (self):
        """ Function doc """
        return DataFrame(self.table)
                                                                

