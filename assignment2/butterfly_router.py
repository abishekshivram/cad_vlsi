# Routing algorithm for Butterfly network

import sys

from butterfly import dec_to_bin, Butterfly
sys.path.insert(1, './../assignment1')

import re
from asgn1 import L1_network, L2_networks

''' I'm going to use the network we defined in the assignment 1'''
''' For butterfly, apart from destination address, we also need a field 
that will represent if the flit will go to the other side before returning back
This can be called Straight_Field '''

Network = None

def find_level(name):
    level = re.findall('.*L(\d+)_.*', name)
    return int(level[0])

def butterfly_route(current_node_name, destination_node_name, full_network):

    level_src = find_level(current_node_name)
    level_dest = find_level(destination_node_name)
    src_nw_id = re.findall('.*_N(\d+).*', current_node_name)[0]
    dest_nw_id = re.findall('.*_N(\d+).*', destination_node_name)[0]

    if(level_src == 2):
        # If destination is in same level and network
        if(level_dest == 2):
            if (src_nw_id == dest_nw_id):
                next_node_name, new_dest_name = find_next_same_network(current_node_name, destination_node_name)
            else:
                # Moving between different networks 
                next_node_name, new_dest_name = find_next_diff_network(current_node_name, destination_node_name)
        else:
            if (src_nw_id == dest_nw_id):
                next_node_name, new_dest_name = find_next_same_network(current_node_name, destination_node_name)
            else:
                # Moving between different networks 
                next_node_name, new_dest_name = find_next_diff_network(current_node_name, destination_node_name)

    elif (level_src == 1):
        # L2 routing: from head node to destination node
        if(level_dest == 2):
            if (src_nw_id == dest_nw_id):
                next_node_name, new_dest_name = find_next_same_network(current_node_name, destination_node_name)
            else:
                # L1 routing must be done to find the head node of destination network
                next_node_name, new_dest_name = l1_next_node(current_node_name, destination_node_name)
        else:
            next_node_name, new_dest_name = l1_next_node(current_node_name, destination_node_name)

    if(next_node_name[0]=="S"): # only when next node is destination
        next_node = full_network.name_node_dict[next_node_name[1:]]
    else:
        next_node = full_network.name_node_dict[next_node_name]

    print(f"from butterfly: {current_node_name}---{next_node_name}, {destination_node_name}--{new_dest_name}")
    return next_node, new_dest_name

def assign_network(current_node_name):
    global Network
    index = get_network_id_from_name(current_node_name)
    Network = L2_networks[int(index)] 

def next_butterfly_node():
    return

def next_butterfly_switch():
    return

def get_network_id_from_name(name):
    '''Extaracts the network id (integer after _N) from the given name
    Name is a well formatted node name
    Returns string name
    eg L2_N2_H_100-> 2'''
    
    nw_id=re.findall('_N(\d+)_.*',name)
    return str(nw_id[0])

def l1_check_if_same_side(current_node_name, destination_node_name):
    source = int(get_network_id_from_name(current_node_name))
    destination = int(get_network_id_from_name(destination_node_name))

    ''' Finding if destination is in left or right side of network'''
    ''' Going to the straight opposite node on the other side, and turn around'''
    
    size_of_l1 = L1_network.num
    if(source < size_of_l1):
        source_side = "Left"
    else:
        source_side = "Right"
        
    if(destination < size_of_l1):
        dest_side = "Left"
    else:
        dest_side = "Right"

    if(source_side == dest_side):
        return True, source_side
    else:
        return False, source_side

def l1_next_node(current_node_name, destination_node_name):

    start_node_nos = re.findall(r'\d+', current_node_name)
    end_node_no = re.findall(r'\d+', destination_node_name)[-1]

    # Determining if the current_node is Node or a Switch
    if(len(start_node_nos) == 4):
        Switch = True
        max_switch_layers = len(start_node_nos[-1]) + 1
    else:
        Switch = False
        max_switch_layers = len(start_node_nos[-1])

    if(type(L1_network) == Butterfly):
        for i in (L1_network.left_nodes + L1_network.right_nodes):
            if(i.name == current_node_name):
                current_node = i
                break


    if(not Switch):
        same_side, side = l1_check_if_same_side(current_node_name, destination_node_name)
        if(same_side):
            destination_node_name = "S" + destination_node_name
            return current_node.neighbour[-1].name, destination_node_name
            '''Please check if 0 index is correct-we need to return the L1 switch'''
        else:
            if(destination_node_name[0]=="S"):
                destination_node_name = destination_node_name[1:]
    

    '''Check if the destination is to the left or right'''
    
    if(Switch):
        Straight_global = True if destination_node_name[0]=="S" else False
    
    
    # If the destination is to the right of source node:
    if(destination_node_name[-max_switch_layers-1] == "R"):
        if(Switch):
            layer = int(start_node_nos[-2])
            identity = start_node_nos[-1]

            if(layer == max_switch_layers-1):
                # Next stop is destination node
                return destination_node_name, destination_node_name

            if(identity[layer] == end_node_no[layer]):
                # We have to move straight
                Straight = True
            else:
                # We have to move up/down
                Straight = False
            
            if(Straight or Straight_global):
                return current_node.right_neighbours[0].name, destination_node_name
            else:
                return current_node.right_neighbours[1].name, destination_node_name
        else: # If source is a Node
            return current_node.neighbour[0].name, destination_node_name
    
    else: # Case: If the destination is to the left of source node:

        if(Switch):
            layer = int(start_node_nos[-2])
            identity = start_node_nos[-1]

            if(layer == 0):
                # Next stop is destination Node
                return destination_node_name, destination_node_name
            else:
                if(identity[-layer] == end_node_no[-layer]):
                    # We have to move straight
                    Straight = True
                else:
                    # We have to move up/down
                    Straight = False
                
                if(Straight or Straight_global):
                    return current_node.left_neighbours[0].name, destination_node_name
                else:
                    return current_node.left_neighbours[1].name, destination_node_name
        else:
            # If source is a Node
            return current_node.neighbour[0].name, destination_node_name



'''If destination and source are in different network, then we have to move to head node
and then do the L1 routing'''
def find_next_diff_network(current_node_name, destination_node_name):
    global Network
    assign_network(current_node_name)
    temp_dest = Network.get_head_node()
    temp_dest_name = temp_dest.name
    if(destination_node_name[0] == "S"):
        temp_dest_name = "S" + temp_dest_name
    next_node_name, temp_new = find_next_same_network(current_node_name, temp_dest_name)
    if(temp_new[0]=="S"):
        destination_node_name = "S"+ destination_node_name
    return next_node_name, destination_node_name


''' On the originating node of butterfly, we can decide if the dest is in same side,
    then assign the Stright_field there itself.'''
    
def find_next_same_network(current_node_name, destination_node_name):
    global Network
    assign_network(current_node_name)
    ''' current_node: Source Node or Source Switch '''
    ''' Assumption: Both nodes are within the same network'''
    ''' What if both source and destination are on the same side? 
        In this case, we have to do a round trip'''

    ''' Since this is a simulator, we have to find if source is a switch/Node based on name
        In the hardware, we will inherently know if its a switch/Node'''

    start_node_nos = re.findall(r'\d+', current_node_name)
    end_node_no = re.findall(r'\d+', destination_node_name)[-1]
    
    # Determining if the current_node is Node or a Switch
    if(len(start_node_nos) == 4):
        Switch = True
        max_switch_layers = len(start_node_nos[-1]) + 1
    else:
        Switch = False
        max_switch_layers = len(start_node_nos[-1])
    

    # if(destination_node_name[-max_switch_layers-1] == current_node_name[-max_switch_layers-1]):
    #     ''' Both source and destination are on the same side
        # One easy solution: route through head node'''
    
    for i in (Network.left_nodes + Network.right_nodes):
        if(i.name == current_node_name):
            current_node = i
            break
    # current_node = 

    '''Check if same side routing is done'''
    if(not Switch):
        # If both same side
        if(destination_node_name[-max_switch_layers-1] == current_node_name[-max_switch_layers-1]):
            destination_node_name = "S" + destination_node_name
        else:# It came to the other side, remove 'S' if its present
            if(destination_node_name[0]=="S"):
                destination_node_name = destination_node_name[1:]

    # if(destination_node_name[0] == "S"):
    #     Straight_global = True
    if(Switch):
        Straight_global = True if destination_node_name[0]=="S" else False

    '''Check if the destination is to the left or right'''

    # If the destination is to the right of source node:
    if(destination_node_name[-max_switch_layers-1] == "R"):
        if(Switch):
            layer = int(start_node_nos[-2])
            identity = start_node_nos[-1]

            if(layer == max_switch_layers-1):
                # Next stop is destination node
                return destination_node_name, destination_node_name

            if(identity[layer] == end_node_no[layer]):
                # We have to move straight
                Straight = True
            else:
                # We have to move up/down
                Straight = False
            
            if(Straight or Straight_global):
                return current_node.right_neighbours[0].name, destination_node_name
            else:
                return current_node.right_neighbours[1].name, destination_node_name
        else: # If source is a Node
            return current_node.neighbour[0].name, destination_node_name
    
    else: # Case: If the destination is to the left of source node:

        if(Switch):
            layer = int(start_node_nos[-2])
            identity = start_node_nos[-1]

            if(layer == 0):
                # Next stop is destination Node
                return destination_node_name, destination_node_name
            else:
                if(identity[-layer] == end_node_no[-layer]):
                    # We have to move straight
                    Straight = True
                else:
                    # We have to move up/down
                    Straight = False
                
                if(Straight or Straight_global):
                    return current_node.left_neighbours[0].name, destination_node_name
                else:
                    return current_node.left_neighbours[1].name, destination_node_name
        else:
            # If source is a Node
            return current_node.neighbour[0].name, destination_node_name





def butterfly_path(start_node, destination_node):
    global Network
    ''' Routing from left to right across Butterfly Network '''
    ''' MSB to LSB bit difference based routing '''
    ''' If the bits at same significant positions are equal, then move straight
        If the bits are different, then move up or down depending on the bit
        (ie) if the bit is 1, then next movement will be upwards
        else if the bit is 0, then next movement will be downwards'''

    start_node_no = re.findall(r'\d+', start_node.name)[-1]
    end_node_no = re.findall(r'\d+', destination_node.name)[-1]
    assert len(start_node_no)==len(end_node_no), "Please check nodes given for routing Butterfly network"
    no_of_movements = len(start_node_no)

    ''' Coding the movement and storing in the flit: Stored in movement_string
        If the movement bit is 0, then move straight.
        If the movement bit is 1, move up or down depending on the source switch/node.
        (ie) If the source node/switch has MSB 1, then move up and vice versa
        
        What to do at the ends?
        Since at the ends, two nodes are connected to a switch, we can easily decide
        whether to move up or down at the end, by checking if the destination node is odd or even.
        If the node number is even, then move up. Else if it's odd, then move down.
    '''
    movement_string = ''
    # if(start_node_no[-1] == '0'):
    #     movement_string += ''
    for i in range(no_of_movements):
        if(start_node_no[i] == end_node_no[i]):
            # We have to move straight
            movement_string += '0'
        else:
            # We have to move up/down
            movement_string += '1'
    movement_string += end_node_no[-1]
