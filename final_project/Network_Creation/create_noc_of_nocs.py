# import sys
# import os 
# cur_path = os.getcwd()
# to_add1 = cur_path + "/Chain"
# sys.path.append(to_add1)

from FoldedTorus.create_L1_FoldedTorus import create_L1_FT
from FoldedTorus.create_L2_FoldedTorus import create_L2_FT

from Mesh.create_L1_Mesh import create_L1_Mesh
from Mesh.create_L2_Mesh import create_L2_Mesh

from Ring.create_L1_Ring import create_L1_Ring
from Ring.create_L2_Rings import create_L2_Rings

from Chain.ChainL1.create_L1_Chain import create_L1_Chain
from Chain.Script.create_L2_Chains import create_L2_Chains


L2_NETWORK_NOC_FILES = []
L2_NETWORK_BSV_MODULES = []
def choose_noc_file(L2_net_type, L2_net_idx):
    if (L2_net_type == 'R'):
        L2_NETWORK_NOC_FILES.append(f"RingNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkRingL2Noc{L2_net_idx}")
    elif (L2_net_type == 'C'):
        L2_NETWORK_NOC_FILES.append(f"ChainNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkChainL2Noc{L2_net_idx}")
    elif (L2_net_type == 'F'):
        L2_NETWORK_NOC_FILES.append(f"FoldedTorusNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkFoldedTorusL2Noc{L2_net_idx}")
    elif (L2_net_type == 'M'):
        L2_NETWORK_NOC_FILES.append(f"MeshNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkMeshL2Noc{L2_net_idx}")

        

# Reading L1 topology text file: 
# L1: Stores the attributes in L1Topology.txt
# L1 network nodes are made up of the head-nodes in L2 
# This file contains how all the head nodes of each network in L2 are interconnected
with open ("L1Topology.txt",'r') as f:
    for line in f:
        if (line=='\n'):
            continue
        L1 = line.strip().replace(" ", "").split(',')
        assert(len(L1) == 3), "Please check your input"
        L1_DIM = (int(L1[2]),int(L1[1]))


# Reading L2 topology text file
# L2: Stores the attributes in L2Topology.txt
# idx: Index of the network (1st network in L2: Index 0)
# This contains details of each of the network
L2 = []
L2_dictionary = {}
NETWORK_TYPES = ['C','R','H','F','M','B']
for i in NETWORK_TYPES:
    # Info needed for L2 networks: NO_OF_NETWORKS, ALL_NETWORK_NUM, ALL_NETWORK_ID, ALL_NETWORK_DIM):
    # NO_OF_NETWORKS: Number of the particular Network in L2
    # ALL_NETWORK_NUM: The Network number associated with the particular Network in L2
    # ALL_NETWORK_ID: The hexadecimal network ID for each network of a particular type in L2
    # ALL_NETWORK_DIM: The dimension of each network of particular type in L2
    L2_dictionary[i] = [0,[],[],[]] 


idx = 0
with open ("L2Topology.txt", 'r') as f:
    for line in f:
        if (line=='\n'):
            continue
        L2_input_network = line.strip().replace(" ", "").split(',')
        assert (len(L2_input_network) == 3), "In L2Topology.txt, line is of invalid format, please check the inputs"
        L2_dictionary[L2_input_network[0]][0] += 1          # NO_OF_NETWORKS
        L2_dictionary[L2_input_network[0]][1].append(idx)   # ALL_NETWORK_NUM
        if (L1[0] in ['F','M']):
            L1_row = L1_DIM[0]
            L1_col = L1_DIM[1]
            L1_row_idx = idx // L1_col
            L1_col_idx = idx - (L1_row_idx*L1_col)
            L2_dictionary[L2_input_network[0]][2].append(f"16'h{L1_row_idx:0>2x}{L1_col_idx:0>2x}")
        else:
            L2_dictionary[L2_input_network[0]][2].append(f"16'h{idx:0>4x}")
        L2_dictionary[L2_input_network[0]][3].append((int(L2_input_network[2]), int(L2_input_network[1])))

        choose_noc_file(L2_input_network[0],idx)
        idx += 1

for i in NETWORK_TYPES:
    if L2_dictionary[i][0] != 0:
        if (i == 'C'):
            create_L2_Chains(L2_dictionary[i][0], L2_dictionary[i][1], L2_dictionary[i][2], L2_dictionary[i][3])        
        elif (i == 'R'):
            create_L2_Rings(L2_dictionary[i][0], L2_dictionary[i][1], L2_dictionary[i][2], L2_dictionary[i][3])        
        elif (i == 'F'):
            create_L2_FT(L2_dictionary[i][0], L2_dictionary[i][1], L2_dictionary[i][2], L2_dictionary[i][3])
        elif (i == 'M'):
            create_L2_Mesh(L2_dictionary[i][0], L2_dictionary[i][1], L2_dictionary[i][2], L2_dictionary[i][3])
              

# Calling L1 Network NOC Generation
# L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES
if L1[0] == 'C':
    create_L1_Chain(L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
elif L1[0] == 'R':
    create_L1_Ring(L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
elif L1[0] == 'F':
    create_L1_FT(L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
elif L1[0] == 'M':
    create_L1_Mesh(L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
  

