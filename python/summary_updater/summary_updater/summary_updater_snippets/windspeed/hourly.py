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
    """
    SELECT 
        date_trunc('hour',dv.datetimeutc) as utcdatetime,
        avg(dv.datavalue) as datavalue,
        siteid,
        OffsetValue, 
        OffsetTypeID,
        NOW() as insertdate,
        OriginalVariableid
    FROM tables.odmdatavalues_metric AS dv 
    WHERE 
        SiteID in (
            select siteid from tables.datastreams where 
            variableid = __VARIABLEID__
        )
        and OriginalVariableid = __VARIABLEID__
    GROUP BY 
        siteid, 
        date_trunc('hour',dv.datetimeutc), 
        OffsetValue, 
        OffsetTypeID,
        OriginalVariableid
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
