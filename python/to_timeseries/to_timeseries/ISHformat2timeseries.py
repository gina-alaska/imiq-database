"""
ISH2timeseries.py
rawser spicer
2017-01-26

ISH FILE FOMATS HAVE NO extention

variables parsed here are name (imiq varid):
  - AIR_TEMP (218)
  - AIR_TEMP_QC
  - CEILING (338)
  - CEILING_CAVOK (367)
  - CEILING_DETEMINATION (367)
  - CEILING_QC
  - DEW_POINT(332)
  - DEW_POINT_QC 
  - SEA_LEVEL_PRESSURE (337)
  - SEA_LEVEL_QC
  - WIND_DIR (334)
  - WIND_DIR_QC
  - WIND_DIR_TYPE (366)
  - WIND_SPEED (335)
  - WIND_SPEED_QC
  - SNOW_DEPTH (370)
  - SNOW_WATER_EQUIVALENT (373)
  - PRECIPTATION (340)
  - SOLAR_RAD-AVG (418)
  - SOLAR_RAD-MIN (419
  - SOLAR_RAD-MAX (420)
  - SOLAR_RAD-STD_DEV (422)
  - PRECIP_CONDTION (369)
  - SWE_CONDTION (373)
    
V1.0.0 

Changes
"""
from pandas import DataFrame
from datetime import datetime
import os
#~ import numpy as np

TOTAL_CHAR = slice(0, 4)
STATION_ID = slice(4, 10)
WBAN = slice(10, 15)
DATE = slice(15, 23)
TIME = slice(23, 27)
SOURCE = 27
LAT= slice(28, 34)
LONG = slice(34,41)
GEOLOC_TYPE = slice(41, 46)
ELEV = slice(46, 51)
CALL_ID = slice(51, 56)
MET_POINT= slice(56, 60)

WIND_DIR = slice(60, 63)
WIND_DIR_QC = 63
WIND_OBS_TYPE = 64
WIND_SPEED = slice(65, 69)
WIND_SPEED_QC = 69

WIND_SPEED_FACTOR = 10

#celing height M
SKY_COND = slice(70,75)
SKY_COND_QC = 75
SKY_COND_OBS_CODE = 76
SKY_COND_CAVOK_CODE = 77

VIS_OBS = slice(78, 84)
VIS_OBS_QV = 84
VIS_OBS_VAR = 85
VIS_OBS_VAR_QC = 86

AIR_TEMP = slice(87, 92)
AIR_TEMP_QC = 92
AIR_TEMP_FACTOR = 10

DEW_POINT = slice(93, 98)
DEW_POINT_QC = 98

# sea-level pressure
PRESSURE = slice(99, 104)
PRESSURE_QC = 104
PRESSURE_FACTOR = 10


#optional feilds imiq uses
## solar rad(avg,min,max,std-dev)
OPTIONAL_FIELD = {
    ## ex for snow depth & swe
    ## AJ100209500203294
    ## |FEILD ID |SNOW DEPTH  |COND |QC |SWE               |COND |QC |
    ## |00 01 02 |03 04 05 06 |07   |08 |09 10 11 12 13 14 |15   |16 |
    ## |A  J  1  |0  0  2  0  |9    |5  |0  0  2  0  3  2  |9    |4  |
    ## SNOW DEPTH = 0020/1 => 20.0 cm, CONDITION FLAG: 9, QC FLAG: 5
    ## SWE = 002032/10 => 203.2 mm, CONDITION FLAG: 9, QC FLAG: 4
    'SNOW_DEPTH-CM': 
        {"ID": 'AJ1', # pos 0-2
        'FACTOR': 1,
        'FIELD': slice(3, 7), # 3-6
        'COND_FIELD': 7, # 7
        'QC_FIELD': 8, #8
        },
    'SNOW_WATER_EQUIVALENT-MM': 
        {"ID": 'AJ1',
        'FACTOR': 10,
        'FIELD': slice(9, 15),
        'COND_FIELD': 15,
        'QC_FIELD': 16,
        },
    ## ex precip
    ## AA101000095
    ## |FEILD ID |PERIOD (HOURS) |PRECIP      |COND |QC |
    ## |00 01 02 |03 04          |05 06 07 08 |09   |10 |
    ## |A  A  1  |0  1           |0  0  0  0  |5    |9  |
    ##  PRECIP OVER 1 HOUR = 0000/10 => 0.0 mm CONDITION FLAG: 5, QC FLAG: 9
    'PRECIPTATION-MM': 
        {"ID": 'AA1',
        'FACTOR': 10,
        'FIELD': slice(5, 9),
        'COND_FIELD': 9,
        'QC_FIELD': 10,
        },
    ## SOLAR RAD EX
    ## 
    ## |FEILD ID |RAD (AVG)      |QC |FLAG |RAD (MIN)      |QC |FLAG | ...
    ## |00 01 02 |03 04 05 06 07 |08 |09   |10 11 12 13 14 |15 |16   | ...
    ## |G  H  1  |0  0  0  0  0  |0  |0    |0  0  0  0  0  |0  |0    | ...
    ##
    ##   RAD (MAX)      |QC |FLAG |RAD (STD DEV)  |QC |FLAG |
    ##   17 18 19 20 21 |22 |23   |24 25 26 27 28 |29 |30   |
    ##   0  0  0  0  0  |0  |0    |0  0  0  0  0  |0  |0    |
    'SOLAR_RAD-AVG-W/METER-SQUARED':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(3, 8),
        'COND_FIELD': None,
        'QC_FIELD': 8,
        },
    'SOLAR_RAD-MIN-W/METER-SQUARED':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(10, 15),
        'COND_FIELD': None,
        'QC_FIELD': 15,
        },
    'SOLAR_RAD-MAX-W/METER-SQUARED':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(17, 22),
        'COND_FIELD': None,
        'QC_FIELD': 22,
        },
    'SOLAR_RAD-STD_DEV':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(24, 29),
        'COND_FIELD': None,
        'QC_FIELD': 29,
        },
    
    
    }
    

def missing (value):
    """
    returns true if all characters are 9
    """
    for i in value:
        if i != '9':
            return False
    return True   
    

def val_to_type (value, factor = 1, typ = float):
    """
    convert valuest to a type or returrn their missing value
    """
    #~ print value, factor ,typ
    #~ print len(value), set(value)
    test = value
    if value[0] in '+-':
        test = value[1:]
    if set(test) == set(['9']):
        return -9999
        #all values are nine, so it's the missing data value
    return typ(value)/factor

def convert (in_file, out_file = None):
    """
    convert the ISD(ISH) to a time series like .csv file
    
    inputs:
        in_file: path to input text file
    """
    
    # set up data
    data = []
    
    # load .dly as text and split to list of lines
    with open(in_file,'r') as fd:
        text = fd.read()
    lines = text.split('\n')
    if lines[-1] =='':
        lines = lines[:-1]
    
    # processing loop
    l_idx = 0
    for line in lines:
        # TODO add sests for missing values
        temp = {"TIMESTAMP": 
                    datetime.strptime(line[DATE] + line[TIME],'%Y%m%d%H%M'),
                #~ "USAF_ID": line[STATION_ID],
                #~ "WBAN": line[WBAN].
                "AIR_TEMP-C": val_to_type(line[AIR_TEMP], AIR_TEMP_FACTOR),
                "AIR_TEMP_QC":line[AIR_TEMP_QC],
                "DEW_POINT-C": val_to_type(line[DEW_POINT],AIR_TEMP_FACTOR),
                "DEW_POINT_QC": line[DEW_POINT_QC],
                "WIND_DIR-DEGFROMNORTH": val_to_type(line[WIND_DIR], typ = int),
                "WIND_DIR_QC": line[WIND_DIR_QC],
                "WIND_DIR_TYPE": line[WIND_OBS_TYPE],
                "WIND_SPEED-METERSPERSECOND": val_to_type(line[WIND_SPEED], WIND_SPEED_FACTOR),
                "WIND_SPEED_QC": line[WIND_SPEED_QC],
                "SEA_LEVEL_PRESSURE-HPA": 
                    val_to_type(line[PRESSURE], PRESSURE_FACTOR),
                "SEA_LEVEL_QC": line[PRESSURE_QC],
                "CEILING-M": val_to_type( line[SKY_COND]),
                "CEILING_QC": line[SKY_COND_QC],
                "CEILING_DETEMINATION": line[SKY_COND_OBS_CODE],
                "CEILING_CAVOK": line[SKY_COND_CAVOK_CODE],
                
                }
        
        #~ print line[DEW_POINT], line[DEW_POINT_QC], line[PRESSURE], line[PRESSURE_QC]
        for k in OPTIONAL_FIELD:
            if line.find(OPTIONAL_FIELD[k]['ID']) == -1:
                #~ print 'skiping', k
                continue
            #~ print 'using', k
            current = line[line.find(OPTIONAL_FIELD[k]['ID']):]
            #~ print current[:20]
            field = current[OPTIONAL_FIELD[k]['FIELD']]
            #~ print field
            
            temp[k] = val_to_type(field, OPTIONAL_FIELD[k]['FACTOR'])
            temp[k + "_QC_FLAG"] = current[OPTIONAL_FIELD[k]['QC_FIELD']]
            
            if not OPTIONAL_FIELD[k]['COND_FIELD'] is None:
                temp[k + "_CONDITION"] = \
                                 current[OPTIONAL_FIELD[k]['COND_FIELD']]
            #~ print temp[k], temp[k + "_QC_FLAG"], temp[k + "_CONDITION"]
       
        data.append(temp)

    # convert to pandas dataframe and set date and 
    # GHCN core elements to be first columns
    data =  DataFrame(data)
    #~ print data
    cols = data.columns
    cols = list(cols)
    start_cols = ['TIMESTAMP']
    for col in start_cols:
        cols.remove(col)
    cols = start_cols + cols
    
    # save file
    if out_file is None:
        pth, f = os.path.split(in_file)
        out_file = os.path.join(pth,f.split('.')[0] + '.csv')
    data[cols].to_csv(out_file,index=False)
    
    
    
        
    
#~ convert('702000-26617-1996')
        
