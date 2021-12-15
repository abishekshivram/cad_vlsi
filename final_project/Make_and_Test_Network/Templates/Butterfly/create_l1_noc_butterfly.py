from string import Template
from math import log2

def create_L1_Butterfly(size,L2_NETWORK_NODE_FILES,L2_NETWORK_BSV_MODULES):
    d = {}

    OUTPUT_FILE_NAME = f"Noc_butterfly{size}x{size}L1" + ".bsv"
    IF_OUT_TO_FILE = True
    connect_nodes_noc = []

    NO_OF_NETWORKS = size*2

    files_to_import = []
    l2_noc_list = []
    rule_l2_l1_connection = """
    rule connect_N{net_id}_to_node{net_id_bin}_L1_to_L2;
            Flit data=defaultValue;
            data <- node{net_id_bin}.get_value_to_l2();
            data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
            data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
            noc_N{net_id}.put_value_from_l1(data);
        endrule
        rule connect_node{net_id_bin}_to_N{net_id}_L2_to_L1;
            Flit data=defaultValue;
            data <- noc_N{net_id}.get_value_to_l1();
            node{net_id_bin}.put_value_from_l2(data);
        endrule"""

    for i in range(NO_OF_NETWORKS):
        files_to_import.append(f"import {L2_NETWORK_NODE_FILES[i]} :: * ;\n")
        l2_noc_list.append(f"\tlet noc_N{i} <- {L2_NETWORK_BSV_MODULES[i]};\n")
        
        if NO_OF_NETWORKS == 8:
            bin = f"{i:0>3b}"
        elif NO_OF_NETWORKS == 16:
            bin = f"{i:0>4b}"
        elif NO_OF_NETWORKS == 32:
            bin = f"{i:0>5b}"
        connect_nodes_noc.append(rule_l2_l1_connection.format(net_id=i,net_id_bin=bin))

    d['import_l2_noc_files'] = ''.join(files_to_import)
    d['NOC_INSTANTIATE'] = ''.join(l2_noc_list)
    d['CONNECT_NODES_TO_NOC'] = "\n".join(connect_nodes_noc)

    with open(f'./Templates/Butterfly/Noc_butterfly{size}x{size}L1.txt', 'r') as f:
        src = Template(f.read())
        result = src.substitute(d)
        if(IF_OUT_TO_FILE):
            with open(OUTPUT_FILE_NAME, 'w') as op:
                op.write(result)
        else:
            print(result)