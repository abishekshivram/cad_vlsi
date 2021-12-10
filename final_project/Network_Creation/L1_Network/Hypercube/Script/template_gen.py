from string import Template
from math import log2

d = {}

NETWORK_ID = 0
OUTPUT_FILE_NAME = "HypercubeNoc.bsv"
IF_OUT_TO_FILE = True

# NODES
PACKAGE_NAME = "HypercubeNocL2"
d['PACKAGE_NAME'] = PACKAGE_NAME
d['NETWORK_ID'] = NETWORK_ID

with open('HypercubeNocTemplate.txt', 'r') as f:
    src = Template(f.read())
    result = src.substitute(d)
    if(IF_OUT_TO_FILE):
        with open(OUTPUT_FILE_NAME, 'w') as op:
            op.write(result)
    else:
        print(result)