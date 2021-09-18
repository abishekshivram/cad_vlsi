###########################################################################
# CS6230:CAD for VLSI Systems - Project 1
# Name: Two level hierarchical Network on Chip 
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Implementation of the Ring network topology
# Last updated on: 18-Sep-2021
############################################################################

from node import Node
from butterfly import dec_to_bin,log

class Ring:
    """
    A class to represent the ring based network topology.
    A node in the network will have two neighbours except head node
    If networks are interconnected, head node can have more than two neighbours
    """

    def __init__(self,name, count,create=True):
        """
        Initialises the Ring class.

        Parameters:
        -----------
        name : string
            The name to be assigned to the network topology.
        Count : Integer
            The number of nodes to be added in the topology
        Create : True/False
            If true, the nodes of the topology are created
            If false, the internal state is updated. Nodes are not created
            Default is True
        """

        self.name=name
        self.count=count
        self.vertices=[]
        if (create):
            self.create_nodes()

    def get_node_name(self, id):
        """
        Generates a node name based on the topology and the Id given
        Appends the given Id to the topology name to generate a new node name

        Parameters:
        -----------
        id : Integer
            The idd to be added to the node name

        Returns:
        --------
        The name generated for the node
        """

        return self.name+str(id)

    def create_nodes(self):
        """
        A private function to initialise the nodes in the topology
        This function, creates and assigns unique name to each node
        """

        len_bits = log(self.count)
        for i in range(0,self.count):
            self.vertices.append(Node(self.get_node_name(dec_to_bin(i,len_bits))))
        self.create_network()

    def insert_nodes(self,node):
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

        max_len = len(self.vertices)
        assert (max_len < self.count),"More than expected nodes for Ring network"
        self.vertices.append(node)
                
    def create_network(self):
        """
        Connects the nodes in the topology to form the Ring network
        """

        for i in range(1,self.count-1):
            self.vertices[i].add_neighbour(self.vertices[i+1])
            self.vertices[i].add_neighbour(self.vertices[i-1])
        if(len(self.vertices)>1):
            self.vertices[0].add_neighbour(self.vertices[1])
            self.vertices[0].add_neighbour(self.vertices[self.count-1])
            self.vertices[self.count-1].add_neighbour(self.vertices[self.count-2])
            self.vertices[self.count-1].add_neighbour(self.vertices[0])

    def print_nodes(self):
        """
        Prints all the nodes in the network.
        Calls the print_neighbour() function in node class
        Prints nodes as per the output file format specification in the problem statement
        """

        for i in self.vertices:
            i.print_neighbour()

    def get_head_node(self):
        """
        Calculates the head node of the topology.
        Since head-nodes of L2 are nodes of L1, we rename the network with prefix L1 (instead of L2)
        In the case of Ring, it is the first node

        Returns:
        --------
        The head node of the topology. Empty node, if the topology is not created
        """

        if(len(self.vertices)>0):
            self.vertices[0].name = 'L1'+self.vertices[0].name[2:]
            return self.vertices[0]
        else:
            print("Ring not created yet")
            n=Node("NIL")
            return n
