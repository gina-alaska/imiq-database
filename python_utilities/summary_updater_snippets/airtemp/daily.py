## Name of table this file is accoiated with
table_name = "daily_airtempdatavalues"

## sources avaiable
sources = [
    210, #GHCN
]

source_tokens = {
    210: {"__VARIABLEID__": 404, # **
          "__MAXID__": 404,
          "__MINID__":403}#GHCN
}
# ** all sources need at least this for looking up values in the 
# datavalues table


insert_sql = \
"""INSERT INTO tables.daily_airtempdatavalues(
    datavalue, utcdatetime, siteid, originalvariableid, insertdate)
select
    datavalue, 
    utcdatetime, 
    siteid, 
    originalvariableid, 
    insertdate
from 
    ( __SNIPPET__ ) as datavalues;
"""

## Taking the average of max and min for each hour recorded in the day 
## (USING local day as UTC day)
## -- for:
## --   NCDC GHCN: maxID= 403, minID= 404, SourceID = 210
using_localdatetime_avg_max_min_vars = [
    """SELECT
        AVG(datavalue) as datavalue, 
        LocalDateTime as utcdatetime, 
        siteid, 
        __MAXID__ as originalvariableid, 
        NOW() as insertdate
    FROM tables.ODMDataValues_metric 
    WHERE 
        SiteID in (
            select siteid from tables.datastreams where 
            variableid = __MAXID__)
        and OriginalVariableid in (__MINID__, __MAXID__) 
    group by utcdatetime, siteid
    order by siteid, utcdatetime
    """,
    ["__MAXID__: the variable id for max airtemp the source",
     "__MINID__: the variable id for min airtemp the source"]
]





## needs to be at end of snippets
## maps sources to snippets
source_to_snippet = {
    # sourceid :
    #  snippet to use(which is [sql snippet, 
    #                           a list describing tokens to be replaced])
    210: using_localdatetime_avg_max_min_vars,

}
