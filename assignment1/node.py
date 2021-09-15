class Node:
    def __init__(self,name="unnamed_node"):
        self.name=name
        self.neighbour=[]

    def set_name(self, name):
        self.name=name
    
    def add_neighbour(self, node):
        if (node not in self.neighbour):
            self.neighbour.append(node)
        
    def print_name(self):
        print(self.name)

    def print_neighbour(self):
        print("Name of node:", self.name, end="\n")
        print("     Neighbours: ", end='')
        for i in(self.neighbour):
            print(i.name, end=", ")
        return ""
