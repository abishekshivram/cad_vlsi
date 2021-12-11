/* Butterfly switch has two (duplex) links at left side, two (duplex) links at right side
Total of 8 VC exists
VC1, VC2 is for left up
VC3, VC4 is for left down
VC5, VC6 is for right up
VC7, VC8 is for right down
*/

package ButterflyL2RouterVC;


import Shared :: * ;

// FIFO used as buffers in routers
import FIFO :: * ;
import FIFOF :: * ;



interface IfcButterflyL2Router ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the corresponding VC
    method Action put_value (Flit flit); // sent into input link

    method ActionValue#(Flit) get_valueVC1();
    method ActionValue#(Flit) get_valueVC2();
    method ActionValue#(Flit) get_valueVC3();
    method ActionValue#(Flit) get_valueVC4();
    
endinterface



(* synthesize *)
// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkButterflyL2RouterL2R #(parameter int my_addr, parameter int index_to_check, parameter Bool right_ext) (IfcButterflyL2Router);

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
    //Reg#(UInt#(3)) layer <- mkReg(layer);
    
    // Input link for the router
    FIFO#(Flit)  input_link  <- mkFIFO; // to get data from left router
    
    // To store the flits that are sent to left up
    FIFO#(Flit)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(Flit)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2
    
    // To store the flits that are sent to left down
    FIFO#(Flit)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(Flit)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    
    // Since we have two VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);
    rule invert_cycle;
        cycle <= cycle + 1;     // Cycle variable oscillates between 0 and 1
    endrule

    // Connect input_link to respective VC
    // This rules fires every alternate cycle, and chooses even named Virtual Channels (VC1, VC3, VC5)
    rule read_input_link_and_send_to_VC_odd(cycle == 1 && !right_ext);

        let flit = input_link.first();
        input_link.deq();

        // Reached the destination - core will consume
        if(pack(flit.currentDstAddress.nodeAddress)[index_to_check] == pack(flit.srcAddress.nodeAddress)[index_to_check])  begin
            $display("Odd cycle: vir_chnl_1.enq at addr:%h", my_addr);
            vir_chnl_1.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_3.enq at addr:%h", my_addr);
            vir_chnl_3.enq(flit);
        end
    endrule

    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC2, VC4, VC6)
    rule read_input_link_and_send_to_VC_even(cycle == 0 && !right_ext);
        //NOTE This logic would need change when L1 is introduced
        //NOTE network address is not considered now
        let flit = input_link.first();
        input_link.deq();

        if(pack(flit.currentDstAddress.nodeAddress)[index_to_check] == pack(flit.srcAddress.nodeAddress)[index_to_check])  begin
            $display("Odd cycle: vir_chnl_2.enq at addr:%h", my_addr);
            vir_chnl_2.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_4.enq at addr:%h", my_addr);
            vir_chnl_4.enq(flit);
        end
    endrule

    rule read_input_link_and_send_to_VC_odd0(cycle == 1 && right_ext);

        let flit = input_link.first();
        input_link.deq();

        // Reached the destination - core will consume
        if(pack(flit.currentDstAddress.nodeAddress)[index_to_check] == 0)  begin
            $display("Odd cycle: vir_chnl_1.enq at addr:%h", my_addr);
            vir_chnl_1.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_3.enq at addr:%h", my_addr);
            vir_chnl_3.enq(flit);
        end
    endrule

    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC2, VC4, VC6)
    rule read_input_link_and_send_to_VC_even0(cycle == 0 && right_ext);
        //NOTE This logic would need change when L1 is introduced
        //NOTE network address is not considered now
        let flit = input_link.first();
        input_link.deq();

        if(pack(flit.currentDstAddress.nodeAddress)[index_to_check] == 0)  begin
            $display("Odd cycle: vir_chnl_2.enq at addr:%h", my_addr);
            vir_chnl_2.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_4.enq at addr:%h", my_addr);
            vir_chnl_4.enq(flit);
        end
    endrule

    // Method to get the flit into the node
    method Action put_value(Flit flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link.enq(flit);
        print_flit_details(flit);
        $display("Butterfly Router (Addr: %h, INDEX_TOCHECK:%h) received the flit into Input Link", my_addr, index_to_check);
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

    // method ActionValue#(Flit) get_valueVC5();
    //     $display("get_valueVC5 called at Router (Addr: %h)", my_addr);
    //     let temp5 = vir_chnl_5.first();
    //     vir_chnl_5.deq();
    //     return temp5;
    // endmethod

    // method ActionValue#(Flit) get_valueVC6();
    //     $display("get_valueVC6 called at Router (Addr: %h)", my_addr);
    //     let temp6 = vir_chnl_6.first();
    //     vir_chnl_6.deq();
    //     return temp6;
    // endmethod

endmodule: mkButterflyL2RouterL2R

(* synthesize *)
// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkButterflyL2RouterR2L #(parameter int my_addr, parameter int index_to_check, parameter Bool left_ext) (IfcButterflyL2Router);

    function Action print_flit_details(Flit flit_to_print);
        return action
            $display("\nPrinting Flit details:");
            $display("Flit Source      address: NetworkID: %h | NodeID: %h", flit_to_print.srcAddress.netAddress, flit_to_print.srcAddress.nodeAddress);
            $display("Flit Destination address: NetworkID: %h | NodeID: %h", flit_to_print.finalDstAddress.netAddress, flit_to_print.finalDstAddress.nodeAddress);
            $display("Flit Current Dst address: NetworkID: %h | NodeID: %h\n", flit_to_print.currentDstAddress.netAddress, flit_to_print.currentDstAddress.nodeAddress);
        endaction;
    endfunction
    int index_to_check_updated = index_to_check + 1;
    // Right now, it has been commented, we may need it for L1, L2 routing
    //Reg#(bit)   level       <- mkReg(0); // 0 for low level (L2), 1 for high level (L1)
    //Reg#(UInt#(3)) layer <- mkReg(layer);
    
    // Input link for the router
    FIFO#(Flit)  input_link  <- mkFIFO; // to get data from left router
    
    // To store the flits that are sent to left up
    FIFO#(Flit)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(Flit)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2
    
    // To store the flits that are sent to left down
    FIFO#(Flit)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(Flit)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    
    // Since we have two VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);
    rule invert_cycle;
        cycle <= cycle + 1;     // Cycle variable oscillates between 0 and 1
    endrule

    // Connect input_link to respective VC
    // This rules fires every alternate cycle, and chooses even named Virtual Channels (VC1, VC3, VC5)
    rule read_input_link_and_send_to_VC_odd(cycle == 1 && !left_ext);

        let flit = input_link.first();
        input_link.deq();

        // Reached the destination - core will consume
        if(pack(flit.currentDstAddress.nodeAddress)[index_to_check_updated] == pack(flit.srcAddress.nodeAddress)[index_to_check_updated])  begin
            $display("Odd cycle: vir_chnl_1.enq at addr:%h", my_addr);
            vir_chnl_1.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_3.enq at addr:%h", my_addr);
            vir_chnl_3.enq(flit);
        end
    endrule

    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC2, VC4, VC6)
    rule read_input_link_and_send_to_VC_even(cycle == 0 && !left_ext);
        //NOTE This logic would need change when L1 is introduced
        //NOTE network address is not considered now
        let flit = input_link.first();
        input_link.deq();

        if(pack(flit.currentDstAddress.nodeAddress)[index_to_check_updated] == pack(flit.srcAddress.nodeAddress)[index_to_check_updated])  begin
            $display("Odd cycle: vir_chnl_2.enq at addr:%h", my_addr);
            vir_chnl_2.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_4.enq at addr:%h", my_addr);
            vir_chnl_4.enq(flit);
        end
    endrule

    rule read_input_link_and_send_to_VC_odd0(cycle == 1 && left_ext);

        let flit = input_link.first();
        input_link.deq();

        // Reached the destination - core will consume
        if(pack(flit.currentDstAddress.nodeAddress)[0] == 0)  begin
            $display("Odd cycle: vir_chnl_1.enq at addr:%h", my_addr);
            vir_chnl_1.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_3.enq at addr:%h", my_addr);
            vir_chnl_3.enq(flit);
        end
    endrule

    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC2, VC4, VC6)
    rule read_input_link_and_send_to_VC_even0(cycle == 0 && left_ext);
        //NOTE This logic would need change when L1 is introduced
        //NOTE network address is not considered now
        let flit = input_link.first();
        input_link.deq();

        if(pack(flit.currentDstAddress.nodeAddress)[0] == 0)  begin
            $display("Odd cycle: vir_chnl_2.enq at addr:%h", my_addr);
            vir_chnl_2.enq(flit);
        end
        // The current flit has to go to left 
        else begin
            $display("Odd cycle: vir_chnl_4.enq at addr:%h", my_addr);
            vir_chnl_4.enq(flit);
        end
    endrule

    // Method to get the flit into the node
    method Action put_value(Flit flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link.enq(flit);
        print_flit_details(flit);
        $display("Butterfly Router (Addr: %h, INDEX_TOCHECK:%h) received the flit into Input Link (leftext? %b)", my_addr, index_to_check, pack(left_ext));
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

    // method ActionValue#(Flit) get_valueVC5();
    //     $display("get_valueVC5 called at Router (Addr: %h)", my_addr);
    //     let temp5 = vir_chnl_5.first();
    //     vir_chnl_5.deq();
    //     return temp5;
    // endmethod

    // method ActionValue#(Flit) get_valueVC6();
    //     $display("get_valueVC6 called at Router (Addr: %h)", my_addr);
    //     let temp6 = vir_chnl_6.first();
    //     vir_chnl_6.deq();
    //     return temp6;
    // endmethod

endmodule: mkButterflyL2RouterR2L




endpackage : ButterflyL2RouterVC