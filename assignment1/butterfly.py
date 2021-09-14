from node import Node

class Switch:
    def __init__(self, name=""):
        self.name = name
        # Each switch has two left edges and two right edges
        # They connect to either node or another switch
        self.left_neighbours = []
        self.right_neighbours = []
    
    def rename(self, name):
        self.name = name

    def add_left_neighbour(self, node):
        if (node not in self.left_neighbours):
            self.left_neighbours.append(node)
    
    def add_right_neighbour(self, node):
        if (node not in self.right_neighbours):
            self.right_neighbours.append(node)

    def print_neighbours(self):
        print(self.name,"---", end="")
        for x in(self.neighbour):
            print("--",x.name,end="")
        print()


def log(n):
    count = 0
    while(not n==1):
        count += 1
        n= n>>1
    return count


def dec_to_bin(val, digits=3):
    return f"{val:0{digits}b}"

def if_even(num):
    return True if num%2==0 else False

# Butterfly has num*2 nodes
# Number of switches = (n/2)*log(n)
# Number of bits needed to represent switches = ceil(log(n*log(n)/2))
# num = 4,8 or 16 - represents size of network

class Butterfly:
    def __init__(self, name, num):
        self.name = name
        self.num = num
        self.left_nodes = []
        self.right_nodes = []
        self.switches = []
        self.create_nodes()
        self.create_switches()
        self.connect_switches_nodes()
    
    def create_nodes(self):
        #no. nodes = num*num
        for i in range(self.num):
            self.left_nodes.append(Node("L"+dec_to_bin(i)))
            self.right_nodes.append(Node("R"+dec_to_bin(i)))
    
    def create_switches(self):
        layers = log(self.num)
        rows_switch = self.num/2
        # no_switch = layers*rows_switch
        # BL1 = butterfly switch layer 1 (from left)
        for i in range(layers):
            for j in range(rows_switch):
                self.switches.append(Switch(f"BL{i}_"+dec_to_bin(j)))

    def connect_switches_nodes(self):
        for i in range(len(self.switches)):
            col_offset = self.num/2
            row_offset = pow(2,log(self.num) - int(i/col_offset) - 2)
            flag = 1 if if_even(int(i/row_offset)) else -1
            
            if (i < self.num/2): # First layer
                self.switches[i].add_left_neighbour(self.left_nodes[2*i])
                self.left_nodes[2*i].add_neighbour(self.switches[i])

                self.switches[i].add_left_neighbour(self.left_nodes[2*i+1])
                self.left_nodes[2*i+1].add_neighbour(self.switches[i])

                self.switches[i].add_right_neighbour(self.switches[i+col_offset])
                self.switches[i+col_offset].add_left_neighbour(self.switches[i])
                
                self.switches[i].add_right_neighbour(self.switches[i+col_offset+flag*row_offset])
                self.switches[i+col_offset+flag*row_offset].add_left_neighbour(self.switches[i])
            
            elif (i >= (log(self.num)-1)*self.num/2): #Last layer
                #self.switches[i].add_left_neighbour(self.switches[i-col_offset])
                #self.switches[i].add_left_neighbour(self.switches[i-col_offset+flag*row_offset])
                self.switches[i].add_right_neighbour(self.right_nodes[2*i])
                self.right_nodes[2*i].add_neighbour(self.switches[i])
                self.switches[i].add_right_neighbour(self.right_nodes[2*i+1])
                self.right_nodes[2*i+1].add_neighbour(self.switches[i])

            else: # Middle layers
                self.switches[i].add_right_neighbour(self.switches[i+col_offset])
                self.switches[i+col_offset].add_left_neighbour(self.switches[i])

                self.switches[i].add_right_neighbour(self.switches[i+col_offset+flag*row_offset])
                self.switches[i+col_offset+flag*row_offset].add_left_neighbour(self.switches[i])
        
    def head_node(self):
        return self.left_nodes[self.num/2]
