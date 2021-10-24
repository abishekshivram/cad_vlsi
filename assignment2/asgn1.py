import sys
sys.path.insert(1, './../assignment1')

from detailed_graph import main 

# L1_network = None
# L2_networks = None
# full_network = None

# def network_as_class_obj():
    # global L1_network, L2_networks, full_network

L1_network, L2_networks = main(print=False)
