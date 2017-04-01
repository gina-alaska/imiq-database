import wget
import os.path

url_base = "https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/all/"
with open("__GHCN_site_list.txt", 'r') as txt:
    sites = txt.read().replace('"','')
    
sites = sites.split('\n')

for site in sites:
    wget.download(url_base+site+'.dly')
