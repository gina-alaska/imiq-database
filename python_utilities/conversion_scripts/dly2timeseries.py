"""
dly2timeseries.py
rawser spicer
2016-12-09

convert DAILY GLOBAL HISTORICAL CLIMATOLOGY NETWORK .dly to csv time series
see GHCN_readme.txt for original file foramth info
"""
from pandas import DataFrame
from datetime import date
import os



# .dly file info
## last column of 'metadata'
METADATA_END_COLUMN = 21
## last columns for 'metadata', start is the previous break or 0 for siteid
SITEID_BREAK = 11
YEAR_BREAK = 15
MONTH_BREAK = 17
ELEMENT_BREAK= 21

## columns realtive to data and flags
DATA_LENGTH = 8
REL_VALUE_BREAK = 5
REL_MFLAG = 5
REL_QFLAG = 6             
REL_SFLAG = 7

def convert (in_file, out_file = None):
    """
    convert the .dly file (GHCH data file) to a time series like .csv file
    
    inputs:
        in_file: path to input .dly file
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
    while l_idx != len(lines):
        
        ## get first row for a month/year
        line = lines[l_idx]
        site = line[:SITEID_BREAK]
        year = line[SITEID_BREAK:YEAR_BREAK]
        month = line[YEAR_BREAK:MONTH_BREAK]
        
        ## get rows that are the same year/month
        temp_lines = [line]
        while True:
            # skip index ahead at start  b/c we load the frist row out of loop
            l_idx += 1
            if l_idx == len(lines):
                # end of data
                break
            # test year/month
            if lines[l_idx][SITEID_BREAK:YEAR_BREAK] == year and\
                lines[l_idx][YEAR_BREAK:MONTH_BREAK] == month:
                temp_lines.append(lines[l_idx])
            else:
                break
            
        ## process a months rows
        temp_rows = []
        for row in temp_lines:
            # get the field and data for the month
            field = row[MONTH_BREAK:ELEMENT_BREAK]
            months_data = row[METADATA_END_COLUMN:]
            
            day = 1 # day of month
            start = 0 # start of current days value and flags
            while start < len(months_data):
                # get value and flags
                temp_val = float(months_data[start: start + REL_VALUE_BREAK])
                m_flag = months_data[start + REL_MFLAG]
                q_flag = months_data[start + REL_QFLAG]
                s_flag = months_data[start + REL_SFLAG]
    
                try:
                    # add first day
                    temp_rows[day-1]['date'] = date(int(year),int(month),day)
                    temp_rows[day-1][field] = temp_val
                    temp_rows[day-1][field + '_mflag'] = m_flag
                    temp_rows[day-1][field + '_qflag'] = q_flag
                    temp_rows[day-1][field + '_sflag'] = s_flag
                except IndexError:
                    # add other days
                    temp_rows.append({'date': date(int(year),int(month),day),
                                      field: temp_val,
                                      field + '_mflag': m_flag,
                                      field + '_qflag': q_flag,
                                      field + '_sflag': s_flag 
                                     })
                except ValueError as e:
                    ## we've reached the end of the month of date 
                    ## constructor fails
                    try:
                        date(int(year),int(month),day)
                    except ValueError as e2:
                        if str(e) == str(e2):
                            break
                        else:
                            raise ValueError, e
                        
                # increment day
                day +=1
                start = start + DATA_LENGTH 
                
        # add month to data 
        data += temp_rows

    # convert to pandas dataframe and set date and 
    # GHCN core elements to be first columns
    data =  DataFrame(data)
    cols = data.columns
    cols = list(cols)
    start_cols = ['date','PRCP','PRCP_mflag','PRCP_qflag','PRCP_sflag',
                  'SNOW','SNOW_mflag','SNOW_qflag','SNOW_sflag',
                  'SNWD','SNWD_mflag','SNWD_qflag','SNWD_sflag',
                  'TMAX','TMAX_mflag','TMAX_qflag','TMAX_sflag',
                  'TMIN','TMIN_mflag','TMIN_qflag','TMIN_sflag',
                  ]
    for col in start_cols:
        cols.remove(col)
    cols = start_cols + cols
    
    # save file
    if out_file is None:
        pth, f = os.path.split(in_file)
        out_file = os.path.join(pth,f.split('.')[0] + '.csv')
    data[cols].to_csv(out_file,index=False)
    
    
    
        
    
convert('USW00026617.dly.txt')
        
