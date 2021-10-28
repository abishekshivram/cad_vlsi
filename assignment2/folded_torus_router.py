# from router import Router
# from flit import Flit
from asgn1 import L1_network, L2_networks
from re import findall

from sys import path
path.insert(1, './../assignment1')
from butterfly import dec_to_bin
from foldedTorus import FoldedTorus

# class FoldedTorusRouter(Router):
#     def __init__(self,name):
#         super(FoldedTorusRouter, self).__init__(name)
#         return

#     # def find_next(destination_node): #current_node we know from this router
#     #     return
    
#     def receive_flit(flit,destination_node): #May be it can store name of nodes it traversed as meta data
#         pass

def foldedtorus_route(current_node, dest_node_name):
    ''' Runs mesh routing algorithm to find the next node'''    
    a = find_next(current_node,dest_node_name)
    return a



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

    next_node=is_node_in_neighbour_list(current_node,next_node_name)
    if(next_node==None):
        print("Internal error: folded torus-node is not in neighbour list")
        return None
    else:
        return next_node


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
    src = [src_row_id,src_col_id]

    dst_nw_id= int(dst_nw_id)
    dst_col_id = dst_nw_id % l1_row_dim
    dst_row_id = dst_nw_id // l1_row_dim
    dst = [dst_row_id,dst_col_id]

    # Find the next node in the path
    next_id =get_next_id(src,dst,l1_row_dim,l1_col_dim)
    next_node=is_nwid_in_neighbour_list(current_node, next_id[0]*l1_col_dim+next_id[1])
    if(next_node==None):
        print("Internal error: Folded torus-network is not in neighbour list")
        return None
    else:
        return next_node
    

def same_network(name1, name2):
    '''Checks if name1 and name2 are in same network
        Name1 and Name2 are well formatted node names
        Returns True if they are. False otherwise
        eg L2_N2_F_01_100, L1_N2_F_01_110-> True'''

    src_nw_id=findall('_(N\d+)_.*',name1)
    dst_nw_id=findall('_(N\d+)_.*',name2)
    if(src_nw_id[0]==dst_nw_id[0]):# Assumes well formatted name is given
        return True
    return False


def get_node_id_from_name(name):
    '''Extaracts the node id (last part of the name) from the given name
    Name is a well formatted node name
    eg L2_N2_F_01_100-> [1,4]'''

    identity=findall('_(\d+)_(\d+)$', name)[0]
    identity=list(identity)
    for i in range(2):
        temp = int(identity[i], base=2)
        identity[i] = temp
    return identity


def get_network_id_from_name(name):
    '''Extracts the network id (integer after _N) from the given name
    Name is a well formatted node name
    Returns string name
    eg L2_N2_F_01_100-> 2'''
    
    nw_id=findall('_N(\d+)_.*',name)
    return nw_id[0]


def get_next_id(src,dst,rowCount,colCount):
    '''From LSB to MSB finds the difference between src and dst
       src and dst are ids in binary formatted string
       Returns the next possible id
       eg. [4,5],[5,1]-> [4,6]: If there are 7 columns'''
    if(src==dst):
        return src
    if (src[1] != dst[1]):
        if (abs(src[1] - dst[1]) > colCount//2):
            if (src[1] > dst[1]):
                src[1] = (src[1] + 1) % colCount
            else:
                src[1] = (src[1] - 1) % colCount
        else:
            if (src[1] > dst[1]):
                src[1] = (src[1] - 1) % colCount
            else:
                src[1] = (src[1] + 1) % colCount

        return src
    
    # Date line algorithm: Clockwise implementation
    if (src[0] != dst[0]):
        # if (abs(src[0] - dst[0]) > rowCount//2):
        #     if (src[0] > dst[0]):
        src[0] = (src[0] + 1) % rowCount
        #     else:
        #         src[0] = (src[0] - 1) % rowCount
        # else:
        #     if (src[0] > dst[0]):
        #         src[0] -= 1
        #     else:
        #         src[0] += 1
        
        return src



def get_node_name_from_id(current_node_name,new_id):
    '''Creates a new nodename with the given id
       current_name is a well formatted name, new_id(string) is only the id part (last digits) 
       Returns string -node name'''
    nod_id = list(findall('L\d_N(\d+)_(.*)_(\d+)_(\d+)$',current_node_name)[0])
    nw_id_str = nod_id[0]
    row_idx = nod_id[2]
    col_idx = nod_id[3]
    new_node_name = 'L2' + '_N' +nw_id_str+ '_'+ nod_id[1] + '_' + str(dec_to_bin(new_id[0],len(row_idx))) + '_' + str(dec_to_bin(new_id[1],len(col_idx)))
    nw_id = int(nod_id[0])
    '''Row at centre '''
    head_node_name = L2_networks[nw_id].get_head_node().name
    if (get_node_id_from_name(head_node_name) == new_id):
        new_node_name = head_node_name

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
    print(f"Current node name: {current_node.name} is not connected to {node_name}") 
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
    print(f"Current node name: {current_node.name} is not connected to network: {next_nw_id}")    
    return None


def is_l2(name):
    '''Returns True if the node name belongs to L2
    name is a well formated node name
    eg L2_N2_F_00_100-> True
    L1_N2_F_00_110-> False
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
    
    