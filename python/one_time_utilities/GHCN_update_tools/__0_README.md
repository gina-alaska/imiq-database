## info 
This directroy contains the files needed to update the GHCN data in imiq.
The steps for this process are documented below

## files:
__0_README.md:
    this file
__current_imiq_GHCN_site_list.txt:
    current list of GHCN sites in imiq
__GHCN_datavalues_args_template.yaml:
    template for creating all of the argument files
__GHCN_datavalues_template.yaml:
    template for y2i, each argument file references this
all_to_sql.py:
    creates all argumnet files and sql files
GHCN_get_all_data.py:
    gets .dly files from source


## steps for update
1) update __current_imiq_GHCN_site_list.txt from imiq
2) get data from GHCN (py)
   python GHCN_get_all_data.py
   
3) create ./dly_files directory and move all .dly files to ./dly_files

3A) convert create ./csv_files dirctory

3B) run ../../Y2I/conversion_scripts/dly2timeseries.py
    python ../../Y2I/conversion_scripts/dly2timeseries.py ./dly_files ./csv_files 

4) create ./sql_files and ./cfg_files directorties 
5) convert to sql (py)
    python all_to_sql.py
    
6) drop all GHCN data from imiq (sql)
    delete from tables.datavalues where datastreamid in (select datastreamid from tables.datastreams where siteid in (select siteid from tables.sites where sourceid = 210)); --210 is ghcn
 
7) add new data to imiq (py)
    python ../imiq-database/python_utilities/sql_run.py --target=sql_files/ --login=../imiq-login.yaml --datavalues=true --log=ghcn_update.csv

