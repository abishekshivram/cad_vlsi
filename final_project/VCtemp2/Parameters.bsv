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
typedef UInt#(16) NetAddress; //Represents the network address in NoC.
typedef UInt#(8) NetAddressX; //Represents the network address split to X dimensions
typedef UInt#(8) NetAddressY; //Represents the network address split to Y dimensions

typedef UInt#(16) NodeAddress; //Represents the node address in NoC.
typedef UInt#(8) NodeAddressX; //Represents the node address split to X dimensions
typedef UInt#(8) NodeAddressY; //Represents the node address split to Y dimensions

typedef SizeOf#(NetAddress) NetAddressLen; //Length of Net address
typedef SizeOf#(NodeAddress) NodeAddressLen; //Length of Node address
typedef SizeOf#(NetAddressX) NetAddressXLen; //Length of Net address X length
typedef SizeOf#(NetAddressY) NetAddressYLen; //Length of Net address Y length
typedef SizeOf#(NodeAddressX) NodeAddressXLen; //Length of Node address X length
typedef SizeOf#(NodeAddressY) NodeAddressYLen; //Length of Node address Y length

//For payload parameterisation, change the size here
//Represents the payload in a Flit
typedef UInt#(64) FlitPayload;


//A type to represet the clock count
typedef FlitPayload ClockCount;

//3 indicates the no of networks (L1 node count). This value will change based on the network count
Integer l1NodeCount=fromInteger(3);

interface MaxAddressInterface;
    method NodeAddress getMaxAddress(NetAddress index);
endinterface: MaxAddressInterface

(* synthesize *)
module mkMaxAddress(MaxAddressInterface);
    
    //An array supporitng the core module genrate valid filt addresses
    //NodeAddressLen represents the maximum value each array element can store
    //Each element of the array contains the maximum address possible in that L2 network
    NodeAddress maxNodeAddress[l1NodeCount];

    //initialise the max address of each network
    maxNodeAddress[0]=fromInteger(6);
    maxNodeAddress[1]=fromInteger(6);
    maxNodeAddress[2]=fromInteger(6);
    //maxNodeAddress[3]=fromInteger(8);
    //maxNodeAddress[4]=fromInteger(12);

    method NodeAddress getMaxAddress(NetAddress index);
        return maxNodeAddress[index];
    endmethod: getMaxAddress

endmodule: mkMaxAddress

endpackage: Parameters
