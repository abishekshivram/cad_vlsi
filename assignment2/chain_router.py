import re
from router import Router
from flit import Flit

class ChainRouter(Router):
    def __init__(self,name):
        super(ChainRouter, self).__init__(name)
        self.vc={} #Dictionary for virtual channel. Key vc name and val is flit
        return

    #To be called after the network is fully created
    def create_virtual_channels(self):
        #mynw=re.findall('_N(\d+)_.*',self.name) #To find my level -> L1_N6_C_011 To match network level 1 (L1) or 2 (L2)
        for neighbr in self.neighbour:
            neighbr_nwid_nodid=re.findall('_(N\d+)_.*_(\d+)$',neighbr.name) #L1_N6_C_011 To match network name and node id eg.N6, 011
            neighbr_nwid_nodid=neighbr_nwid_nodid[0][0]+"_"+neighbr_nwid_nodid[0][1] #eg. N6_011
            self.vc[neighbr_nwid_nodid]=None

    def find_next(dest_name): #current_node we know from this router
        if(self.name==dest_name):
            return #Routing over, print the route
        src_nw_id=re.findall('_(N\d+)_.*',self.name)
        dst_nw_id=re.findall('_(N\d+)_.*',dest_name)
        if(src_nw_id==dst_nw_id): #The destination is in my network
            if(dest_name[1]=='1'):# Destination is L1 (head node)
                #Headnode at right or at left?
                pass
            else:#Not head node
                # my id < or > of the dest?
                pass
        else:
            pass

        



        return
    
    def receive_flit(flit,immediate_Src_name,dest_name): #May be it can store name of nodes it traversed as meta data
        pass
