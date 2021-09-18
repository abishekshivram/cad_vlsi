from hypercube import Hypercube
from butterfly import *
from ring import Ring
from chain import Chain
from mesh import Mesh
from foldedTorus import FoldedTorus

def network(level,networkType,idx,n,m):
	networkID = level+"_"+networkType+str(idx)+"_"
	
	if (networkType == 'B'):
		assert (n==m),"Dimensions of Butterfly network should be equal"
		network = Butterfly(networkID,n,False if level == 'L1' else True)
	
	elif (networkType == 'C'):
		assert (m==1),"Second dimension of Chain network is invalid"
		network = Chain(networkID,n,False if level == 'L1' else True)

	elif (networkType == 'R'):
		assert (m==1),"Second dimension of Ring network is invalid"
		network = Ring(networkID,n,False if level == 'L1' else True)

	elif (networkType == 'M'):
		assert (m>1 and n>1 and m+n>4),"The given dimension doesn't correspond to a Mesh network"
		network = Mesh(networkID,m,n,False if level == 'L1' else True)

	elif (networkType == 'F'):
		assert (m>1 and n>1 and m+n>4),"The given dimension doesn't correspond to a Folded Torus network"
		network = FoldedTorus(networkID,m,n,False if level == 'L1' else True)

	elif (networkType == 'H'):
		assert (m==n),"Please specify the dimension of the Hypercube network properly"
		network = Hypercube(networkID,n,False if level == 'L1' else True)

	else:
		print("Please choose a valid network")
		network = None
	
	return network

# Reading L1 topology text file
# This file contains how all the central nodes of each network are connected
with open ("L1Topology.txt",'r') as f:
	for line in f:
		L1 = line.strip().replace(" ", "").split(',')
		L1_network = network('L1',L1[0],0,int(L1[1]),int(L1[2]))

# Reading L2 topology text file
# This contains details of each of the network
L2 = []
L2_network = []
idx = 0
with open ("L2Topology.txt", 'r') as f:
	for line in f:
		L2.append(line.strip().replace(" ", "").split(','))
		L2_network.append(network('L2',L2[-1][0],idx,int(L2[-1][1]),int(L2[-1][2])))
		idx += 1 

for i in L2_network:
	L1_network.insert_nodes(i.get_head_node())

L1_network.create_network()

for networks in L2_network:
	networks.print_nodes()



#from butterfly import *

#check_B = Butterfly("B1", 8)
#check_B.print_all()
