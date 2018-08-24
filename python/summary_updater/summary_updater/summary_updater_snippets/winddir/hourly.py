## Name of table this file is accoiated with
table_name = "hourly_winddirectiondatavalues"

## sources avaiable
sources = [
    209, #ISH
]

source_tokens = {
    209: {"__WSVARIABLEID__": 335, "__WDVARIABLEID__": 334}#ISH
}
# ** all sources need at least this for looking up values in the 
# datavalues table


insert_sql = \
"""INSERT INTO tables.hourly_winddirectiondatavalues(
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

## (Averging hourly utc values)
## -- for:
## --   NCDC ISD/ISH: , SourceID = 209
using_utc_hourly_avg_by_component = [
    """
    SELECT 
        date_trunc('hour',WD.datetimeutc) as utcdatetime, 
        tables.calcwinddirection(
            CAST(AVG(WS.M*COS(WD.DataValue*PI()/180)) as real),
            CAST(AVG(WS.M*SIN(WD.DataValue*PI()/180)) as real)
        ) as datavalue,
        wd.siteid as siteid,
        OffsetValue, 
        OffsetTypeID,
        NOW() as insertdate,
     	WD.OriginalVariableid as OriginalVariableid
    FROM tables.ODMDataValues_metric AS WD 
    inner join (
        select 
            SiteID,
            DateTimeUTC,
            DataValue as M 
        from tables.ODMDataValues_metric WS 
        where 
            WS.SiteID in (
                select siteid from tables.datastreams where 
                variableid = __WSVARIABLEID__
            ) and
            WS.OriginalVariableid = __WSVARIABLEID__
    ) as WS 
    on 
        WD.SiteID=WS.Siteid and WS.DateTimeUTC=WD.DateTimeUTC 
    WHERE 
        WD.SiteID in (
            select siteid from tables.datastreams where 
            variableid = __WDVARIABLEID__
        )
        and WD.OriginalVariableid = __WDVARIABLEID__
    GROUP BY 
        wd.siteid, 
        date_trunc('hour',WD.datetimeutc), 
        OffsetValue, 
        OffsetTypeID,
     	OriginalVariableid
    """,
    ["__WSVARIABLEID__: Wind Speed variable id for the source",
     "__WDVARIABLEID__: Wind Direction variable id for the source",]
]





## needs to be at end of snippets
## maps sources to snippets
source_to_snippet = {
    # sourceid :
    #  snippet to use(which is [sql snippet, 
    #                           a list describing tokens to be replaced])
    209: using_utc_hourly_avg_by_component,

}
