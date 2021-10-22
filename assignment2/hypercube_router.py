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
            #Have to check topology and then call the correct algo. Now simply calling Routing algo of H
            return l1_find_next(current_node, dest_node_name)# L1 routing algo depends on L1 topology



def l2_find_next(current_node, dest_node_name):
    src_n_id=get_node_id_from_name(current_node.name)
    dst_n_id=get_node_id_from_name(dest_node_name)
    next_node_id=get_lsb_to_msb_next_id(src_n_id,dst_n_id)
    next_node_name=new_node_name_from_id(current_node.name, next_node_id)
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
       Returns the next possible id
       eg. 101,110-> 100
           1110,1000-> 1100
           1100,1000-> 1000'''
    
    length=len(src)
    if(length!=len(dst)):
        print ("Internal error:- get_lsb_to_msb_next_id- paramer length is not equal")
    length=length-1
    while(length>=0):
        if(src[length]!=dst[length]):
            src[length]=dst[length]
            return src
        length=length-1
    print ("Internal error:- get_lsb_to_msb_next_id- could not convert")
    return ""


def new_node_name_from_id(current_name, new_id):
    '''Creates a new nodename with the given id
       current_name is a well formatted name, new_id is only the id part (last digits) 
       Returns string -node name
       eg L2_N2_H_100,110-> L2_N2_H_110'''

    nod_id=get_node_id_from_name(current_name)
    if(len(nod_id)!=len(new_id)):
        print("Internal error: node_name_from_id, id length not matching")
        return
    my_id=current_name[:len(new_id)*-1]+new_id
    return my_id


def is_node_in_neighbour_list(current_node,node_name):
    '''Searches the node_name in the neighbours of current_node
    current_node is a node object node_name is string well formatted node name
    Returns the matched node on success, None on no match'''
    
    for neighbour in current_node.neighbour:
        if(neighbour.name==node_name):
            return neighbour
    return None

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
    
    cur_node_nw_id=get_network_id_from_name(current_node.name)
    for neighbour in current_node.neighbour:
        neightbour_nw_id=get_network_id_from_name(neighbour.name)
        if(cur_node_nw_id==neightbour_nw_id):
            return neighbour
    return None


def is_l2(name):
    '''Returns True if the node name belongs to L2
    name is a well formated node name
    eg L2_N2_H_100-> True
    L1_N2_H_100-> False
    '''
    if(name[1]=='2'):
        return True
    return False
