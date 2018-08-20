"""
utility
-------
utility.py

Utility for the data_puller

"""
import dly2timeseries
import ISHformat2timeseries
import yaml

from utilitools import clite
import os

class DataPullerConfigError(Exception):
    """Custom exception to be raised when config is invalid
    """
    pass

def main (in_format, in_dir, out_dir, echo = False):
    """Function to manage the data pulling.
    
    Parameters
    ----------
    config: dict
        config describing how to pull data
    out_dir: path
        path to store data locally
    echo: bool, default False
        if true status messages are printed to prompt.
    
    Returns
    -------
    bool
        True, if utility is succesull
    """
    in_format = '.' + in_format if in_format[0] != '.' else in_format

    if in_format == '.dly':
        converter = dly2timeseries
    if in_format == '.isdtxt':
        converter = ISHformat2timeseries
    else:
        return False
        
    
    for filename in [f for f in os.listdir(in_dir) if f.find(in_format) != -1]:
        in_file = os.path.join(in_dir,filename)
        if echo:
            print in_file
        out_file = os.path.join(out_dir, filename.split('.')[0] + '.csv')
        converter.convert(in_file,out_file)
        
    return True
        
    


UTILITY_HELP_STR = """
Tool to format raw data to csv for processing into sql and ingest into imiq

Use
---
    
    
Flags
-----

--echo: bool
    if true the utility will print messages to prompt
--in-dir
--out-dir
--format: str
    .dly, or .isdtxt

"""
 
def utility ():
    """ Function doc """
    try:
        arguments = clite.CLIte([
            '--in-dir', '--out-dir', '--format'
            ],
            ['--echo',],
            types = {
                '--in-dir':str,'--out-dir': str,
                '--format': str, '--echo':bool
            })
    except (clite.CLIteHelpRequestedError, clite.CLIteMandatoryError):
        print UTILITY_HELP_STR
        return
     
    try:
        os.makedirs(arguments['--out-dir'])
    except:
        pass
    
    echo = arguments['--echo'] if (not arguments['--echo'] is None) else False
    
        
    main(
        arguments['--format'], 
        arguments['--in-dir'], 
        arguments['--out-dir'], 
        echo
    )
    
    
