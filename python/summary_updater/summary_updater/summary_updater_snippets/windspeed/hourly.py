## Name of table this file is accoiated with
table_name = "hourly_windspeeddatavalues"

## sources avaiable
sources = [
    209, #ISH
]

source_tokens = {
    209: {"__VARIABLEID__": 335,}  #ISH
}

insert_sql = \
"""INSERT INTO tables.hourly_windspeeddatavalues(
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

## Averging UTC vaues for each imt stamp
## -- for:
## --   NCDC ISH: VariableID = 335, SourceID = 209
using_utc_avg = [
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
    209: using_utc_avg,

}
