from string import Template
from math import log2

def create_L1_Butterfly(size,L2_NETWORK_NODE_FILES,L2_NETWORK_BSV_MODULES):
    d = {}


    # NODES
    # size = 4

    OUTPUT_FILE_NAME = f"Noc_butterfly{size}x{size}L1" + ".bsv"
    IF_OUT_TO_FILE = True
    connect_nodes_noc = []

    NO_OF_NETWORKS = size*2

    files_to_import = []
    l2_noc_list = []
    rule_l2_l1_connection = []

    for i in range(NO_OF_NETWORKS):
        files_to_import.append(f"import {L2_NETWORK_NODE_FILES[i]} :: * ;\n")
        l2_noc_list.append(f"\tlet noc_N{i} <- {L2_NETWORK_BSV_MODULES[i]};\n")

    d['import_l2_noc_files'] = ''.join(files_to_import)
    d['NOC_INSTANTIATE'] = ''.join(l2_noc_list)
    d['CONNECT_NODES_TO_NOC'] = "\n".join(connect_nodes_noc)

    with open(f'./Butterfly/ButterflyL1/Noc_butterfly{size}x{size}L1.txt', 'r') as f:
        src = Template(f.read())
        result = src.substitute(d)
        if(IF_OUT_TO_FILE):
            with open(OUTPUT_FILE_NAME, 'w') as op:
                op.write(result)
        else:
            print(result)