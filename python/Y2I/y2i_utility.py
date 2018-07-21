"""
Y2I (YAML to Insert)
--------------------

utility for using yaml file to describe conversion of csv files to .sql 
insert scripts

V1.0.1

change log:
    V1.0.1: (2017/02/14) updated comments

"""
from pandas import read_csv,concat,DataFrame,to_datetime
import posthaste as ph
import yaml
import os
import sys
import warnings

from y2i import utility
    
def main ():
    """main utility function.
    
    python y2i.py <config.yaml>
    
    config.yaml may be a yaml config file or a yaml describing a template file
    """
    #~ print sys.argv[1:]
    utility(sys.argv[1])
    
if __name__ == "__main__":
    main()
    
        
