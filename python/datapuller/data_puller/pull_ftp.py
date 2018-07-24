"""
pull FTP
--------
pull_ftp.py

class for pulling data from ftp.

TODO
----
    * at some point the __init__ function may need to be updated to support
        login with user and password
    * speed up with multiprocessing?

"""
from ftplib import FTP, error_perm
import os

class PullFTPConfigError(Exception):
    """Custom exception to be raised when config is invalid
    """
    pass


class PullFTP ( object ):
    """This class pulls data from ftp
    
    Parameters
    ----------
    config: dict
        config dictionary with keys:
            url_base: string base ftp url I.E. ftp.ncdc.noaa.gov
            cwd: path to working directory to pull files from I.E. 
                /pub/data/ghcn/daily/all     
            files: a list of files to pull
    """
    
    def __init__ (self, config):
        """ Class initialiser """
        cfg_required = set(['files', 'url_base', 'cwd'])
        if not set(config.keys())  >=  cfg_required:
            raise PullFTPConfigError, "Config did not contain keys " + \
                str(cfg_required)
        
        self.ftp = FTP (config['url_base'])
        self.ftp.login()   
        self.ftp.cwd(config['cwd'])
        self.files = config['files']
        if not type(self.files) is list:
            raise PullFTPConfigError, "configs files value was not a list"

        
    def __del__(self):
        """ Destructor
        """
        self.ftp.quit()
       
    def pull_data (self, directory, echo = False):
        """Gets ftp data to a directory
        
        Parameters
        ----------
        directory: path
            path to write files to
        """
        for f in self.files:
            if echo: 
                print "fetching: ", f
                
            try: 
                self.ftp.retrbinary(
                    'RETR ' + f,
                    open(os.path.join(directory,f), 'wb').write
                ) 
            except error_perm as e: 
                if echo:
                    print e
                pass
