import psycopg2
import datetime 
import gc

class Connection(object):
    """ 
    This calss creates a connection to the imiq_staging database
        
    terms:
        connections will refer to self.conn and self.cur 
    """
    
    def __init__ (self, database, host, user, password, async = False):
        """ 
        Class initializer. sets up the connection to the database
        
        Preconditions: 
            user is a user on the database, with password being their password.
        Postconditions:
            a connection to the database is open. 
        """
        gc.enable()
        self.async = async
        if not async :
            self.conn = psycopg2.connect(database=database, 
                                user=user, 
                                host=host,
                                password=password)
            self.cur = self.conn.cursor()
        else:
            aconn = psycopg2.connect(database=database, 
                                user=user, 
                                host=host,
                                password=password, 
                                async=1)
            wait(self.conn)
            self.cur = self.conn.cursor()
            
        #~ self.cur.itersize = 10000


    def __del__ (self):
        """ 
        Closes the connection to the database. 
        
        Preconditions:
            self.cur and self.conn should be open
        Postconditions;
            self.cur and self.conn should be closed.
        """
        self.cur.close()
        self.conn.close()
        #~ print "connection closed"

    def execute (self, sql, args = None):
        """
        executes a sql command on the server
        
        Pre:
            The Connections(self.cur & self.conn) should be open. Sql should be a 
        valid sql(the postgres version) statement, with %s as place holder for 
        arguments. Args should have a length that is equal to the number of %s
        placeholders. 
        
        Post:
            The results of the query will be in self.cur.
        """
        if args is None:
            self.cur.execute(sql)
        else:
            self.cur.execute(sql,args)
        if self.async == True:
            print "waiting for query to complete"
            wait(self.conn)
        gc.collect()
        
    def fetch (self):
        """
        returns all of the results from cursor
            
        Pre:
            Connections should be open.
        Post:
            a list is returned & self.cur will be free of results.
        """
        try:
            return self.cur.fetchall()
        except psycopg2.ProgrammingError:
            return []
        
    def commit (self):
        """
        commits updates to the database.
        
        Pre:
            connections should be open
        Post:
            The database changes are saved in the database
        """
        self.conn.commit()
        
