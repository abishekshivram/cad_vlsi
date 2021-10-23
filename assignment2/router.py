###########################################################################
# CS6230:CAD for VLSI Systems - Project 2
# Name: Deciding the Route (In a Two level hierarchical Network on Chip)
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: A base class to represent the router in each node of the system
# Last updated on: 20-Oct-2021
############################################################################

from os import name
import sys
from flit import Flit
sys.path.insert(1, './../assignment1')
from node import Node
import queue


class Router(Node):
    '''A class for adding routing related functionality to each node'''

    def __init__(self,name):
        '''Constructor - Sets the name of the node from the given name
        The name has to be a well formatted node name'''
        super(Router, self).__init__(name)

        '''A dictionaly ro hold virtual channels. This virtual channel can store only one Flit
        Neighbour 0 allocated with VC 0,Neighbour 1 with VC 1, host node with VC N'''
        self.vc={} 

        '''A FIFO to store the flits from the host node'''
        self.flit_from_host_node= queue.Queue()
        return

    
    def create_virtual_channels(self):
        '''Creates virtual channels for the node.
        The virtual channel count is the no  of links (I/P) in the node 
        + one more channel for handling the Flit generated by the node attached to the router
        This function to be called after the network is fully created with all the links
        Channel 0 is meant for neighbour 0, channel 1 for neighbour 1 etc...
        The channel no for the host node is n. Where n is the no. of neighbours (neighbours are indexd from 0)'''

        i=0
        for neighbr in self.neighbour:
            self.vc[i]=None
            i=i+1
        self.vc[i]=None #None indicates channel is empty

    def is_vc_free(self, name):
        ''' ***For flow control***
        As of now for each neighbour only one buffer slot is avaibale per channel
        Before sending a flit it is the responsibility of the neighbour to ensure the buffer is free
        This is kind of a credit based flow control
        name is the well formatted name of the neighbour eg-L2_N2_H_100
        Returns true if the respective VC is free'''

        i=0
        for neighbr in self.neighbour:
            if(neighbr.name==name):
                if(self.vc[i]==None):
                    return True
                else:
                    return False
            i=i+1
        if(self.vc[i]==None):
            return True
        else:
            return False

    def add_flits_to_fifo_from_host(self, flit):
        '''Adds host generated Flits to the FIFO - for ready to transfer
        flit is a valid Flit object'''
        self.flit_from_host_node.put(flit)


        

    def clock(): #Click signal, What to do on clock, may be this can be moved to a base class to avoid repetition
        #scan through the virtual channels of this node
        #find the one with highest priority
        #extarct the Flit
        #from flit extarct the dest node name
        #next_node=find_next(destination_node)
        #if(next==None):
        #    print("Internal Error")
        #Append this node name as flit meta data
        #next_node.receive_flit(flit)

        pass

    def clock(destination_node): #In this case asks the router to generate a flit dor the dest node specified

        pass
    
