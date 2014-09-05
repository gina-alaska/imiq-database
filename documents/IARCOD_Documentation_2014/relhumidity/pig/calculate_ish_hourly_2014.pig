raw = load '/Users/asjacobs/Documents/AWS/data/ish_dp_at_2014_v2.csv' using PigStorage(',') as (timestamp:chararray,siteid:chararray,varid:chararray,dew:float,airtemp:float);
has_at_rh = FILTER raw by (airtemp is not null and dew is not null and dew <= airtemp);
dp = foreach has_at_rh generate CONCAT(SUBSTRING(timestamp,0,14),'00:00') as hour,siteid,varid,dew,airtemp;
grpd = group dp by (hour, siteid, varid);
avg = foreach grpd generate group, AVG(dp.dew) as avg_dew, AVG(dp.airtemp) as avg_airtemp; 
rh = foreach avg generate group.hour as timestamp,group.siteid,group.varid,(0.611 * EXP((17.3 * avg_dew)/(avg_dew + 237.3))) / (0.611 * EXP((17.3 * avg_airtemp)/(avg_airtemp + 237.3))) * 100.0 as rel, avg_airtemp;
ordered_rh = ORDER rh BY siteid ASC,varid ASC, timestamp ASC;
store ordered_rh into 'ish_processed_hourly_2014_v5';
