## Name of table this file is accoiated with
table_name = "daily_winddirectionsdatavalues"

## sources avaiable
sources = [
    210, #GHCN
]

source_tokens = {
    #~ 210: {"__WSVARIABLEID__": 743, "__WDVARIABLEID__": 747}#GHCN
    210: { "__WDVARIABLEID__": 747}#GHCN
}

insert_sql = \
"""INSERT INTO tables.daily_winddirectiondatavalues(
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

## Taking the only winddirection recorded in the day (USING local day as UTC day)
using_localdatetime_calc_from_components = [
    """
SELECT 
	localdatetime as utcdatetime,
    tables.calcwinddirection(
        CAST(WS.M*COS(WD.DataValue*PI()/180) as real),
        CAST(WS.M*SIN(WD.DataValue*PI()/180) as real)) 
    as direction,
    WS.siteid,
    originalvariableid,
    OffsetValue, 
    OffsetTypeID,
    NOW() as insertdate
FROM tables.ODMDataValues_metric AS WD 
inner join( 
select 
    SiteID,
    DateTimeUTC,
    DataValue as M 
from tables.ODMDataValues_metric WS 
where 
    WS.SiteID in (
            select siteid from tables.datastreams where 
            variableid = __WSVARIABLEID__
        )  and 
    WS.OriginalVariableID= __WSVARIABLEID__)
as WS
on 
	WD.SiteID=WS.Siteid and
    WS.DateTimeUTC=WD.DateTimeUTC 
WHERE 
    WD.SiteID in (
            select siteid from tables.datastreams where 
            variableid = __WDVARIABLEID__
        ) and
    WD.OriginalVariableid= __WDVARIABLEID__
order by siteid, datetimeutc
     """,
    ["__WSVARIABLEID__: Wind Speed variable id for the source",
     "__WDVARIABLEID__: Wind Direction variable id for the source",]
]

## Daily Value already in degrees
## -- for:
## --   NCDC GHCN: WS VariableID = 743, WD VariableID = 747, SourceID = 210
using_localdatetime = [
    """
    SELECT 
		LocalDateTime as utcdatetime,
        datavalue,
        siteid,
        originalvariableid,
        OffsetValue, 
        OffsetTypeID,
        NOW() as insertdate
    FROM tables.ODMDataValues_metric 
    WHERE 
        Siteid in (
            select siteid from tables.datastreams where 
            variableid = __WDVARIABLEID__
        )
        and OriginalVariableid = __WDVARIABLEID__
    """,
   ["__WDVARIABLEID__: Wind Direction variable id for the source",]
]


## needs to be at end of snippets
## maps sources to snippets
source_to_snippet = {
    # sourceid :
    #  snippet to use(which is [sql snippet, 
    #                           a list describing tokens to be replaced])
    210: using_localdatetime,

}
