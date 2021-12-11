/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: File to define data types to be shared among the packages of the project
Last updated on: 09-Dec-2021
**************************************************************************************/

package Shared;

import Parameters::*;
import DefaultValue::*;

//A strucutre to represent the address in the network
//Address is made up of network address and node address 
typedef struct
{
    NetAddress netAddress;
    NodeAddress nodeAddress;
}Address deriving(Bits,Eq); 

instance DefaultValue #(Address);
    defaultValue = Address { netAddress : 0,
                             nodeAddress : 0 };
endinstance

//A structure representing the Flit in NoC
//A flit is made of Source Address, Final destination address, \
//       Current Destination Address (Head node) and Payload (The data)
typedef struct
{
    Address srcAddress;
    Address finalDstAddress;
    Address currentDstAddress;
    FlitPayload payload;
}Flit deriving(Bits,Eq); 

instance DefaultValue #(Flit);
    defaultValue = Flit { srcAddress: defaultValue, 
                          finalDstAddress:defaultValue,
                          currentDstAddress:defaultValue, 
                          payload:0 };
endinstance

endpackage: Shared
