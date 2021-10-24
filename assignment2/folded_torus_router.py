from router import Router
from flit import Flit
from simulate import L1_network, L2_networks
from re import compile,findall

from sys import path
path.insert(1, './../assignment1')
from butterfly import dec_to_bin
from foldedTorus import FoldedTorus

class FoldedTorusRouter(Router):
    def __init__(self,name):
        super(FoldedTorusRouter, self).__init__(name)
        return

    def find_next(destination_node): #current_node we know from this router
        return
    
    def receive_flit(flit,destination_node): #May be it can store name of nodes it traversed as meta data
        pass

def foldedtorus_route(current_node, dest_node_name):
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
    
    network_id = int(get_network_id_from_name(current_node.name))
    rowCount = L2_networks[network_id].rowCount
    colCount = L2_networks[network_id].colCount
    next_node_id=get_next_id(src_n_id,dst_n_id,rowCount,colCount)
    next_node_name=get_node_name_from_id(current_node.name, next_node_id)

    next=is_node_in_neighbour_list(current_node,next_node_name)
    if(next==None):
        print("Internal error: folded torus-node is not in neighbour list")
        return None
    else:
        return next


def l1_find_next(current_node, dest_node_name):
    if(current_node==None):
        print("Internal error- l1_find_next - bad call")
        return None
    src_nw_id=int(get_network_id_from_name(current_node.name))
    dst_nw_id=int(get_network_id_from_name(dest_node_name))

    if (type(L1_network) != FoldedTorus):
        print("L1 network is not folded torus- invalid call to folded torus routine")
        return None
    l1_row_dim = L1_network.rowCount
    l1_col_dim = L1_network.colCount

    src_nw_id= int(src_nw_id)
    src_col_id = src_nw_id % l1_row_dim
    src_row_id = src_nw_id // l1_row_dim
    src = (src_row_id,src_col_id)

    dst_nw_id= int(dst_nw_id)
    dst_col_id = dst_nw_id % l1_row_dim
    dst_row_id = dst_nw_id // l1_row_dim
    dst = (dst_row_id,dst_col_id)

    # Find the next node in the path
    next_id =get_next_id(src,dst)
    if(next_id==src):
        return None
    next=is_nwid_in_neighbour_list(current_node, next_id[0]*l1_col_dim+next_id)
    if(next==None):
        print("Internal error: Folded torus-network is not in neighbour list")
        return None
    else:
        return next
    

def same_network(name1, name2):
    '''Checks if name1 and name2 are in same network
        Name1 and Name2 are well formatted node names
        Returns True if they are. False otherwise
        eg L2_N2_H_100, L1_N2_H_200-> True'''

    src_nw_id=findall('_(N\d+)_.*',name1)
    dst_nw_id=findall('_(N\d+)_.*',name2)
    if(src_nw_id[0]==dst_nw_id[0]):# Assumes well formatted name is given
        return True
    return False


def get_node_id_from_name(name):
    '''Extaracts the node id (last part of the name) from the given name
    Name is a well formatted node name
    Returns string name'''

    id=findall('_(\d+)_(\d+)$',name)
    for i in range(2):
        id[0][i] = int(id[0][i],2)
    return id[0]


def get_network_id_from_name(name):
    '''Extracts the network id (integer after _N) from the given name
    Name is a well formatted node name
    Returns string name
    eg L2_N2_H_100-> 2'''
    
    nw_id=findall('_N(\d+)_.*',name)
    return nw_id[0]


def get_next_id(src,dst,rowCount,colCount):
    '''From LSB to MSB finds the difference between src and dst
       src and dst are ids in binary formatted string
       Returns the next possible id
       eg. 101,110-> 100
           1110,1000-> 1100
           1100,1000-> 1000'''
    if(src==dst):
        return src
        
    while (src[1] != dst[1]):
        if (abs(src[1] - dst[1]) > colCount//2):
            if (src[1] > dst[1]):
                src[1] = (src[1] + 1) % colCount
            else:
                src[1] = (src[1] - 1) % colCount
        else:
            if (src[1] > dst[1]):
                src[1] -= 1
            else:
                src[1] += 1

        return src
    
    while (src[0] != dst[0]):
        if (abs(src[0] - dst[0]) > rowCount//2):
            if (src[0] > dst[0]):
                src[0] = (src[0] + 1) % rowCount
            else:
                src[0] = (src[0] - 1) % rowCount
        else:
            if (src[0] > dst[0]):
                src[0] -= 1
            else:
                src[0] += 1
        
        return src



def get_node_name_from_id(current_node_name,new_id):
    '''Creates a new nodename with the given id
       current_name is a well formatted name, new_id(string) is only the id part (last digits) 
       Returns string -node name'''

    nod_id = findall('(.*_)(\d+)_(\d+)$',current_node_name)
    new_node_name = nod_id[0] + str(dec_to_bin(new_id[0],len(nod_id[0][1]))) + '_' + str(dec_to_bin(new_id[1],len(nod_id[0][2])))
    return new_node_name


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


def get_head_node_name(current_node_name):
    '''Gets the headnode of current folded torus network from name
    name is a well formatted folded torus name (string
    returns string - head node name'''

    network_id = int(get_network_id_from_name(current_node_name))
    return L2_networks[network_id].get_head_node().name
    
    