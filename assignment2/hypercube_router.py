###########################################################################
# CS6230:CAD for VLSI Systems - Project 2
# Name: Deciding the Route (In a Two level hierarchical Network on Chip)
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Routing algorithm for Hypercube
# Last updated on: 20-Oct-2021
############################################################################

# from router import Router
# from flit import Flit
from butterfly import dec_to_bin
import re

# class HypercubeRouter(Router):
#     def __init__(self,name):
#         super(HypercubeRouter, self).__init__(name)
#         return

#     # def find_next(destination_node): #current_node we know from this router
#     #     return
    
#     def receive_flit(flit,destination_node): #May be it can store name of nodes it traversed as meta data
#         pass

def hypercube_route(current_node, dest_node_name):
    ''' Do all necessary and return - incomplete function '''
    return find_next(current_node,dest_node_name)


def find_next(current_node, dest_node_name):
    '''From the current_node object identifies the next node to reach the destination.
       Returns the next node object 
       This fun. is for routing in the L2 network'''

    #print("current_node, dest_node_name->",current_node.name, dest_node_name)

    if(current_node==None):
        return None

    if(current_node.name==dest_node_name):
        print("dest reached... absorb")
        return None
    
    if(same_network(current_node.name,dest_node_name)):
        return l2_find_next(current_node, dest_node_name)
    else:
        if(is_l2(current_node.name)):#Move to head node
            return find_next(current_node,get_head_node_name(current_node.name)) 
        else:#currently in L1
            #Have to check topology and then call the correct algo. Now simply calling Routing algo of H
            return l1_find_next(current_node, dest_node_name)# L1 routing algo depends on L1 topology



def l2_find_next(current_node, dest_node_name):
    '''If both the nodes belong to same network (including head node) finds the next node
    The current node might belong to L2 and next node may be in L1 (head node)
    The current node might belong to L1 (head node) and next node may be in L2 
    If the both the nodes are same None is returned
    current_node is the Node object, dest_node_name is the name of destination'''

    if(current_node==None):
        print("Internal error- l2_find_next - bad call")
        return None
    src_n_id=get_node_id_from_name(current_node.name)
    dst_n_id=get_node_id_from_name(dest_node_name)
    next_node_id=get_lsb_to_msb_next_id(src_n_id,dst_n_id)
    next_node_name=new_node_name_from_id(current_node.name, next_node_id)
    if(is_l2(current_node.name)==False):#This is a head node
        next_node_name="L2"+next_node_name[2:]
    
    next_node_id=get_node_id_from_name(next_node_name)
    if(int(next_node_id)==0):#Next node is head node. Change to L1
        next_node_name="L1"+next_node_name[2:]
    
    next_node=is_node_in_neighbour_list(current_node,next_node_name)
    if(next_node==None):
        print("Internal error: Hypercube-node is not in neighbour list")
        return None
    else:
        return next_node


def l1_find_next(current_node, dest_node_name):
    if(current_node==None):
        print("Internal error- l1_find_next - bad call")
        return None
    src_nw_id=get_network_id_from_name(current_node.name)
    dst_nw_id=get_network_id_from_name(dest_node_name)
    src_nw_id=dec_to_bin(int(src_nw_id))
    dst_nw_id=dec_to_bin(int(dst_nw_id))
    nw_ids=[src_nw_id,dst_nw_id]
    make_equal_len_id(nw_ids)
    next_nw_id=get_lsb_to_msb_next_id(nw_ids[0],nw_ids[1])
    if(next_nw_id==src_nw_id):
        return None
    next_node=is_nwid_in_neighbour_list(current_node,str(int(next_nw_id,2)))
    if(next_node==None):
        print("Internal error: Hypercube-network is not in neighbour list")
        return None
    else:
        return next_node
    

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
    return str(nw_id[0])


def get_lsb_to_msb_next_id(src,dst):
    '''From LSB to MSB finds the difference between src and dst
       src and dst are ids in binary formatted string
       Returns the next possible id
       eg. 101,110-> 100
           1110,1000-> 1100
           1100,1000-> 1000'''
    if(src==dst):
        return src
    length=len(src)
    if(length!=len(dst)):
        print ("Internal error:- get_lsb_to_msb_next_id- paramer length is not equal")
        return ""
    length=length-1
    while(length>=0):
        if(src[length]!=dst[length]):
            src = src[:length] + dst[length] + src[length + 1:]
            return src
        length=length-1
    print ("Internal error:- get_lsb_to_msb_next_id- could not convert")
    return ""


def new_node_name_from_id(current_name, new_id):
    '''Creates a new nodename with the given id
       current_name is a well formatted name, new_id(string) is only the id part (last digits) 
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
    
    if(current_node==None):
        print("Internal error- is_node_in_neighbour_list - bad call")
        return None
    for neighbour in current_node.neighbour:
        if(neighbour.name==node_name):
            return neighbour
    return None

def make_equal_len_id(in_list):
    '''Adds preceeding zeros to in_list[0] or in_list[1], to make them equal length
    in_list is a list containing two binary formatted string
    modifies in_list[0] or in_list[1]
    eg.11,100->011,100'''

    if(len(in_list)!=2):
        print("Internal error: make_equal_len_id input error")
    id1=in_list[0]
    id2=in_list[1]
    
    if(len(id1)>len(id2)):
        diff=len(id1)-len(id2)
        ret=id2
        while(diff>0):
            ret='0'+ret
            diff=diff-1
        in_list[1]=ret
    else:
        diff=len(id2)-len(id1)
        ret=id1
        while(diff>0):
            ret='0'+ret
            diff=diff-1
            print (id1,id2)
        in_list[0]=ret


def is_nwid_in_neighbour_list(current_node,next_nw_id):
    '''Searches the next_nw_id in the neighbours of current_node
    current_node is a node object, next_nw_id is decimal formatted string containing only NW id
    Returns the matched node on success, None on no match'''
    
    if(current_node==None):
        print("Internal error- is_nwid_in_neighbour_list - bad call")
        return None
    for neighbour in current_node.neighbour:
        neightbour_nw_id=get_network_id_from_name(neighbour.name)
        if(int(next_nw_id)==int(neightbour_nw_id)):
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


def get_head_node_name(name):
    '''Gets the headnode of current hypercube network from name
    name is a well formatted hypercube name (string
    returns string - head node name'''

    node_id=get_node_id_from_name(name)
    zeros_node_id=dec_to_bin(0,len(node_id))
    head_node_name=new_node_name_from_id(name,zeros_node_id)
    head_node_name="L1"+head_node_name[2:]
    return head_node_name
