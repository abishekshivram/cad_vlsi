###########################################################################
# CS6230:CAD for VLSI Systems - Project 2
# Name: Deciding the Route (In a Two level hierarchical Network on Chip)
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Program entry point
# Last updated on: 20-Oct-2021
############################################################################
import sys
sys.path.insert(1, './../assignment1')

import re
from network_layout import NetworkLayout 
from hypercube_router import *
from input_reader import InputReader
from flit import Flit
from detailed_graph import main 

L1_network = None
L2_networks = None

L1_network, L2_networks = main(print=False)

def network_as_class_obj():
    pass


def program_entry():
    '''Execution starts from here'''

    input_read=InputReader("../input.txt")

    l1_topology=input_read.get_l1_topology()
    

    '''Builds the network layout and creates necessary virtual channesl in the node'''
    network=NetworkLayout("../assignment1/output.txt",l1_topology)

    #complete and test the vc creation part

    clock_tick=0
    while(1):
        #When nothing to read from input file and all the vc/fifo empty exit the loop

        clock_tick=clock_tick+1
        src_dst=input_read.get_src_and_destinations(clock_tick)
        generate_flit(src_dst)
        
        for node in network.name_node_dict:
            node.clock()
        pass
    pass


def generate_flit(src_dst,network):
    '''Generates Flit for the source-destination pairs given as input
    These flits are added to the FIFO of the source router
    src_dst is a list containing source-destination pairs
    network is the network layout generated from the Project1 output'''

    for pair in src_dst:
        src=pair[0]
        dst=pair[1]
        src_node=network.node_exists(src)
        dst_node=network.node_exists(dst)
        if(src_node!=None and dst_node!=None):
            src_node.add_flits_to_fifo_from_host(Flit(dst))
        else:
            print("Input error ",src,dst)
