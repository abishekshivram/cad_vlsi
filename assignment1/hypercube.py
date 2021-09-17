from node import Node
from butterfly import dec_to_bin

class Hypercube:
    def __init__(self,name,dim,create=True):
        self.name=name
        self.dim=dim
        self.nodeCount=2**dim
        self.nodes=[]
		if (create):        
			self.create_nodes()

    def get_node_name(self,nodeID):
        return self.name+str(nodeID)

    def create_nodes(self):
        #init
        for i in range(self.nodeCount):
            self.nodes.append(Node(self.get_node_name(dec_to_bin(i))))
        self.create_network()    

    def insert_nodes(self):
		max_len = len(self.nodes)
		assert (max_len < self.nodeCount),"More than expected nodes for Hypercube network"
		self.nodes.append(node)
                
	def create_network(self):
        for i in range(self.nodeCount):
            for j in range(self.dim):
                neighbour_index = i ^ (1 << (self.dim-1-j))
                self.nodes[i].add_neighbour(self.nodes[neighbour_index])
                

    def print_nodes(self):
        for i in range(self.nodeCount):
          self.nodes[i].print_neighbour()
    
    def get_head_node(self):
        return self.nodes[0] 
