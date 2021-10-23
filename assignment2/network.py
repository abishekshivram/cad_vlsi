import sys
sys.path.insert(1, './../assignment1')
from chain import Chain
from ring import Ring
from butterfly import Butterfly
from foldedTorus import FoldedTorus
from hypercube import Hypercube
from mesh import Mesh
from node import Node
from switch import Switch

class Network:
    def __init__(self):
        self.lvl1_network = None
        self.lvl2_networks = []


    def build_network(self,line,lvl):
        assert(lvl in ['L1','L2']), "Please enter a valid level"
        input = line.strip().replace(" ", "").split(',')
        assert(len(input) == 3), "Input should have 3 parameters only"
        input[1] = int(input[1])
        input[2] = int(input[2])        
        
        if (input[0] == 'B'):
            assert(input[1] == input[2]),"Dimensions of Butterfly network should be equal"
            if (lvl == 'L1'):
                self.lvl1_network = Butterfly('',input[1], False)
            else:
                self.lvl2_networks.append(Butterfly('',input[1], False))
        
        elif (input[0] == 'C'):
            assert (input[2]==1),"Second dimension of Chain network is invalid"
            if (lvl == 'L1'):
                self.lvl1_network = Chain('',input[1], False)
            else:
                self.lvl2_networks.append(Chain('',input[1], False))
        
        elif (input[0] == 'R'):
            assert (input[2]==1),"Second dimension of Ring network is invalid"
            if (lvl == 'L1'):
                self.lvl1_network = Ring('',input[1], False)
            else:
                self.lvl2_networks.append(Ring('',input[1], False))   
        
        elif (input[0] == 'M'):
            assert (input[1]>1 and input[2]>1 and input[1]+input[2]>4),"The given dimension doesn't correspond to a Mesh network"
            if (lvl == 'L1'):
                self.lvl1_network = Mesh('',input[2],input[1],False)
            else:
                self.lvl2_networks.append(Mesh('',input[2],input[1],False))            

        elif (input[0] == 'F'):
            assert (input[1]>1 and input[2]>1 and input[1]+input[2]>4),"The given dimension doesn't correspond to a Folded Torus network"
            if (lvl == 'L1'):
                self.lvl1_network = FoldedTorus('',input[2],input[1],False)
            else:
                self.lvl2_networks.append(FoldedTorus('',input[2],input[1],False))     
	
        elif (input[0] == 'H'):
            assert (input[1] == input[2] and input[1] == 3),"Please specify the dimension of the Hypercube network properly, can only be specified as 'H,3,3'"
            if (lvl == 'L1'):
                self.lvl1_network = Hypercube('',input[1],False)
            else:
                self.lvl2_networks.append(Hypercube('',input[1],False))            

        else:
            print(f"Please choose a valid network, {input[0]} is not a valid network type")
            exit()

        if (lvl == 'L1'):
            return self.head_nodes(input)
        else:
            return 0



    def head_nodes(self,input):
        
        if (input[0] == 'B'):
            return 2*input[1]

        elif (input[0] == 'C'):
            return input[1]
        
        elif (input[0] == 'R'):
            return input[1]  
        
        elif (input[0] == 'M'):
            return input[1]*input[2]           

        elif (input[0] == 'F'):
            return input[1]*input[2]  
	
        elif (input[0] == 'H'):
            return 2**input[1]        

    def add_node(self):
        return


def create_node(name):
    return Node(name)

def create_switch(name):
    return Switch(name)

