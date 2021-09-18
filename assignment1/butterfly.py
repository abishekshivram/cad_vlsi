###########################################################################
# CS6230:CAD for VLSI Systems - Project 1
# Name: Two level hierarchical Network on Chip 
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Implementation of the Butterfly network topology
# Last updated on: 18-Sep-2021
############################################################################

from node import Node

class Switch:
    """
    A class to represent the Switch in Butterfly based network topology.
    """

    def __init__(self, name=""):
        """
        Initialises the Switch class.

        Parameters:
        -----------
        name : string
            The name to be assigned to the switch.
        """

        self.name = name
        # Each switch has two left edges and two right edges
        # They connect to either node or another switch
        self.left_neighbours = []
        self.right_neighbours = []
    
    def rename(self, name):
        """
        A function to change the name of the switch
		
        Parameters:
		-----------
		name : String
    		The new name to be assigned
        """

        self.name = name

    def add_left_neighbour(self, node):
        """
        Adds left side neighbours to the switch
		
        Parameters:
		-----------
		node : Object of type node
    		   The nodes to be added as the left neighbours of the switch
        """

        if (node not in self.left_neighbours):
            self.left_neighbours.append(node)
    
    def add_right_neighbour(self, node):
        """
        Adds right side neighbours to the switch
		
        Parameters:
		-----------
		node : Object of type node
    		   The nodes to be added as the right neighbours of the switch
        """

        if (node not in self.right_neighbours):
            self.right_neighbours.append(node)

    def print_neighbours(self):
        """
        Prints neighbours of the switch
        Left neighbours are printed first, then right neighbours
		"""

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
    """
    Computes log2 of the given number

    Parameters:
    -----------
        n : Integer
              The number to which the log to be computed
    Returns:
    --------
    The log2 of the given number
    """

    count = 0
    while(n>1):
        count += 1
        n= float(n/2)
    return count


def dec_to_bin(val, digits=3):
    """
    Converts the given decimal number to binary with the given width

    Parameters:
    -----------
        val : Integer
              The number to be converted to binary
        digits : Integer, default is 3
              The minimum width of the binary number

    Returns:
    --------
    The binary number
    """    

    return f"{val:0{digits}b}"

def if_even(num):
    """
    Checks if the given number is even or not

    Parameters:
    -----------
        num : Integer
              The number to be checked for even or not

    Returns:
    --------
    True of the number is even. False otherwise
    """    

    return True if num%2==0 else False

# Butterfly has num*2 nodes
# Number of switches = (n/2)*log(n)
# Number of bits needed to represent switches = ceil(log(n*log(n)/2))
# num = 4,8 or 16 - represents size of network

class Butterfly:
    """
    A class to represent the Butterfly based network topology.
    A node in the network are interconnected using intermediate Switch nodes
    Head node is used to interconnect the nodes
    """

    def __init__(self, name, num, create=True):
        """
        Initialises the Butterfly class.

        Parameters:
        -----------
        name : string
            The name to be assigned to the network topology.
        num : Integer
            The size of the network to be created
        Ceate : True/False
            If true, the nodes of the topology are created
            If false, the internal state is updated. Nodes are not created
            Default is True
        """

        self.name = name
        self.num = num
        self.left_nodes = []
        self.right_nodes = []
        self.switches = []
        if (create):
            self.create_nodes()
            self.create_network()

    def create_network(self):
        """
        Creates the network by connecting switches and nodes
        The switches are newly created here
        """        
        self.create_switches()
        self.connect_switches_nodes()
        
    def print_nodes(self):
        """
        Prints all the nodes in the network.
        Calls the print_neighbour() function in node class
        Prints nodes as per the output file format specification in the problem statement
        This function treats intermediate switches also as nodes
        """

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

    def insert_nodes(self, node):
        """
        Insert a new node to the topology.
        This function is used to add a new node to the topology,
        if the number of nodes is less than what is specfied at the time of topology creation
        This function is used to add Layer 2 topology head node in to the Layer 1 network

        Parameters:
        -----------
        node : An object of Node class
               The new node to be added to the topology
        """

        if(len(self.left_nodes) <= self.num):
            self.left_nodes.append(node)
        else:
            self.right_nodes.append(node)
        

    def create_nodes(self):
        """
        A private function to initialise the nodes in the topology
        This function, creates and assigns unique name to each node
        """

        #no. nodes = num*num
        for i in range(self.num):
            self.left_nodes.append(Node("L_"+dec_to_bin(i)))
            self.right_nodes.append(Node("R_"+dec_to_bin(i)))
    
    def create_switches(self):
        """
        A private function to create the required number of switches to interconnect the nodes
        This function, creates and assigns unique name to each switch
        """

        layers = int(log(self.num))
        rows_switch = int(self.num/2)
        # no_switch = layers*rows_switch
        # BL1 = butterfly switch layer 1 (from left)
        for i in range(layers):
            for j in range(rows_switch):
                self.switches.append(Switch(f"BL{i}_"+dec_to_bin(j)))

    def connect_switches_nodes(self):
        """
        A private function to establish connection netween switches and nodes
        The connection is established with switchs and nodes in left,
        switchs and nodes on the right, switches in the middle
        """

        for i in range(len(self.switches)):
            col_offset = int(self.num/2)
            row_offset = int(pow(2,log(self.num) - int(i/col_offset) - 2))
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
            
            elif (i >= (log(self.num)-1)*self.num/2): #Last layer
                #self.switches[i].add_left_neighbour(self.switches[i-col_offset])
                #self.switches[i].add_left_neighbour(self.switches[i-col_offset+flag*row_offset])
                j = int(i - (log(self.num)-1)*self.num/2)
                self.switches[i].add_right_neighbour(self.right_nodes[2*j])
                self.right_nodes[2*j].add_neighbour(self.switches[i])
                self.switches[i].add_right_neighbour(self.right_nodes[2*j+1])
                self.right_nodes[2*j+1].add_neighbour(self.switches[i])

            else: # Middle layers
                self.switches[i].add_right_neighbour(self.switches[i+col_offset])
                self.switches[i+col_offset].add_left_neighbour(self.switches[i])

                self.switches[i].add_right_neighbour(self.switches[i+col_offset+flag*row_offset])
                self.switches[i+col_offset+flag*row_offset].add_left_neighbour(self.switches[i])
        
    def get_head_node(self):
        """
        Calculates the head node of the topology.
        In the case of Butterfly, it selects the middle node

        Returns:
        --------
        The head node of the topology. 
        """

        self.left_nodes[self.num//2].name = 'L1'+ self.left_nodes[self.num//2].name[2:]
        return self.left_nodes[self.num//2]
