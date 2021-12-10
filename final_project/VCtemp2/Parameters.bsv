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

typedef SizeOf#(NetAddress) NetAddressLen; //Length of Net address
typedef SizeOf#(NodeAddress) NodeAddressLen; //Length of Node address
typedef SizeOf#(NetAddressX) NetAddressXLen; //Length of Net address X length
typedef SizeOf#(NetAddressY) NetAddressYLen; //Length of Net address Y length
typedef SizeOf#(NodeAddressX) NodeAddressXLen; //Length of Node address X length
typedef SizeOf#(NodeAddressY) NodeAddressYLen; //Length of Node address Y length

typedef Bit#(16) LinkUtilisationCounter; //To measure link utilisation performance
typedef Bit#(3) LinkUtiliPrInterval; //Link utilisation print interval

//For payload parameterisation, change the size here
//Represents the payload in a Flit
typedef Bit#(64) FlitPayload;


//A type to represet the clock count
typedef FlitPayload ClockCount;

//3 indicates the no of networks (L1 node count). This value will change based on the l2 network count
Integer l1NodeCount=fromInteger(1);

interface MaxAddressInterface;
    method NodeAddressX getMaxAddressX(NetAddress index);
    method NodeAddressY getMaxAddressY(NetAddress index);
    method NetAddressX getMaxNetAddressX();
    method NetAddressY getMaxNetAddressY();
endinterface: MaxAddressInterface

(* synthesize *)
module mkMaxAddress(MaxAddressInterface);
    
    //An array supporitng the core module to genrate valid filt addresses
    //NodeAddressLen represents the maximum value each array element can store
    //Each element of the array contains the maximum address possible in that L2 network (in Mesh - X and Y dimensions, for chain, ring etc fill Y dimension first, MSB overflow may be stored in X)
    //
    NodeAddressX maxNodeAddressX[l1NodeCount];     NodeAddressY maxNodeAddressY[l1NodeCount];


    //initialise the max address of L1 network
    NetAddressX maxNetAddressX='h00; NetAddressY maxNetAddressY='h01;

    //initialise the max address of each network
    maxNodeAddressX[0]='h03; maxNodeAddressY[0]='h03;
    //maxNodeAddressX[1]='h00; maxNodeAddressY[1]='h06;
    //maxNodeAddressX[2]='h00; maxNodeAddressY[2]='h06;
    //maxNodeAddressX[3]='h00; maxNodeAddressY[3]='h06;
    
    method NodeAddressX getMaxAddressX(NetAddress index);
        return maxNodeAddressX[index];
    endmethod: getMaxAddressX

    method NodeAddressY getMaxAddressY(NetAddress index);
        return maxNodeAddressY[index];
    endmethod: getMaxAddressY

    method NetAddressX getMaxNetAddressX();
        return maxNetAddressX;
    endmethod

    method NetAddressY getMaxNetAddressY();
        return maxNetAddressY;
    endmethod

endmodule: mkMaxAddress

endpackage: Parameters
