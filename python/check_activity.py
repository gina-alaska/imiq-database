#! /usr/bin/env python
"""
checks activity on imiq database
"""
from utilitools.posthaste import PostHaste
import yaml
import os, sys


def check_activity (host, db, user, pswd):
    """ execute the check activity script"""
    sql = os.path.join('sql', 'check_activity.sql')
    activity = PostHaste(host,db,user,pswd)
    activity.open(sql)
    activity.run()
    return activity.as_DataFrame()


def load_login (fname):
    """ load login from yaml"""
    with open(fname, 'r') as f:
        login = yaml.load(f)
    return login['host'], login['database'], login['user'], login['password']
    

# run util
if __name__ == "__main__":
    login = sys.argv[1]
    host, db, user, pswd = load_login(login)
    print check_activity(host, db, user, pswd)
