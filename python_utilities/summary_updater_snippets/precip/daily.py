## Name of table this file is accoiated with
table_name = "daily_precipdatavalues"

## sources avaiable
sources = [
    210, #GHCN
]

source_tokens = {
    210: {"__VARIABLEID__": 398,}#GHCN
}

insert_sql = \
"""INSERT INTO tables.daily_precipdatavalues(
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

## Taking the only precip recorded in the day (USING local day as UTC day)
## -- for:
## --   NCDC GHCN: VariableID = 398, SourceID = 210
using_localdatetime = [
    """SELECT 
        datavalue,
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

## Taking the MAX precip recorded in the day (USING local day as UTC day)
## -- for:
## --   RAWS: VariableID = 441. SourceID = 211,214,215,216,217,218,219
using_localdatetime_max = [
    """SELECT 
        MAX(datavalue) as datavalue,
        date_trunc('day', LocalDateTime) as utcdatetime,
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
    GROUP BY utcdatetime, siteid, originalvariableid
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
