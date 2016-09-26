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
        conn.execute(self.sql, ())
        self.table = conn.fetch()
        conn.commit()
        
    def as_DataFrame (self):
        """ Function doc """
        return DataFrame(self.table)
                                                                

