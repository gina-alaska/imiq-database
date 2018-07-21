"""
create sql for all files

steps
 0) find files in csv sub_dir
 1) create yaml argumes file from args template
 2) create sql using y2i.utility
"""

import os
import y2i

# 0)
files = [f for f in os.listdir('csv_files') if f.find('(') == -1 and f.find('.csv') != -1]

done = True 
for f in files:
    #~ if 'USW00026438.csv' == f:
        #~ done = False
    #~ if done is True:
        #~ continue
    # 1) get stie code and create Y2I argument file text
    with open('__GHCN_datavalues_args_template.yaml', 'r') as arg_temp:
        text = arg_temp.read().replace("<SITECODE>", f[:-4])
    
    ## save Y2I argument file for a site
    cfg = './cfg_files/' + f[:-4] + '.yaml'
    with open(cfg, 'w') as cfg_f:
        cfg_f.write(text)

    # 2)
    print f
    y2i.utility(cfg)
        
    
