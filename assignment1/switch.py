###########################################################################
# CS6230:CAD for VLSI Systems - Project 1
# Name: Two level hierarchical Network on Chip 
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Implementation of the Switch in the network topology
# Last updated on: 18-Sep-2021
############################################################################

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

        print("Switch ID: ", self.name)
        print(f"Links: {len(self.left_neighbours)+len(self.left_neighbours)}")
        print("Left Neighbours of the switch:")
        count = 0
        for i in(self.left_neighbours):
            count += 1
            print(f"L{count}: ", i.name,end="\n")
        print("Right Neighbours of the switch:")
        for i in(self.right_neighbours):
            count += 1
            print(f"L{count}: ", i.name,end="\n")
        return ""
