what are these file & folders about 

check_activity.sql:
       check the status table on imiq's database 
       
findnew.sql:
        find new datastreams in imiq
        
hourly_to_daily_max.sql:
        find the daily max for a site, would need to change siteid and 
    originalvariableid to find other things. I think this was just a test script

load_source.sql:   (IMPORTANT)
        load a source into a summary table. the sourceid(or ids) need to be
    updated,  and the  tables.uspgetdailysnowdepth function needs too be 
    changed along with the variable passed to it

summary_max_at.sql:
        git max air temp from a summary table. This seems to be an example 
    for myself
        
UPDATE_Datastreams_addDates.sql: (IMPORTANT)
    ﻿   Update tables.datastreams to add the Begin DATE and end DATE for 
    the datastreams.

folders:
    amy_mssql: 
            Amy's SQL scripts from the old mssql version of Imiq. Exists for 
        example purposes 
        
    create_scripts:  (IMPORTANT)
            Scripts for creating the summary tables. Files in view2table may
        have some overlap
        
    functions:   (IMPORTANT)
        functions for adding new sites to summary tables 
    
    view2table:    (IMPORTANT)
            scripts for recreating the old summary views as tables 
        can be used to update view tables 
        
        
