from node import Node
class Chain:
    def __init__(self,name,count):
        self.name=name
        self.count=count
        self.vertices=[]
        self.create()

    #A private function
    def create(self):
        for i in range(0,self.count):
            self.vertices.append(Node(self.get_node_name(i)))
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
            return self.vertices[headpos]
        else:
            print("Chain not created yet")
            n=Node("NIL")
            return n
