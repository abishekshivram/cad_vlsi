###########################################################################
# CS6230:CAD for VLSI Systems - Project 1
# Name: Two level hierarchical Network on Chip 
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Implementation of the Hypercube network topology
# Last updated on: 18-Sep-2021
############################################################################

from node import Node
from butterfly import dec_to_bin

class Hypercube:
	"""
	A class to represent the Hypercube network topology.
	A node in the network will have equal number of neighbours depending on the dimension, except head node
	If networks are interconnected, head node can have more neighbours
	"""

	def __init__(self,name,dim,create=True):
		"""
		Initialises the Hypercube class

		Parameters:
		-----------
		name : string
    		The name to be assigned to the network topology.
		dim: Integer
			The dimension of the Hypercube to be created.
		Ceate : True/False
    		If true, the nodes of the topology are created
    		If false, the internal state is updated. Nodes are not created
    		Default is True
		"""

		self.name=name
		self.dim=dim
		self.nodeCount=2**dim
		self.nodes=[]
		if (create):        
			self.create_nodes()

	def get_node_name(self,nodeID):
		"""
		Generates a node name based on the topology and the NodeID given
		Appends the given Id to the topology name to generate a new node nam

		Parameters:
		-----------
		NodeID : Integer
    		The NodeID to be added to the node name

		Returns:
		--------
		The name generated for the node
		"""

		return self.name+str(nodeID)
		
	def rename(self,name):
		"""
		A function to change the name of the topology
		"""		

		self.name = name

	def create_nodes(self):
		"""
		A private function to initialise the nodes in the topology
		This function, creates and assigns unique name to each node
		"""		

		for i in range(self.nodeCount):
			self.nodes.append(Node(self.get_node_name(dec_to_bin(i))))
		self.create_network()    

	def insert_nodes(self,node):
		"""
		Insert a new node to the topology.
		This function is used to add a new node to the topology,
		if the number of nodes is less than what is specfied at the time of topology creation
		This function is used to add Layer 2 topology head node in to the Layer 1 network
		
		Parameters:
		-----------
		node : An object of Node class
    		   The new node to be added to the topology
		"""

		max_len = len(self.nodes)
		assert (max_len < self.nodeCount),"More than expected nodes for Hypercube network"
		self.nodes.append(node)
				
	def create_network(self):
		"""
		Connects the nodes in the topology to form the Hypercube network
		"""

		for i in range(self.nodeCount):
			for j in range(self.dim):
				neighbour_index = i ^ (1 << (self.dim-1-j))
				self.nodes[i].add_neighbour(self.nodes[neighbour_index])
				

	def print_nodes(self):
		"""
		Prints all the nodes in the network.
		Calls the print_neighbour() function in node class
		Prints nodes as per the output file format specification in the problem statement
		"""

		for i in range(self.nodeCount):
		  self.nodes[i].print_neighbour()
	
	def get_head_node(self):
		"""
		Returns the head node of the topology.
		In the case of Hypercube, it is the first node
		
		Returns:
		--------
		The head node of the topology. 
		"""

		self.nodes[0].name = 'L1'+ self.nodes[0].name[2:]
		return self.nodes[0] 
