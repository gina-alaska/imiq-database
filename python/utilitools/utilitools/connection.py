"""
Connection
----------

    This calss creates a connection to a postgress database. A wrapper to 
psycopg2

Rawser Spicer
version: 1.0.0
Split from imiq-database python utilities: 2017-08-18


"""
import psycopg2
import datetime 
import gc
import select

def wait(conn):
    """from psycopg2 docs 
    http://initd.org/psycopg/docs/advanced.html#asynchronous-support
    function in order to carry on asynchronous operations
    
    Parameters
    ----------
    conn: psycopg2.connection
        a psycopg2 object
    """
    while 1:
        state = conn.poll()
        if state == psycopg2.extensions.POLL_OK:
            break
        elif state == psycopg2.extensions.POLL_WRITE:
            select.select([], [conn.fileno()], [])
        elif state == psycopg2.extensions.POLL_READ:
            select.select([conn.fileno()], [], [])
        else:
            raise psycopg2.OperationalError(
                "poll() returned %s" % state
            )

class Connection(object):
    """This calss creates a connection to a postgress database
    """
    
    def __init__ (self, database, host, user, password, async = False):
        """This calss creates a connection to a postgress database.
        
        Paramertes
        ----------
        database: str
            name of database to connect to
        host: str
            hostname of database server
        user: str
            a user on the database
        password: str
            password for user
        async: Bool
            use asynchronous operations
            
        Attributes
        ----------
        async : bool
            indicates if asynchronous operations are used
        conn: psycopg2.connection
            the connection to the database
        cur: psycopg2.cursor
            cursor object bound to conn that allows operation in 
        database
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
            self.conn = psycopg2.connect(database=database, 
                                user=user, 
                                host=host,
                                password=password, 
                                async=1)
            wait(self.conn)
            self.cur = self.conn.cursor()
            
        #~ self.cur.itersize = 10000


    def __del__ (self):
        """ Closes the connection to the database. 
        """
        self.cur.close()
        self.conn.close()
        #~ print "connection closed"

    def execute (self, sql, args = None):
        """Executes a sql command on the server
        
        Prameters
        ---------
        sql: str
            a sql snippet or script
        args: list or dict
            variables to be substutued into sql snippet. %s is uesd for lists 
        where variables are substiuted positionally. %(name)s is used for 
        dictioarys where kes should corospond with name
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
        """returns all of the results from cursor
            
        Returns
        -------
        list of rusults from cursor
        """
        try:
            return self.cur.fetchall()
        except psycopg2.ProgrammingError:
            return []
        
    def commit (self):
        """commits updates to the database.
        """
        self.conn.commit()
        
