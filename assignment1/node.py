class Node:
    def __init__(self,name=""):
        self.name=name
        self.neighbour=[]

    def set_name(self, name):
        self.name=name
    
    def add_neighbour(self, node):
        if (node not in self.neighbour):
            self.neighbour.append(node)

    def print_neighbour(self):
        print(self.name,"---", end="")
        for x in(self.neighbour):
            print("--",x.name,end="")
        print()
