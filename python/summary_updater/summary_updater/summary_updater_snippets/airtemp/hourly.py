## Name of table this file is accoiated with
table_name = "hourly_airtempdatavalues"

## sources avaiable
sources = [
    209, #ISH
]

source_tokens = {
    209: {"__VARIABLEID__": 218, }#ISH
}
# ** all sources need at least this for looking up values in the 
# datavalues table


insert_sql = \
"""INSERT INTO tables.hourly_airtempdatavalues(
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

## (Averging hourly utc values)
## -- for:
## --   NCDC ISD/ISH: variableid = 218, SourceID = 209
using_utc_hourly_avg = [
    """
    SELECT 
        AVG(datavalue) as datavalue,
        date_trunc('hour', dv.datetimeutc) as utcdatetime,
        siteid,
        originalvariableid,
        NOW() as insertdate
    FROM tables.odmdatavalues_metric as dv
    WHERE SiteID in (
            select siteid from tables.datastreams where 
            variableid = __VARIABLEID__) 
        and OriginalVariableid = __VARIABLEID__
    GROUP BY siteid, date_trunc('hour', dv.datetimeutc), originalvariableid
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
    209: using_utc_hourly_avg,

}
