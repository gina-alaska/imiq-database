"""
Y2I (YAML to Insert)
--------------------

utility for using yaml file to describe conversion of csv files to .sql 
insert scripts

V1.0.0

"""
from pandas import read_csv,concat,DataFrame,to_datetime
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
    length:
    table
    tab
    
    
    """
    
    def __init__ (self, config_file, template_args = None):
        """ Class initialiser """
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
        
        if not self.validate_config():
            # write a custom error
            raise StandardError, "bad config file"
            
        self.data = {}
        self.load_infiles()
        
        self.columns = []
        
        self.length = 0
        self.load_length()
        
        self.table = DataFrame([])
        self.tab = '    '

            
    def validate_config (self):
        """TODO: This should validate the config file """
        return True
        
    def load_infiles (self):
        """load the input files. Sets data[fame] = <file_data> for each file
        """
        #~ print self.config.keys()
        #~ print self.config['infiles']
        for f in self.config['infiles']:
            #~ print f
            self.data[f] = read_csv(f, 
                            skiprows = self.config['infiles'][f]['skiprows'])
            self.data[f] = self.data[f][self.config['infiles'][f]['columns']]
            
            try:
                self.data[f] = self.data[f][self.data[f][self.config['infiles'][f]['skipnan']].isnull() == False]
            except KeyError:
                pass
                
    def load_length (self):
        """load the lenth of the data to add into imiq. Sets length"""
        if 'of_file' in self.config['length'].keys():
            self.length = len(self.data[self.config['length']['of_file']])
        else: 
            self.length = self.config['length']['constant']

    def create_table (self):
        """create a proxy the table for the database as a dataframe. sets table.
        """
        self.table = DataFrame(index = range(self.length))
        
        for col in self.config['columns']:
            self.columns.append(col['name'])
            
            if col['source'] == "imiq":
                siteid = get_datastreamid(col['sitecode'],col['variablecode'],col['imiq_login'])
                #~ print siteid
                self.table[col['name']] = siteid
            
            elif col['source'] in self.data.keys():
                try:
                    if type(col['value']) is int:
                        col['value'] = self.data[col['source']].columns[col['value']]
                except KeyError as e:
                    if col['dtype'] == 'geolocation':
                        pass
                    else:
                        raise KeyError, e
                if col['dtype'] == 'datetime':
                    values = to_datetime(self.data[col['source']][col['value']],
                                                    infer_datetime_format=True)
                elif col['dtype'] == 'geolocation':
                    values = "POINT("  + \
                        self.data[col['source']][col['long']].astype(str) + \
                        ' ' + \
                        self.data[col['source']][col['lat']].astype(str) + \
                        ' ' + \
                        self.data[col['source']][col['elev']].astype(str) + ')'
                else:
                    dt = col['dtype']
                    values = self.data[col['source']][col['value']]
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
                    
                    values = values.astype(dt)
                    # apply scalers
                    try:
                        if not col['scaler'] is None:
                            values[values != -9999] *= col['scaler']
                    except KeyError as e:
                        pass
                    
                self.table = concat([self.table, values],axis = 1)
            else:
                #~ print 'b'
                #~ print col['name']
                if col['dtype'] == 'datetime':
                    #~ print 
                    values = to_datetime(col['value'])
                    self.table[col['name']] = values
                else:
                    self.table[col['name']] = col['value']
               
            #~ self.table
            
        self.table.columns = self.columns
        #~ print self.table
        #~ print self.table[self.table['PRCP'] == -9999]['PRCP_qflag']
        warnings.filterwarnings("ignore")
        try:
            conditions = self.config['special conditions']
            for c in conditions:
                #~ print c['condition'].keys()[0],c['condition'][c['condition'].keys()[0]]
                #~ print self.table[c['condition'].keys()[0]]
                idx = self.table[c['condition'].keys()[0]] == c['condition'][c['condition'].keys()[0]]
                for k in c['result']:
                    #~ print c['result'][k]
                    self.table[k][idx] = float(c['result'][k])
                    #~ print self.table[idx][k]
        except:
            pass
        warnings.filterwarnings("default")
        
        #~ print self.table
        #~ print self.columns
    
    def to_string (self):
        """
        Returns
        -------
            the insert sql statement as a string
            
        """
        
        table = self.table.fillna('NULL').values.tolist()
        string = "INSERT INTO " + self.config['schema'] + '.' + \
                    self.config['table'] + \
                    ' ' + str(tuple(self.columns)).replace("'","") + ' VALUES\n' 
    
        for row in table:
            #~ print row
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
            
        string = string[:-2] + ';'
            
        # replace null values
        return string.replace("'None'","NULL").replace("'NULL'","NULL")

    def save_sql (self):
        """saves sql file as out file described in config
        """
        try:
            mode = self.config['mode']
        except KeyError:
            mode = 'w'
        with open(self.config['name'], mode) as sql:
            sql.write(self.to_string()+'\n')
            
    def generate_sql (self):
        """create the table and generate the sql file
        """
        self.create_table()
        self.save_sql()
        
import posthaste as ph
def get_datastreamid(sitecode, varcode, creds):
    s = ph.PostHaste(*ph.load_login(creds))
    s.sql = """
select datastreamid from tables.datastreams 
    where 
    siteid in (select siteid from tables.sites where sitecode = 'SITECODE') 
        and 
    variableid in (select variableid from tables.variables where variablecode = 'VARCODE')
    """.replace('VARCODE',str(varcode)).replace('SITECODE',str(sitecode))

    s.run()

    try:
        return s.data().values[0][0]
    except IndexError:
        raise StandardError, "Datastreamid not found for: " + str(sitecode) + ' & ' + str(varcode)
        

def test():
    """test utility
    """
    converter = Y2I('example.yaml')
    converter.generate_sql()
    
def main ():
    """main utility function.
    
    python y2i.py <config.yaml>
    
    config.yaml may be a yaml config file or a yaml describing a template file
    """
    try:
        setup = sys.argv[1]
        with open(setup, 'r') as s:
            setup = yaml.load(s)
        
        for i in range(len(setup['arguments'])):
            try:
                print setup['arguments'][i]['name']
            except KeyError:
                print "No Name"
            #~ print  setup['arguments'][i]['value_column']
            converter = Y2I(setup['template'], setup['arguments'][i])
            #~ print converter.config
            try:
                converter.generate_sql()
            except StandardError as e:
                print e
                print " -- no sql generated"
                continue
    except KeyError as e:
        print e
        converter = Y2I(sys.argv[1])
        converter.generate_sql()
    
if __name__ == "__main__":
    main()
    
        
