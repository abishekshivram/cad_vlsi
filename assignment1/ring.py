from node import Node
from butterfly import dec_to_bin,log

class Ring:
    def __init__(self,name, count,create=True):
        self.name=name
        self.count=count
        self.vertices=[]
        if (create):
            self.create_nodes()

    def get_node_name(self, id):
        return self.name+str(id)

    def create_nodes(self):
        len_bits = log(self.count)
        for i in range(0,self.count):
            self.vertices.append(Node(self.get_node_name(dec_to_bin(i,len_bits))))
        self.create_network()

    def insert_nodes(self):
        max_len = len(self.vertices)
        assert (max_len < self.count),"More than expected nodes for Ring network"
        self.vertices.append(node)
                
    def create_network(self):
        for i in range(1,self.count-1):
            self.vertices[i].add_neighbour(self.vertices[i+1])
            self.vertices[i].add_neighbour(self.vertices[i-1])
        if(len(self.vertices)>1):
            self.vertices[0].add_neighbour(self.vertices[1])
            self.vertices[0].add_neighbour(self.vertices[self.count-1])
            self.vertices[self.count-1].add_neighbour(self.vertices[self.count-2])
            self.vertices[self.count-1].add_neighbour(self.vertices[0])

    def print_nodes(self):
        for i in self.vertices:
            i.print_neighbour()

    def get_head_node(self):
        if(len(self.vertices)>0):
            self.vertices[0].name = 'L1'+self.vertices[0].name[2:]
            return self.vertices[0]
        else:
            print("Ring not created yet")
            n=Node("NIL")
            return n
