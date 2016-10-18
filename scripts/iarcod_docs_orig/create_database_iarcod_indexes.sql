
/* datavalues table 
 "UNIQUE"   KEY `DataValues_UNIQUE_DataValues` (`DataValue` ASC,`ValueAccuracy` ASC,`LocalDateTime` ASC,`UTCOffset` ASC,`DateTimeUTC` ASC,`SiteID` ASC,`VariableID` ASC,`OffsetValue` ASC,`OffsetTypeID` ASC,`CensorCode`(50) ASC,`QualifierID` ASC,`MethodID` ASC,`Source null,
*/

create unique key datavalues_unique (datavalue ASC, valueaccuracy asc, localdatetime asc, utcoffset asc, datetimeutc asc, siteid asc, variableid asc, offsetvalue asc, offsettypeid asc, censorcode asc, qualifierid asc, methodid asc, source); 


\q

drop INDEX tables.daily_airtempdatavalues_idx;
drop INDEX tables.daily_airtempdatavaluestest_idx;
drop INDEX tables.daily_airtempmaxdatavalues_idx;
drop INDEX tables.daily_airtempmindatavalues_idx;
drop INDEX tables.daily_dischargedatavalues_idx;
drop INDEX tables.daily_precipdatavalues_idx;
drop INDEX tables.daily_rhdatavalues_idx;
drop INDEX tables.daily_snowdepthdatavalues_idx;
drop INDEX tables.daily_swedatavalues_idx;
drop INDEX tables.daily_winddirectiondatavalues_idx;
drop INDEX tables.daily_windspeeddatavalues_idx;

CREATE UNIQUE INDEX daily_airtempdatavalues_idx ON tables.daily_airtempdatavalues
  USING btree (utcdatetime, siteid, originalvariableid);
  
CREATE UNIQUE INDEX daily_airtempdatavaluestest_idx ON tables.daily_airtempdatavalues_test
  USING btree (utcdatetime, siteid, originalvariableid);
  
 CREATE UNIQUE INDEX daily_airtempmaxdatavalues_idx ON tables.daily_airtempmaxdatavalues
  USING btree (utcdatetime, siteid, originalvariableid);
    
CREATE UNIQUE INDEX daily_airtempmindatavalues_idx ON tables.daily_airtempmindatavalues
  USING btree (utcdatetime, siteid, originalvariableid);
    
CREATE UNIQUE INDEX daily_dischargedatavalues_idx ON tables.daily_dischargedatavalues
  USING btree (utcdatetime, siteid, originalvariableid);   
  
CREATE UNIQUE INDEX daily_precipdatavalues_idx ON tables.daily_precipdatavalues
  USING btree (utcdatetime, siteid, originalvariableid);
  
CREATE UNIQUE INDEX daily_rhdatavalues_idx ON tables.daily_rhdatavalues
  USING btree (utcdatetime, siteid, originalvariableid);
   
CREATE UNIQUE INDEX daily_snowdepthdatavalues_idx ON tables.daily_snowdepthdatavalues
  USING btree (utcdatetime, siteid, originalvariableid);
  
CREATE UNIQUE INDEX daily_swedatavalues_idx ON tables.daily_swedatavalues
  USING btree (utcdatetime, siteid, originalvariableid);
  
CREATE UNIQUE INDEX daily_winddirectiondatavalues_idx ON tables.daily_winddirectiondatavalues
  USING btree (utcdatetime, siteid, offsetvalue, originalvariableid);
      
CREATE UNIQUE INDEX daily_windspeeddatavalues_idx ON tables.daily_windspeeddatavalues
  USING btree (utcdatetime, siteid, offsetvalue, originalvariableid);
 
 