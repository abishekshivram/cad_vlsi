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
        if(self.name==name):    
            if(self.vc[i]==None):
                return True
            else:
                return False
        return False
        
    def add_flit_to_vc(self,name,flit):
        '''Adds flits to VC of the given name
        Name is the well formatted name of the neighbour who wants to add flit in my vc
        The assumption is that the VC is free
        call is_vc_free before calling this function'''

        i=0
        for neighbr in self.neighbour:
            if(neighbr.name==name):
                self.vc[i]=(1,flit)
                return True
            i=i+1
        return False


    def add_flits_to_fifo_from_host(self, flit):
        '''Adds host generated Flits to the FIFO - for ready to transfer
        flit is a valid Flit object'''

        print("add_flits_to_fifo_from_host->", self.name,flit.dst_name)
        self.flit_from_host_node.put(flit)


    def increment_flit_priority(self):
        ''' Increments the priority of flits in all the virtual channels of this router'''
        for key,val in self.vc.items():
            if(val==None):
                continue
            pair=self.vc[key]
            print("pair old val->",self.vc[key])
            new_pair=(pair[0]+1,pair[1])
            self.vc[key]=new_pair
            print("pair new val->",self.vc[key])


    def add_flit_to_vc_from_host_fifo(self):
        '''If host FIFO contains a Flit and if the Host's VC is free adds the flit to VC
        Initially flit is added with priority 0'''
        vc_no=len(self.neighbour)
        if(self.vc[vc_no]!=None):#VC Free
            flit=self.flit_from_host_node.get()
            if(flit):
                self.vc[vc_no]=(0,flit)

    def get_key_of_flit_from_vc_with_priority(self,priority):
        '''From virtual channels returns the key which has the given priority
        priority-int specifies the priority
        1 indicates the high priority value to extarct
        2 secnd etc...
        returns None if the item with the given priority doesnt exist
        '''
        priority_dict = {}
        for i in self.vc:
            priority_dict[i] = self.vc[i][0]

        # Sorting the priorities of self.vc in descending order
        sorted_priority = sorted(priority_dict.items(), key = lambda kv: kv[1],reverse=True)
        
        #Returning the key of the vc dictionary with the given priority
        return sorted_priority[priority-1][0]

    def remove_flit(self, channel_no):
        '''Removes the flit from the given channel number'''
        if(channel_no>=len(self.vc)):
            return
        self.vc[channel_no]=None

    def get_flit(self, channel_no):
        '''Gets the flit (copy) from the given channel number'''
        if(channel_no>=len(self.vc)):
            return None
        if(self.vc[channel_no]):
            return self.vc[channel_no][1]
        return None

    def clock(self): 
        self.add_flit_to_vc_from_host_fifo()
        self.increment_flit_priority()
        
        i=1
        while(i<=len(self.vc)):
            key=self.get_key_of_flit_from_vc_with_priority(i)
            if(key):
                flit=self.get_flit(key)
                next=self.find_next(self, flit.dst_name)
                if(next.is_vc_free(self.name)):
                    next.add_flit_to_vc(self.name,flit)
                    self.remove_flit(key)
        i=i+1

        #2) Chose the flit with highest priority to send
        #3) Try to send it (if the channel already used in this clock- cant send), if successful remove from VC and update output channel as used
        #4) Repeat step2 until all the VC are traversed
        pass
        

        #scan through the virtual channels of this node
        #find the one with highest priority
        #extarct the Flit
        #from flit extarct the dest node name
        #next_node=find_next(destination_node)
        #if(next==None):
        #    print("Internal Error")
        #Append this node name as flit meta data
        #next_node.receive_flit(flit)
