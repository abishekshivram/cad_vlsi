package ChainRouterL2HeadVC;
// This package contains the router - which implements the routing algorithm for the chain topology
// Routing algorithm works as follows:
// For each link, two VCs are allocated. For example, in each node in chain topology, we have
// 3 links (core, left neighbour, right neighbour). So 6 VCs are made and VC1,2 allocated to core, 
// VC3,4 allocated to left neighbour, VC5,6 allocated to right neighbour
// This routing can be seen in line 58: Two rules are written that connects the Input link to the respective VC

import Shared::*;
import Parameters::*;
// FIFO used as buffers in routers
import FIFO :: * ;
import FIFOF :: * ;



interface IfcChainRouterL2HeadVC ;
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
    method ActionValue#(Flit) get_valueVC6();
    
    method ActionValue#(Flit) get_valueVC7();
    method ActionValue#(Flit) get_valueVC8();
    
    method LinkUtilisationCounter get_link_util_counter();

endinterface


(* synthesize *)

// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkChainRouterL2HeadVC #(parameter Address my_addr) (IfcChainRouterL2HeadVC);

    function Action print_flit_details(Flit flit_to_print);
        return action
            $display("\nPrinting Flit details:");
            $display("Flit Source      address: NetworkID: %h | NodeID: %h", flit_to_print.srcAddress.netAddress, flit_to_print.srcAddress.nodeAddress);
            $display("Flit Destination address: NetworkID: %h | NodeID: %h", flit_to_print.finalDstAddress.netAddress, flit_to_print.finalDstAddress.nodeAddress);
            $display("Flit Current Dst address: NetworkID: %h | NodeID: %h\n", flit_to_print.currentDstAddress.netAddress, flit_to_print.currentDstAddress.nodeAddress);
        endaction;
    endfunction

    // Right now, it has been commented, we may need it for L1, L2 routing
    //Reg#(bit)   level       <- mkReg(0); // 0 for low level (L2), 1 for high level (L1)
    
    // Input link for the router
    FIFO#(Flit)  input_link  <- mkFIFO; // to get data from left router
    
    // To store the flits that are sent to core
    FIFO#(Flit)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(Flit)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2
    
    // To store the flits that are sent to left
    FIFO#(Flit)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(Flit)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    
    // To store the flits that are sent to right
    FIFO#(Flit)  vir_chnl_5  <- mkFIFO; // Virtual Channel 5
    FIFO#(Flit)  vir_chnl_6  <- mkFIFO; // Virtual Channel 6

    // TO L1
    FIFO#(Flit)  vir_chnl_7  <- mkFIFO; // Virtual Channel 7
    FIFO#(Flit)  vir_chnl_8  <- mkFIFO; // Virtual Channel 8

    // Since we have two VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);
    rule invert_cycle;
        cycle <= cycle + 1;     // Cycle variable oscillates between 0 and 1
    endrule

    Reg#(LinkUtilisationCounter) link_util_counter  <- mkReg(0);

    // Connect input_link to respective VC
    // This rules fires every alternate cycle, and chooses even named Virtual Channels (VC1, VC3, VC5)
    rule read_input_link_and_send_to_VC_odd(cycle == 1);

        let flit = input_link.first();
        input_link.deq();

        // Reached the destination - core will consume
        if(flit.finalDstAddress.netAddress != my_addr.netAddress) begin
            $display("Odd cycle: GOING TO L1 from L2 at addr:%h", my_addr.nodeAddress);
            vir_chnl_7.enq(flit);
        end
        else if(flit.currentDstAddress.nodeAddress == my_addr.nodeAddress)  begin
            $display("Odd cycle: vir_chnl_1.enq at addr:%h", my_addr);
            vir_chnl_1.enq(flit);
        end
        // The current flit has to go to left 
        else if(flit.currentDstAddress.nodeAddress < my_addr.nodeAddress)  begin
            $display("Odd cycle: vir_chnl_3.enq at addr:%h", my_addr);
            vir_chnl_3.enq(flit);
        end
        // The current flit has to go to right
        else  begin
            $display("Odd cycle: vir_chnl_5.enq at addr:%h", my_addr);
            vir_chnl_5.enq(flit);
        end
    endrule

    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC2, VC4, VC6)
    rule read_input_link_and_send_to_VC_even(cycle == 0);
        //NOTE This logic would need change when L1 is introduced
        //NOTE network address is not considered now
        let flit = input_link.first();
        input_link.deq();
            
        if(flit.finalDstAddress.netAddress != my_addr.netAddress) begin
            $display("Even cycle: GOING TO L1 from L2 at addr:%h", my_addr.nodeAddress);
            vir_chnl_8.enq(flit);
        end
        // Reached the destination - core will consume
        else if(flit.currentDstAddress.nodeAddress == my_addr.nodeAddress)  begin
            $display("Even cycle: vir_chnl_2.enq at addr:%h", my_addr);
            vir_chnl_2.enq(flit);
        end
        // The current flit has to go to left 
        else if(flit.currentDstAddress.nodeAddress < my_addr.nodeAddress)  begin
            $display("Even cycle: vir_chnl_4.enq at addr:%h", my_addr);
            vir_chnl_4.enq(flit);
        end
        // The current flit has to go to right
        else  begin
            $display("Even cycle: vir_chnl_6.enq at addr:%h", my_addr);
            vir_chnl_6.enq(flit);
        end
    endrule

    // Method to get the flit into the node
    method Action put_value(Flit flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link.enq(flit);
        print_flit_details(flit);
        $display("Core router (Addr: %h) received the flit into Input Link", my_addr);
        link_util_counter <= link_util_counter+1;
    endmethod


    // Following are the six methods (corresponding to six available VCs) 
    // These methods return the flit so that it can reach the next node in its path
    // The VC1, VC2 methods will be invoked to send the flits to the core (as we fixed earlier, line:4)
    method ActionValue#(Flit) get_valueVC1();
        $display("get_valueVC1 called at Router (Addr: %h)", my_addr);
         let temp1 = vir_chnl_1.first();
         vir_chnl_1.deq();
        return temp1;
    endmethod

    method ActionValue#(Flit) get_valueVC2();
        $display("get_valueVC2 called at Router (Addr: %h)", my_addr);
         let temp2 = vir_chnl_2.first();
         vir_chnl_2.deq();
        return  temp2;
    endmethod

    method ActionValue#(Flit) get_valueVC3();
        $display("get_valueVC3 called at Router (Addr: %h)", my_addr);
        let temp3 = vir_chnl_3.first();
        vir_chnl_3.deq();
        return temp3;
    endmethod

    method ActionValue#(Flit) get_valueVC4();
        $display("get_valueVC4 called at Router (Addr: %h)", my_addr);
        let temp4 = vir_chnl_4.first();
        vir_chnl_4.deq();
        return temp4;
    endmethod

    method ActionValue#(Flit) get_valueVC5();
        $display("get_valueVC5 called at Router (Addr: %h)", my_addr);
        let temp5 = vir_chnl_5.first();
        vir_chnl_5.deq();
        return temp5;
    endmethod

    method ActionValue#(Flit) get_valueVC6();
        $display("get_valueVC6 called at Router (Addr: %h)", my_addr);
        let temp6 = vir_chnl_6.first();
        vir_chnl_6.deq();
        return temp6;
    endmethod

    method ActionValue#(Flit) get_valueVC7();
        $display("get_valueVC5 called at Router (Addr: %h)", my_addr);
        let temp7 = vir_chnl_7.first();
        vir_chnl_7.deq();
        return temp7;
    endmethod

    method ActionValue#(Flit) get_valueVC8();
        $display("get_valueVC6 called at Router (Addr: %h)", my_addr);
        let temp8 = vir_chnl_8.first();
        vir_chnl_8.deq();
        return temp8;
    endmethod


    method LinkUtilisationCounter get_link_util_counter();
        return link_util_counter;
    endmethod

endmodule: mkChainRouterL2HeadVC

endpackage : ChainRouterL2HeadVC
