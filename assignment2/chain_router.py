import re
from router import Router
from flit import Flit
from butterfly import dec_to_bin

class ChainRouter(Router):
    def __init__(self,name):
        super(ChainRouter, self).__init__(name)
        #### Would have to remove this - use the one is base class
        self.vc={} #Dictionary for virtual channel. Key vc name and val is flit  ##### can be moved to base class
        self.headnode_name=""    ##### can be moved to base class
        return

    #To be called after the network is fully created
    #def create_virtual_channels(self):  ##### can be moved to base class

    #    #print("head node name is->"+self.headnode_name)

    #    #mynw=re.findall('_N(\d+)_.*',self.name) #To find my level -> L1_N6_C_011 To match network level 1 (L1) or 2 (L2)
    #    for neighbr in self.neighbour:
    #        neighbr_nwid_nodid=re.findall('_(N\d+)_.*_(\d+)$',neighbr.name) #L1_N6_C_011 To match network name and node id eg.N6, 011
    #        neighbr_nwid_nodid=neighbr_nwid_nodid[0][0]+"_"+neighbr_nwid_nodid[0][1] #eg. N6_011
    #        self.vc[neighbr_nwid_nodid]=None

    def find_next(self,dest_name):
        
        if(self.name==dest_name):
            return #Routing over, print the route

        src_nw_id=re.findall('_(N\d+)_.*',self.name)
        dst_nw_id=re.findall('_(N\d+)_.*',dest_name)

        if(src_nw_id==dst_nw_id): #The destination is in my network
            #if(dest_name[1]=='1'):# Destination is L1 (head node)
            #    if(self.headnode_at_right()==True):
            #        return self.create_next_node_name(True)
            #    else:
            #        return self.create_next_node_name(False)
            #
            #else:#Not head node
            my_id=re.findall('C_(\d+)',self.name)
            dest_id=re.findall('C_(\d+)',dest_name)

            if(int(my_id[0])<int(dest_id[0])):
                return self.create_next_node_name(True)
            else:
                return self.create_next_node_name(False)

        else: # Destination is in another network
            #Am I in L2 network now? then go to head node
            if(self.name[1]==2): #L2
                my_id=re.findall('C_(\d+)',self.name)
                head_id=re.findall('C_(\d+)',self.headnode_name)
                if(int(my_id[0])<int(head_id[0])):
                    return self.create_next_node_name(True)
                else:
                    return self.create_next_node_name(False)

            else: #At head node L1 routing needed

                pass

    def create_next_node_name(self, incr_or_decr):
        #Extract id part from my name and increment it
        my_id=re.findall('C_(\d+)',self.name)
        my_id=my_id[0]
        id_len=len(str(my_id))
        my_id=int(my_id, 2)
        if(incr_or_decr==True):
            my_id=my_id+1
        else:
            my_id=my_id-1

        #Extract id part from my headnode name 
        head_id=re.findall('C_(\d+)',self.headnode_name)
        head_id=head_id[0]
        head_id=int(head_id, 2)

        if(my_id==head_id): # Next node is head, so toplogy is L1
            nw_lvl="L1"
        else:
            nw_lvl="L2"

        my_id=dec_to_bin(my_id,id_len)
        my_id=self.name[:int(id_len)*-1]+my_id
        return nw_lvl+ my_id[2:]

    #def headnode_at_right(self):
        ##Extract id part from my name
        #my_id=re.findall('C_(\d+)',self.name)
        #my_id=my_id[0]
        #my_id=int(my_id, 2)
        ##Extract id part from my headnode name 
        #head_id=re.findall('C_(\d+)',self.headnode_name)
        #head_id=head_id[0]
        #head_id=int(head_id, 2)
        #if(head_id>my_id):
        #    return True
        #elif (head_id<my_id):
        #    return False
        #else:
        #    print("Internal error-headnode_at_right")



    def receive_flit(flit,immediate_Src_name,dest_name): #May be it can store name of nodes it traversed as meta data   ##### can be moved to base class
        pass
