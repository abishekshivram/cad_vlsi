from node import Node
from butterfly import dec_to_bin,log

class Chain:
    def __init__(self,name,count,create=True):
        self.name=name
        self.count=count
        self.vertices=[]
        if (create):
            self.create_nodes()

    #A private function
    def create_nodes(self):
        len_bits = log(self.count)
        for i in range(0,self.count):
            self.vertices.append(Node(self.get_node_name(dec_to_bin(i,len_bits))))
        self.create_network()
            
    def insert_nodes(self, node):
        max_len = len(self.vertices)
        assert (max_len < self.count),"More than expected nodes for Chain network"
        self.vertices.append(node)
            
    def create_network(self):
        # Make network connections and connect nodes
        for i in range(1,self.count-1):
            self.vertices[i].add_neighbour(self.vertices[i+1])
            self.vertices[i].add_neighbour(self.vertices[i-1])
        if(self.count>1):    
            self.vertices[0].add_neighbour(self.vertices[1])
            self.vertices[self.count-1].add_neighbour(self.vertices[self.count-2])

    def get_node_name(self,id):
        return self.name+str(id)

    def print_nodes(self):
        for i in self.vertices:
            i.print_neighbour()

    def get_head_node(self):
        headpos=self.count//2
        if(len(self.vertices)>0 and len(self.vertices)>=headpos):
            self.vertices[headpos].name = 'L1'+self.vertices[headpos].name[2:]
            return self.vertices[headpos]
        else:
            print("Chain not created yet")
            n=Node("NIL")
            return n
