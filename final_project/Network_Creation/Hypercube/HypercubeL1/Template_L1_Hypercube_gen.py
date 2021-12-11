from string import Template
from math import log2

def create_L1_Hypercube(L2_NETWORK_NODE_FILES,L2_NETWORK_BSV_MODULES):
    d = {}

    NETWORK_ID = 0
    NUMBER_OF_NODES = 3
    NO_OF_NETWORKS = NUMBER_OF_NODES
    IF_OUT_TO_FILE = True


    d['NETWORK_ID'] = f"{NETWORK_ID}"


    # NODES
    PACKAGE_NAME = "HypercubeNocL1"
    d['PACKAGE_NAME'] = PACKAGE_NAME 
    OUTPUT_FILE_NAME = PACKAGE_NAME + ".bsv"



    l1_nodes_phrase = """\tAddress node{id}_address;  node{id}_address.netAddress={id};  node{id}_address.nodeAddress={id};
        let nodeL1_{id}   <- mkHypercubeL1Node{id}VC(node{id}_address); 
    """

    l1_inst_nodes = []
    l2_networks = []
    files_to_import = []

    for i in range(8):
        files_to_import.append(f"import {L2_NETWORK_NODE_FILES[i]} :: * ;\n")
        sentence = "\tlet noc_N{net_id} <- {module};\n"
        l2_networks.append(sentence.format(net_id=i,module =L2_NETWORK_BSV_MODULES[i]))
        l1_inst_nodes.append(l1_nodes_phrase.format(id=i))

    d['EIGHT_NETWORKS_HYPERCUBE_CONNECTED'] = ''.join(l2_networks)
    d['nodes_inst'] = ''.join(l1_inst_nodes)

    l1_l2_connections = []


    ruleL1L2 = """\trule connect_N{net_id}_to_node{net_id}_L1_to_L2;
            Flit data=defaultValue;
            data <- nodeL1_{net_id}.get_value_to_l2();
            data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
            data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
            noc_N{net_id}.put_value_from_l1(data);
        endrule
        rule connect_node{net_id}_to_N{net_id}_L2_to_L1;
            Flit data=defaultValue;
            data <- noc_N{net_id}.get_value_to_l1();
            nodeL1_{net_id}.put_value_from_l2(data);
        endrule
    """
    for i in range(8):
        l1_l2_connections.append(ruleL1L2.format(net_id=i))


    d['L1_TO_L2'] = ''.join(l1_l2_connections)

    with open('./Hypercube/HypercubeL1/Template_HypercubeL1Noc.txt', 'r') as f:
        src = Template(f.read())
        result = src.substitute(d)
        if(IF_OUT_TO_FILE):
            with open(OUTPUT_FILE_NAME, 'w') as op:
                op.write(result)
        else:
            print(result)
