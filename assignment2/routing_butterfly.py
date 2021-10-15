# Routing algorithm for Butterfly network

import sys
sys.path.insert(1, './../assignment1')
import re
from node import Node
from switch import Switch

from butterfly import Butterfly

Network = Butterfly("but", 8)

Network.print_nodes()

def next_butterfly_node():
    return

def next_butterfly_switch():
    return


def find_next(current_node, destination_node):
    ''' current_node: Source Node or Source Switch '''
    ''' Assumption: Both nodes are within the same network'''
    ''' What if both source and destination are on the same side? '''

    ''' Since this is a simulator, we have to find if source is a switch/Node based on name
        In the hardware, we will inherently know if its a switch/Node'''

    start_node_nos = re.findall(r'\d+', start_node.name)
    end_node_no = re.findall(r'\d+', destination_node.name)[-1]
    
    # Determining if the current_node is Node or a Switch
    if(len(start_node_nos) == 4):
        Switch = True
        max_switch_layers = len(start_node_nos[-1]) + 1
    else:
        Switch = False
        max_switch_layers = len(start_node_nos[-1])
    
    
    
    # Check if the destination is to the left or right

    # If the destination is to the right of source node:
    if(destination_node.name[-no_of_movements-1] == "R"):
        if(Switch):
            layer = int(start_node_nos[-2])
            identity = start_node_nos[-1]

            if(layer == max_switch_layers-1):
                # Next stop is destination node
                return destination_node

            if(identity[layer] == end_node_no[layer]):
                # We have to move straight
                Straight = True
            else:
                # We have to move up/down
                Straight = False
            
            if(Straight):
                return current_node.right_neighbours[0]
            else:
                return current_node.right_neighbours[1]
        else: # If source is a Node
            return current_node.neighbour[0]
    
    else: # Case: If the destination is to the left of source node:

        if(Switch):
            layer = int(start_node_nos[-2])
            identity = start_node_nos[-1]

            if(layer == 0):
                # Next stop is destination Node
                return destination_node
            else:
                if(identity[-layer] == end_node_no[-layer]):
                    # We have to move straight
                    Straight = True
                else:
                    # We have to move up/down
                    Straight = False
                
                if(Straight):
                    return current_node.left_neighbours[0]
                else:
                    return current_node.left_neighbours[1]
        else:
            # If source is a Node
            return current_node.neighbour[0]





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
    assert(len(start_node_no)==len(end_node_no), "Please check nodes given for routing Butterfly network")
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
