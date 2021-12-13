# import sys
# import os 
# cur_path = os.getcwd()
# to_add1 = cur_path + "/Chain"
# sys.path.append(to_add1)

from Templates.FoldedTorus.create_L1_FoldedTorus import create_L1_FT
from Templates.FoldedTorus.create_L2_FoldedTorus import create_L2_FT

from Templates.Mesh.create_L1_Mesh import create_L1_Mesh
from Templates.Mesh.create_L2_Mesh import create_L2_Mesh

from Templates.Ring.create_L1_Ring import create_L1_Ring
from Templates.Ring.create_L2_Rings import create_L2_Rings

from Templates.Chain.create_L1_Chain import create_L1_Chain
from Templates.Chain.create_L2_Chains import create_L2_Chains

from Templates.Hypercube.Template_L1_Hypercube_gen import create_L1_Hypercube
from Templates.Butterfly.create_l1_noc_butterfly import create_L1_Butterfly


def isPowerOfTwo(x):
	"""
	Checks if the given number is power of 2 or not

	Parameters:
	-----------
	x : Integer
	The number to be checked for 

	Returns:
	--------
	True if the number is power of two
	"""
    # First x in the below expression
    # is for the case when x is 0
	return (x and (not(x & (x - 1))))

# A set of assertion statements to make sure that L1 and L2 Topolgy has been defined rightly
def check_input(level,networkType,n,m):
	if (networkType == 'B'):
		assert (n==m),f"Dimensions of Butterfly network should be equal in {level}Topology.txt"
		assert (isPowerOfTwo(n)), "n should be a power of two in Butterfly network"
		if level == 'L1':
			total_head_nodes = 2*m
	
	elif (networkType == 'C'):
		assert (m==1),f"Second dimension of Chain network is invalid in {level}Topology.txt"
		if level == 'L1':
			total_head_nodes = n

	elif (networkType == 'R'):
		assert (m==1),f"Second dimension of Ring network is invalid in {level}Topology.txt"
		if level == 'L1':
			total_head_nodes = n

	elif (networkType == 'M'):
		assert (m>1 and n>1 and m+n>4),f"The given dimension doesn't correspond to a Mesh network in {level}Topology.txt"
		if level == 'L1':
			total_head_nodes = m*n

	elif (networkType == 'F'):
		assert (m>1 and n>1 and m+n>4),f"The given dimension doesn't correspond to a Folded Torus network in {level}Topology.txt"
		if level == 'L1':
			total_head_nodes = m*n

	elif (networkType == 'H'):
		assert (m==n and m==3),f"Please specify the dimension of the Hypercube network properly in {level}Topology.txt, can only be specified as 'H,3,3'"
		if level == 'L1':
			total_head_nodes = 2**n

	else:
		print(f"Please choose a valid network in {level}Topology.txt, {networkType} is not a valid network type")

	return total_head_nodes if level == 'L1' else None



# Function to define the module and NOC files that need to be instantiated and imported 
#   respectively for each L2 network in the L1 Noc file
L2_NETWORK_NOC_FILES = []
L2_NETWORK_BSV_MODULES = []
def choose_noc_file(L2_net_type, L2_net_idx,dim1):
    if (L2_net_type == 'R'):
        L2_NETWORK_NOC_FILES.append(f"RingNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkRingL2Noc{L2_net_idx}()")
    elif (L2_net_type == 'C'):
        L2_NETWORK_NOC_FILES.append(f"ChainNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkChainL2Noc{L2_net_idx}()")
    elif (L2_net_type == 'F'):
        L2_NETWORK_NOC_FILES.append(f"FoldedTorusNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkFoldedTorusL2Noc{L2_net_idx}()")
    elif (L2_net_type == 'M'):
        L2_NETWORK_NOC_FILES.append(f"MeshNocL2_{L2_net_idx}")
        L2_NETWORK_BSV_MODULES.append(f"mkMeshL2Noc{L2_net_idx}()")
    elif (L2_net_type == 'H'):
        L2_NETWORK_NOC_FILES.append(f"HypercubeL2Noc")
        L2_NETWORK_BSV_MODULES.append(f"mkHypercubeL2Noc({L2_net_idx})")
    elif (L2_net_type == 'B'):
        L2_NETWORK_NOC_FILES.append(f"Noc_butterfly{dim1}x{dim1}L2")
        L2_NETWORK_BSV_MODULES.append(f"mkButterfly{dim1}x{dim1}L2Noc({L2_net_idx})") 
      

# Reading L1 topology text file: 
# L1: Stores the attributes in L1Topology.txt
# L1 network nodes are made up of the head-nodes in L2 
# This file contains how all the head nodes of each network in L2 are interconnected
with open ("L1Topology.txt",'r') as f:
    for line in f:
        if (line=='\n'):
            continue
        L1 = line.strip().replace(" ", "").split(',')
        assert(len(L1) == 3), "Please check your input in L1Toplogy.txt"
        total_head_nodes = check_input('L1',L1[0],int(L1[1]),int(L1[2]))        
        L1_DIM = (int(L1[2]),int(L1[1]))


# Reading L2 topology text file
# L2: Stores the attributes in L2Topology.txt
# idx: Index of the network (1st network in L2: Index 0)
# This contains details of each of the network
L2_dictionary = {}
NETWORK_TYPES = ['C','R','H','F','M','B']
for i in NETWORK_TYPES:
    # Info needed for L2 networks: NO_OF_NETWORKS, ALL_NETWORK_NUM, ALL_NETWORK_ID, ALL_NETWORK_DIM):
    # NO_OF_NETWORKS: Number of the particular Network in L2
    # ALL_NETWORK_NUM: The Network number associated with the particular Network in L2
    # ALL_NETWORK_ID: The hexadecimal network ID for each network of a particular type in L2
    # ALL_NETWORK_DIM: The dimension of each network of particular type in L2
    L2_dictionary[i] = [0,[],[],[]] 


# Reading the L2Topology file for making NoC files as necessary
idx = 0
with open ("L2Topology.txt", 'r') as f:
    for line in f:
        if (line=='\n'):
            continue
        L2_input_network = line.strip().replace(" ", "").split(',')
        assert (len(L2_input_network) == 3), "In L2Topology.txt, line is of invalid format, please check the inputs"
        
        # Checking if the input matches the expected behaviour
        check_input('L2',L2_input_network[0],int(L2_input_network[1]),int(L2_input_network[2]))
        L2_dictionary[L2_input_network[0]][0] += 1          # NO_OF_NETWORKS
        L2_dictionary[L2_input_network[0]][1].append(idx)   # ALL_NETWORK_NUM
        
        # ALL_NETWORK_ID
        if (L1[0] in ['F','M']):
            L1_row = L1_DIM[0]
            L1_col = L1_DIM[1]
            L1_row_idx = idx // L1_col
            L1_col_idx = idx - (L1_row_idx*L1_col)
            L2_dictionary[L2_input_network[0]][2].append(f"16'h{L1_row_idx:0>2x}{L1_col_idx:0>2x}")
        else:
            L2_dictionary[L2_input_network[0]][2].append(f"16'h{idx:0>4x}")
        
        # ALL_NETWORK_DIM
        L2_dictionary[L2_input_network[0]][3].append((int(L2_input_network[2]), int(L2_input_network[1])))

        # Modules that need to be instantiated in the L1 NoC
        choose_noc_file(L2_input_network[0],idx,L2_input_network[1])
        idx += 1


# If there is an inconsistency in the number of nodes in L1 and the number of head-nodes in L2
assert (idx == total_head_nodes), "Please check your inputs, inconsistency in terms of number of nodes in L1 and networks in L2"

# Calling L2 NoC making functons
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
    TOP_MODULE = "mkChainL1Noc"
    TOP_MODULE_FILE = "ChainNocL1"
elif L1[0] == 'R':
    create_L1_Ring(L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
    TOP_MODULE_FILE = "RingNocL1"
    TOP_MODULE = "mkRingL1Noc"
elif L1[0] == 'F':
    create_L1_FT(L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
    TOP_MODULE_FILE = "FoldedTorusNocL1"
    TOP_MODULE = "mkFoldedTorusL1Noc"    
elif L1[0] == 'M':
    create_L1_Mesh(L1_DIM,L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
    TOP_MODULE_FILE = "MeshNocL1"
    TOP_MODULE = "mkMeshL1Noc" 
elif L1[0] == 'H':
    create_L1_Hypercube(L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
    TOP_MODULE_FILE = "HypercubeNocL1"
    TOP_MODULE = "mkHypercubeL1Noc" 
elif L1[0] == 'B':
    create_L1_Butterfly(L1_DIM[0],L2_NETWORK_NOC_FILES,L2_NETWORK_BSV_MODULES)
    TOP_MODULE_FILE = f"Noc_butterfly{L1_DIM[0]}x{L1_DIM[0]}L1"
    TOP_MODULE = f"mkButterfly{L1_DIM[0]}x{L1_DIM[0]}L1Noc" 
  

# MAKING MAKEFILE.INC
makefile_contents = f"""\n
TOP_MODULE:={TOP_MODULE}
TOP_FILE:=./src_nocs/{TOP_MODULE_FILE}.bsv
TOP_DIR:=.
MODULE:=testRunner
BLUESPEC_TOOL:=/home/gay3/bsc\n\n
"""
with open('Makefile.inc', 'w') as f:
    f.write(makefile_contents)

