"""
utility
-------
utility.py

Utility for the data_puller

"""
import pull_ftp
import yaml

from utilitools import clite
import os

class DataPullerConfigError(Exception):
    """Custom exception to be raised when config is invalid
    """
    pass

def main (config, out_dir, echo = False):
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
    try: 
       validate_config(config)
    except RetriverConfigError as e:
        print "Config Invalid:", e
        return False
    
    try:
        if config['type'] == 'ftp':
            puller = pull_ftp.PullFTP(config)
        elif config['type'] == 'ish-ftp':
            puller = pull_ftp.PullISDFTP(config)
        elif config['type'] == 'webservice':  
            print "Websevices need to be written" 
            #~ puller = pull_webservice.PullWS(config)
            return False
        else:
            return False
    except StandardError as e:
        print "Config Invalid:", e
        return False
    
    puller.pull_data(out_dir, echo)
        
    return True
        

def validate_config (config):
    """returns True if confing is valid
    
    Parameters
    ----------
    config: dict
        config describing how to pull data
        
    Returns
    -------
    bool
    """
    cfg_required = set(['type'])
    if not set(config.keys())  >=  cfg_required:
        raise RetriverConfigError, "Config did not contain keys " + \
            str(cfg_required)
    
    valid_types =  ['ftp, webservice']
    if config['type'] in valid_types:
        raise RetriverConfigError, "Type was not in " + str(valid_tpyes)
    
    return True
    



def load_config (infile):
    """load confing from yaml
    
    Paramaters
    ----------
    infile: path
        yaml file
    
    Returns
    -------
    dict:
        config
    """
    with open(infile, 'r') as i:
        config = yaml.load(i)
    return config
    
    


UTILITY_HELP_STR = """
Tool to pull data from remote sources for processing and ingest into imiq

Use
---
    data-puller --config=ghcn_config.yml --directory=source-data/ghcn/
    
Flags
-----
--config: path
    config yaml file
--directory: path
    output directory
--echo: bool
    if true the utility will print messages to prompt

"""
 
def utility ():
    """ Function doc """
    try:
        arguments = clite.CLIte(['--config', '--directory'],['--echo',],
            types = {'--config':str, '--directory': str, '--echo':bool})
    except (clite.CLIteHelpRequestedError, clite.CLIteMandatoryError):
        print UTILITY_HELP_STR
        return
     
    try:
        os.mkdir(arguments['--directory'])
    except:
        pass
    
    echo = arguments['--echo'] if (not arguments['--echo'] is None) else False
    
    cfg = load_config(arguments['--config'])
        
    main(cfg ,arguments['--directory'], echo)
    
    
