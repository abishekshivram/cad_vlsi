
class Flit:
    def __init__(self):
        self.route=[] # Stores the name of each node, the flit passed through
    
    def add_node_name(self,name):
        self.route.append(name)

    def print_path(self):
        for i in range(len(self.route)):
            print(self.route[i], end="->")

