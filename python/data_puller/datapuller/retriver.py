"""
"""
import pull_ftp
import yaml



class DataPullerConfigError(Exception):
    """Custom exception to be raised when config is invalid
    """
    pass

def data_puller (config, out_dir, echo = False):
    """ Function doc """
    try: 
       validate_config(config)
    except RetriverConfigError as e:
        print "Config Invalid:", e
        return False
    
    try:
        if config['type'] == 'ftp':
            puller = pull_ftp.PullFTP(config)
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
    """ Function doc """
    cfg_required = set(['type'])
    if not set(config.keys())  >=  cfg_required:
        raise RetriverConfigError, "Config did not contain keys " + \
            str(cfg_required)
    
    valid_types =  ['ftp, webservice']
    if config['type'] in valid_types:
        raise RetriverConfigError, "Type was not in " + str(valid_tpyes)
    
    return True
    



def load_config (infile):
    """ Function doc """
    with open(infile, 'r') as i:
        config = yaml.load(i)
    return config
