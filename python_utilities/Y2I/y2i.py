from pandas import read_csv,concat,DataFrame,to_datetime
import yaml
import os
import sys

class Y2I (object):
    """ Yaml to Imiq (or Insert) """
    
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
                    text = text.replace('<' + arg + '>', str(template_args[arg]))
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
        """ This should validate the config file """
        return True
        
    def load_infiles (self):
        """ load the input files """
        for f in self.config['infiles']:
            self.data[f] = read_csv(f, 
                            skiprows = self.config['infiles'][f]['skiprows'])

    def load_length (self):
        """ load the lenth of the data to add into imiq """
        if 'of_file' in self.config['length'].keys():
            self.length = len(self.data[self.config['length']['of_file']])
        else: 
            self.length = self.config['length']['constant']

    def create_table (self):
        """ create a proxy the table for the database as a dataframe """
        self.table = DataFrame(index = range(self.length))
        
        for col in self.config['columns']:
            self.columns.append(col['name'])
            if col['source'] in self.data.keys():
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
                    values = "POINT("+self.data[col['source']][col['long']].astype(str) +' ' + self.data[col['source']][col['lat']].astype(str)  + ' ' + self.data[col['source']][col['elev']].astype(str)+ ')'
                else:
                    dt = col['dtype']
                    values = self.data[col['source']][col['value']].astype(dt)
                
                self.table = concat([self.table, values],axis = 1)
            else:
                #~ print 'b'
                self.table[col['name']] = col['value']
    
    def to_string (self):
        """ return the insert sql statement as a string """
        
        table = self.table.values.tolist()
        string = "INSERT INTO " + self.config['schema'] + '.' + \
                    self.config['table'] + \
                    ' ' + str(tuple(self.columns)).replace("'","") + ' VALUES\n' 
    
        for row in table:
            #~ print row
            row = str(row)
            row = '(' + row[1:-1] + ')'
            string += self.tab + row + ',\n'
            
        string = string[:-2] + ';'
            
        # replace null values
        return string.replace("'None'","NULL")

    def save_sql (self):
        """ Function doc """
        with open(self.config['name'], 'w') as sql:
            sql.write(self.to_string())
            
    def generate_sql (self):
        """ create the table and generate the sql file"""
        self.create_table()
        self.save_sql()
        

def test():
    converter = Y2I('example.yaml')
    converter.generate_sql()
    
def main ():
    """ Function doc """
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
            converter.generate_sql()
    except KeyError:
        converter = Y2I(sys.argv[1])
        converter.generate_sql()
    
if __name__ == "__main__":
    main()
    
        