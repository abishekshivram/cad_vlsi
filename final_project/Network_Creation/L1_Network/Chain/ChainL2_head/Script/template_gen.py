from string import Template
from math import log2

d = {}

NETWORK_ID = 0
NUMBER_OF_NODES = 6
OUTPUT_FILE_NAME = "ChainNoc.bsv"
IF_OUT_TO_FILE = True


ruleL2R = """\trule connect_Node{from_node}_to_Node{to_node}_L2R;
        let data{from_node}{to_node}_L2R <- node{from_node}.GetValuetoRight();
        node{to_node}.PutValuefromLeft(data{from_node}{to_node}_L2R);
    endrule\n\n"""

ruleR2L = """\trule connect_Node{from_node}_to_Node{to_node}_R2L;
        let data{from_node}{to_node}_R2L <- node{from_node}.GetValuetoLeft();
        node{to_node}.PutValuefromRight(data{from_node}{to_node}_R2L);
    endrule\n\n"""

# NODES
PACKAGE_NAME = "ChainNocL2"
d['PACKAGE_NAME'] = PACKAGE_NAME

BITS_NEEDED = int(log2(NUMBER_OF_NODES)) + 1
all_nodes = []
rules_L2R = []
rules_R2L = []

for i in range(NUMBER_OF_NODES):
    string_node = f"\tAddress node{i}_address;  node{i}_address.netAddress={NETWORK_ID};  node{i}_address.nodeAddress={i};\n"	
    string_node += f"\tlet node{i}   <- mkChainNode(node{i}_address, {i==NUMBER_OF_NODES//2});\n"
    stringLR = ruleL2R.format(from_node= i, to_node=i+1)
    rules_L2R.append(stringLR)
    stringRL = ruleR2L.format(from_node= i+1, to_node=i)
    rules_R2L.append(stringRL)
    all_nodes.append(string_node)

d['nodes_instantiate'] = ''.join(all_nodes)
d['rule_left_to_right'] = ''.join(rules_L2R)
d['rule_right_to_left'] = ''.join(rules_R2L)


with open('template_NOC.txt', 'r') as f:
    src = Template(f.read())
    result = src.substitute(d)
    if(IF_OUT_TO_FILE):
        with open(OUTPUT_FILE_NAME, 'w') as op:
            op.write(result)
    else:
        print(result)
