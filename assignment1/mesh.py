###########################################################################
# CS6230:CAD for VLSI Systems - Project 1
# Name: Two level hierarchical Network on Chip 
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Implementation of the Mesh network topology
# Last updated on: 18-Sep-2021
############################################################################

from node import Node
from butterfly import dec_to_bin,log

class Mesh:
    """
    A class to represent the Mesh based network topology.
    A node in the network will have three or four neighbours except head node
    If networks are interconnected, head node can have more than four neighbours
    """

    def __init__(self,name,rowCount,colCount,create=True):
        """
        Initialises the Mesh class.

        Parameters:
        -----------
        name : string
            The name to be assigned to the network topology.
        RowCount : Integer
            The number of rows to be added in the topology
        ColCount : Integer
            The number of coloums to be added in the topology
        Ceate : True/False
            If true, the nodes of the topology are created
            If false, the internal state is updated. Nodes are not created
            Default is True
        """

        self.name=name
        self.rowCount=rowCount
        self.colCount=colCount
        self.rowVertices=[]
        if (create):
            self.create_nodes()

    def get_node_name(self,i,j):
        """
        Generates a node name based on the topology and the Row-Id & Col-Id given
        Appends the given Ids to the topology name to generate a new node name

        Parameters:
        -----------
        i : Integer
            The row id to be added to the node name
        
        j : Integer
            The col id to be added to the node name

        Returns:
        --------
        The name generated for the node
        """

        return self.name+str(i)+"_"+str(j)

    def create_nodes(self):
        """
        A private function to initialise the nodes in the topology
        This function, creates and assigns unique name to each node
        """

        row_bits = log(self.rowCount)
        col_bits = log(self.colCount)
        for i in range(0,self.rowCount):
            self.colVertices=[]
            for j in range(0,self.colCount):
                self.colVertices.append(Node(self.get_node_name(dec_to_bin(i,row_bits),dec_to_bin(j,col_bits))))
            self.rowVertices.append(self.colVertices)
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

        max_row = len(self.rowVertices)
        
        if max_row > 0:
            max_column = len(self.rowVertices[-1])
        else:
            max_column = 0
        
        assert (max_row < self.rowCount or (max_row == self.rowCount and max_column < self.colCount)),\
            "More than expected rows for Mesh network"
        
        if (max_row == 0 or len(self.rowVertices[-1]) == self.colCount):
            self.rowVertices.append([]) 
        self.rowVertices[-1].append(node)
        
    def create_network(self):
        """
        Connects the nodes in the topology to form the mesh network
        """
        #Nodes in the center
        for i in range(1,len(self.rowVertices)-1):
            for j in range(1,len(self.rowVertices[i])-1):
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i-1][j])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i+1][j])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i][j-1])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i][j+1])

        #Top row and bottom row of the mesh
        lastRow=self.rowCount-1
        for i in range(1, self.colCount-1):
            self.rowVertices[0][i].add_neighbour(self.rowVertices[0][i+1])
            self.rowVertices[0][i].add_neighbour(self.rowVertices[0][i-1])
            self.rowVertices[0][i].add_neighbour(self.rowVertices[1][i])
            
            self.rowVertices[lastRow][i].add_neighbour(self.rowVertices[lastRow][i+1])
            self.rowVertices[lastRow][i].add_neighbour(self.rowVertices[lastRow][i-1])
            self.rowVertices[lastRow][i].add_neighbour(self.rowVertices[lastRow-1][i])

        #Corners of the mesh
        if self.colCount >1:
            self.rowVertices[0][0].add_neighbour(self.rowVertices[0][1])#TopLeft
            self.rowVertices[0][self.colCount-1].add_neighbour(self.rowVertices[0][self.colCount-2]) #TopRight
            self.rowVertices[lastRow][0].add_neighbour(self.rowVertices[lastRow][1]) #BottmLeft
            self.rowVertices[lastRow][self.colCount-1].add_neighbour(self.rowVertices[lastRow][self.colCount-2])#BottmRight

        if self.rowCount >1:
            self.rowVertices[0][0].add_neighbour(self.rowVertices[1][0])#TopLeft
            self.rowVertices[0][self.colCount-1].add_neighbour(self.rowVertices[1][self.colCount-1]) #TopRight
            self.rowVertices[lastRow][0].add_neighbour(self.rowVertices[lastRow-1][0]) #BottmLeft
            self.rowVertices[lastRow][self.colCount-1].add_neighbour(self.rowVertices[lastRow-1][self.colCount-1])#BottmRight

        #Left col and right col
        for i in range(1, self.rowCount-1):
            self.rowVertices[i][0].add_neighbour(self.rowVertices[i+1][0])
            self.rowVertices[i][0].add_neighbour(self.rowVertices[i-1][0])
            self.rowVertices[i][0].add_neighbour(self.rowVertices[i][1])
            
            self.rowVertices[i][self.colCount-1].add_neighbour(self.rowVertices[i+1][self.colCount-1])
            self.rowVertices[i][self.colCount-1].add_neighbour(self.rowVertices[i-1][self.colCount-1])
            self.rowVertices[i][self.colCount-1].add_neighbour(self.rowVertices[i][self.colCount-2])
            
            
    def print_nodes(self):
        """
        Prints all the nodes in the network.
        Calls the print_neighbour() function in node class
        Prints nodes as per the output file format specification in the problem statement
        """

        for i in range(0,self.rowCount):
            for j in range(0,self.colCount):
                self.rowVertices[i][j].print_neighbour()


    def get_head_node(self):
        """
        Calculates the head node of the topology.
        In the case of Mesh, it is the node in center

        Returns:
        --------
        The head node of the topology. Empty node, if the topology is not created
        """

        midrow=self.rowCount//2
        midcol=self.colCount//2

        if(len(self.rowVertices)>0 and len(self.rowVertices)>=midrow):
            if(len(self.rowVertices[midrow])>0 and len(self.rowVertices[midrow])>=midcol):
                self.rowVertices[midrow][midcol].name = 'L1'+self.rowVertices[midrow][midcol].name[2:]
                return self.rowVertices[midrow][midcol]
        print("Mesh not created yet")
        n=Node("NIL")
        return n
