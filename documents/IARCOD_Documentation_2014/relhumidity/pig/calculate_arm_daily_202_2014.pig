raw = load '/Users/asjacobs/Documents/AWS/data/arm_rh_at_sourceid202_2014.csv' using PigStorage(',') as (siteid:chararray,timestamp:chararray,airtemp:float,rh:float);
filtered= FILTER raw by (rh > 0 and airtemp is not null and rh is not null);
dp = foreach filtered generate siteid,CONCAT(SUBSTRING(timestamp,0,11),'00:00:00.000') as timestamp,airtemp,(LOG((0.611*(EXP((17.3*airtemp)/(airtemp+237.3))))*rh/100)+0.4926)/(0.0708-0.00421*LOG((0.611*(EXP((17.3*airtemp)/(airtemp+237.3))))*rh/100)) as dew;
grpd = group dp by (timestamp,siteid);
avg = foreach grpd generate group, AVG(dp.airtemp) as avg_airtemp,AVG(dp.dew) as avg_dew;
filtered_avg = FILTER avg by (avg_dew <= avg_airtemp);
rh = foreach filtered_avg generate group.timestamp as timestamp,group.siteid as siteid, (0.611 * EXP((17.3 * avg_dew)/(avg_dew + 237.3))) / (0.611 * EXP((17.3 * avg_airtemp)/(avg_airtemp + 237.3))) * 100.0 as rel;
ordered_rh = ORDER rh by siteid ASC,timestamp ASC;
store ordered_rh into 'arm_processed_daily_202_2014';
