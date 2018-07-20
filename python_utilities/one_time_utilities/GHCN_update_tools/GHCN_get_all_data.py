#~ import wget
from urllib2 import urlopen
import os.path

url_base = "https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/all/"
with open("GHCN_update_tools/__current_imiq_GHCN_site_list.txt", 'r') as txt:
    sites = txt.read().replace('"','')
    
sites = sites.split('\n')

for site in sites:
    try:
        response = urlopen(url_base+site+'.dly')
        with open(site+'.dly', 'w') as s:
            s.write(response.read())
    except:
        pass
