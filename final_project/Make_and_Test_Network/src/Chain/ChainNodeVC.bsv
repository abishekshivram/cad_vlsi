/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: Represents a node in a chain based network
Last updated on: 09-Dec-2021
**************************************************************************************/

package ChainNodeVC;

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;
import ChainRouterVC :: *;

// Interface exposed by the Chain Node
// This interface is used by the NoC to build interconnection between nodes
interface IfcChainNode;
    
    // Methods to put flits to the input link buffer of the router. 
    // Each input link has one associated router. Core of the node too has an associated router.
    // Flits that come from left neighbour are inserted to the node's router_left's input link buffer
    // and flits that come from right neighbour are inserted to the node's router_rights's input link buffer
    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);

    // Get Value is used to read the value from the router
    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();

endinterface


// Module to implement the chain node.
// This module mainly inplements the rules implementing the round robin arbiter for the output link VCs
// Accepts two parameters - source address and current destination to be used in flit and for flit routing 
(* synthesize *)
module mkChainNode #(parameter Address my_addr, parameter Address head_node_addr) (IfcChainNode);

    // Core and three routers - core, left link, right link instantiation
    let core            <- mkCore(my_addr, head_node_addr); 
    let router_left     <- mkChainRouterVC(my_addr); // takes input from left neighbour and puts in corresponding VC
    let router_right    <- mkChainRouterVC(my_addr);
    let router_core     <- mkChainRouterVC(my_addr);


    // FIFOs to store the flits from VCs to be moved to the output links present in the node.
    FIFO#(Flit) output_link_left <- mkFIFO;
    FIFO#(Flit) output_link_right <- mkFIFO;

    // This counter is used by arbiters to choose VC to send out data
    // This counter helps to fire different arbiter rules in a round robin fashion 
    Reg#(Bit#(2)) counter   <- mkReg(0);
    rule count_every_cycle;
        counter <= counter + 1;
    endrule

    // Rule to move the valid flit generated by the core to the core-router
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True)
            router_core.put_value(flit_generated);
    endrule


    //A counter to help deciding when to display link utilisation
    // This is a clock interval for printing the link utilisation
    Reg#(LinkUtiliPrInterval) link_util_print_interval <- mkReg(0); 
    rule incr_link_util_print_interval;
        link_util_print_interval <= link_util_print_interval+1;
    endrule

    // This rule prints the link utilisation of the link associated with this node 
    // when the LinkUtiliPrInterval counter is reset
    rule print_link_utilisation(link_util_print_interval==0);
        let rl=router_left.get_link_util_counter();
        let rr=router_right.get_link_util_counter();
        $display("@@@@@@@@@@@@@@@ Link utilisation at Node:%h,%h | : Left Link->%d, Right Link->%d",my_addr.netAddress,my_addr.nodeAddress,rl,rr);
    endrule
    
    
    // These four rules are used to move data from router left and router rights VCs (VC1 & VC2) to the core router
    // VC1 and VC2 are used to send data to the core 
    // In this rule, we choose VC1 or VC2 from router_left or router_right in a round robin fashion (implemented through 2 bit counter) 
    rule outputLinkCore0(counter == 2'b00);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC1();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore1(counter == 2'b01);
        $display("here flit is put into core from router_right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore2(counter == 2'b10);
        $display("here flit is put into core from router_left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore3(counter == 2'b11);
        $display("here flit is put into core from router_right vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC2();
        core.put_flit(data_core);
    endrule



    // These four rules are used to move data from router left and router core's VCs (VC5 & VC6) to the right output link
    // VC5 and VC6 are used to send data to the right output link
    // In this rule, we choose VC5 or VC6 from router_left or router_core in a round robin fashion (implemented through 2 bit counter) 
    rule add_to_link_right0(counter == 2'b00);
        $display("add_to_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right1(counter == 2'b01);
        $display("add_to_link_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right2(counter == 2'b10);
        $display("add_to_link_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right3(counter == 2'b11);
        $display("add_to_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule


    // These four rules are used to move data from router right and router core's VCs (VC3 & VC4) to the left output link
    // VC3 and VC4 are used to send data to the left output link
    // In this rule, we choose VC3 or VC4 from router_right or router_core in a round robin fashion (implemented through 2 bit counter) 
    rule add_to_link_left0(counter == 2'b00);
        $display("add_to_link_left0 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left1(counter == 2'b01);
        $display("add_to_link_left1 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left2(counter == 2'b10);
        $display("add_to_link_left2 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left3(counter == 2'b11);
        $display("add_to_link_left3 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC4();
        output_link_left.enq(data_left);
    endrule



    // Methods to get the flit from output link and return
    // These methods are invoked by the NoC module to make connections between nodes

    // Method to take the flit from left output link and return 
    method ActionValue#(Flit) get_value_to_left();
        let data_to_left = output_link_left.first();
        output_link_left.deq();
        return data_to_left;
    endmethod

    // Method to take the flit from right output link and return 
    method ActionValue#(Flit) get_value_to_right();
        let data_to_right = output_link_right.first();
        output_link_right.deq();
        return data_to_right;
    endmethod


    // Methods to put flits to the input link buffer of the router. 
    // Each input link has one associated router. Core of the node too has an associated router.

    // The flits that come from left neighbour are inserted to the node's router_left's input link buffer
    method Action put_value_from_left(Flit data_left);
        router_left.put_value(data_left);
    endmethod

    // The flits that come from right neighbour are inserted to the router_right's input link buffer
    method Action put_value_from_right(Flit data_right);
        router_right.put_value(data_right);
    endmethod


endmodule

endpackage: ChainNodeVC
