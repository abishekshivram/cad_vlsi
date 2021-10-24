###########################################################################
# CS6230:CAD for VLSI Systems - Project 1
# Name: Two level hierarchical Network on Chip 
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Program entry point is defined in this file
# Last updated on: 18-Sep-2021
############################################################################

from hypercube import Hypercube
from butterfly import *
from ring import Ring
from chain import Chain
from mesh import Mesh
from foldedTorus import FoldedTorus


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

def network(level,networkType,idx,n,m):
	"""
	Reads the input file, performs necessary checks (based on expected dimensions of the network) and builds the network
	
	Parameters:
	-----------
		level : Integer
			    The level to which the network is to be created (L1 or L2)
		networkType: Character
				The type of the network
				C = Chain
				R = Ring
				M = Mesh
				F = Folded Torus
				H = Hypercube
				B = Butterfly
		idx: Integer
			Index of the network
		n: Integer
			Dimension of the network - n as per the input file
		m: Integer
			Dimension of the network - m as per the input file
	"""

	# networkID gives us the format of the name for each network
	networkID = level+"_"+"N"+str(idx)+"_"+networkType+"_"
	
	# Calculating expected number of head nodes in the network by determining the number of nodes in the L1 network
	# Used to determine if there are enough networks defined in L2
	total_head_nodes = 0
	
	# Assert statements to catch exceptions; and networks in L2 made based on the network specification in the input file
	# For the network in L1, we only allow initiation of the network, and don't create new nodes since nodes of L2 make the network.
	if (networkType == 'B'):
		assert (n==m),"Dimensions of Butterfly network should be equal"
		assert (isPowerOfTwo(n)), "n should be a power of two in Butterfly network"
		network = Butterfly(networkID,n,False if level == 'L1' else True)
		if level == 'L1':
			total_head_nodes = 2*m
	
	elif (networkType == 'C'):
		assert (m==1),"Second dimension of Chain network is invalid"
		network = Chain(networkID,n,False if level == 'L1' else True)
		if level == 'L1':
			total_head_nodes = n

	elif (networkType == 'R'):
		assert (m==1),"Second dimension of Ring network is invalid"
		network = Ring(networkID,n,False if level == 'L1' else True)
		if level == 'L1':
			total_head_nodes = n

	elif (networkType == 'M'):
		assert (m>1 and n>1 and m+n>4),"The given dimension doesn't correspond to a Mesh network"
		network = Mesh(networkID,m,n,False if level == 'L1' else True)
		if level == 'L1':
			total_head_nodes = m*n

	elif (networkType == 'F'):
		assert (m>1 and n>1 and m+n>4),"The given dimension doesn't correspond to a Folded Torus network"
		network = FoldedTorus(networkID,m,n,False if level == 'L1' else True)
		if level == 'L1':
			total_head_nodes = m*n

	elif (networkType == 'H'):
		assert (m==n and m==3),"Please specify the dimension of the Hypercube network properly, can only be specified as 'H,3,3'"
		network = Hypercube(networkID,n,False if level == 'L1' else True)
		if level == 'L1':
			total_head_nodes = 2**n

	else:
		print(f"Please choose a valid network, {networkType} is not a valid network type")
		exit()
	
	return network, total_head_nodes



def main(print=True):
	# Reading L1 topology text file: 
	# L1: Stores the attributes in L1Topology.txt
	# L1_network: Stores the class associated with L1 network 
	# Currently, we don't create nodes and connections for L1, and merely assign the dimensions for the L1 specification.
	# L1 network nodes are made up of the head-nodes in L2 
	# This file contains how all the head nodes of each network in L2 are interconnected
	with open ("../assignment1/L1Topology.txt",'r') as f:
		for line in f:
			if (line=='\n'):
				continue
			L1 = line.strip().replace(" ", "").split(',')
			assert(len(L1) == 3), "Please check your input"
			L1_network, total_head_nodes = network('L1',L1[0],0,int(L1[1]),int(L1[2]))


	# Reading L2 topology text file
	# L2: Stores the attributes in L2Topology.txt
	# L2_network: Stores the classes associated with L2 networks
	# idx: Index of the network (1st network in L2: Index 0)
	# This contains details of each of the network
	L2 = []
	L2_network = []
	idx = 0
	with open ("../assignment1/L2Topology.txt", 'r') as f:
		for line in f:
			if (line=='\n'):
				continue
			L2_input_network = line.strip().replace(" ", "").split(',')
			assert (len(L2_input_network) == 3), "In L2Topology.txt, line is of invalid format, please check the inputs"
			L2.append(L2_input_network)
			L2_network.append(network('L2',L2[-1][0],idx,int(L2[-1][1]),int(L2[-1][2]))[0])
			idx += 1

	# If there is an inconsistency in the number of nodes in L1 and the number of head-nodes in L2
	assert (len(L2_network) == total_head_nodes), "Please check your inputs, inconsistency in terms of number of nodes in L1 and networks in L2"

	# Based on head-nodes from L2, inserting nodes into the L1 network
	for i in L2_network:
		L1_network.insert_nodes(i.get_head_node())

	# Making the L1 network: Connection between the nodes
	L1_network.create_network()

	if(not print):
		return L1_network, L2_network

	# Printing the nodes in the network
	# 
	for networks in L2_network:
		networks.print_nodes()

	# If L1 network is a Butterfly network, then printing its switches here
	if (L1[0] == 'B'):
		L1_network.print_nodes(True)

print("Nodes of the Two level hierarchical Network on Chip")
main(True)