raw = load '/Users/asjacobs/Documents/AWS/werc_processed_hourly_includes_at_2014/werc_hourly_2014.txt' using PigStorage() as (siteid:chararray,timestamp:chararray,rh:float,at:float);
filter_at = FILTER raw by (at is not null and rh is not null and rh > 0);
dp = foreach filter_at generate siteid,CONCAT(SUBSTRING(timestamp,0,11),'00:00:00.000') as timestamp,at,(LOG((0.611*(EXP((17.3*at)/(at+237.3))))*rh/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*at)/(at+237.3))))*rh/100)) as dew; 
grpd = group dp by (siteid,timestamp);
dp_daily = foreach grpd generate group,AVG(dp.dew) as avg_dew,AVG(dp.at) as avg_airtemp;
filtered = FILTER dp_daily by (avg_dew <= avg_airtemp);
rh = foreach filtered generate group.siteid,group.timestamp, (0.611 * EXP((17.3 * avg_dew)/(avg_dew + 237.3))) / (0.611 * EXP((17.3 * avg_airtemp)/(avg_airtemp + 237.3))) * 100.0 as rel;
ordered_rh = ORDER rh BY siteid ASC,timestamp ASC;
store ordered_rh into 'werc_processed_daily_2014';
