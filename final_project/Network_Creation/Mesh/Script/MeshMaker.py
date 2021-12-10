from string import Template
from math import log2



TOTAL_ROWS = 3
TOTAL_COLS = 3
NETWORK_ID = 0
d = {}

nodes = """    Address node{row_id}{col_id}_address;  node{row_id}{col_id}_address.netAddress={net_id};  node{row_id}{col_id}_address.nodeAddress=16'h{row_id:0>2x}{col_id:0>2x};
    let node{row_id}{col_id}   <- mkMeshNode(node{row_id}{col_id}_address, 0);
"""
nodes_inst = []
for row in range(TOTAL_ROWS):
    for col in range(TOTAL_COLS):
        sentence = nodes.format(row_id=row, col_id=col, net_id=NETWORK_ID)
        nodes_inst.append(sentence)

d['nodes_instantiate'] = ''.join(nodes_inst)


# print("\n   // Connecting Left to Right nodes")

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
d['PACKAGE_NAME'] = 'MeshNoc'
d['NO_OF_ROWS'] = f"{TOTAL_ROWS}"
d['NO_OF_COLUMNS'] = f"{TOTAL_COLS}"


with open('Meshtemplate.txt', 'r') as f:
    src = Template(f.read())
    result = src.substitute(d)

    output_file_name = f"MeshNoc.bsv"
    with open(output_file_name, 'w') as op:
        op.write(result)