package ButterflySwitchL2;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import ButterflyL2HeadRouterVC :: *;
import ButterflyL2RouterVC :: *;


interface IfcButterflySwitchL2;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left_up(Flit data_left);
    method Action put_value_from_left_down(Flit data_left);
    method Action put_value_from_right_up(Flit data_right);
    method Action put_value_from_right_down(Flit data_right);

    method ActionValue#(Flit) get_value_to_left_up();
    method ActionValue#(Flit) get_value_to_left_down();
    method ActionValue#(Flit) get_value_to_right_up();
    method ActionValue#(Flit) get_value_to_right_down();

endinterface


`define BUTTERFLY_MAX_BITS 4 // 8x8
`define BUTTERFLY_MAX_BITS_INDEX 3 // 8x8

(* synthesize *)

module mkButterflySwitchL2 #(parameter int my_addr, parameter int layer, parameter Bool left_ext, parameter Bool right_ext, parameter int max_bits_index) (IfcButterflySwitchL2);

    //Reg#(bit) lvl <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)

    int butterfly_MAX_BITS_INDEX = max_bits_index;
    let router_l2r_up       <- mkButterflyL2RouterL2R(my_addr, butterfly_MAX_BITS_INDEX-1-layer, right_ext);
    let router_l2r_down     <- mkButterflyL2RouterL2R(my_addr, butterfly_MAX_BITS_INDEX-1-layer, right_ext);
    let router_r2l_up       <- mkButterflyL2RouterL2R(my_addr, butterfly_MAX_BITS_INDEX-1-layer, left_ext);
    let router_r2l_down     <- mkButterflyL2RouterL2R(my_addr, butterfly_MAX_BITS_INDEX-1-layer, left_ext);
    
    Reg#(Bit#(1)) counter_even_odd      <- mkReg(0);
    Reg#(Bit#(1)) counter_up_down       <- mkReg(0);

    // This counter_even_odd is used by arbiters to choose VC to send out data
    rule count_even_odd;
        counter_even_odd <= counter_even_odd + 1;
    endrule

    rule count_up_down(counter_even_odd==1'b0);
        counter_up_down <= counter_up_down + 1;
    endrule

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left_up     <- mkFIFO;
    FIFO#(Flit) output_link_left_down   <- mkFIFO;

    FIFO#(Flit) output_link_right_up    <- mkFIFO;
    FIFO#(Flit) output_link_right_down  <- mkFIFO;


    //A counter to help deciding when to display link utilisation
    Reg#(LinkUtiliPrInterval) link_util_print_interval <- mkReg(0); 
    rule incr_link_util_print_interval;
        link_util_print_interval <= link_util_print_interval+1;
    endrule
    rule print_link_utilisation(link_util_print_interval==0);
        let rl=router_l2r_up.get_link_util_counter();
        let rr=router_l2r_down.get_link_util_counter();
        let ru=router_r2l_up.get_link_util_counter();
        let rd=router_r2l_down.get_link_util_counter();
        $display("@@@@@@@@@@@@@@@ Link utilisation at Node:%h,%h | : L2R_Up->%d, L2R_Down->%d, R2L_Down->%d, R2L_down->%d",my_addr.netAddress,my_addr.nodeAddress,rl,rr,ru,rd);
    endrule

    // We know that l2r router will send only to right output links
    rule l2r_up2up_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_up.get_valueVC2();
        output_link_right_up.enq(data);
    endrule
    rule l2r_down2up_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_down.get_valueVC2();
        output_link_right_up.enq(data);
    endrule
    rule l2r_up2down_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_up.get_valueVC4();
        output_link_right_down.enq(data);
    endrule
    rule l2r_down2down_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_down.get_valueVC4();
        output_link_right_down.enq(data);
    endrule


    // Similarly, r2l routers will send only to left output links
    rule l2r_up2up_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_up.get_valueVC1();
        output_link_right_up.enq(data);
    endrule
    rule l2r_down2up_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_down.get_valueVC1();
        output_link_right_up.enq(data);
    endrule
    rule l2r_up2down_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_up.get_valueVC3();
        output_link_right_down.enq(data);
    endrule
    rule l2r_down2down_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_l2r_down.get_valueVC3();
        output_link_right_down.enq(data);
    endrule


    // OUTPUT LINK LEFT
    rule r2l_up2up_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_up.get_valueVC2();
        output_link_left_up.enq(data);
    endrule
    rule r2l_down2up_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_down.get_valueVC2();
        output_link_left_up.enq(data);
    endrule
    rule r2l_up2down_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_up.get_valueVC4();
        output_link_left_down.enq(data);
    endrule
    rule r2l_down2down_connect_even(counter_even_odd == 1'b0 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_down.get_valueVC4();
        output_link_left_down.enq(data);
    endrule


    // Similarly, r2l routers will send only to left output links
    rule r2l_up2up_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_up.get_valueVC1();
        output_link_left_up.enq(data);
    endrule
    rule r2l_down2up_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit up (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_down.get_valueVC1();
        output_link_left_up.enq(data);
    endrule
    rule r2l_up2down_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b0);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_up.get_valueVC3();
        output_link_left_down.enq(data);
    endrule
    rule r2l_down2down_connect_odd(counter_even_odd == 1'b1 && counter_up_down==1'b1);
        $display("EVEN Butterfly Switch passes flit down (my_addr %d)", my_addr); 
        Flit data = defaultValue;
        data <- router_r2l_down.get_valueVC3();
        output_link_left_down.enq(data);
    endrule



    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
    method ActionValue#(Flit) get_value_to_left_up();
        let data_to_left = output_link_left_up.first();
        output_link_left_up.deq();
        return data_to_left;
    endmethod
    
    method ActionValue#(Flit) get_value_to_left_down();
        let data_to_left = output_link_left_down.first();
        output_link_left_down.deq();
        return data_to_left;
    endmethod


    // Method to take the flit from OUTPUT_LINK_RIGHT and return 
    method ActionValue#(Flit) get_value_to_right_up();
        let data_to_right = output_link_right_up.first();
        output_link_right_up.deq();
        return data_to_right;
    endmethod
    // Method to take the flit from OUTPUT_LINK_RIGHT and return 
    method ActionValue#(Flit) get_value_to_right_down();
        let data_to_right = output_link_right_down.first();
        output_link_right_down.deq();
        return data_to_right;
    endmethod


      // Methods to take care of input links 
    // (ie) the flits that come from left neighbour are inserted to the router_left's input link buffer
    method Action put_value_from_left_up(Flit data_left);
        router_l2r_up.put_value(data_left);
    endmethod

    method Action put_value_from_left_down(Flit data_left);
        router_l2r_down.put_value(data_left);
    endmethod

    // The flits that come from right neighbour are inserted to the router_right's input link buffer
    method Action put_value_from_right_up(Flit data_right);
        router_r2l_up.put_value(data_right);
    endmethod

    method Action put_value_from_right_down(Flit data_right);
        router_r2l_down.put_value(data_right);
    endmethod

  
endmodule

endpackage: ButterflySwitchL2
