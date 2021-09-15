# Reading L1 topology text file
# This file contains how all the central nodes of each network are connected
with open ("L1Topology.txt",'r') as f:
    for line in f:
        L1 = line.strip().replace(" ", "").split(',')

# Reading L2 topology text file
# This contains details of each of the network
L2 = []
with open ("L2Topology.txt", 'r') as f:
    for line in f:
        L2.append(line.strip().replace(" ", "").split(','))
        
print(L1)
print(L2)
