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
from datetime import datetime, timedelta
from StringIO import StringIO
import gzip
import glob
import shutil

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
    
    def __init__ (self, 
            config, 
            cfg_required = set(['files', 'url_base', 'cwd'])
        ):
        """ Class initialiser """
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
                r = StringIO()
                #~ self.ftp.retrbinary(
                    #~ 'RETR ' + f,
                    #~ open(os.path.join(directory,f), 'wb').write
                #~ ) 
                self.ftp.retrbinary(
                    'RETR ' + f,
                    r.write
                ) 
                #~ print r.getvalue()
                with open(os.path.join(directory,f), 'wb') as f:
                    f.write(r.getvalue())
                
            except error_perm as e: 
                if echo:
                    print e
                pass
                
class PullISDFTP (PullFTP):
    """"""
    
    def __init__ (self, config):
        """ Class initialiser """
        cfg_required = set(['start_year', 'url_base', 'cwd', 'stations' ])
        config['files'] = []
        super(PullISDFTP,self).__init__(config, cfg_required)
        del config['files']
        
        current_year = (datetime.now() - timedelta(weeks = 12)).year
        if config['start_year'] == 'current':
            start_year = current_year
        else:
            start_year = config['start_year']
        self.years = range(start_year, current_year+1)
        self.stations = config['stations']
        for year in self.years:
            for station in self.stations:
                self.files.append(
                    str(year) + '/' + station +'-' + str(year) + '.gz'
                )
        
        
        
    def pull_data (self, directory, echo = False):
        """ """
        for year in self.years:
            os.mkdir(os.path.join(directory,str(year)))
        super(PullISDFTP,self).pull_data(directory, echo)
        for fn in self.files:
            f = os.path.join(directory,fn)
            if os.path.exists(f):
                os.rename(f, os.path.join(directory, os.path.split(f)[1]))
        for year in self.years:
            os.rmdir(os.path.join(directory,str(year)))
        
        for station in self.stations:
            #~ print os.path.join('./'+directory, station+'*.gz')
            files = glob.glob(os.path.join(directory, station+'*.gz'))
            #~ print files
            for fn in files:
                with gzip.open( fn, 'rb') as f_in:
                    with open(os.path.join(directory, station+'.isdtxt'), 'ab') as f_out:
                        shutil.copyfileobj(f_in, f_out)
                os.remove(fn)
            
    
