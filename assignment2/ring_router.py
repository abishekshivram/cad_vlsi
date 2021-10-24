import re
# from router import Router
# from flit import Flit
from butterfly import dec_to_bin

from asgn1 import L1_network, L2_networks

def ring_route(src_node, dest_name,full_network):
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

    # Same network
    if(src_nw_id==dst_nw_id): 
        links = L2_networks[src_nw_id].count
        my_id=int(re.findall('R_(\d+)',src_name)[0])
        dest_id=int(re.findall('R_(\d+)',dest_name)[0])

        ''' Move right if dest is higher in number'''
        if(abs(my_id-dest_id) > links//2):
            if (my_id > dest_id):
                name = create_next_node_name(src_name, True,links)
            else:
                name = create_next_node_name(src_name, False,links)
            
        else:
            if (my_id > dest_id):
                name = create_next_node_name(src_name, False,links)
            else:
                name = create_next_node_name(src_name, True,links)
        
        return full_network.name_node_dict[name]
            

    else: # Destination is in another network
        #Am I in L2 network now? then go to head node
        if(src_name[1]=='2'): #L2
            links = L2_networks[src_nw_id].count
            my_id=int(re.findall('R_(\d+)', src_name)[0])
            headnode_name = L2_networks[src_nw_id].get_head_node().name
            head_id=int(re.findall('R_(\d+)', headnode_name)[0])
                    
            ''' Move right if dest is higher in number'''
            if(abs(my_id-head_id) > links//2):
                if (my_id > head_id):
                    name = create_next_node_name(src_name, True,links)
                else:
                    name = create_next_node_name(src_name, False,links)
                
            else:
                if (my_id > head_id):
                    name = create_next_node_name(src_name, False,links)
                else:
                    name = create_next_node_name(src_name, True,links)
            
            return full_network.name_node_dict[name]

        else: #At head node L1 routing needed
            current_node_name = src_name
            #assert () check if L1 is ring - sanity check
            for i in (L1_network.vertices):
                if(i.name == current_node_name):
                    current_node = i
                    break
            
            links = L1_network.count

            ''' Move left-right based on network id '''
            if(abs(src_nw_id-dst_nw_id) > links//2):
                if (src_nw_id > dst_nw_id):
                    src_nw_id = (src_nw_id+1) % links
                    name = L1_network.vertices[src_nw_id].name
                else:
                    src_nw_id = (src_nw_id-1) % links
                    name = L1_network.vertices[src_nw_id].name                    
                
            else:
                if (src_nw_id > dst_nw_id):
                    src_nw_id = (src_nw_id-1) % links
                    name = L1_network.vertices[src_nw_id].name
                else:
                    src_nw_id = (src_nw_id+1) % links
                    name = L1_network.vertices[src_nw_id].name
            
            return full_network.name_node_dict[name]


def create_next_node_name(src_name, incr_or_decr,links):
    #Extract id part from my name and increment it
    my_id=re.findall('R_(\d+)',src_name)
    my_id=my_id[0]
    id_len=len(str(my_id))
    my_id=int(my_id, 2)
    if(incr_or_decr==True):
        my_id=my_id+1 % links
    else:
        my_id=my_id-1 % links

    src_nw_id=int(re.findall('_N(\d+)_.*',src_name)[0])
    headnode_name = L2_networks[src_nw_id].get_head_node().name

    #Extract id part from my headnode name 
    head_id=re.findall('R_(\d+)', headnode_name)
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
