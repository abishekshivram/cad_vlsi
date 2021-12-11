from string import Template

# NO_OF_NETWORKS: Number of Folded Torus Networks in L2
# ALL_NETWORK_NUM: The Network number associated with the Folded Torus Network in L2
# ALL_NETWORK_ID: The hexadecimal network ID for each Folded Torus L2 network
# ALL_NUMBER_OF_NODES: The dimension of each Folded Torus network in L2
def create_L2_Mesh(NO_OF_NETWORKS, ALL_NETWORK_NUM, ALL_NETWORK_ID, ALL_NUMBER_OF_NODES):
    d = {}
 
    # L1_NETWORKS_DIM = (2,3)
    # NO_OF_NETWORKS = L1_NETWORKS_DIM[0]*L1_NETWORKS_DIM[1]

    # ALL_NETWORK_ID = []
    # for i in range(L1_NETWORKS_DIM[0]):
    #     for j in range(L1_NETWORKS_DIM[1]):
    #         ALL_NETWORK_ID.append(f"16'h{i:0>2x}{j:0>2x}")

    # ALL_NUMBER_OF_NODES = [(3,3), (4,4), (3,5), (4,3), (3,4), (3,3)]

    for i in range(NO_OF_NETWORKS):
        NETWORK_ID = ALL_NETWORK_ID[i]
        NUMBER_OF_NODES = ALL_NUMBER_OF_NODES[i]
        IF_OUT_TO_FILE = True

        NUMBER_OF_ROWS = NUMBER_OF_NODES[0]
        NUMBER_OF_COLS = NUMBER_OF_NODES[1]

        d['NETWORK_ID'] = f"{ALL_NETWORK_NUM[i]}"

        ruleL2R = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_L2R;
            let data{from_row_id}{from_col_id}_L2R <- node{from_row_id}{from_col_id}.get_value_to_right();
            node{to_row_id}{to_col_id}.put_value_from_left(data{from_row_id}{from_col_id}_L2R);
        endrule\n\n"""

        ruleR2L = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_R2L;
            let data{from_row_id}{from_col_id}_R2L <- node{from_row_id}{from_col_id}.get_value_to_left();
            node{to_row_id}{to_col_id}.put_value_from_right(data{from_row_id}{from_col_id}_R2L);
        endrule\n\n"""

        ruleU2D = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_U2D;
            let data{from_row_id}{from_col_id}_U2D <- node{from_row_id}{from_col_id}.get_value_to_down();
            node{to_row_id}{to_col_id}.put_value_from_up(data{from_row_id}{from_col_id}_U2D);
        endrule\n\n"""

        ruleD2U = """\trule connect_Node{from_row_id}{from_col_id}_to_Node{to_row_id}{to_col_id}_D2U;
            let data{from_row_id}{from_col_id}_D2U <- node{from_row_id}{from_col_id}.get_value_to_up();
            node{to_row_id}{to_col_id}.put_value_from_down(data{from_row_id}{from_col_id}_D2U);
        endrule\n\n"""

        # NODES
        PACKAGE_NAME = "MeshNocL2_"
        d['PACKAGE_NAME'] = PACKAGE_NAME + str(ALL_NETWORK_NUM[i])
        OUTPUT_FILE_NAME = PACKAGE_NAME + str(ALL_NETWORK_NUM[i]) + ".bsv"


        # BITS_NEEDED = int(log2(NUMBER_OF_NODES)) + 1
        all_nodes = []
        rules_L2R = []
        rules_R2L = []
        rules_U2D = []
        rules_D2U = []

        
        all_nodes.append(f"\tAddress head_node_addr;  head_node_addr.netAddress={NETWORK_ID};  head_node_addr.nodeAddress=16'h{NUMBER_OF_ROWS//2:0>2x}{NUMBER_OF_COLS:0>2x};\n\n")
        
        for i in range(NUMBER_OF_ROWS):
            for j in range(NUMBER_OF_COLS):
                string_node = f"\tAddress node{i}{j}_address;  node{i}{j}_address.netAddress={NETWORK_ID};  node{i}{j}_address.nodeAddress=16'h{i:0>2x}{j:0>2x};\n"	
                if(i==NUMBER_OF_ROWS//2 and j==NUMBER_OF_COLS//2):
                    string_node += f"\tlet node{i}{j}   <- mkMeshL2HeadNode(node{i}{j}_address, head_node_addr);\n"
                else:
                    string_node += f"\tlet node{i}{j}   <- mkMeshNode(node{i}{j}_address, head_node_addr);\n"
                all_nodes.append(string_node)
                if (j < NUMBER_OF_COLS -1):
                    stringLR = ruleL2R.format(from_row_id=i, from_col_id=j, to_row_id=i, to_col_id=(j+1))
                    rules_L2R.append(stringLR)
                    stringRL = ruleR2L.format(from_row_id=i, from_col_id=(j+1), to_row_id=i, to_col_id=j)
                    rules_R2L.append(stringRL)

        for j in range(NUMBER_OF_COLS):            
            for i in range(NUMBER_OF_ROWS-1):
                stringUD = ruleU2D.format(from_row_id=i, from_col_id=j, to_row_id=(i+1), to_col_id=j)
                rules_U2D.append(stringUD)
                stringDU = ruleD2U.format(from_row_id=(i+1), from_col_id=j, to_row_id=i, to_col_id=j)
                rules_D2U.append(stringDU)        
            

        d['nodes_instantiate'] = ''.join(all_nodes)
        d['rule_left_to_right'] = ''.join(rules_L2R)
        d['rule_right_to_left'] = ''.join(rules_R2L)
        d['rule_up_to_down'] = ''.join(rules_U2D)
        d['rule_down_to_up'] = ''.join(rules_D2U)

        d['HEADNODE'] = f"{NUMBER_OF_ROWS//2}{NUMBER_OF_COLS//2}"

        with open('./Mesh/template_L2_Mesh.txt', 'r') as f:
            src = Template(f.read())
            result = src.substitute(d)
            if(IF_OUT_TO_FILE):
                with open(OUTPUT_FILE_NAME, 'w') as op:
                    op.write(result)
            else:
                print(result)
