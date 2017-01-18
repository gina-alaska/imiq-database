"""
summary_updater_metatdata.py
ross spicer

info on .sql files/ imiq tables for summary updater

version 1.1.0
updated: 2017-01-13

changelog:
    1.1.0: added watertemp, updated swe, added snow depth, updated airtemps
    1.0.0: working code
"""
import os

sql_rt = os.path.join('sql','summary_updater')
metadata = {
"airtemp":{ 
    'daily': {
        'table': 'daily_airtempdatavalues',
        'fn': 'uspgetdailyairtemp2',
        'sql': os.path.join(sql_rt, 'airtemp',
                            'daily', 'uspgetdailyairtemp2.sql'),
             },
    "hourly": {
        'table': 'hourly_airtempdatavalues',
        'fn': 'uspgethourlyairtemp2',
        'sql': os.path.join(sql_rt, 'airtemp',
                            'hourly', 'uspgethourlyairtemp2.sql'),
              },
    "summaries": 
        [os.path.join(sql_rt, 'airtemp','hourly', 'create_hourly_airtemp.sql'),
         os.path.join(sql_rt, 'airtemp','daily', 'create_daily_airtemp.sql'),
         os.path.join(sql_rt, 'airtemp','monthly', 'create_monthly_airtemp_all.sql'),
         os.path.join(sql_rt, 'airtemp','monthly', 'create_monthly_airtemp.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgfallairtemp_all.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgfallairtemp.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgwinterairtemp_all.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgwinterairtemp.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgspringairtemp_all.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgspringairtemp.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgsummerairtemp_all.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgsummerairtemp.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgairtemp_all.sql'),
         os.path.join(sql_rt, 'airtemp','annual', 'create_annual_avgsairtemp.sql'),
   
         ]
       },

"airtempmax":{
    'daily': {
        'table': 'daily_airtempmaxdatavalues',
        'fn': 'uspgetdailyairtempmax2',
        'sql': os.path.join(sql_rt, 'airtempmax', 'uspgetdailyairtempmax2.sql'),
             },
    "summaries": [
         os.path.join(sql_rt, 'airtempmax', 'create_daily_airtempmax.sql')]
       },

"airtempmin":{
    'daily': {
        'table': 'daily_airtempmindatavalues',
        'fn': 'uspgetdailyairtempmin2',
        'sql': os.path.join(sql_rt, 'airtempmin', 'uspgetdailyairtempmin2.sql'),
             },
    "summaries":[
         os.path.join(sql_rt, 'airtempmin', 'create_daily_airtempmin.sql')
         ]
       },

"discharge":{ #needs work
    'daily': {
        'table': 'daily_dischargedatavalues',
        'fn': 'uspgetdailydischarge2',
        'sql': os.path.join(sql_rt, 'discharge', 'uspgetdailydischarge2.sql'),
             },
    "hourly": {
        'table': 'hourly_dischargedatavalues',
        'fn': 'uspgethourlydischarge2',
        'sql': os.path.join(sql_rt, 'discharge', 'uspgethourlydischarge2.sql'),
              },
    "summaries": 
        [os.path.join(sql_rt, 'discharge', 'create_hourly_discharge.sql'),
         os.path.join(sql_rt, 'discharge', 'create_daily_discharge.sql')]
       },
       
"precipitation":{ #needs work
    'daily': {
        'table': 'daily_precipdatavalues',
        'fn': 'uspgetdailyprecip2',
        'sql': os.path.join(sql_rt, 'precip', 'uspgetdailyprecip2.sql'),
             },
    "hourly": {
        'table': 'hourly_precipdatavalues',
        'fn': 'uspgethourlyprecip2',
        'sql': os.path.join(sql_rt, 'precip', 'uspgethourlyprecip2.sql'),
              },
    "summaries": 
        [os.path.join(sql_rt, 'precip', 'create_hourly_precip.sql'),
         os.path.join(sql_rt, 'precip', 'create_daily_precip.sql')]
       },
       
"rh":{ #needs much work
    'daily': {
        'table': 'daily_rhdatavalues',
        'fn': 'uspgetdailyrh2',
        'sql': os.path.join(sql_rt, 'rh', 'uspgetdailyrh2.sql'),
             },
    "hourly": {
        'table': 'hourly_rhdatavalues',
        'fn': 'uspgethourlyrh2',
        'sql': os.path.join(sql_rt, 'rh', 'uspgethourlyrh2.sql'),
              },
    #~ "monthly": {
    #~ }
    #~ "annual": {
    #~ }
    "summaries": 
        [os.path.join(sql_rt, 'rh', 'create_hourly_rh.sql'),
         os.path.join(sql_rt, 'rh', 'create_daily_rh.sql'),
         ]
       },

"swe":{
    'daily': {
        'table': 'daily_swedatavalues',
        'fn': 'uspgetdailyswe2',
        'sql': os.path.join(sql_rt, 'swe', 'uspgetdailyswe2.sql'),
             },
    "hourly": {
        'table': 'hourly_swedatavalues',
        'fn': 'uspgethourlyswe2',
        'sql': os.path.join(sql_rt, 'swe', 'uspgethourlyswe2.sql'),
              },
    "summaries": 
        [os.path.join(sql_rt, 'swe', 'create_hourly_swe.sql'),
         os.path.join(sql_rt, 'swe', 'create_daily_swe.sql'),
         os.path.join(sql_rt, 'swe', 'create_monthly_sweavg_all.sql'),
         os.path.join(sql_rt, 'swe', 'create_monthly_swe.sql'),
         os.path.join(sql_rt, 'swe', 'create_annual_peakswe_all.sql'),
         os.path.join(sql_rt, 'swe', 'create_annual_peakswe.sql')]
       },
       
"snow depth":{ #needs work
    'daily': {
        'table': 'daily_snowdepthdatavalues',
        'fn': 'uspgetdailysnowdepth',
        'sql': os.path.join(sql_rt, 'snowdepth', 'uspgetdailysnowdepth.sql'),
             },
    "hourly": {
        'table': 'hourly_snowdepthdatavalues',
        'fn': 'uspgethourlysnowdepth',
        'sql': os.path.join(sql_rt, 'snowdepth', 'uspgethourlysnowdepth.sql'),
              },
    "summaries": 
        [os.path.join(sql_rt, 'snowdepth', 'create_hourly_snowdepth.sql'),
         os.path.join(sql_rt, 'snowdepth', 'create_daily_snowdepth.sql'),
         os.path.join(sql_rt, 'snowdepth', 'create_monthly_snowdepthavg_all.sql'),
         os.path.join(sql_rt, 'snowdepth', 'create_monthly_snowdepth.sql'),
         os.path.join(sql_rt, 'snowdepth', 'create_annual_peaksnowdepth_all.sql'),
         os.path.join(sql_rt, 'snowdepth', 'create_annual_peaksnowdepth.sql')]
    },
       
"wind speed":{
    'daily': {
        'table': 'daily_windspeeddatavalues',
        'fn': 'uspgetdailywindspeed2',
        'sql': os.path.join(sql_rt, 'windspeed', 'uspgetdailywindspeed2.sql'),
             },
    "hourly": {
        'table': 'hourly_windspeeddatavalues',
        'fn': 'uspgethourlywindspeed2',
        'sql': os.path.join(sql_rt, 'windspeed', 'uspgethourlywindspeed2.sql'),
              },
    "summaries": 
        [os.path.join(sql_rt, 'windspeed', 'create_hourly_windspeed.sql'),
         os.path.join(sql_rt, 'windspeed', 'create_daily_windspeed.sql')]
       },
       
"wind direction":{
    'component functions': [
        os.path.join(sql_rt, 'winddirection', 'calcwinddirection.sql'),
                            ],
    'daily': {
        'table': 'daily_winddirectiondatavalues',
        'fn': 'uspgetdailywinddirection',
        'sql': os.path.join(sql_rt, 'winddirection',
                    'uspgetdailywinddirection.sql'),
             },
    "hourly": {
        'table': 'hourly_winddirectiondatavalues',
        'fn': 'uspgethourlywinddirection',
        'sql': os.path.join(sql_rt, 'winddirection', 
                    'uspgethourlywinddirection.sql'),
              },
    "summaries": [
        os.path.join(sql_rt, 'winddirection',
            'create_hourly_winddirection.sql'),
        os.path.join(sql_rt, 'winddirection', 'create_daily_winddirection.sql')
                ]
       },
"water temperature":{
    "daily":{
        'table': 'daily_watertempdatavalues',
        'fn': 'uspgetwatertemp',
        'sql': os.path.join(sql_rt, 'watertemp',
                    'uspgetdailywatertemp.sql'),
            },
    "summaries": [
        os.path.join(sql_rt, 'watertemp', 'create_daily_watertemp.sql'),   
        os.path.join(sql_rt, 'watertemp', 'create__15min_watertemp.sql'),
            ]

    }        
}


