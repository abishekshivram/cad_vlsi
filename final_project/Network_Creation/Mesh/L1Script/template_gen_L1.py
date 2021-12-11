from string import Template
from math import log2

d = {}


TOTAL_ROWS = 3
TOTAL_COLS = 3

NETWORK_ID = 0


t=TOTAL_ROWS/2
head_node_address ="""Address head_node_address; head_node_address.netAddress=16'h{row_id:0>2x}{col_id:0>2x}; head_node_address.nodeAddress=16'h{row_id:0>2x}{col_id:0>2x};""";
head_node_address = head_node_address.format(row_id=TOTAL_ROWS//2, col_id=TOTAL_COLS//2)

d['headnode_instantiate'] =head_node_address

nodes = """    Address node{row_id}{col_id}_address;  node{row_id}{col_id}_address.netAddress=16'h{row_id:0>2x}{col_id:0>2x};  node{row_id}{col_id}_address.nodeAddress=16'h{row_id:0>2x}{col_id:0>2x};
    let node{row_id}{col_id}   <- mkMeshNodeL1(node{row_id}{col_id}_address, head_node_address); 
"""
nodes_inst = []
for row in range(TOTAL_ROWS):
    for col in range(TOTAL_COLS):
        sentence = nodes.format(row_id=row, col_id=col, net_id=NETWORK_ID)
        nodes_inst.append(sentence)

d['nodes_instantiate'] = ''.join(nodes_inst)




NUMBER_OF_NODES = 3  #Needed?
NO_OF_NETWORKS = NUMBER_OF_NODES
IF_OUT_TO_FILE = True


#d['NETWORK_ID'] = f"{NETWORK_ID}"




row_l2r_r2l = """    rule connect_Node{row_id}{col_id}_to_Node{row_id}{col_id_next}_L2R;
        let data{row_id}{col_id_next}_L2R <- node{row_id}{col_id}.get_value_to_right();
        node{row_id}{col_id_next}.put_value_from_left(data{row_id}{col_id_next}_L2R);
    endrule
    rule connect_Node{row_id}{col_id_next}_to_Node{row_id}{col_id}_R2L;
        let data{row_id}{col_id}_R2L <- node{row_id}{col_id_next}.get_value_to_left();
        node{row_id}{col_id}.put_value_from_right(data{row_id}{col_id}_R2L);
    endrule
"""
# row_start = [0]
# for i in range(1,row):
#     ind = row_start[-1] + col
#     row_start.append(ind)
row_connections_r2l_l2r = []
for row in range(TOTAL_ROWS):
    for col in range(TOTAL_COLS-1):
        sentence = row_l2r_r2l.format(row_id= row,col_id=col,col_id_next=col+1)
        row_connections_r2l_l2r.append(sentence)

d['LR_CONNECTIONS'] = ''.join(row_connections_r2l_l2r)



up_down = """    rule connect_Node{row_id}{col_id}_to_Node{row_id_next}{col_id}_T2B;
        let data{row_id_next}{col_id}_T2B <- node{row_id}{col_id}.get_value_to_down();
        node{row_id_next}{col_id}.put_value_from_up(data{row_id_next}{col_id}_T2B);
    endrule
    rule connect_Node{row_id_next}{col_id}_to_Node{row_id}{col_id}_B2T;
        let data{row_id}{col_id}_B2T <- node{row_id_next}{col_id}.get_value_to_up();
        node{row_id}{col_id}.put_value_from_down(data{row_id}{col_id}_B2T);
    endrule
"""
up_down_connections = []

for row in range(TOTAL_ROWS-1):
    for col in range(TOTAL_COLS):
        sentence = up_down.format(row_id=row, col_id=col, row_id_next=row+1)
        up_down_connections.append(sentence)

d['UP_DOWN_CONNECTIONS'] = ''.join(up_down_connections)

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
PACKAGE_NAME = "MeshNocL1"
d['PACKAGE_NAME'] = PACKAGE_NAME 
OUTPUT_FILE_NAME = PACKAGE_NAME + ".bsv"


#BITS_NEEDED = int(log2(NUMBER_OF_NODES)) + 1
#all_nodes = []



#d['HEADNODE'] = f"{NUMBER_OF_NODES//2}"

d['L2_nodes'] = ""

files_to_import = []
l2_noc_list = []
rule_l2_l1_connection = []

for i in range(NO_OF_NETWORKS):
    files_to_import.append(f"import MeshNocL2_{i} :: * ;\n")
    l2_noc_list.append(f"\tlet noc_N{i} <- mkMeshL2Noc{i}();\n")
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


