from re import compile,match
from network import Network

FILE_PATH_INPUT_LVL1 = "../assignment1/L1Topology.txt"
FILE_PATH_INPUT_LVL2 = "../assignment1/L2Topology.txt"
FILE_PATH_OUTPUT = "../assignment1/output.txt"

def _parse_line(line):
    """
    Do a regex search against all defined regexes in rx_dict_output and
    return the key and match result of the first matching regex

    """

    for key, rx in rx_dict_output.items():
        match = rx.search(line)
        if match:
            return key, match
    # if there are no matches
    return None, None


"""
The python dictionary defining the different attributes of node specification
and the way in which they are defined in output.txt

"""
rx_dict_output = {
    'NodeID': compile(r'^NodeID: (?P<nodeID>.*)\n'),
    'NumLink': compile(r'^Links: (?P<numLinks>\d+)\n'),
    'NeighbourLink': compile(r'^L(?P<L_idx>\d+): (?P<neighbourID>.*)\n'),
    'SwitchID': compile(r'^Switch ID:  (?P<switchID>.*)\n'),
    'SwitchLink': compile(r'^L(?P<L_idx>\d+):  (?P<switchID>.*)\n'),
    'LeftNeighbourDeclaration': compile(r'^Left Neighbours of the switch:\n'),
    'RightNeighbourDeclaration': compile(r'^Right Neighbours of the switch:\n'),
}


def nodeIDInterpreter(nodeID,nodeName):
    lenNodeID = len(nodeID)
    assert lenNodeID in [4,5],"Please check your nodeID specification"
    
    level= nodeID[0]
    assert level in ['L1','L2'],"Levels can only be 'L1' or 'L2'"
    
    networkID = compile("^N(?P<networkIndex>\d+)")
    assert networkID.match(nodeID[1]) != None,"Network ID should be of type N<id>"
    networkIndex = int(networkID.match(nodeID[1]).group('networkIndex'))
    
    lvl2networkType = nodeID[2]
    assert lvl2networkType in ['C','B','F','R','M','H'],"Network Type Specified should be one of 'C','B','F','R','M' or 'H'"
    
    if lvl2networkType == 'B':
        if (lenNodeID == 4):
            assert nodeID[3][0] in ['L','R'], "Butterfly end nodes can only be of the form 'L' or 'R'"
            if nodeID[3][0] == 'L':
                if (level == 'L1'):
                    NOC.lvl1_network.left
                butterflySide = 'L'
                nodeIndex = int(nodeID[3][1:])
            else:
               butterflySide = 'R'
               nodeIndex = int(nodeID[3][1:]) 
        else:
            assert nodeID[3][0] == 'S', "Switches of a butterfly network should be denoted with 'S'"
            switchNum = int(nodeID[3][1:])   
            switchNodeIndex = int(nodeID[4]) 
    else:
        nodeIndex = int(nodeID[3])


# MAIN function equivalent part of the program
NOC = Network()
with open (FILE_PATH_INPUT_LVL1,'r') as f_lvl1:
    lines = f_lvl1.readlines()
    lvl1_nodes = NOC.build_network(lines[0],'L1')
    if (len(lines) > 1):
        for line in lines[1:]:
            assert (line.strip() != '\n'), "L1 Topology input file should have only one network"


with open (FILE_PATH_INPUT_LVL2,'r') as f_lvl2:
    for line in f_lvl2:
        if (line.strip() == '\n'):
            continue
        NOC.build_network(line,'L2')

assert (len(NOC.lvl2_networks) == lvl1_nodes), "L2 headnodes do not match number of nodes in L1"  


with open (FILE_PATH_OUTPUT,'r') as f:
    for line in f:
        if (line=='\n'):
            continue
        # at each line check for a match with a regex
        key,match = _parse_line(line)
        
        if key == 'NodeID':
            nodeName = match.group('nodeID').strip()
            nodeID = nodeName.split('_')
            nodeIDInterpreter(nodeID,nodeName)

        elif key == 'NumLink':
            numLinks = int(match.group('numLinks').strip())
        elif key == 'NeighbourLink':
            neighbourNum = int(match.group('L_idx').strip())
            neighbourName = match.group('neighbourID').strip()
            neighbourID = neighbourName.split('_')
            nodeIDInterpreter(nodeID,neighbourName)

