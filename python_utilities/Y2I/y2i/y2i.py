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
        """
        #~ print config_file
        
        if template_args is None:
            with open(config_file, 'r') as cfg:
                self.config = yaml.load(cfg)
        else:
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
        """Load the input files. Sets data[fame] = <file_data> for each file.
        """
        for f in self.config['infiles']:
            self.data[f] = read_csv(f, 
                skiprows = self.config['infiles'][f]['skiprows'],
                low_memory= False)
               
            try:
                if 'columns' in self.config['infiles'][f].keys():
                    self.data[f] = \
                        self.data[f][self.config['infiles'][f]['columns']]
            except KeyError:
                msg = "cannot find columns " + \
                    str(self.config['infiles'][f]['columns'])
                raise RuntimeError, msg
                
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
                #~ print "A"
                pass
            #~ print self.data[f].iloc[:10]
                
    def load_length (self):
        """Load the lenth of the data to add into imiq. Sets length."""
        if 'of_file' in self.config['length'].keys():
            self.length = len(self.data[self.config['length']['of_file']])
        else: 
            self.length = self.config['length']['constant']

    def create_table (self):
        """create a proxy the table for the database as a dataframe. Sets table.
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
                    
                    ## REPLACE feature:
                    # TODO: remove, use special conditions instead -------------
                    try:
                        if not col['replace'] is None:
                            warnings.filterwarnings("ignore")
                            #~ for col['replace'].keys():
                            reps = list( set(col['replace'].keys()) -\
                                            set(['default']))
                            values[values.isin(reps) == False] = \
                                                col['replace']['default']
                            for k in reps:
                                values[values == k] = col['replace'][k]
                    except KeyError as e:
                        pass
                    warnings.filterwarnings("default")
                    #-----------------------------------------------------------
                    
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
        
    
    def to_string (self):
        """
        Returns
        -------
            the insert sql statement as a string
            
        """
        #~ print self.table.fillna('NULL').iloc[:10]
        table = self.table.fillna('NULL').values.tolist()
        string = "INSERT INTO " + self.config['schema'] + '.' + \
                    self.config['table'] + \
                    ' ' + str(tuple(self.columns)).replace("'","") + ' VALUES\n' 
        #~ print table[:10]
        for row in table:
            #~ print row
            #~ break
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
            
            
        if row.find('NaT') != -1:
            print "An invalid time was located.'\
                    ' Please search on 'Nat' to locate"
            
        if 'sql comment' in self.config.keys():
            string = '--' + self.config['sql comment'] +\
                '\n' + string[:-2] + ';'
        else: 
            string = string[:-2] + ';'
            
        # replace null values
        return string.replace("'None'","NULL").replace("'NULL'","NULL")

    def save_sql (self):
        """Saves sql file as out file described in config
        """
        try:
            mode = self.config['mode']
        except KeyError:
            mode = 'w'
        with open(self.config['name'], mode) as sql:
            sql.write(self.to_string()+'\n')
            
    def generate_sql (self):
        """Create the table and generate the sql file
        """
        self.create_table()
        self.save_sql()
        
def get_datastreamid(sitecode, varcode, creds):
    """Get datastreamid from imiq
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
        

def test():
    """test utility
    """
    converter = Y2I('example.yaml')
    converter.generate_sql()
    
def utility (script):
    try:
        ## config is argument/template type
        setup = script
        with open(setup, 'r') as s:
            setup = yaml.load(s)
        for i in range(len(setup['arguments'])):
            try:
                print setup['arguments'][i]['name']
            except KeyError:
                print "No Name"
            try:
            #~ print  setup['arguments'][i]['value_column']
                converter = Y2I(setup['template'], setup['arguments'][i])
            #~ print converter.config
            
                converter.generate_sql()
            except RuntimeError as e:
                print e
                print " -- no sql generated"
                continue
    except KeyError as e:
        print e
        ## config is plain config type 
        converter = Y2I(script)
        converter.generate_sql()
    #~ print "\n\n"
    
def main ():
    """main utility function.
    
    python y2i.py <config.yaml>
    
    config.yaml may be a yaml config file or a yaml describing a template file
    """
    #~ print sys.argv[1:]
    utility(sys.argv[1])
    
if __name__ == "__main__":
    main()
    
        
