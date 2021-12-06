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

    Empty node <- mkNode;

    rule test;

        Address add;
        add.netAddress=fromInteger(5);
        add.nodeAddress=fromInteger(6);

        $display("Hello world!-> %x,%x",add.netAddress,add.nodeAddress);

        

    endrule: test

endmodule: mkTest

endpackage: NoC

/*
// Copyright 2010 Bluespec, Inc.
//All rights reserved.
package NoC;
// importing the FIFO library package
import FIFO ::*;
// ----------------------------------------------------------------
// A top-level module instantiating a fifo
(* synthesize *)
module mkTest (Empty);
FIFO#(int) f <- mkFIFO;
// Instantiate a fifo
// ----------------
// Step ’state’ from 1 to 10
Reg#(int) state <- mkReg (0);
rule step_state;
if (state > 9) $finish (0);
state <= state + 1;
endrule
// ----------------
// Enqueue two values to the fifo from seperate rules in the testbench
//
//(* descending_urgency = "enq1, enq2"*)
rule enq1 (state < 7);
f.enq(state);
$display("fifo enq1: %d", state);
endrule
rule enq2 (state > 4);
f.enq(state+1);
$display("fifo enq2: %d", state+1);
endrule
// ----------------
// Dequeue from the fifo, and check the first value
//
rule deq;
f.deq();

$display("fifo deq : %d", f.first() );
endrule
endmodule: mkTest
endpackage: NoC*/