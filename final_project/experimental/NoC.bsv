/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: 
Last updated on: 09-Dec-2021
**************************************************************************************/

package NoC;

import Shared::*;
import Node::*;


(* synthesize *)
module mkTest (Empty);

    
    rule test;

        Address add;
        add.netAddress=fromInteger(5);
        add.nodeAddress=fromInteger(6);

        $display("Hello world!-> %x,%x",add.netAddress,add.nodeAddress);
    endrule: test

endmodule: mkTest

endpackage: NoC
