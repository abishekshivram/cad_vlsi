from re import compile,match
from network import Network,create_node,create_switch
from sys import path
path.insert(1, './../assignment1')
from butterfly import log

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
    'LeftNeighbourDeclaration': compile(r'^Left Neighbours of the switch:\n'),
    'RightNeighbourDeclaration': compile(r'^Right Neighbours of the switch:\n'),
}


def addNetworkNode(nodeID,node):
    lenNodeID = len(nodeID)
    assert lenNodeID in [4,5],f"Please check your nodeID specification for {node.name}"
    
    level= nodeID[0]
    assert level in ['L1','L2'],f"Levels can only be 'L1' or 'L2'. Please check {node.name}"
    
    networkID = compile("^N(?P<networkIndex>\d+)")
    assert networkID.match(nodeID[1]) != None,"Network ID should be of type N<id>. Please check {nodeName}"
    networkIndex = int(networkID.match(nodeID[1]).group('networkIndex'))
    
    lvl2networkType = nodeID[2]
    assert lvl2networkType in ['C','B','F','R','M','H'],"Network Type Specified should be one of 'C','B','F','R','M' or 'H'. Please check {nodeName}"

    NOC.lvl2_networks[networkIndex].insert_nodes(node)
    if (level == 'L1'):
        NOC.lvl1_network.insert_nodes(node)


def addNetworkSwitch(switchID,switch):
    lenSwitchID = len(switchID)
    assert lenSwitchID == 5,"Please check your switchID specification. Please check {switch.name}"
    
    level= switchID[0]
    assert level in ['L1','L2'],"Levels can only be 'L1' or 'L2'"
    
    networkID = compile("^N(?P<networkIndex>\d+)")
    assert networkID.match(switchID[1]) != None,"Network ID should be of type N<id>"
    networkIndex = int(networkID.match(switchID[1]).group('networkIndex'))
    
    networkType = switchID[2]
    assert networkType == 'B',"Network Type should be 'B' for switches"
    
    if (level == 'L1'):
        assert networkIndex == 0,"There can be only one L1 network"
        NOC.lvl1_network.switches.append(switch)
    else:
        NOC.lvl2_networks[networkIndex].switches.append(switch)

def line_parse(file_name):
    line = file_name.readline()
    while (line.strip()=='\n'):
        line = file_name.readline()
        continue
    # at each line check for a match with a regex
    key,match = _parse_line(line)
    return key,match

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

        try:
            nodeID
        except:
            nodeID = None
        assert key != 'NeighbourLink', "Printing more than expected neighbours for {nodeID}"
        
        if key == 'NodeID':
            nodeName = match.group('nodeID').strip()
            nodeID = nodeName.split('_')
            node = create_node(nodeName)
            
            key,match = line_parse(f)
            assert (key == 'NumLink'), f"Need to specify the number of links for {nodeName}"
            numLinks = int(match.group('numLinks').strip())

            for i in range(numLinks):
                key,match = line_parse(f)
                assert key == 'NeighbourLink', f"Please enter the {i+1}th Neighbour ID of {nodeName}"
                # neighbourNum = int(match.group('L_idx').strip())
                neighbourName = match.group('neighbourID').strip()
                neighbourID = neighbourName.split('_')
                neighbourNode = create_node(neighbourName)
                node.add_neighbour(neighbourNode)
            
            addNetworkNode(nodeID,node)
        
        elif key == 'SwitchID':
            switchName = match.group('switchID').strip()
            switchID = switchName.split('_')
            switch = create_switch(switchName)
            
            key,match = line_parse(f)
            assert (key == 'NumLink'), f"Need to specify the number of links for {switchName}"
            numLinks = int(match.group('numLinks').strip())
            assert (numLinks == 2**(log(numLinks)) and (numLinks > 2)), "Number of neighbours for a Butterfly network should be a power of 2"
            
            key,match = line_parse(f)
            assert (key == 'LeftNeighbourDeclaration'), f"Declaration of left nodes for {switchName} not found"
            for i in range(numLinks+1):
                key,match = line_parse(f)
                if (i == numLinks/2):
                    assert key == 'RightNeighbourDeclaration', f"Declaration of right nodes for {switchName} not found"
                    continue
                assert key == 'NeighbourLink', f"Please enter the {i+1}th Neighbour ID of {switchName}"
                # neighbourNum = int(match.group('L_idx').strip())
                neighbourName = match.group('neighbourID').strip()
                neighbourID = neighbourName.split('_')
                if (neighbourID[3][0] == 'S'):
                    neighbourNode = create_switch(neighbourName)
                else:
                    neighbourNode = create_node(neighbourName)
                
                if (i<numLinks/2):
                    switch.add_left_neighbour(neighbourNode)
                else:
                    switch.add_right_neighbour(neighbourNode)
            
            addNetworkSwitch(switchID,switch)

