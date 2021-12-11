from string import Template
from math import log2

d = {}

NO_OF_NETWORKS = 3
ALL_NETWORK_ID = [0, 1, 2]
ALL_NUMBER_OF_NODES = [6, 4, 5]

for i in range(NO_OF_NETWORKS):
    NETWORK_ID = ALL_NETWORK_ID[i]
    NUMBER_OF_NODES = ALL_NUMBER_OF_NODES[i]
    IF_OUT_TO_FILE = True

    d['NETWORK_ID'] = f"{NETWORK_ID}"

    ruleL2R = """\trule connect_Node{from_node}_to_Node{to_node}_L2R;
        let data{from_node}{to_node}_L2R <- node{from_node}.get_value_to_right();
        node{to_node}.put_value_from_left(data{from_node}{to_node}_L2R);
    endrule\n
    rule connect_Node{from_node}_to_Node{to_node}_L2R_dateline;
        let data{from_node}{to_node}_L2R_dateline <- node{from_node}.get_value_to_right_dateline();
        node{to_node}.put_value_from_left_dateline(data{from_node}{to_node}_L2R_dateline);
    endrule\n\n"""

    ruleR2L = """\trule connect_Node{from_node}_to_Node{to_node}_R2L;
        let data{from_node}{to_node}_R2L <- node{from_node}.get_value_to_left();
        node{to_node}.put_value_from_right(data{from_node}{to_node}_R2L);
    endrule\n
    rule connect_Node{from_node}_to_Node{to_node}_R2L_dateline;
        let data{from_node}{to_node}_R2L_dateline <- node{from_node}.get_value_to_left_dateline();
        node{to_node}.put_value_from_right_dateline(data{from_node}{to_node}_R2L_dateline);
    endrule\n\n"""

    # NODES
    PACKAGE_NAME = "RingNocL2_"
    d['PACKAGE_NAME'] = PACKAGE_NAME + str(NETWORK_ID)
    OUTPUT_FILE_NAME = PACKAGE_NAME + str(NETWORK_ID) + ".bsv"


    BITS_NEEDED = int(log2(NUMBER_OF_NODES)) + 1
    all_nodes = []
    rules_L2R = []
    rules_R2L = []
    
    all_nodes.append(f"\tAddress head_node_addr;  head_node_addr.netAddress={NETWORK_ID};  head_node_addr.nodeAddress={0};\n\n")
    
    for i in range(NUMBER_OF_NODES):
        string_node = f"\tAddress node{i}_address;  node{i}_address.netAddress={NETWORK_ID};  node{i}_address.nodeAddress={i};\n"	
        if(i==0):
            string_node += f"\tlet node{i}   <- mkRingL2HeadNode(node{i}_address, {NUMBER_OF_NODES-1}, head_node_addr);\n"
        else:
            string_node += f"\tlet node{i}   <- mkRingNode(node{i}_address, {NUMBER_OF_NODES-1}, head_node_addr);\n"
        all_nodes.append(string_node)

    for i in range(NUMBER_OF_NODES):
        stringLR = ruleL2R.format(from_node= i, to_node=(i+1)%NUMBER_OF_NODES)
        rules_L2R.append(stringLR)
        stringRL = ruleR2L.format(from_node= (i+1)%NUMBER_OF_NODES, to_node=i)
        rules_R2L.append(stringRL)

    d['nodes_instantiate'] = ''.join(all_nodes)
    d['rule_left_to_right'] = ''.join(rules_L2R)
    d['rule_right_to_left'] = ''.join(rules_R2L)
    d['HEADNODE'] = f"{0}"

    with open('template_L2_Rings.txt', 'r') as f:
        src = Template(f.read())
        result = src.substitute(d)
        if(IF_OUT_TO_FILE):
            with open(OUTPUT_FILE_NAME, 'w') as op:
                op.write(result)
        else:
            print(result)
