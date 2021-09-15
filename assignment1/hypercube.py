from node import Node
from butterfly import dec_to_bin

class Hypercube:
    def __init__(self,name,dim):
        self.name=name
        self.dim=dim
        self.nodeCount=2**dim
        self.nodes=[]
        self.create()

    def get_node_name(self,nodeID):
        return self.name+str(dec_to_bin(nodeID))

    def create(self):
        #init
        for i in range(self.nodeCount):
            self.nodes.append(Node(self.get_node_name(i)))
            
        #logn = log(self.nodeCount)
        for i in range(self.nodeCount):
            for j in range(self.dim):
                neighbour_index = i ^ (1 << (self.dim-1-j))
                self.nodes[i].add_neighbour(self.nodes[neighbour_index])
                

    def print(self):
        for i in range(self.nodeCount):
          self.nodes[i].print_neighbour()
    
    def get_head_node(self):
        return self.nodes[0] 
