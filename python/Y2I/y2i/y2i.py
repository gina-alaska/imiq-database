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
from utilitools import posthaste as ph
from utilitools import clite
import yaml
import os
import sys
import warnings

class Y2I (object):
    """Yaml to Imiq (or Insert). Use to convert csv files to instert scripts 
    throuh configuration files in yaml
    
    Parameters
    ----------
    config_file: path
        path to configuration file, see y2i_yaml_description.
    template_args: dictionary
        a dictionary of 
        
    Attributes
    ----------
    config : dictionary
        configuration information for conversion
    data : dictionary
        dictionary of data file keyed by filename
    columns : list
        list of columns to add to insert script
    length: int
        # of rows in table to insert
    table : pandas.DataFrame
        representation of tables data
    tab: str
        indetation size for to_string function defaults to 4 spaces
    
    
    """
    
    def __init__ (self, config_file, template_args = None):
        """Class initialiser 
        
        This loads the config file via 2 possible methods
        
        1) STANDALONE METHOD:
            if only the first (and required) argument, config_file, is provided
        the settings in that file are used as is to generate the insert scripts.
        
        2) TEMPLATE METHOD
        if config_file, and template_args, are provided the config_file
        is used as a template, and the arguments in template_args are used
        to fill in the template. Because the arguments in template_args
        are a list one config file can be written as a template in a way that 
        allows it to be used for multiple datastrams. See the examples.
        
        
        Parameters
        ----------
        config_file: path
            path to configuration file, see y2i_yaml_description.
        template_args: dictionary (optional)
            a dictionary of 
        
        """
        #~ print config_file
        

        if template_args is None:
            ## STANDALONE METHOD
            with open(config_file, 'r') as cfg:
                self.config = yaml.load(cfg)
        else:
            ## TEMPLATE METHOD
            with open(config_file, 'r') as cfg:
                text = cfg.read()
                for arg in template_args:
                    #~ print arg, template_args[arg]
                    #~ print template_args[arg]
                    text = text.replace('<' + arg + '>',
                        str(template_args[arg]))
                #~ print text
                self.config = yaml.load(text)
                #~ print text
        
        valid, reason = self.validate_config()
        if not valid:
            # write a custom error
            raise RuntimeError, "bad config file" + reason
            
        self.data = {}
        self.load_infiles()
        
        self.columns = []
        
        self.length = 0
        self.load_length()
        
        self.table = DataFrame([])
        self.tab = '    '
        
        try:
            self.new_data_only = self.config['only_add_new_data']
        except KeyError:
            self.new_data_only = True
        print self.new_data_only, type(self.new_data_only)
            
    def validate_config (self):
        """TODO: This should validate the config file """
        #~ return True, ""
        try:
            key = []
            key.append('name')
            if self.config['name']:
                pass
                #~ print os.path.isdir(os.path.split(self.config['name'])[0])
                
        except KeyError:
            return False, str(key)
        
        return True, ""
        
    def load_infiles (self):
        """Load the input CSV files. 
        Sets data[fame] = <file_data> for each file.
        """
        ## for each file
        for f in self.config['infiles']:
            self.data[f] = read_csv(f, 
                skiprows = self.config['infiles'][f]['skiprows'],
                low_memory= False)
            
            ## Check that rquired rows exitst
            ## TODO: possibly move before data is stored
            try:
                if 'columns' in self.config['infiles'][f].keys():
                    self.data[f] = \
                        self.data[f][self.config['infiles'][f]['columns']]
            except KeyError:
                msg = "cannot find columns " + \
                    str(self.config['infiles'][f]['columns'])
                raise RuntimeError, msg
                
            
            # for each row IF the value in the skipnan column is nan, 
            # do not load the row
            try:
                #### NOTE: create a tempfile to make sure rows are droped
                #### probably possible as strings"
                self.data[f] = self.data[f].dropna(\
                    subset = [self.config['infiles'][f]['skipnan']])
                self.data[f].to_csv('.temp.csv', index = False)
                try:
                    self.data[f] = read_csv('.temp.csv')
                except IOError:
                    pass
                try:
                    os.remove('.temp.csv')
                except OSError:
                    pass
            except KeyError:
                pass
            #~ print self.data[f].iloc[:10]
                
    def load_length (self):
        """Load the lenth of the data to add into imiq. Sets length."""
        if 'of_file' in self.config['length'].keys():
            self.length = len(self.data[self.config['length']['of_file']])
        else: 
            self.length = self.config['length']['constant']

    def create_table (self, login=None):
        """create the table for the database as a dataframe. Sets table.
        """
        ## set up rows for table
        self.table = DataFrame(index = range(self.length))
        #~ print self.table
        
        ## set up each column
        for col in self.config['columns']:
        
            ## add column to the list of columns
            self.columns.append(col['name'])
            
            ## check each source
            if col['source'] == "imiq":
                ## Source is on imiq, so get info from database
                # TODO: add statement for choosing functions.
                #~ self.imiq_login = col['imiq_login']
                self.imiq_login = login
                ## TODO implment function feature
                siteid = get_datastreamid(col['sitecode'],
                                          col['variablecode'],
                                          col['imiq_login'])
                self.table[col['name']] = siteid
            
            elif col['source'] in self.data.keys():
                ## source is a data file
                
                # TODO: this bit seems redundant ----------------
                try:
                    #int data
                    if type(col['value']) is int:
                        col['value'] = \
                            self.data[col['source']].columns[col['value']]
                except KeyError as e:
                    if col['dtype'] == 'geolocation':
                        pass
                    else:
                        raise KeyError, e
                # -------------------------
                        
                if col['dtype'] == 'datetime':
                    ## timestamp column, try to infer format, 
                    ## if not possible then use specified format
                    try:
                        values = \
                            to_datetime(self.data[col['source']][col['value']],
                            infer_datetime_format=True)
                    except ValueError:
                        values = \
                            to_datetime(self.data[col['source']][col['value']],
                            format = col['format'])
                    
                elif col['dtype'] == 'geolocation':
                    ## make geolocation form multiple columns
                    values = "POINT("  + \
                        self.data[col['source']][col['long']].astype(str) + \
                        ' ' + \
                        self.data[col['source']][col['lat']].astype(str) + \
                        ' ' + \
                        self.data[col['source']][col['elev']].astype(str) + ')'
                else:
                    ## use data type specified in yaml
                    dt = col['dtype']
                    values = self.data[col['source']][col['value']]
                    
                    ## Xonvert ot type
                    values = values.astype(dt)
                    ## Cpply scalers
                    try:
                        if not col['scaler'] is None and \
                            not type(col['scaler']) is str:
                            values[values != -9999] *= col['scaler']
                    except KeyError as e:
                        pass
                ## Add column to table
                self.table = concat([self.table, values],axis = 1)
            else:
                ## source is config file
                ## TODO: add features that from file has
                if col['dtype'] == 'datetime':
                    ## date time type
                    values = to_datetime(col['value'])
                    self.table[col['name']] = values
                else:
                    # scaler, or string
                    self.table[col['name']] = col['value']
               
               
        ## update Table columns
        self.table.columns = self.columns


        ## Special conditions to repalce values
        if 'special conditions' in self.config.keys():
            warnings.filterwarnings("ignore")
            conditions = self.config['special conditions']
            for c in conditions:
                ## for each condition
                
                ## create index
                if not c['condition'][c['condition'].keys()[0]] == "None":
                    idx = self.table[c['condition'].keys()[0]] == \
                        c['condition'][c['condition'].keys()[0]]
                else:
                    idx = self.table[c['condition'].keys()[0]] != \
                        c['condition'][c['condition'].keys()[0]]
        
                ## apply resluts
                for k in c['result']:
                    self.table[k][idx] = c['result'][k]
           
            warnings.filterwarnings("default")
        
    
    def to_string (self, echo = False):
        """
        Convert table to string insert statment.
        
        Parameters
        ----------
        echo: bool
        
        Returns
        -------
            the insert sql statement as a string
            
        """
        #~ print self.table.fillna('NULL').iloc[:10]
        table = self.table.fillna('NULL').values.tolist()
        string = "INSERT INTO " + self.config['schema'] + '.' + \
                    self.config['table'] + \
                    ' ' + str(tuple(self.columns)).replace("'","") + ' VALUES\n' 
        init_str = string 
        #~ print table[:10]
        #~ col= self.config
        dates_present_in_db = True
        if self.new_data_only:
            try:
                dsid = self.table['DatastreamID'].values[0]
                timestamps_present = \
                    to_datetime(
                        get_current_datastream_timestamps(dsid,self.imiq_login)
                    )
            except KeyError:
                dates_present_in_db = False
                
        #~ print timestamps_present
        for row in table:
            #~ print row
            if self.new_data_only and  dates_present_in_db:
                #~ if not(row[1] > ld):
                    #~ continue
                if row[1] in  timestamps_present:
                    continue
            if echo:
                print 'Adding row to sql:'
                print '   ', row
                
            
            row = str(row)
            row = '(' + row[1:-1] + ')'
            while row.find("Timestamp(") != -1:
                ts_sec = row[row.find("Timestamp")+len("Timestamp"):]
                start = row[:row.find("Timestamp")+len("Timestamp")]
                remaing = ts_sec[ts_sec.find(')')+1:]
                ts_sec = ts_sec[:ts_sec.find(')')+1]
                row = start + ' '+ ts_sec[1:-1]+ ' ' + remaing 
                
                #~ row = row[:row.find("Timestamp")+len("Timestamp")]
            string += self.tab + row + ',\n'
            
        if string == init_str:
            return ''
        
        if row.find('NaT') != -1:
            if echo:
                print "    An invalid time was located.'\
                    ' Please search on 'Nat' to locate"
            
        if 'sql comment' in self.config.keys():
            string = '--' + self.config['sql comment'] +\
                '\n' + string[:-2] + ';'
        else: 
            string = string[:-2] + ';'
            
        # replace null values
        return string.replace("'None'","NULL").replace("'NULL'","NULL")

    def save_sql (self, echo = False):
        """Saves sql file as out file described in config
        """

        try:
            mode = self.config['mode']
        except KeyError:
            mode = 'w'
        s = self.to_string(echo)
        if s == '':
            if echo:
                print "No new data not writing to sql."
            return
        with open(self.config['name'], mode) as sql:
            sql.write(s+'\n')
            
    def generate_sql (self, login=None, echo = False):
        """Create the table and generate the sql file
        """
        self.create_table(login)
        self.save_sql(echo)
        
def get_datastreamid(sitecode, varcode, creds):
    """Get datastreamid from imiq
    
    Parameters
    ----------
    sitecode: str
        the sitecode for an imiq site
    varcode: str
        the varcode for an imiq variable
    creds: dict
        imiq database credentials 
    
    """
    s = ph.PostHaste(*ph.load_login(creds))
    s.sql = """select datastreamid from tables.datastreams 
    where 
    siteid in (select siteid from tables.sites where sitecode = 'SITECODE') 
        and 
    variableid in (select variableid from tables.variables where variablecode = 'VARCODE')
    """.replace('VARCODE',str(varcode)).replace('SITECODE',str(sitecode))

    s.run()

    try:
        return s.data().values[0][0]
    except IndexError:
        raise RuntimeError, "Datastreamid not found for: " + str(sitecode) + ' & ' + str(varcode)
        
#~ def get_last_date(dsid, creds):
    #~ s = ph.PostHaste(*ph.load_login(creds))
    #~ s.sql = """select max(localdatetime) from tables.datavalues where datastreamid = DSID"""
    #~ s.sql =  s.sql.replace('DSID', str(dsid))
    #~ s.run()
    #~ return s.data().values[0][0] 
    
def get_current_datastream_timestamps(dsid, creds):
    """Get the timestamps for a datastream that is currently in imiq, as a list. 
    
    Parameters
    ----------
    disd: int
        datastreamid in imiq 
    creds:
        imiq login credentials
    """
    s = ph.PostHaste(*ph.load_login(creds))
    s.sql = """select localdatetime from tables.datavalues where datastreamid = DSID"""
    s.sql =  s.sql.replace('DSID', str(dsid))
    s.run()
    #~ print s.data().T.values[0]
    return s.data().T.values[0]

def test():
    """test utility
    """
    converter = Y2I('example.yaml')
    converter.generate_sql()
    
def main (script, login, echo):
    """Function called by commandline utility to create insert scripts
    
    Parameters
    ----------
    script:
        input script file
    """
    try:
        ## config is argument/template type
        setup = script
        with open(setup, 'r') as s:
            setup = yaml.load(s)
        for i in range(len(setup['arguments'])):
            if echo:
                try:
                    print setup['arguments'][i]['name']
                except KeyError:
                    print "No Name"
            try:
            #~ print  setup['arguments'][i]['value_column']
                converter = Y2I(setup['template'], setup['arguments'][i])
            #~ print converter.config
            
                converter.generate_sql(login, echo)
            except RuntimeError as e:
                if echo:
                    print e
                    print " -- no sql generated"
                continue
    except KeyError as e:
        if echo:
            print 'Standalone Config Used'
        ## config is plain config type 
        converter = Y2I(script)
        converter.generate_sql(login, echo)
    #~ print "\n\n"
    
#~ def  ():
    #~ """ Function doc """
    

    
UTILITY_HELP_STR = """
converts csv files to sql insert scripts

Use
---
    
    
Flags
-----

--echo: bool
    if true the utility will print messages to prompt

"""
 
def utility ():
    """ Function doc """
    try:
        arguments = clite.CLIte(
            ['--config',],
            ['--echo','--login'],
            types = {'--config':str, '--echo':bool, '--login':str}
        )
    except (clite.CLIteHelpRequestedError, clite.CLIteMandatoryError):
        print UTILITY_HELP_STR
        return
     
    echo = arguments['--echo'] if (not arguments['--echo'] is None) else False
    login = arguments['--login'] if (not arguments['--login'] is None) else None        
    main(arguments['--config'], login, echo)
    
    
        

