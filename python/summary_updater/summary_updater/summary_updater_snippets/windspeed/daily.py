## Name of table this file is accoiated with
table_name = "daily_windspeeddatavalues"

## sources avaiable
sources = [
    209, #GHCN
    210, #GHCN
]

source_tokens = {
    209: {"__VARIABLEID__": 335,},  #ISH
    210: {"__VARIABLEID__": 743,}   #GHCN
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


## Averging UTC vaues for each imt stamp
## -- for:
## --   NCDC ISH: VariableID = 335, SourceID = 209
using_utc_avg = [
    """
    SELECT 
        date_trunc('day',dv.datetimeutc) as utcdatetime,
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
        date_trunc('day',dv.datetimeutc), 
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
    209: using_utc_avg,
    210: using_localdatetime,

}
