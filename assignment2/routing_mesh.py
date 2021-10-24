from router import Router
from flit import Flit
from simulate import L1_network, L2_networks
from re import compile,findall

from sys import path
path.insert(1, './../assignment1')
from butterfly import dec_to_bin
from mesh import Mesh

# def mesh_path(start_node, destination_node,meshNodes):
#     meshPath = [start_node]
#     parts_start = start_node.split("_")
#     parts_dest = destination_node.split("_")
#     network_start = f"{parts_start[1]}_{parts_start[2]}_"
#     network_dest = f"{parts_dest[1]}_{parts_dest[2]}_"
#     assert (network_start == network_dest), "Network should match"

#     index_pattern = compile(r"^L[12]_N([\d])+_M_(?P<row_idx>\d+)_(?P<col_idx>\d+)")
#     start_row_index = int(index_pattern.match(start_node).group('row_idx'),2)
#     dest_row_index = int(index_pattern.match(destination_node).group('row_idx'),2)
#     start_col_index = int(index_pattern.match(start_node).group('col_idx'),2)
#     dest_col_index = int(index_pattern.match(destination_node).group('col_idx'),2)

#     while (start_col_index != dest_col_index or start_row_index != dest_row_index):
        
#         while (start_col_index != dest_col_index):
#             if (start_col_index > dest_col_index):
#                 start_col_index -= 1
#             else:
#                 start_col_index += 1
#             meshPath.append(meshNodes[meshNodes.colCount*start_row_index+start_col_index].name)
        
#         while (start_row_index != dest_row_index):
#             if (start_row_index > dest_row_index):
#                 start_row_index -= 1
#             else:
#                 start_row_index += 1
#             meshPath.append(meshNodes[meshNodes.colCount*start_row_index+start_col_index].name)
    
#     return meshPath



