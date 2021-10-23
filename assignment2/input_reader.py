###########################################################################
# CS6230:CAD for VLSI Systems - Project 2
# Name: Deciding the Route (In a Two level hierarchical Network on Chip)
# Team Name: Kilbees
# Team Members: Abishekshivram AM (EE18B002)
#               Gayatri Ramanathan Ratnam (EE18B006)
#               Lloyd K L (CS21M001)
# Description: Reads input file
# Last updated on: 20-Oct-2021
############################################################################

import re

class InputReader:
    '''A class for reading the flit generation details from a file'''

    def __init__(self,input_name):
 
        '''Constructor - Sets the name of the which contains the input details'''
        self.filename=input_name

    def get_l1_topology(self):
        '''Returs the L1 topology and dimensions from the input file
        Eg - C_3_0,R_3_0,M_4_4,F_4_4,B_8_8,H_3_3'''

        with open(self.filename) as file:
            for line in file:
                l1_topo=line.partition("L1Topology:")[2]
                if(l1_topo!=""):
                    node_name=str(l1_topo).strip()
                    match=re.findall('(^[C|R|M|F|B|H]_\d+_\d+$)',node_name) 
                    if(match):
                        return match[0]
                    else:
                        print("Invalid L1 topology specified in the input")
                    break

    def get_src_and_destinations(self, clock_count):
        '''Gets the source node and destination nodes for communication in this clock cycle
        clock_count is the current position (tick) of the clock
        Returns well formatted source node and destination node names pair as a list
        eg. 10 -> L1_N0_H_111, L1_N7_H_111'''

        with open(self.filename) as file:
            output=[]
            for line in file:
                key_vals=line.split(',')
                if(key_vals.count()!=3):
                    continue
                
                clk=key_vals[0].partition("Clock:")[2]
                clk=str(clk).strip()
                if(clk==""):
                    continue
                if(int(clk)!=int(clock_count)):
                    continue
                src=key_vals[1].partition("Source:")[2]
                src=str(src).strip()
                dst=key_vals[2].partition("Destination:")[2]
                dst=str(dst).strip()
                src_dst_pair=(src,dst)
                output.insert(src_dst_pair)
 