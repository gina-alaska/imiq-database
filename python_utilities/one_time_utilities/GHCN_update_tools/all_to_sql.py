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

for f in files:
    
    # 1)
    with open('__GHCN_datavalues_args_template.yaml', 'r') as arg_temp:
        text = arg_temp.read().replace("<SITECODE>", f[:-4])
    
    cfg = './cfg_files/' + f[:-4] + '.yaml'
    with open(cfg, 'w') as cfg_f:
        cfg_f.write(text)

    # 2)
    print f
    y2i.utility(cfg)
        
    
