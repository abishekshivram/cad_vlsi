# Level represents the highest level where this Node is present
# (ie) if its head node of L2, it will be present in L1
# Hence, level=1 else level=2 

class Node:
    def __init__(self,name="unnamed_node", level=2):
        self.name=name
        self.neighbour=[]
        self.level = level

    def set_name(self, name):
        self.name=name

    def set_level(self, level):
        self.level=level
    
    def add_neighbour(self, node):
        if (node not in self.neighbour):
            self.neighbour.append(node)
        
    def print_name(self):
        print(self.name)

    def print_neighbour(self):
        print("\nNodeID:", self.name, end="\n")
        print("Links:",len(self.neighbour),end="\n")
        for i in range(len(self.neighbour)):
            print(f"L{i+1}:",self.neighbour[i].name, end="\n")
        return ""
