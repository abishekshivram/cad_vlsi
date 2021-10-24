###########################################################################
# CS6230:CAD for VLSI Systems - Project 2
# Name: Deciding the Route (In a Two level hierarchical Network on Chip)
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: A class representing the Flit
# Last updated on: 20-Oct-2021
############################################################################

class Flit:
    '''A class to represent Flit. This can be considered as a Head flit
    Each flit contains the destnation node name
    To print the path traversed, node names are added as a meta inforamtion to the flit'''
    
    def __init__(self,name):
        '''Stores the name of each node, the flit passed through- This is meta information
        name is the well formatted name of the Destination node to which the Flit to be transferred'''
        self.dst_name=name
        self.route=[] 
    
    def add_node_name(self,name):
        '''Adds the node name to the traversed path - This is a meta information
        If needed virtual channel no. can also be appended to the node name'''
        self.route.append(name)

    def print_path(self):
        '''Prints the nodes(Routers) through which this flit has travelled'''
        print(*self.route, sep='->')

