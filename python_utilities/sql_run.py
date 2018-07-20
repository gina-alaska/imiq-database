"""sql_run.py
Rawser Spicer

a utility for running a sql script or directory of sql scripts

version 1.0.0
updated: 2017-03-23

"""
import os
import sys

from datetime import datetime

from pandas import read_csv, DataFrame

from utilitools import posthaste as ph

def main():
    """main utility
    
    Usage
    -----
    python sql_run.py --login=<login info file> --target=<file or direcrory>
    
    optional flags:
        --datavalues=<True|False>: A value of True will force a refresh of 
            tables.datavaluesaggregate, tables.boundarycatalog,
            tables.seriescatalog, and tables.metrics
        --log=<path to log file>: An existing log file 
            (csv with on column labled 'completed') can be provided. This
            allows a directory to run ignoreing scripts that have already been 
            run
    """
    ## set up cli and get required values
    from utilitools.clite import CLIte
    flags = CLIte(['--login','--target'],['--datavalues','--log'])
    
    login = flags['--login']
    target = flags['--target']
    

    ## set up scripts
    s = ph.PostHaste(*ph.load_login(login), dry_run=False)
    if target[-4:] == '.sql':
       scripts = [target]
    else:
        scripts = sorted([os.path.join(target,f) for f in os.listdir(target) if f[-4:] == '.sql'])
        
    
    
    ## setup log
    if not flags['--log'] is None:
        log_file = flags['--log']
    else:
        log_file = "SQL_RUN_LOG_" + datetime.strftime(datetime.now(),'%Y%m%d%H%M%S') + '.csv'
    print log_file
    try:
        completed = read_csv(log_file)['completed'].values.tolist()
    except (KeyError,IOError):
        completed = []

    ## run scripts
    for script in scripts:
        if script in completed:
            continue
        print "running: " + script
        try:
            #~ pass
            s.open (script)
            s.run()
        except StandardError:
            print e
            break
        completed.append(script)
        DataFrame(completed,columns=['completed']).to_csv(log_file, index=False)
    
    ## save log
    DataFrame(completed,columns=['completed']).to_csv(log_file, index=False)
    
    ## update mat views
    if not flags['--datavalues'] is None:
        update_to_datavalues = flags['--datavalues'].lower()
        update_to_datavalues = update_to_datavalues == 'true' or update_to_datavalues== 't'
    else:
        update_to_datavalues = False
        
    if update_to_datavalues:
        s.sql = "REFRESH MATERIALIZED VIEW tables.datavaluesaggregate;"
        print s.sql 
        s.run_async()
        s.sql = "REFRESH MATERIALIZED VIEW tables.boundarycatalog;"
        print s.sql 
        s.run_async()
        s.sql = "REFRESH MATERIALIZED VIEW tables.seriescatalog;"
        print s.sql 
        s.run_async()
        s.sql = "REFRESH MATERIALIZED VIEW tables.metrics;"
        print s.sql 
        s.run_async()


main()
