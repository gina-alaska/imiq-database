## Name of table this file is accoiated with
table_name = "daily_windspeeddatavalues"

## sources avaiable
sources = [
    210, #GHCN
]

source_tokens = {
    210: {"__VARIABLEID__": 743,}#GHCN
}

insert_sql = \
"""INSERT INTO tables.daily_windspeeddatavalues(
    datavalue, utcdatetime, siteid, originalvariableid,
    offsetValue, offsetTypeID , insertdate)
select
    datavalue, 
    utcdatetime, 
    siteid, 
    originalvariableid, 
    offsetValue, 
    offsetTypeID ,
    insertdate
from 
    ( __SNIPPET__ ) as datavalues;
"""

## Taking the only windspeed recorded in the day (USING local day as UTC day)
## -- for:
## --   NCDC GHCN: VariableID = 743, SourceID = 210
using_localdatetime = [
    """SELECT 
        datavalue,
        LocalDateTime as utcdatetime,
        siteid,
        originalvariableid,
        offsetValue, 
        offsetTypeID ,
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





## needs to be at end of snippets
## maps sources to snippets
source_to_snippet = {
    # sourceid :
    #  snippet to use(which is [sql snippet, 
    #                           a list describing tokens to be replaced])
    210: using_localdatetime,

}
