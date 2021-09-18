# Level represents the highest level where this Node is present
# (ie) if its head node of L2, it will be present in L1
# Hence, level=1 else level=2 

class Node:
    """
    A class to represent Nodes (Vertices) in the network.
    A node can be present in Level2 or in the case head node Level1 and Level2
    A head node is considered to be part of Level1 network
    """

    def __init__(self,name="unnamed_node", level=2):
        """
        Initialises the Node class.

        Parameters:
        -----------
        name : string, optional
            The name to be assigned to the node.
        Level :integer, optional
            The level to which this node belongs.
            Default level is 2
        """
        self.name=name
        self.neighbour=[]
        self.level = level

    def set_name(self, name):
        """
        A function for setting the node name.

        Parameters:
        -----------
        name : string
            The name to be assigned to the node.
        """
        self.name=name

    def set_level(self, level):
        """
        A function for setting the node level.

        Parameters:
        -----------
        name : integer
            The level to be assigned to the node.
        """
        self.level=level
    
    def add_neighbour(self, node):
        """
        A function for adding neighbours of the node.

        Parameters:
        -----------
        node : Node
            The new neighbouring node of this node
        """
        if (node not in self.neighbour):
            self.neighbour.append(node)
        
    def print_name(self):
        """
        A function to print the name of this node.
        """
        print(self.name)

    def print_neighbour(self):
        """
        Prints all the neighbouring nodes of this node
        Node name printed in the first line
        Node name is followed by each Link in a newline
        """
        print("\nNodeID:", self.name, end="\n")
        print("Links:",len(self.neighbour),end="\n")
        for i in range(len(self.neighbour)):
            print(f"L{i+1}:",self.neighbour[i].name, end="\n")
        return ""
