from hypercube import Hypercube
from butterfly import Butterfly
from ring import Ring
from chain import Chain
from mesh import Mesh
from foldedTorus import FoldedTorus


def network(level,networkType,n,m):
	if (networkType == 'B'):
		assert (n==m),"Dimensions of Butterfly network should be equal"
		network = Butterfly(level+networkType,n)
		network.print()
		return network
	elif (networkType == 'C'):
		assert (m==1),"Second dimension of Chain network is invalid"
		network = Chain(level+networkType,n)
		network.print()
		return network
	elif (networkType == 'R'):
		assert (m==1),"Second dimension of Ring network is invalid"
		network = Ring(level+networkType,n)
		network.print()
		return network
	elif (networkType == 'M'):
		assert (m>1 and n>1 and m+n>4),"The given dimension doesn't correspond to a Mesh network"
		network = Mesh(level+networkType,m,n)
		network.print()
		return network	
	elif (networkType == 'F'):
		assert (m>1 and n>1),"The given dimension doesn't correspond to a Folded Torus network"
		network = FoldedTorus(level+networkType,m,n)
		network.print()
		return network	
	elif (networkType == 'H'):
		assert (m==n),"Please specify the dimension of the Hypercube network properly"
		network = Hypercube(level+networkType,n)
		network.print()
		return network
	else:
		print("Please choose a valid network")

# Reading L1 topology text file
# This file contains how all the central nodes of each network are connected
with open ("L1Topology.txt",'r') as f:
	for line in f:
		L1 = line.strip().replace(" ", "").split(',')
		L1_network = network('L1',L1[0],int(L1[1]),int(L1[2]))

# Reading L2 topology text file
# This contains details of each of the network
L2 = []
L2_network = []
with open ("L2Topology.txt", 'r') as f:
	for line in f:
		L2.append(line.strip().replace(" ", "").split(','))
		L2_network.append(network('L2',L2[-1][0],int(L2[-1][1]),int(L2[-1][2])))	
