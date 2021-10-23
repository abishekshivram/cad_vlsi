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


class InputReader:
    '''A class for reading the flit generation details from a file'''

    def __init__(self,input_name):
 
        '''Constructor - Sets the name of the which contains the input details'''
        self.filename=input_name

    def get_l1_topology(self):
        '''Returs the L1 topology and dimensions from the input file
        Eg - C_3_0,R_3_0,M_4_4,F_4_4,B_8_8,H_3_3'''

        pass

    def get_src_and_destinations(self, clock_count):
        '''Gets the source node and destination nodes for communication in this clock cycle
        clock_count is the current position (tick) of the clock
        Returns well formatted source node and destination node names
        eg. 10 -> L1_N0_H_111, L1_N7_H_111'''
        pass


    
 