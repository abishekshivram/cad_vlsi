from re import compile
FILE_PATH = "../assignment1/output.txt"

def _parse_line(line):
    """
    Do a regex search against all defined regexes in rx_dict and
    return the key and match result of the first matching regex

    """

    for key, rx in rx_dict.items():
        match = rx.search(line)
        if match:
            return key, match
    # if there are no matches
    return None, None


"""
The python dictionary defining the different attributes of node specification
and the way in which they are defined in output.txt

"""
rx_dict = {
    'NodeID': compile(r'^NodeID: (?P<nodeID>.*)\n'),
    'NumLink': compile(r'^Links: (?P<numLinks>\d+)\n'),
    'NeighbourLink': compile(r'^L(?P<L_idx>\d+): (?P<neighbourID>.*)\n')
}


def nodeIDInterpreter(nodeID):
    lenNodeID = len(nodeID)
    assert lenNodeID in [4,5],"Please check your nodeID specification"
    level= nodeID[0]
    lvl2networkNum = nodeID[1]
    lvl2networkType = nodeID[2]
    assert lvl2networkType in ['C','B','F','R','M','H'],"Network Type Specified should be one of 'C','B','F','R','M' or 'H'"
    
    if lvl2networkType == 'B':
        if (lenNodeID == 4):
            assert nodeID[3][0] in ['L','R'], "Butterfly end nodes can only be of the form 'L' or 'R'"
            if nodeID[3][0] == 'L':
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
with open (FILE_PATH,'r') as f:
    for line in f:
        if (line=='\n'):
            continue
        # at each line check for a match with a regex
        key,match = _parse_line(line)
        
        if key == 'NodeID':
            nodeID = match.group('nodeID').strip().split('_')
            nodeIDInterpreter(nodeID)

        elif key == 'NumLink':
            numLinks = int(match.group('numLinks').strip())
        elif key == 'NeighbourLink':
            neighbourNum = int(match.group('L_idx').strip())
            neighbourID = match.group('neighbourID').strip().split('_')
            nodeIDInterpreter(nodeID)

