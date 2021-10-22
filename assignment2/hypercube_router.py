from router import Router
from flit import Flit
from butterfly import dec_to_bin
import re

class HypercubeRouter(Router):
    def __init__(self,name):
        super(HypercubeRouter, self).__init__(name)
        return

    def find_next(destination_node): #current_node we know from this router
        return
    
    def receive_flit(flit,destination_node): #May be it can store name of nodes it traversed as meta data
        pass




def find_next(current_node, dest_node_name):
    '''From the current_node object identifies the next node to reach the destination.
       Returns the next node object 
       This fun. is for routing in the L2 network'''
    
    if(same_network(current_node.name,dest_node_name)):
        return l2_find_next(current_node, dest_node_name)
    else:
        if(is_l2(current_node.name)):#Move to head node
            find_next(current_node,"L2_N2_H_000") # will change the constant with real head node id
        else:#currently in L1
            return l1_find_next(current_node, dest_node_name)# L1 routing algo depends on L1 topology



def l2_find_next(current_node, dest_node_name):
    src_n_id=get_node_id_from_name(current_node.name)
    dst_n_id=get_node_id_from_name(dest_node_name)
    next_node_id=get_lsb_to_msb_next_id(src_n_id,dst_n_id)
    next_node_name=node_name_from_id(current_node.name, next_node_id)
    next=is_node_in_neighbour_list(current_node,next_node_name)
    if(next==None):
        print("Internal error: Hypercube-node is not in neighbour list")
    else:
        return next


def l1_find_next(current_node, dest_node_name):
    src_nw_id=get_network_id_from_name(current_node.name)
    dst_nw_id=get_network_id_from_name(dest_node_name)
    src_nw_id=dec_to_bin(src_nw_id)
    dst_nw_id=dec_to_bin(dst_nw_id)
    make_equal_len_id(src_nw_id,dst_nw_id)
    next_nw_id=get_lsb_to_msb_next_id(src_nw_id,src_nw_id)
    next=is_nwid_in_neighbour_list(current_node,next_nw_id)
    if(next==None):
        print("Internal error: Hypercube-network is not in neighbour list")
    else:
        return next
    

def same_network(name1, name2):
    '''Checks if name1 and name2 are in same network
        Name1 and Name2 are well formatted node names
        Returns True if they are. False otherwise
        eg L2_N2_H_100, L1_N2_H_200-> True'''

    src_nw_id=re.findall('_(N\d+)_.*',name1)
    dst_nw_id=re.findall('_(N\d+)_.*',name2)
    if(src_nw_id[0]==dst_nw_id[0]):# Assumes well formatted name is given
        return True
    return False


def get_node_id_from_name(name):
    '''Extaracts the node id (last part of the name) from the given name
    Name is a well formatted node name
    Returns string name
    eg L2_N2_H_100-> 100'''

    id=re.findall('_(\d+)$',name)
    return id[0]


def get_network_id_from_name(name):
    '''Extaracts the network id (integer after _N) from the given name
    Name is a well formatted node name
    Returns string name
    eg L2_N2_H_100-> 2'''
    nw_id=re.findall('_N(\d+)_.*',name)
    return nw_id[0]


def get_lsb_to_msb_next_id(src,dst):
    '''From LSB to MSB finds the difference between src and dst
       src and dst are ids in binary formatted string
       Returns the next possible id'''
    pass

def node_name_from_id(current_name, new_id):
    '''Creates a new nodename with the given id
    current_name is a well formatted name, new_id is only the id part (last digit) 
       Returns string -node name'''


    pass

def is_node_in_neighbour_list(current_node,node_name):
    '''Searches the node_name in the neighbours of current_node
    current_node is a node object node_name is string well formatted node name
    Returns the matched node on success, None on no match'''
    pass

def make_equal_len_id(id1,id2):
    '''Adds preceeding zeros to id1 or id2, to make them equal length
    id1 and id2 are binary formatted string
    modifies id1 or id2
    eg.11,100->011,100'''
    
    if(len(id1)>len(id2)):
        diff=len(id1)-len(id2)
        ret=id2
        while(diff>0):
            ret='0'+ret
        id2=ret
    else:
        diff=len(id2)-len(id1)
        ret=id1
        while(diff>0):
            ret='0'+ret
        id1=ret


def is_nwid_in_neighbour_list(current_node,next_nw_id):
    '''Searches the nw_id in the neighbours of current_node
    current_node is a node object, next_nw_id is binary formatted string containing only NW id
    Returns the matched node on success, None on no match'''
    pass

def is_l2(name):
    '''Returns True if the node name belongs to L2
    '''
    pass



#L2_N2_H_100

    #neighbr_nwid_nodid=re.findall('_(N\d+)_.*_(\d+)$',neighbr.name) #L1_N6_C_011 To match network name and node id eg.N6, 011
    #neighbr_nwid_nodid=neighbr_nwid_nodid[0][0]+"_"+neighbr_nwid_nodid[0][1] #eg. N6_011


    #Extract id part from my name and increment it
    #my_id=re.findall('C_(\d+)',self.name)
    #my_id=my_id[0]
    #id_len=len(str(my_id))
    #my_id=int(my_id, 2)
    #if(incr_or_decr==True):
    #    my_id=my_id+1
    #else:
    #    my_id=my_id-1


    #src_nw_id=re.findall('_(N\d+)_.*',self.name)
    #dst_nw_id=re.findall('_(N\d+)_.*',dest_name)

    #if(src_nw_id==dst_nw_id): #The destination is in my network