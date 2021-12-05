package Core;

import LFSR :: * ;

/* We need core to generate random values and consume values sent to it*/

interface Ifc_Core;
    method Action put_data(int data);
    method int return_data();
endinterface

(* synthesize *)

module mkCore(Ifc_Core);

    Reg#(int) random_number <- mkReg(0);
    Reg#(Bool) rndm_valid   <- mkReg(False); // not sure if this is needed
    Reg#(int) self_id       <- mkReg(0); // later change to how much ever bits needed
    Reg#(int) consume_data  <- mkReg(0);
    
    // a LFSR for random patterns 
    LFSR#( Bit#(32) ) lfsr <- mkLFSR_32 i_rand ;

    // This rules triggers lfsr to next value every cycle
    rule update_lfsr; 
        lfsr.next ;     // update the lfsr value
    endrule 
    
    rule generate_random;
        $display("Node ID: %h, number_generated: %h", self_id, random_number);
        random_number   <= unpack(lfsr);
        rndm_valid      <= True;
    endrule

    method Action put_data(int data);
        consume_data    <= data;
    endmethod

    method int return_data();
        if(rndm_valid) return random_number;
    endmethod

endmodule: mkCore

endpackage: Core
