###########################################################################
# CS6230:CAD for VLSI Systems - Project 2
# Name: Deciding the Route (In a Two level hierarchical Network on Chip)
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: To construct the network from the output of Project 1
# Last updated on: 20-Oct-2021
############################################################################

import sys
sys.path.insert(1, './../assignment1')
import re
from node import Node
from butterfly import log
from butterfly import dec_to_bin


from chain_router import ChainRouter
from hypercube_router import HypercubeRouter

class NetworkLayout:
    """
    A class to represent Nodes (Vertices) in the network.
    A node can be present in Level2 or in the case head node Level1 and Level2
    A head node is considered to be part of Level1 network
    """
    def __init__(self, layout_filename):
        '''Build network from project1 output file
        The layour is stored as dictionary in name_node_dict'''
        self.filename=layout_filename
        self.name_node_dict={}
        self.build_layout()

    def node_exists(self,node_name):
        '''Searches the given node name in the network layout
        Returns Node object on success, None otherwie
        node_name is a well formatted node name'''
        out=self.name_node_dict[node_name]
        return out


    def build_layout(self):
        '''Build network from project1 output file
        The layour is stored as dictionary in name_node_dict'''

        with open(self.filename) as file:
            '''This block reads all the nodes and switches from the input file added to the dictionary
            In this phase links are not established
            The respective router is also attached with the Node object
            eg. for chain node ChainRouter, for Hypercube node HypercubeRouter etc..'''
            for line in file:
                nid=line.partition("NodeID:")[2]
                if(nid==""):
                    nid=line.partition("Switch ID:")[2]
                if(nid!=""):
                    node_name=str(nid).strip()

                    match=re.findall('L\d+_N\d+_([a-z,A-Z])+_',node_name) #L1_N6_C_011 To match network name C,R,M etc..
                    match=str(match[0]).strip()
                    if(match=="C"): #Chain Router
                        self.name_node_dict[node_name]=ChainRouter(node_name) 
                    elif(match=="R"): #Ring Router
                        self.name_node_dict[node_name]=Node(node_name) #Change
                    elif(match=="M"): #Mesh Router
                        self.name_node_dict[node_name]=Node(node_name) #Change
                    elif(match=="F"): #Folded Torus Router
                        self.name_node_dict[node_name]=Node(node_name) #Change
                    elif(match=="B"): #Butterfly Router
                        self.name_node_dict[node_name]=Node(node_name) #Change
                    elif(match=="H"): #Hypercube Router
                        self.name_node_dict[node_name]=HypercubeRouter(node_name)
                    else:
                        print("Error: Unknown network->"+match)
                    

        with open(self.filename) as file:
            '''This block reads the link information from the inout file and establishes the 
            link between nodes (Routers)'''
            for line in file:
                nid=line.partition("NodeID:")[2]
                sid=line.partition("Switch ID:")[2]
                nid=str(nid).strip()
                sid=str(sid).strip()
                if(nid!="" or sid!=""): #Match for NodeID/SwitchID
                    line1=file.readline()
                    link_count=int(line1.partition("Links:")[2]) #Match Links: and extarct link count
                    while(link_count):
                        line1=file.readline()
                        match=re.findall('L\d+:(.*)',line1)
                        if match:
                            lname=str(match[0]).strip()
                            node_ref=self.name_node_dict[lname] #Extarct node reference from dictionary for links L1,L2 etc
                            if(nid!=""):
                                self.name_node_dict[nid].add_neighbour(node_ref)
                            if(sid!=""):
                                self.name_node_dict[sid].add_neighbour(node_ref)
                            link_count=link_count-1

        with open(self.filename) as file:
            ''' This block computes the no of nodes in each L2 chain network 
            Identifies the headnode for chain networks'''
            dic_chain={} # Stores the node count for each L2 chain network
            dic_hc={} #may not be needed
            for line in file:
                match_c=re.findall('NodeID:.*_N(\d+)_C',line)
                match_h=re.findall('NodeID:.*_N(\d+)_H',line)
                if(match_c):
                    if(int(match_c[0]) not in dic_chain):
                        dic_chain[int(match_c[0])]=1
                    else:
                        dic_chain[int(match_c[0])]=dic_chain[int(match_c[0])]+1

                elif(match_h):# This block may not be needed
                    if(int(match_h[0]) not in dic_hc):
                        dic_hc[int(match_h[0])]=1
                    else:
                        dic_hc[int(match_h[0])]=dic_hc[int(match_h[0])]+1                        



        for n_name, n_val in self.name_node_dict.items():
            

            match=re.findall('L\d+_N(\d+)_([a-z,A-Z])+_',n_name) #L1_N6_C_011 To match network name C,R,M etc..
            match_nwid=str(match[0][0]).strip()
            match_topo=str(match[0][1]).strip()
            #print(match_nwid+","+match_topo)
            if(match_topo=="C"): #Chain Router
                width=log(dic_chain[int(match_nwid)])
                head_node_id=dec_to_bin(dic_chain[int(match_nwid)]//2,width) # generate head node id (last part of the name)
                n_val.headnode_name="L1_N"+str(match_nwid)+"_C_"+head_node_id # create headnode name and set it in each node
                n_val.create_virtual_channels()

                #test line
                n_val.find_next("L2_N0_C_11")

            elif(match_topo=="R"): #Ring Router
                pass
            elif(match_topo=="M"): #Ring Router
                pass
            elif(match_topo=="F"): #Ring Router
                pass
            elif(match_topo=="B"): #Ring Router
                pass
            elif(match_topo=="H"): #Hypercube Router
                width=log(dic_hc[int(match_nwid)])
                head_node_id=dec_to_bin(0,width) # generate head node id (last part of the name)
                n_val.headnode_name="L1_N"+str(match_nwid)+"_H_"+head_node_id # create headnode name and set it in each node
                #n_val.create_virtual_channels()

                #print("head node name is->"+n_val.headnode_name)
