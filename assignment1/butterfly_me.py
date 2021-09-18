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
        #print("Printing SWITCH Neighbours:")
        print("Name of switch: ", self.name)
        print("     Printing Left Neighbours of the switch:")
        for i in(self.left_neighbours):
            print("     ", i.name,end="\n")
        print("     Printing Right Neighbours of the switch:")
        for i in(self.right_neighbours):
            print("     ", i.name,end="\n")
        return ""


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
# Number of switches = (num/2)*log(num)
# Number of bits needed to represent switches = ceil(log(num*log(num)/2))
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

    def print_all(self):
        print(f"\nPrinting from Class Butterfly named: {self.name}")
        print("\nPrinting Left nodes")
        for i in self.left_nodes:
            print(i.print_neighbour())
        print("\nPrinting Right nodes")
        for i in self.right_nodes:
            print(i.print_neighbour())
        print("\nPrinting Switches nodes")
        for i in self.switches:
            print(i.print_neighbours())
        print("\n")

    def create_nodes(self):
        #no. nodes = num*num
        id_len = log(self.num)
        for i in range(self.num):
            self.left_nodes.append(Node("L"+dec_to_bin(i,id_len)))
            self.right_nodes.append(Node("R"+dec_to_bin(i,id_len)))
    
    def create_switches(self):
        layers = int(log(self.num))
        rows_switch = int(self.num/2)
        # no_switch = layers*rows_switch
        # BL1 = butterfly switch layer 1 (from left)
        for i in range(layers):
            for j in range(rows_switch):
                self.switches.append(Switch(f"BL{i}_"+dec_to_bin(j,layers-1)))

    def connect_switches_nodes(self):
        id_size = log(self.num)
        for i in range(len(self.switches)):
            col_offset = int(self.num/2)
            row_offset = int(pow(2,id_size - int(i/col_offset) - 2))
            if(row_offset):
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
            
            elif (i >= (id_size-1)*self.num/2): #Last layer
                #self.switches[i].add_left_neighbour(self.switches[i-col_offset])
                #self.switches[i].add_left_neighbour(self.switches[i-col_offset+flag*row_offset])
                j = int(i - (id_size-1)*self.num/2)
                self.switches[i].add_right_neighbour(self.right_nodes[2*j])
                self.right_nodes[2*j].add_neighbour(self.switches[i])
                self.switches[i].add_right_neighbour(self.right_nodes[2*j+1])
                self.right_nodes[2*j+1].add_neighbour(self.switches[i])

            else: # Middle layers
                self.switches[i].add_right_neighbour(self.switches[i+col_offset])
                self.switches[i+col_offset].add_left_neighbour(self.switches[i])

                self.switches[i].add_right_neighbour(self.switches[i+col_offset+flag*row_offset])
                self.switches[i+col_offset+flag*row_offset].add_left_neighbour(self.switches[i])
        
    def head_node(self):
        return self.left_nodes[self.num/2]
