## Name of table this file is accoiated with
table_name = "daily_snowdepthdatavalues"

## sources avaiable
sources = [
    209, #ISH
    210, #GHCN
]

source_tokens = {
    209: {"__VARIABLEID__": 370, },#ISH
    210: {"__VARIABLEID__": 402,}#GHCN
}

insert_sql = \
"""INSERT INTO tables.daily_snowdepthdatavalues(
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

## Taking the only snowdept recorded in the day (USING local day as UTC day)
## -- for:
## --   NCDC GHCN: VariableID = 402, SourceID = 210
using_localdatetime_convert_mm_to_m = [
    """SELECT 
        datavalue / 1000.0 as datavalue,
        LocalDateTime as utcdatetime,
        siteid,
        originalvariableid,
        NOW() as insertdate
    FROM tables.ODMDataValues_metric 
    WHERE 
        SiteID in (
            select siteid from tables.datastreams where 
            variableid = __VARIABLEID__
        ) 
        and OriginalVariableid = __VARIABLEID__
    order by siteid, UTCDateTime
    """,
    ["__VARIABLEID__: the variable id for the source"]
]


## (Averging daily utc values)
## -- for:
## --   NCDC ISD/ISH: variableid = 370, SourceID = 209
using_utc_daily_avg_cm_to_m = [
    """
    SELECT 
        AVG(datavalue)/100 as datavalue,
        date_trunc('day', dv.datetimeutc) as utcdatetime,
        siteid,
        originalvariableid,
        NOW() as insertdate
    FROM tables.odmdatavalues_metric as dv
    WHERE SiteID in (
            select siteid from tables.datastreams where 
            variableid = __VARIABLEID__) 
        and OriginalVariableid = __VARIABLEID__
    GROUP BY siteid, date_trunc('day', dv.datetimeutc), originalvariableid
    ORDER BY siteid, UTCDateTime
    """,
    ["__VARIABLEID__: the variable id for the source",]
]


## needs to be at end of snippets
## maps sources to snippets
source_to_snippet = {
    # sourceid :
    #  snippet to use(which is [sql snippet, 
    #                           a list describing tokens to be replaced])
    209: using_utc_daily_avg_cm_to_m,
    210: using_localdatetime_convert_mm_to_m,

}
