/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: Implementation of core - which generates valid flits in random, and consumes flit destined to it
Last updated on: 09-Dec-2021
**************************************************************************************/

package Core;
import Parameters::*;
import Shared::*;

(* synthesize *)
module mkCore(Empty);
//The core should know its network address and node address
//declare varibale for source address and set it at the time of each core module creation

    rule generateFlit; //This rule to be fired randomly for different cores

        Flit flit;
        flit.srcAddress.netAddress=fromInteger(5); //To be set properly
        flit.srcAddress.nodeAddress=fromInteger(6);//To be set properly

        flit.finalDstAddress.netAddress=fromInteger(5);//To be set properly
        flit.finalDstAddress.nodeAddress=fromInteger(6);//To be set properly

        flit.currentDstAddress.netAddress=fromInteger(0);
        flit.currentDstAddress.nodeAddress=fromInteger(0);
        //flit.payload=current clock count

    endrule: generateFlit
    
endmodule: mkCore

endpackage: Core
