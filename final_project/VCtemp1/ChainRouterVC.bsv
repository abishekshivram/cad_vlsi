package ChainRouterVC;
// This package contains the router - which implements the routing algorithm for the chain topology
// Routing algorithm works as follows:
// For each link, two VCs are allocated. For example, in each node in chain topology, we have
// 3 links (core, left neighbour, right neighbour). So 6 VCs are made and VC1,2 allocated to core, 
// VC3,4 allocated to left neighbour, VC5,6 allocated to right neighbour
// This routing can be seen in line 58: Two rules are written that connects the Input link to the respective VC

import Shared::*;

// FIFO used as buffers in routers
import FIFO :: * ;
import FIFOF :: * ;



interface IfcChainRouterVC ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value (Flit flit);

    // Each output link gets two VC channel (for chain, we have: left, right, core)
    // Hence, we need 6 VCs
    // Each of the following methods will dequeue (ACTION) an element from the VC and return it (VALUE)
    method ActionValue#(Flit) get_valueVC1();
    method ActionValue#(Flit) get_valueVC2();
    method ActionValue#(Flit) get_valueVC3();
    method ActionValue#(Flit) get_valueVC4();
    method ActionValue#(Flit) get_valueVC5();
    // method Flit get_valueVC5();
    method ActionValue#(Flit) get_valueVC6();
    
endinterface


(* synthesize *)

// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkChainRouterVC #(parameter Address my_addr) (IfcChainRouterVC);

    // Right now, it has been commented, we may need it for L1, L2 routing
    //Reg#(bit)   level       <- mkReg(0); // 0 for low level (L2), 1 for high level (L1)
    //Reg#(Bit#(3))   my_id   <- mkReg(3'b001); // using python - *insert the id and bits, assumed 3*
    

    // Input link for the router
    FIFO#(Flit)  input_link   <- mkFIFO; // to get data from left router


    // To store the flits that are sent to core
    FIFO#(Flit)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(Flit)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2


    // To store the flits that are sent to left
    FIFO#(Flit)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(Flit)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    

    // To store the flits that are sent to right
    FIFOF#(Flit)  vir_chnl_5  <- mkFIFOF; // Virtual Channel 5
    FIFO#(Flit)  vir_chnl_6  <- mkFIFO; // Virtual Channel 6

    // Since we have two VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);


    // rule test_rule1;
    //     Flit f=defaultValue;
    //     vir_chnl_4.enq(f);
    //     $display("test_rule1 fired");
    // endrule

    // rule test_rule2;
    //     //Flit f=defaultValue;
    //     Flit f= vir_chnl_4.first();
    //     vir_chnl_4.deq();
    //     $display("test_rule2 fired");
    //     // vir_chnl_4.notEmpty() -- true or false
    // endrule

    // Cycle variable oscillates between 0 and 1
    rule invert_cycle;
        cycle <= cycle + 1;
        
        
        // let cur_flit_check = vir_chnl_5.first();
        // $display("Check from RouterVC: %h", cur_flit_check.currentDstAddress.nodeAddress);
    endrule

    // Connect input_link to respective VC
    // This rules fires every alternate cycle, and chooses even named Virtual Channels (VC1, VC3, VC5)

    (* preempts = "read_input_link_and_send_to_VC_odd, check_if_five_is_empty" *)
    rule read_input_link_and_send_to_VC_odd(cycle == 1);
    
        // int flit should be changed to Flit data structure! -Lloyd changed
        let flit = input_link.first();
        input_link.deq();

        // Assumption (not correct): Address is 3 bits. We need to change it!
        //Bit#(3) extracted_id = pack(flit)[31:29];
        
        // Reached the destination - core will consume
        if(flit.currentDstAddress.nodeAddress == my_addr.nodeAddress)  begin
            $display("vir_chnl_1.enq");
            vir_chnl_1.enq(flit);
        end
        // The current flit has to go to left 
        else if(flit.currentDstAddress.nodeAddress < my_addr.nodeAddress)  begin
            $display("vir_chnl_3.enq");
            vir_chnl_3.enq(flit);
        end
        // The current flit has to go to right
        else  begin
            $display("vir_chnl_5.enq -- %h", my_addr);
            vir_chnl_5.enq(flit);
        end
    endrule

    rule check_if_five_is_empty;
        let check_if_empty = vir_chnl_5.notEmpty();
        $display("odd cycles at %h, vir chnl 5 notEmpty: %d", my_addr, check_if_empty);
    endrule


    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC2, VC4, VC6)
    rule read_input_link_and_send_to_VC_even(cycle == 0);

        //NOTE This logic would need change when L1 is introduced
        //NOTE network address is not considered now
        let flit = input_link.first();
        input_link.deq();
        //Bit#(3) extracted_id = pack(flit)[31:29];
        
        // Reached the destination - core will consume
        //if(extracted_id == my_id)  begin
        if(flit.currentDstAddress.nodeAddress == my_addr.nodeAddress)  begin
            $display("vir_chnl_2.enq");
            vir_chnl_2.enq(flit);
        end
        // The current flit has to go to left 
        else if(flit.currentDstAddress.nodeAddress < my_addr.nodeAddress)  begin
            $display("vir_chnl_4.enq");
            vir_chnl_4.enq(flit);
        end
        // The current flit has to go to right
        else  begin
            $display("vir_chnl_6.enq");
            vir_chnl_6.enq(flit);
        end
    endrule

    // Method to get the flit into the node
    method Action put_value(Flit flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link.enq(flit);
        $display("Core router got the flit");
    endmethod


    // Following are the six methods (corresponding to six available VCs) 
    // These methods return the flit so that it can reach the next node in its path
    // The VC1, VC2 methods will be invoked to send the flits to the core (as we fixed earlier, line:4)
    method ActionValue#(Flit) get_valueVC1();
        $display("get_valueVC1");
        // let temp1 = vir_chnl_1.first();
        // vir_chnl_1.deq();
        return defaultValue;
    endmethod

    method ActionValue#(Flit) get_valueVC2();
        $display("get_valueVC2");
        // let temp2 = vir_chnl_2.first();
        // vir_chnl_2.deq();
        return defaultValue;
    endmethod

    method ActionValue#(Flit) get_valueVC3();
        $display("get_valueVC3");
        let temp3 = vir_chnl_3.first();
        vir_chnl_3.deq();
        return temp3;
    endmethod

    method ActionValue#(Flit) get_valueVC4();
        $display("get_valueVC4");
        let temp4 = vir_chnl_4.first();
        vir_chnl_4.deq();
        return temp4;
    endmethod

    /*method ActionValue#(Flit) get_valueVC5();
        $display("get_valueVC5");
        let temp5 = vir_chnl_5.first();
        vir_chnl_5.deq();
        return temp5;
    endmethod*/

    method ActionValue#(Flit) get_valueVC5();
        $display("get_valueVC5");
        //let temp5 = vir_chnl_5.first();
        //vir_chnl_5.deq();
        //return temp5;
        
        return defaultValue;
    endmethod

    method ActionValue#(Flit) get_valueVC6();
        $display("get_valueVC6");
        let temp6 = vir_chnl_6.first();
        vir_chnl_6.deq();
        return temp6;
    endmethod



endmodule

endpackage : ChainRouterVC
