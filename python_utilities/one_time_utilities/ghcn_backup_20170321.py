"""script to backup the GHCN values in the datavalues table on 2017/03/21

Rawser Spicer

version 1.0.0
updated: 2017-03-21
"""
import posthaste as ph
import os

s = ph.PostHaste(*ph.load_login('../../imiq-login.yaml'))


## setup directory or get datastrams that are downloaded
try:
    save_dir = "./ghcn_backup_20170321"
    os.mkdir(save_dir)
except OSError:
    backed_ds = [int(f.split('_')[1].split('.')[0]) for f in os.listdir(save_dir) if f.find('datastream_') != -1]


## sql code
datastreams_with_no_data_sql = """select distinct(datastreamid) from tables.datastreams where siteid in (select siteid from tables.sites where sourceid = 210)
except
select distinct(datastreamid) from tables.ghcn_backup
"""

datastreams_sql = """select distinct(datastreamid) from tables.ghcn_backup"""

get_data_stream_sql = """select * from tables.ghcn_backup where datastreamid = DSID"""

get_cols_sql = """select attname, typname 
from pg_attribute a 
join pg_class c on a.attrelid = c.oid 
join pg_type t on a.atttypid = t.oid
where relname = 'ghcn_backup' and attnum >= 1;
"""

## get datastreams from imiq and remove downloaded streams
s.sql = datastreams_sql
s.run()
datastreams = s.as_named_DataFrame()['distinctdatastreamid'].T.values

datastreams = list(set(datastreams) - set(backed_ds))

## get table headers
s.sql = get_cols_sql
s.run()
cols = list(s.as_named_DataFrame()['attname'].T.values)


## download functuion
def save(dsid):
    """
    
    Parameters
    ----------
    dsid: int
        a datastream id from imiq
    """
    s_t = ph.PostHaste(*ph.load_login('../../imiq-login.yaml'))
    out_file = os.path.join(save_dir, "datastream_" + str(dsid) + ".csv")
    s_t.sql = get_data_stream_sql.replace('DSID',str(dsid) )
    s_t.run()
    data = s_t.as_DataFrame()
    data.columns = cols
    data.to_csv(out_file, index=False)  


## multi core download loop
from multiprocessing import Process, Lock,active_children, cpu_count
            
lock = Lock()

for dsid in datastreams: #["Stebbins","Adak","Brevig_Mission"]:
    while len(active_children()) >= cpu_count():
        continue
    lock.acquire()
    print dsid, "started"
    lock.release()
    Process(target=save, args=(dsid,)).start()

## wait for all processes to finish
while len(active_children()) > 0:
    continue


