### SWITCH

router_names = ["router_l2r_up", "router_l2r_down", "router_r2l_up", "router_r2l_down"]

switch_connect = """    rule add_to_link_right0(counter == 2'b00);
        $display("add_to_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule
"""

node_instantiate = """    Address node{id}_address;  node{id}_address.netAddress=0;  node{id}_address.nodeAddress={id};
    let node{id:0>4b} <- mkButterflyNode(node{id}_address);"""

switches_inst = """     let switch_L{layer}_{id} <- mkButterflySwitch(node{id}_address, {layer});"""

left_nodes_to_switches = """    rule node{node_id}_to_switch_L{layer}_{id};
        let data <- node{node_id:0>4b}.get_value();
        switch_L{layer}_{id}.put_value_from_left_{up_down}(data);
    endrule
"""
up_down = "down"

right_nodes_to_switches = """    rule node{node_id}_to_switch_L{layer}_{id};
        let data <- node{node_id:0>4b}.get_value();
        switch_L{layer}_{id}.put_value_from_right_{up_down}(data);
    endrule
"""
up_down = "down"
for i in range(16):
    print(node_instantiate.format(id=i))
    # if(i<12):
        # print(switches_inst.format(layer=i//4, id=i%4))
# #     if(i<8):
#         up_down = "down" if up_down=="up" else "up"
#         # print(left_nodes_to_switches.format(layer=(i//2)//4, id=(i//2)%4, node_id=i, up_down=up_down))
#     else:
#         up_down = "down" if up_down=="up" else "up"
#         print(right_nodes_to_switches.format(layer=1+(i//2)//4, id=(i//2)%4, node_id=i, up_down=up_down))

    
# CONNECT SWITCHES (UP==STRAIGHT) (DOWN==CROSS)
switch_connect_l2r_straight = """    rule connect_l2r_switchL{layer_from}_{row_from}_switchL{layer_to}_{row_to};
        let data <- switch_L{layer_from}_{row_from}.get_value_to_right_up();
        switch_L{layer_to}_{row_to}.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL{layer_to}_{row_to}_switchL{layer_from}_{row_from};
        let data <- switch_L{layer_to}_{row_to}.get_value_to_left_up();
        switch_L{layer_from}_{row_from}.put_value_from_right_up(data);
    endrule

"""

switch_connect_l2r_cross = """    rule connect_l2r_switchL{layer_from}_{row_from}_switchL{layer_to}_{row_to};
        let data <- switch_L{layer_from}_{row_from}.get_value_to_right_down();
        switch_L{layer_to}_{row_to}.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL{layer_to}_{row_to}_switchL{layer_from}_{row_from};
        let data <- switch_L{layer_to}_{row_to}.get_value_to_left_down();
        switch_L{layer_from}_{row_from}.put_value_from_right_down(data);
    endrule

"""
# switch_connect_r2l

SIZE= 8 # 8x8
for layer in range(2):
    for row in range(SIZE//2):
        keys = {}
        keys['layer_from'] = layer
        keys['layer_to'] = layer+1
        keys['row_from'], keys['row_to'] = row, row
        # print(switch_connect_l2r_straight.format(layer_from=layer, layer_to=layer+1,row_from=row, row_to=row))
        # print(switch_connect_l2r_straight.format(**keys))

MAX_OFFSET = 2*2
MAX_ROWS = 4*2
for layer in range(2):
    print(f"// LAYER {layer}")
    MAX_OFFSET = MAX_OFFSET//2
    MAX_ROWS = MAX_ROWS//2
    for row in range(SIZE//2):
        keys = {}
        keys['layer_from'] = layer
        keys['layer_to'] = layer+1
        keys['row_from'], keys['row_to'] = row, (row+MAX_OFFSET)%MAX_ROWS + (row//MAX_ROWS)*MAX_ROWS
        # print(switch_connect_l2r_straight.format(layer_from=layer, layer_to=layer+1,row_from=row, row_to=row))
        # print(switch_connect_l2r_cross.format(**keys))
