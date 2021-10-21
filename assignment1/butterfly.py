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
from switch import Switch

def log(n):
    """
    Computes log2 of the given number

    Parameters:
    -----------
        n : Integer
              The number to which the log to be computed
    Returns:
    --------
    The log2 (rounded off to ceil) of the given number
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

    def __init__(self, name, num, create=True, identity=0):
        """
        Initialises the Butterfly class.

        Parameters:
        -----------
        name : string
            The name to be assigned to the network topology.
        num : Integer
            The size of the network to be created
        Create : True/False
            If true, the nodes of the topology are created
            If false, the internal state is updated. Nodes are not created
            Default is True
        """

        self.name = name
        self.num = num
        self.id = identity
        self.left_nodes = []
        self.right_nodes = []
        self.switches = []
        if (create):
            self.create_nodes()
            self.create_network()

    def create_network(self):
        """
        Switches needed for the network are created
        The network is formed by connecting switches and nodes
        """        
        self.create_switches()
        self.connect_switches_nodes()
        
    def print_nodes(self, switch_alone=False):
        """
        Prints all the nodes in the network.
        Calls the print_neighbour() function in node class
        Prints nodes as per the output file format specification in the problem statement
        This function treats intermediate switches also as nodes
        """
        if(not switch_alone):
            for i in self.left_nodes:
                i.print_neighbour()

            for i in self.right_nodes:
                i.print_neighbour()
        
        print("\nPrinting Switches: ")        
        for i in self.switches:
            print(i.print_neighbours())
        

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

        if(len(self.left_nodes) < self.num):
            self.left_nodes.append(node)
        elif (len(self.right_nodes) < self.num):
            self.right_nodes.append(node)
        

    def create_nodes(self):
        """
        A private function to initialise the nodes in the topology
        This function, creates and assigns unique name to each node
        """

        digits = log(self.num)
        for i in range(self.num):
            self.left_nodes.append(Node(f"{self.name}L"+dec_to_bin(i, digits)))
            self.right_nodes.append(Node(f"{self.name}R"+dec_to_bin(i, digits)))
    
    def create_switches(self):
        """
        A private function to create the required number of switches to interconnect the nodes
        This function, creates and assigns unique name to each switch
        """

        layers = int(log(self.num))
        rows_switch = int(self.num/2)
        digits = log(rows_switch)

        # BL1 = butterfly switch layer 1 (from left)
        for i in range(layers):
            for j in range(rows_switch):
                self.switches.append(Switch(f"{self.name}"+f"S{i}_"+dec_to_bin(j, digits)))

    def connect_switches_nodes(self):
        """
        A private function to establish connection between switches and nodes
        The connection is established with switchs and nodes in left,
        switchs and nodes on the right, between switches in the middle
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
        Since head-nodes of L2 are nodes of L1, we rename the network with prefix L1 (instead of L2)
        In the case of Butterfly, it selects the middle node

        Returns:
        --------
        The head node of the topology. 
        """

        self.right_nodes[self.num//2].name = 'L1'+ self.right_nodes[self.num//2].name[2:]
        return self.right_nodes[self.num//2]
