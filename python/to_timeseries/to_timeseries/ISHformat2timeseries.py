"""
ISH2timeseries.py
rawser spicer
2017-01-26

ISH FILE FOMATS HAVE NO extention

V1.0.0 

Changes
"""
from pandas import DataFrame
from datetime import datetime
import os



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

#celing height
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
    'SNOW_DEPTH': 
        {"ID": 'AJ1',
        'FACTOR': 1,
        'FIELD': slice(0, 4),
        'COND_FIELD': 4,
        'QC_FIELD': 5,
        },
    'SNOW_WATER_EQUIVALENT': 
        {"ID": 'AJ1',
        'FACTOR': 10,
        'FIELD': slice(6, 12),
        'COND_FIELD': 12,
        'QC_FIELD': 13,
        },
    'PRECIPTATION': 
        {"ID": 'AA1',
        'FACTOR': 10,
        'FIELD': slice(2, 4),
        'COND_FIELD': 4,
        'QC_FIELD': 5,
        },
    'SOLAR_RAD-AVG':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(0, 5),
        'COND_FIELD': None,
        'QC_FIELD': 5,
        },
    'SOLAR_RAD-MIN':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(7, 12),
        'COND_FIELD': None,
        'QC_FIELD': 12,
        },
    'SOLAR_RAD-MAX':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(15, 20),
        'COND_FIELD': None,
        'QC_FIELD': 20,
        },
    'SOLAR_RAD-STD_DEV':
        {"ID": 'GH1',
        'FACTOR': 10,
        'FIELD': slice(22, 27),
        'COND_FIELD': None,
        'QC_FIELD': 7,
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
    for i in value:
        #~ print i
        if i in '+-':
            # don't test sign
            continue
        if i != '9':
            #~ print typ(value)/factor
            return typ(value)/factor
    #~ print value
    return value  

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
                "AIR_TEMP": val_to_type(line[AIR_TEMP], AIR_TEMP_FACTOR),
                "AIR_TEMP_QC":line[AIR_TEMP_QC],
                "DEW_POINT": val_to_type(line[DEW_POINT],AIR_TEMP_FACTOR),
                "DEW_POINT_QC": line[DEW_POINT_QC],
                "WIND_DIR": val_to_type(line[WIND_DIR], typ = int),
                "WIND_DIR_QC": line[WIND_DIR_QC],
                "WIND_DIR_TYPE": line[WIND_OBS_TYPE],
                "WIND_SPEED": val_to_type(line[WIND_SPEED], WIND_SPEED_FACTOR),
                "WIND_SPEED_QC": line[WIND_SPEED_QC],
                "SEA_LEVEL_PRESSURE": 
                    val_to_type(line[PRESSURE], PRESSURE_FACTOR),
                "SEA_LEVEL_QC": line[PRESSURE_QC],
                "CEILING": val_to_type( line[SKY_COND]),
                "CEILING_QC": line[SKY_COND_QC],
                "CEILING_DETEMINATION": line[SKY_COND_OBS_CODE],
                "CEILING_CAVOK": line[SKY_COND_CAVOK_CODE],
                
                }
        
        #~ print line[DEW_POINT], line[DEW_POINT_QC], line[PRESSURE], line[PRESSURE_QC]
        for k in OPTIONAL_FIELD:
            if line.find(OPTIONAL_FIELD[k]['ID']) == -1:
                #~ print k
                continue
            current = line[line.find(OPTIONAL_FIELD[k]['ID'])+3:]
            #~ print current
            field = current[OPTIONAL_FIELD[k]['FIELD']]
            
            if missing(field):
                temp[k] = field
            else:
                temp[k] = float(field)/OPTIONAL_FIELD[k]['FACTOR']
                
            #~ temp[k + "_RAW"] = field
            temp[k + "_QC_FLAG"] = current[OPTIONAL_FIELD[k]['QC_FIELD']]
            
            if not OPTIONAL_FIELD[k]['COND_FIELD'] is None:
                temp[k + "_CONDITION"] = \
                                 current[OPTIONAL_FIELD[k]['COND_FIELD']]
       
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
        
