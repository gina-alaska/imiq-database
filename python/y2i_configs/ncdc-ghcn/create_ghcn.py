'''
Create GHCN Arguments
---------------------
File: create_ghcn_arguments.py

tool for generating y2i argument files for use with the y2i ghcn conf file
'''
import os
import sys


## file name for sc_list_file, a text file with GHCN sitecodes, one on each line
sc_list_file = sys.argv[1]

## template file, use __GHCN_datavalues_args_template.yaml
template_file = sys.argv[2]

## working dir #path to where files are
working_dir = sys.argv[3]

## directory to write to
config_dir = sys.argv[4]


with open(sc_list_file, 'r') as scl:
    text = scl.read().strip().replace('\r','')
    sc_list = text.split('\n')

for site in sc_list:
    print site
    with open(template_file, 'r') as arg_temp:
        for i in range(6):
            arg_temp.readline()
        text = arg_temp.read().replace("<SITECODE>", site).replace(
            "<root_path>", working_dir
        )

    comment = "#Y2I argument file for GHCN site " + site + "\n"

    text = comment + text

    filename = site + '.yaml'
    cfg = os.path.join(config_dir, filename)
    with open(cfg, 'w') as cfg_f:
        cfg_f.write(text)
