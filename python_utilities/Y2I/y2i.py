from pandas import read_csv,concat,DataFrame,to_datetime
import yaml
import os


class Y2I (object):
    """ Yaml to Imiq (or Insert) """
    
    def __init__ (self, config_file):
        """ Class initialiser """
        with open(config_file, 'r') as cfg:
            self.config = yaml.load(cfg)
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
                if col['dtype'] == 'datetime':
                    values = to_datetime(self.data[col['source']][col['value']],
                                                    infer_datetime_format=True)
                else:
                    dt = col['dtype']
                    values = self.data[col['source']][col['value']].astype(dt)
                
                self.table = concat([self.table, values],axis = 1)
            else:
                self.table[col['name']] = col['value']
    
    def to_string (self):
        """ return the insert sql statement as a string """
        
        table = self.table.values.tolist()
        string = "INSERT INTO " + self.config['schema'] + '.' + \
                                    self.config['table'] + \
                                    ' ' + str(tuple(self.columns)) + ' VALUES\n' 
    
        for row in table:
            string += self.tab + str(row).replace('(',' ').replace(')',' ').\
                                     replace('[','(').replace(']',')') + ',\n'
            
        string = string[:-2] + ';'
            
        return string

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
    
    
if __name__ == "__main__":
    test()
    
        
