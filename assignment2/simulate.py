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

# from hypercube_router import *
from input_reader import InputReader
from flit import Flit


# from test import full_network



def program_entry(full_network):
    '''Execution starts from here'''


    #complete and test the vc creation part

    clock_tick=0
    while(1):
        #When nothing to read from input file and all the vc/fifo empty exit the loop
        input_read=InputReader("./input.txt")
        
        clock_tick=clock_tick+1
        src_dst=input_read.get_src_and_destinations(clock_tick)
        generate_flit(src_dst, full_network)
        
        for node_name, node in full_network.name_node_dict.items():
            node.clock(full_network)

        if(clock_tick>500):
            break
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
