/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: Represents a router in a head node in a chain network
Last updated on: 09-Dec-2021
**************************************************************************************/

// This package contains the chain head node router - which implements the routing algorithm for the chain head node
// Routing algorithm works as follows:
// For each link, two VCs are allocated. For example, in head node of a chain topology, we have
// 4 links (core, left neighbour, right neighbour and link connecting node in L1 network). So 8 VCs are made. VC 1 & 2 are allocated to core, 
// VC 3 & 4 are allocated to left neighbour, VC 5 & 6 are allocated to right neighbour and VC 7 & 8 are allocated to L1 link. 
// Each input link the node has an associated router. When the routing rule is fired, each router reads the flit from its respective input link 
// and moves it to any of the VC associated with the respective output link (Core (1,2), left (3,4) , right (5,6), or L1 (7,8))
// The arbiter at the 'node' reads each VC in a round robin fashion and moves the flit to the output link.
// If the flit is destined to 'this' node, it will be moved from input link to core and the core would consume it.
// Flit transmission delay is calculated by the core.

package ChainRouterL2HeadVC;

import Shared::*;
import Parameters::*;
// FIFO used as buffers in routers
import FIFO :: * ;
import FIFOF :: * ;


// This interface is used by the chain head node router module. The methods can be used to put/get flit to/from the router.
interface IfcChainRouterL2HeadVC ;

    // Method to move the flit into the node.
    // Used to move data to the input link FIFO of the router.
    method Action put_value (Flit flit);

    // Get Value methods are used to read the value from the virtual channels (VC) of the router
    // Each output link gets two VC (for a chain head node we have: left, right, L1 and core output link), Hence we need 8 VCs
    // Each of the following methods will dequeue a flit from the VC and return it
    method ActionValue#(Flit) get_valueVC1();
    method ActionValue#(Flit) get_valueVC2();
    method ActionValue#(Flit) get_valueVC3();
    method ActionValue#(Flit) get_valueVC4();
    method ActionValue#(Flit) get_valueVC5();
    method ActionValue#(Flit) get_valueVC6();
    
    method ActionValue#(Flit) get_valueVC7();
    method ActionValue#(Flit) get_valueVC8();
    
    // A method to get the link utilisation count of the link (input) associated with this router.
    // Each link in the NoC is associated with a router in a node. So the utilisation of all the links in the NoC can be measured         
    method LinkUtilisationCounter get_link_util_counter();

endinterface

//This module implements the routing algorithm for the chain head node. There are two rules which get fired in alternate cycles (odd and even)
// This router moves the flit in left, right or L1  directions. 
(* synthesize *)
module mkChainRouterL2HeadVC #(parameter Address my_addr) (IfcChainRouterL2HeadVC);

    //A function to print the flit details
    function Action print_flit_details(Flit flit_to_print);
        return action
            $display("\nPrinting Flit details:");
            $display("Flit Source      address: NetworkID: %h | NodeID: %h", flit_to_print.srcAddress.netAddress, flit_to_print.srcAddress.nodeAddress);
            $display("Flit Destination address: NetworkID: %h | NodeID: %h", flit_to_print.finalDstAddress.netAddress, flit_to_print.finalDstAddress.nodeAddress);
            $display("Flit Current Dst address: NetworkID: %h | NodeID: %h\n", flit_to_print.currentDstAddress.netAddress, flit_to_print.currentDstAddress.nodeAddress);
        endaction;
    endfunction

    
    // FIFOs used to store the flits from input link and to represet each VCs associated with the router

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

    // To store the flits that are sent to L1
    FIFO#(Flit)  vir_chnl_7  <- mkFIFO; // Virtual Channel 7
    FIFO#(Flit)  vir_chnl_8  <- mkFIFO; // Virtual Channel 8

    // A couter which helps to fire the odd and even routing rules alternatively
    // Since we have two VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);
    rule invert_cycle;
        cycle <= cycle + 1;     // Cycle variable oscillates between 0 and 1
    endrule

    // A register to store the link utilisation calculated for the input link associated with this router.
    // Each link in the NoC is associated with a router in a node. So the utilisation of all the links in the NoC can be measured     
    Reg#(LinkUtilisationCounter) link_util_counter  <- mkReg(0);


    // Implementation of the routing algorithm. Connects the input_link to respective odd numbered VC
    // This rules fires every alternate cycle (odd cycles), and chooses odd named Virtual Channel (VC1, VC3, VC5) associated with the output link    
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

    // Implementation of the routing algorithm. Connects the input_link to respective even numbered VC
    // This rules fires every alternate cycle (even cycles), and chooses the even named Virtual Channel (VC2, VC4, VC6) associated with the output link    
    rule read_input_link_and_send_to_VC_even(cycle == 0);

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


    // Method to move the flit into the node.
    // Used to move data to the input link FIFO of the router.
    // Increments the link utilisation counter    
    method Action put_value(Flit flit);
        // Data that comes from left/right/core/L1 link is put into the input link buffer
        input_link.enq(flit);
        print_flit_details(flit);
        $display("Core router (Addr: %h) received the flit into Input Link", my_addr);
        link_util_counter <= link_util_counter+1;
    endmethod


    // Get Value methods are used to read the value from the virtual channels (VC) of the router
    // Each output link gets two VC (for a chain head node we have: left, right, L1 and core output link), Hence we need 8 VCs
    // Each of the following eight methods will dequeue a flit from the VC and return it
    // The flit returned by this method is moved to the next node in the destinations path
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

    // A method to get the current value in the link utilisation couter
    method LinkUtilisationCounter get_link_util_counter();
        return link_util_counter;
    endmethod

endmodule: mkChainRouterL2HeadVC

endpackage : ChainRouterL2HeadVC
