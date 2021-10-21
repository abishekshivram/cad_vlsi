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

from chain_router import ChainRouter
from hypercube_router import HypercubeRouter

class NetworkLayout:
    """
    A class to represent Nodes (Vertices) in the network.
    A node can be present in Level2 or in the case head node Level1 and Level2
    A head node is considered to be part of Level1 network
    """
    def __init__(self, layout_filename): #Build network from project1 output file
        self.filename=layout_filename
        self.name_node_dict={}
        self.build_layout()


    def build_layout(self): #by creating node objects and respective router objects

        with open(self.filename) as file:
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

            #Just to print and debug the network
            #for key in self.name_node_dict:
            #    print("Key is->"+key)
            #    print(self.name_node_dict[key].print_neighbour())
            for n_name, n_val in self.name_node_dict.items():
                match=re.findall('L\d+_N\d+_([a-z,A-Z])+_',n_name) #L1_N6_C_011 To match network name C,R,M etc..
                match=str(match[0]).strip()
                if(match=="C"): #Chain Router
                    n_val.create_virtual_channels()
