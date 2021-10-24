# import re
from network_layout import NetworkLayout 

# from hypercube_router import *
from input_reader import InputReader
# from flit import Flit

from simulate import program_entry

input_read=InputReader("./input.txt")

l1_topology=input_read.get_l1_topology()


'''Builds the network layout and creates necessary virtual channesl in the node'''
full_network=NetworkLayout("../assignment1/output.txt",l1_topology)

program_entry(full_network)
print("\n\n\nEnd of Program\n\n\n")
quit()
