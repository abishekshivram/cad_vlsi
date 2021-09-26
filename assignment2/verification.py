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

with open (FILE_PATH,'r') as f:
    for line in f:
        if (line=='\n'):
            continue
        # at each line check for a match with a regex
        key,match = _parse_line(line)
        
        if key == 'NodeID':
            nodeID = match.group('nodeID').strip().split('_')
        elif key == 'NumLink':
            numLinks = int(match.group('numLinks').strip())
        elif key == 'NeighbourLink':
            neighbourNum = int(match.group('L_idx').strip())
            neighbourID = match.group('neighbourID').strip().split('_')
