from string import Template
from math import log2

d = {}


NETWORK_ID = 0
NUMBER_OF_NODES = 3
NO_OF_NETWORKS = NUMBER_OF_NODES
IF_OUT_TO_FILE = True


d['NETWORK_ID'] = f"{NETWORK_ID}"

ruleL2R = """\trule connect_Node{from_node}_to_Node{to_node}_L2R;
        let data{from_node}{to_node}_L2R <- nodeL1_{from_node}.get_value_to_right();
        nodeL1_{to_node}.put_value_from_left(data{from_node}{to_node}_L2R);
    endrule\n\n"""

ruleR2L = """\trule connect_Node{from_node}_to_Node{to_node}_R2L;
        let data{from_node}{to_node}_R2L <- nodeL1_{from_node}.get_value_to_left();
        nodeL1_{to_node}.put_value_from_right(data{from_node}{to_node}_R2L);
    endrule\n\n"""

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


# NODES
PACKAGE_NAME = "ChainNocL1"
d['PACKAGE_NAME'] = PACKAGE_NAME 
OUTPUT_FILE_NAME = PACKAGE_NAME + ".bsv"


BITS_NEEDED = int(log2(NUMBER_OF_NODES)) + 1
all_nodes = []
rules_L2R = []
rules_R2L = []

for i in range(NUMBER_OF_NODES):
    string_node = f"\tAddress node{i}_address;  node{i}_address.netAddress={i};  node{i}_address.nodeAddress={i};\n"	
    string_node += f"\tlet nodeL1_{i}   <- mkChainNodeL1(node{i}_address);\n"
    all_nodes.append(string_node)
    if(i<NUMBER_OF_NODES-1):
        stringLR = ruleL2R.format(from_node= i, to_node=i+1)
        rules_L2R.append(stringLR)
        stringRL = ruleR2L.format(from_node= i+1, to_node=i)
        rules_R2L.append(stringRL)
        

d['nodes_instantiate'] = ''.join(all_nodes)
d['rule_left_to_right'] = ''.join(rules_L2R)
d['rule_right_to_left'] = ''.join(rules_R2L)
d['HEADNODE'] = f"{NUMBER_OF_NODES//2}"

d['L2_nodes'] = ""

files_to_import = []
l2_noc_list = []
rule_l2_l1_connection = []

for i in range(NO_OF_NETWORKS):
    files_to_import.append(f"import ChainNocL2_{i} :: * ;\n")
    l2_noc_list.append(f"\tlet noc_N{i} <- mkChainL2Noc{i}();\n")
    rule_l2_l1_connection.append(ruleL1L2.format(net_id=i))


d['import_l2_noc_files'] = "".join(files_to_import)
d['noc_instantiate'] = "".join(l2_noc_list)
d['L1_L2_connection'] = "\n".join(rule_l2_l1_connection)


with open('template_NOC_L1.txt', 'r') as f:
    src = Template(f.read())
    result = src.substitute(d)
    if(IF_OUT_TO_FILE):
        with open(OUTPUT_FILE_NAME, 'w') as op:
            op.write(result)
    else:
        print(result)
