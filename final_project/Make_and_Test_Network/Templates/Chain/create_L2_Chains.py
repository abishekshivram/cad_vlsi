from string import Template
from math import log2

d = {}

# NO_OF_NETWORKS: Number of Chain Networks in L2
# ALL_NETWORK_NUM: The Network number associated with the Chain Network in L2
# ALL_NETWORK_ID: The hexadecimal network ID for each Chain L2 network
# ALL_NETWORK_DIM: The dimension of each Chain network in L2
def create_L2_Chains(NO_OF_NETWORKS, ALL_NETWORK_NUM, ALL_NETWORK_ID, ALL_NETWORK_DIM):
    # NO_OF_NETWORKS = 8
    # ALL_NETWORK_ID = [0, 1, 2, 3, 4, 5, 6, 7]
    # ALL_NETWORK_DIM = [6, 4, 5, 3, 4, 3, 2, 4]

    for i in range(NO_OF_NETWORKS):
        NETWORK_ID = ALL_NETWORK_ID[i]
        NUMBER_OF_NODES = ALL_NETWORK_DIM[i][0]*ALL_NETWORK_DIM[i][1]
        IF_OUT_TO_FILE = True

        d['NETWORK_ID'] = f"{ALL_NETWORK_NUM[i]}"

        ruleL2R = """\trule connect_Node{from_node}_to_Node{to_node}_L2R;
            let data{from_node}{to_node}_L2R <- node{from_node}.get_value_to_right();
            node{to_node}.put_value_from_left(data{from_node}{to_node}_L2R);
        endrule\n\n"""

        ruleR2L = """\trule connect_Node{from_node}_to_Node{to_node}_R2L;
            let data{from_node}{to_node}_R2L <- node{from_node}.get_value_to_left();
            node{to_node}.put_value_from_right(data{from_node}{to_node}_R2L);
        endrule\n\n"""

        # NODES
        PACKAGE_NAME = "ChainNocL2_"
        d['PACKAGE_NAME'] = PACKAGE_NAME + str(ALL_NETWORK_NUM[i])
        OUTPUT_FILE_NAME = PACKAGE_NAME + str(ALL_NETWORK_NUM[i]) + ".bsv"


        BITS_NEEDED = int(log2(NUMBER_OF_NODES)) + 1
        all_nodes = []
        rules_L2R = []
        rules_R2L = []
        
        all_nodes.append(f"\tAddress head_node_addr;  head_node_addr.netAddress={NETWORK_ID};  head_node_addr.nodeAddress={NUMBER_OF_NODES//2};\n\n")
        
        for i in range(NUMBER_OF_NODES):
            string_node = f"\tAddress node{i}_address;  node{i}_address.netAddress={NETWORK_ID};  node{i}_address.nodeAddress={i};\n"	
            if(i==NUMBER_OF_NODES//2):
                string_node += f"\tlet node{i}   <- mkChainL2HeadNode(node{i}_address, head_node_addr);\n"
            else:
                string_node += f"\tlet node{i}   <- mkChainNodeL1(node{i}_address);\n"
            all_nodes.append(string_node)

        for i in range(NUMBER_OF_NODES-1):
            stringLR = ruleL2R.format(from_node= i, to_node=i+1)
            rules_L2R.append(stringLR)
            stringRL = ruleR2L.format(from_node= i+1, to_node=i)
            rules_R2L.append(stringRL)

        d['nodes_instantiate'] = ''.join(all_nodes)
        d['rule_left_to_right'] = ''.join(rules_L2R)
        d['rule_right_to_left'] = ''.join(rules_R2L)
        d['HEADNODE'] = f"{NUMBER_OF_NODES//2}"

        # with open('template_NOC.txt', 'r') as f:
        with open('./Chain/ChainL2/template_L2_NOC.txt', 'r') as f:
            src = Template(f.read())
            result = src.substitute(d)
            if(IF_OUT_TO_FILE):
                with open(OUTPUT_FILE_NAME, 'w') as op:
                    op.write(result)
            else:
                print(result)
