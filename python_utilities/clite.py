import sys


class CLIte (object):
    """ Class doc """
    
    def __init__ (self, mandatory, optional = []):
        """ Class initialiser """
        self.flags = mandatory + optional
        self.args = {}
        for item in sys.argv[1:]:
            try:
                flag, value = item.split('=')
                self.args[flag] = value
            except ValueError:
                flag = item.split('=')[0]
                self.args[flag] = True
        if not set(mandatory) <= set(self.args.keys()) or not set(self.args.keys()) <= set(self.flags):
            raise StandardError, "Invalid flags"
            
        
    def __getitem__ (self, key):
        """ Function doc """
        try:
            return self.args[key]
        except KeyError:
            if key in self.flags:
                return None
            else:
                raise KeyError, key
        
        
        
        

if __name__ == "__main__":
    try:
        test = CLIte(['--a','--b'],['--c'])
    except  StandardError:
        print """
Valid flags are:
    --a, --b, and --c(optional)
        """
    print test['--a']
    print test['--b']
    print test['--c']
    
