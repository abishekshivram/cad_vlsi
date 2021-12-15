# MAKING Parameters.bsv
params_contents = """
/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: The configurable parameters are defined in this file
Last updated on: 09-Dec-2021
**************************************************************************************/

//This file is meant to be generated by Python script

package Parameters;

//Modify here for changing network address length 
//Assumption - All the network topologies share the same network address length and node address length
typedef Bit#(16) NetAddress; //Represents the network address in NoC.

//NOTE Most significant byte is X and LSByte is Y

typedef Bit#(8) NetAddressX; //Represents the network address split to X dimensions
typedef Bit#(8) NetAddressY; //Represents the network address split to Y dimensions

typedef Bit#(16) NodeAddress; //Represents the node address in NoC.
typedef Bit#(8) NodeAddressX; //Represents the node address split to X dimensions
typedef Bit#(8) NodeAddressY; //Represents the node address split to Y dimensions

typedef SizeOf#(NetAddress) NetAddressTotalLen; //Length of Net address
typedef SizeOf#(NodeAddress) NodeAddressTotalLen; //Length of Node address
typedef SizeOf#(NetAddressX) NetAddressXLen; //Length of Net address X length
typedef SizeOf#(NetAddressY) NetAddressYLen; //Length of Net address Y length
typedef SizeOf#(NodeAddressX) NodeAddressXLen; //Length of Node address X length
typedef SizeOf#(NodeAddressY) NodeAddressYLen; //Length of Node address Y length

typedef Bit#(16) LinkUtilisationCounter; //To measure link utilisation performance
typedef Bit#(7) LinkUtiliPrInterval; //Link utilisation print intervalet

//Modify here for changing network address length 
typedef Int#(16) NetAddressLen;

//Modify here for changing node address length 
typedef Int#(16) NodeAddressLen;

//For payload parameterisation, change the size here
typedef UInt#(64) PayloadLen; 
typedef Bit#(64) FlitPayload;

//A type to represet the clock count
typedef FlitPayload ClockCount;

//5 indicates the no of networks (L1 node count). This value will change based on the network count
//NOTE To be changed as per node count in the L1 network
//If L1 is a 4x3 mesh, l1NodeCount count to be set to 12
Integer l1NodeCount=fromInteger({l1_nodes});

interface MaxAddressInterface;
    method NodeAddressX getMaxAddressX(NetAddressY index); //NOTE here the argument type NetAddressY is acting just like an int used to index into the array maxNodeAddressX
    method NodeAddressY getMaxAddressY(NetAddressY index); //NOTE here the argument type NetAddressY is acting just like an int used to index into the array maxNodeAddressY
    method NetAddressX getMaxNetAddressX();
    method NetAddressY getMaxNetAddressY();
endinterface: MaxAddressInterface

(* synthesize *)
module mkMaxAddress(MaxAddressInterface);
    
    //An array supporitng the core module genrate valid filt addresses
    //NodeAddressLen represents the maximum value each array element can store
    //Each element of the array contains the maximum address possible in that L2 network
    //NodeAddressLen maxNodeAddress[l1NodeCount];
    
    NodeAddressX maxNodeAddressX[l1NodeCount];     NodeAddressY maxNodeAddressY[l1NodeCount];
    
    //NOTE To be changed as per the configuration of L1 network
    //If L1 is a 4x3 mesh, maxNetAddressX would be 'h03, maxNetAddressY would be ='h04
    NetAddressX maxNetAddressX='h{x_dim_l1:0>2x}; NetAddressY maxNetAddressY='h{y_dim_l1:0>2x}; //initialise the max address of L1 network

    //NOTE To be changed as per the configuration of L1 & L2 network
    //initialise the max address of each L2 network. The line count in this source block will be equal to l1NodeCount
    //So if l1NodeCount=12, there will be 12 L2 networks and each networks max parameters are to be set
    //If 0th L2 network is a 3x4 mesh, the configuration will be maxNodeAddressX[0]='h04; maxNodeAddressY[0]='h03;
    //If 1th L2 network is a 3 node chain, the configuration will be maxNodeAddressX[1]='h00; maxNodeAddressY[1]='h03; etc..
    {sentence}
                

    method NodeAddressX getMaxAddressX(NetAddressY index); //NOTE here the argument type NetAddressY is acting just like an int used to index into the array maxNodeAddressX
        return maxNodeAddressX[index];
    endmethod: getMaxAddressX

    method NodeAddressY getMaxAddressY(NetAddressY index); //NOTE here the argument type NetAddressY is acting just like an int used to index into the array maxNodeAddressY
        return maxNodeAddressY[index];
    endmethod: getMaxAddressY

    method NetAddressX getMaxNetAddressX();
        return maxNetAddressX;
    endmethod

    method NetAddressY getMaxNetAddressY();
        return maxNetAddressY;
    endmethod


endmodule: mkMaxAddress

endpackage: Parameters"""



def make_param_file(l1_nodes,l1_dim,l2_dim):
    sentence = ""
    for i in range(l1_nodes):
        sentence += f"\n\tmaxNodeAddressX[{i}]='h{l2_dim[i][0]:0>2x}; maxNodeAddressY[{i}]='h{l2_dim[i][1]:0>2x};"

    with open('./src/Parameters.bsv', 'w') as f:
        f.write(params_contents.format(l1_nodes=l1_nodes,x_dim_l1=l1_dim[0],y_dim_l1=l1_dim[1],sentence=sentence))




