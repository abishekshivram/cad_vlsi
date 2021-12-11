from string import Template
from math import log2

d = {}

def create_L1_FT(L1_DIM,L2_NETWORK_NODE_FILES,L2_NETWORK_BSV_MODULES):
    NETWORK_ID = 0
    NUMBER_OF_ROWS = L1_DIM[0]
    NUMBER_OF_COLS = L1_DIM[1]

    NO_OF_NETWORKS = NUMBER_OF_ROWS * NUMBER_OF_COLS
    IF_OUT_TO_FILE = True


    d['NETWORK_ID'] = f"{NETWORK_ID}"

    ruleL2R = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_L2R;
            let data{from_row_id}{from_col_id}_L2R <- nodeL1_{from_row_id}{from_col_id}.get_value_to_right();
            nodeL1_{to_row_id}{to_col_id}.put_value_from_left(data{from_row_id}{from_col_id}_L2R);
        endrule\n\n"""

    ruleR2L = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_R2L;
            let data{from_row_id}{from_col_id}_R2L <- nodeL1_{from_row_id}{from_col_id}.get_value_to_left();
            nodeL1_{to_row_id}{to_col_id}.put_value_from_right(data{from_row_id}{from_col_id}_R2L);
        endrule\n\n"""

    ruleU2D = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_U2D;
            let data{from_row_id}{from_col_id}_U2D <- nodeL1_{from_row_id}{from_col_id}.get_value_to_down();
            nodeL1_{to_row_id}{to_col_id}.put_value_from_up(data{from_row_id}{from_col_id}_U2D);
        endrule\n
        rule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_U2D_dateline;
            let data{from_row_id}{from_col_id}_U2D_dateline <- nodeL1_{from_row_id}{from_col_id}.get_value_to_down_dateline();
            nodeL1_{to_row_id}{to_col_id}.put_value_from_up_dateline(data{from_row_id}{from_col_id}_U2D_dateline);
        endrule\n\n"""

    ruleD2U = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_D2U;
            let data{from_row_id}{from_col_id}_D2U <- nodeL1_{from_row_id}{from_col_id}.get_value_to_up();
            nodeL1_{to_row_id}{to_col_id}.put_value_from_down(data{from_row_id}{from_col_id}_D2U);
        endrule\n
        rule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_D2U_dateline;
            let data{from_row_id}{from_col_id}_D2U_dateline <- nodeL1_{from_row_id}{from_col_id}.get_value_to_up_dateline();
            nodeL1_{to_row_id}{to_col_id}.put_value_from_down_dateline(data{from_row_id}{from_col_id}_D2U_dateline);
        endrule\n\n"""


    ruleL1L2 = """\trule connect_N{net_id}_to_node{row_id}{col_id}_L1_to_L2;
            Flit data=defaultValue;
            data <- nodeL1_{row_id}{col_id}.get_value_to_l2();
            data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
            data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
            noc_N{net_id}.put_value_from_l1(data);
        endrule
        rule connect_node{row_id}{col_id}_to_N{net_id}_L2_to_L1;
            Flit data=defaultValue;
            data <- noc_N{net_id}.get_value_to_l1();
            nodeL1_{row_id}{col_id}.put_value_from_l2(data);
        endrule
    """


    # NODES
    PACKAGE_NAME = "FoldedTorusNocL1"
    d['PACKAGE_NAME'] = PACKAGE_NAME 
    OUTPUT_FILE_NAME = PACKAGE_NAME + ".bsv"

    all_nodes = []
    rules_L2R = []
    rules_R2L = []
    rules_U2D = []
    rules_D2U = []
    rulesL1L2 = []

    for i in range(NUMBER_OF_ROWS):
        for j in range(NUMBER_OF_COLS):
            string_node = f"\tAddress nodeL1_{i}{j}_address;  nodeL1_{i}{j}_address.netAddress=16'h{i:0>2x}{j:0>2x};  nodeL1_{i}{j}_address.nodeAddress=0;\n"	
            string_node += f"\tlet nodeL1_{i}{j}   <- mkFoldedTorusL1Node(nodeL1_{i}{j}_address, {NUMBER_OF_COLS-1}, {NUMBER_OF_ROWS-1});\n"
            all_nodes.append(string_node)
            stringLR = ruleL2R.format(from_row_id= i, from_col_id = j, to_row_id=i, to_col_id = (j+1)%NUMBER_OF_COLS)
            rules_L2R.append(stringLR)
            stringRL = ruleR2L.format(from_row_id= i, from_col_id = (j+1)%NUMBER_OF_COLS, to_row_id=i, to_col_id = j)
            rules_R2L.append(stringRL)
            stringL1L2 = ruleL1L2.format(row_id= i, col_id = j, net_id = i*NUMBER_OF_COLS+j)
            rulesL1L2.append(stringL1L2)

    for j in range(NUMBER_OF_COLS):
        for i in range(NUMBER_OF_ROWS):
            stringUD = ruleL2R.format(from_row_id= i, from_col_id = j, to_row_id=(i+1)%NUMBER_OF_ROWS, to_col_id=j)
            rules_U2D.append(stringUD)
            stringDU = ruleR2L.format(from_row_id= (i+1)%NUMBER_OF_ROWS, from_col_id = j, to_row_id=i , to_col_id = j)
            rules_D2U.append(stringDU)

    d['nodes_instantiate'] = ''.join(all_nodes)
    d['rule_left_to_right'] = ''.join(rules_L2R)
    d['rule_right_to_left'] = ''.join(rules_R2L)

    d['rule_up_to_down'] = ''.join(rules_U2D)
    d['rule_down_to_up'] = ''.join(rules_D2U)

    d['HEADNODE'] = f"{NUMBER_OF_ROWS//2}{NUMBER_OF_COLS//2}"

    d['L2_nodes'] = ""

    files_to_import = []
    l2_noc_list = []

    for i in range(NO_OF_NETWORKS):
        files_to_import.append(f"import {L2_NETWORK_NODE_FILES[i]} :: * ;\n")
        l2_noc_list.append(f"\tlet noc_N{i} <- {L2_NETWORK_BSV_MODULES[i]}();\n")

    d['import_l2_noc_files'] = "".join(files_to_import)
    d['noc_instantiate'] = "".join(l2_noc_list)
    d['L1_L2_connection'] = "\n".join(rulesL1L2)


    with open('./FoldedTorus/template_L1_FoldedTorus.txt', 'r') as f:
        src = Template(f.read())
        result = src.substitute(d)
        if(IF_OUT_TO_FILE):
            with open(OUTPUT_FILE_NAME, 'w') as op:
                op.write(result)
        else:
            print(result)
