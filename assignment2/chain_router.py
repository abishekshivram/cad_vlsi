import re
# from router import Router
# from flit import Flit
from butterfly import dec_to_bin


from asgn1 import L1_network, L2_networks

def chain_route(src_node, dest_name,full_network):
    ''' Do all necessary and return - incomplete function '''
    return find_next(src_node, dest_name,full_network)

# class ChainRouter(Router):
#     def __init__(self,name):
#         super(ChainRouter, self).__init__(name)
#         #### Would have to remove this - use the one is base class
#         self.vc={} #Dictionary for virtual channel. Key vc name and val is flit  ##### can be moved to base class
#         self.headnode_name=""    ##### can be moved to base class
#         return

#To be called after the network is fully created
#def create_virtual_channels(self):  ##### can be moved to base class

#    #print("head node name is->"+self.headnode_name)

#    #mynw=re.findall('_N(\d+)_.*',self.name) #To find my level -> L1_N6_C_011 To match network level 1 (L1) or 2 (L2)
#    for neighbr in self.neighbour:
#        neighbr_nwid_nodid=re.findall('_(N\d+)_.*_(\d+)$',neighbr.name) #L1_N6_C_011 To match network name and node id eg.N6, 011
#        neighbr_nwid_nodid=neighbr_nwid_nodid[0][0]+"_"+neighbr_nwid_nodid[0][1] #eg. N6_011
#        self.vc[neighbr_nwid_nodid]=None

def find_next(src_node,dest_name,full_network):
    src_name = src_node.name
    if(src_name==dest_name):
        ''' Destination already reached - we can consume'''
        return #Routing over, print the route

    src_nw_id=int(re.findall('_N(\d+)_.*',src_name)[0])
    dst_nw_id=int(re.findall('_N(\d+)_.*',dest_name)[0])

    if(src_nw_id==dst_nw_id): 

        my_id=re.findall('C_(\d+)',src_name)
        dest_id=re.findall('C_(\d+)',dest_name)

        ''' Move right if dest is higher in number'''
        if(int(my_id[0])<int(dest_id[0])):
            name = create_next_node_name(src_name, True)
            return full_network.name_node_dict[name]
            
        else:
            ''' Move left since its lower in number'''
            name = create_next_node_name(src_name, False)
            return full_network.name_node_dict[name]

    else: # Destination is in another network
        #Am I in L2 network now? then go to head node
        if(src_name[1]=='2'): #L2
            my_id=re.findall('C_(\d+)', src_name)
            headnode_name = L2_networks[src_nw_id].get_head_node().name
            head_id=re.findall('C_(\d+)', headnode_name)
            ''' Move right towards head node'''
            if(int(my_id[0])<int(head_id[0])):
                name = create_next_node_name(src_name, True)
                return full_network.name_node_dict[name]
            else:
                ''' Move left towards head node'''
                name = create_next_node_name(src_name, False)
                return full_network.name_node_dict[name]

        else: #At head node L1 routing needed
            current_node_name = src_name
            #assert () check if L1 is chain - sanity check
            for i in (L1_network.vertices):
                if(i.name == current_node_name):
                    current_node = i
                    break
            
            ''' Move left-right based on network id '''
            if(src_nw_id<dst_nw_id):
                # Move right
                right_network = src_nw_id + 1
                NextNode = L1_network.vertices[right_network]
                return full_network.name_node_dict[NextNode.name]
            else:
                left_network = src_nw_id - 1
                NextNode = L1_network.vertices[left_network]
                return full_network.name_node_dict[NextNode.name]


def create_next_node_name(src_name, incr_or_decr):
    #Extract id part from my name and increment it
    my_id=re.findall('C_(\d+)',src_name)
    my_id=my_id[0]
    id_len=len(str(my_id))
    my_id=int(my_id, 2)
    if(incr_or_decr==True):
        my_id=my_id+1
    else:
        my_id=my_id-1

    src_nw_id=int(re.findall('_N(\d+)_.*',src_name)[0])
    headnode_name = L2_networks[src_nw_id].get_head_node().name

    #Extract id part from my headnode name 
    head_id=re.findall('C_(\d+)', headnode_name)
    head_id=head_id[0]
    head_id=int(head_id, 2)

    if(my_id==head_id): # Next node is head, so toplogy is L1
        nw_lvl="L1"
    else:
        nw_lvl="L2"

    my_id=dec_to_bin(my_id,id_len)
    my_id=src_name[:int(id_len)*-1]+my_id
    return nw_lvl+ my_id[2:]


def receive_flit(flit,immediate_Src_name,dest_name): #May be it can store name of nodes it traversed as meta data   ##### can be moved to base class
    pass
