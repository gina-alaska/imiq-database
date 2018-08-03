#! /usr/bin/env python
"""
checks activity on imiq database
"""
from utilitools.posthaste import PostHaste
import yaml
import os, sys


def check_activity (host, db, user, pswd):
    """ execute the check activity script"""
    #~ sql = os.path.join('sql', 'check_activity.sql')
    activity = PostHaste(host,db,user,pswd)
    activity.sql = 'SELECT * FROM pg_stat_activity'
    activity.run()
    return activity.as_DataFrame()


def load_login (fname):
    """ load login from yaml"""
    with open(fname, 'r') as f:
        login = yaml.load(f)
    return login['host'], login['database'], login['user'], login['password']
    

def main ():
    """a utility for checking activity on imiq
    
    Usage
    -----
    run-sql <login info file>
    """
    try:
        login = sys.argv[1]
        host, db, user, pswd = load_login(login)
    except IndexError:
        login = '--help'
    except IOError:
        print "Login file not found"
        return
   
    if login == '--help':
        print main.__doc__
        return
    
    print check_activity(host, db, user, pswd)

    

# run util
if __name__ == "__main__":
    main()
    
