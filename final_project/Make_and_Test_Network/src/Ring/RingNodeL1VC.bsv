package RingNodeL1VC;

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;
import RingRouterL1VC :: *;


interface IfcRingL1Node;

    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);

    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();

    method Action put_value_from_left_dateline(Flit data_left);
    method Action put_value_from_right_dateline(Flit data_right);

    method ActionValue#(Flit) get_value_to_left_dateline();
    method ActionValue#(Flit) get_value_to_right_dateline();
    
    method Action put_value_from_l2(Flit data_l2);
    method ActionValue#(Flit) get_value_to_l2();

endinterface


(* synthesize *)

module mkRingL1Node #(parameter Address my_addr, parameter NetAddress maxNetAddress) (IfcRingL1Node);

    // Reg#(bit) lvl <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)

    // Core and three routers - core, left link, right link instantiation
    let router_left     <- mkRingRouterL1VC(my_addr, maxNetAddress); // takes input from left neighbour and puts in corresponding VC
    let router_right    <- mkRingRouterL1VC(my_addr, maxNetAddress);
    let router_l2       <- mkRingRouterL1VC(my_addr, maxNetAddress);

    Reg#(Bit#(2)) counter   <- mkReg(0);

    // This counter is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter <= counter + 1;
    endrule

    
    // VC1 and VC2 are used to send data to the core (as decided earlier)
    // Rule - Output link - connecting to associated core
    // In this rule, we choose VC1 or VC2 from router_left or router_right (router_l2 cannot send to itself)
    // in a round robin fashion (implemented through 2 bit counter) (2 bit because we have 4 VCs to choose from)
    FIFO#(Flit) output_link_l2 <- mkFIFO;

    rule outputLinkl20(counter == 2'b00);
        $display("here flit is put into router_l2 from router left vc1; Arbiter count-%d", counter);      
        Flit data_l2=defaultValue;
        data_l2 <- router_left.get_valueVC1();
        output_link_l2.enq(data_l2);
    endrule

    rule outputLinkl21(counter == 2'b01);
        $display("here flit is put into router_l2 from router_right vc1; Arbiter count-%d", counter);      
        Flit data_l2=defaultValue;
        data_l2 <- router_right.get_valueVC1();
        output_link_l2.enq(data_l2);
    endrule

    rule outputLinkl22(counter == 2'b10);
        $display("here flit is put into router_l2 from router_left vc2; Arbiter count-%d", counter);      
        Flit data_l2=defaultValue;
        data_l2 <- router_left.get_valueVC2();
        output_link_l2.enq(data_l2);
    endrule

    rule outputLinkl23(counter == 2'b11);
        $display("here flit is put into router_l2 from router_right vc2; Arbiter count-%d", counter);      
        Flit data_l2=defaultValue;
        data_l2 <- router_right.get_valueVC2();
        output_link_l2.enq(data_l2);
    endrule

    
    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left            <- mkFIFO;
    FIFO#(Flit) output_link_right           <- mkFIFO;
    FIFO#(Flit) output_link_left_dateline   <- mkFIFO;
    FIFO#(Flit) output_link_right_dateline  <- mkFIFO;

    rule add_to_link_right0(counter == 2'b00 || counter == 2'b10);
        $display("add_to_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_l2.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right1(counter == 2'b01 || counter == 2'b11);
        $display("add_to_link_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right2(counter == 2'b00 || counter == 2'b10);
        $display("add_to_link_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_right_dateline=defaultValue;
        data_right_dateline <- router_l2.get_valueVC6();
        output_link_right_dateline.enq(data_right_dateline);
    endrule


    rule add_to_link_right3(counter == 2'b01 || counter == 2'b11);
        $display("add_to_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right_dateline=defaultValue;
        data_right_dateline <- router_left.get_valueVC6();
        output_link_right_dateline.enq(data_right_dateline);
    endrule

    //NOTE LLOYD This can be improved
    //If chosen VC (counter) has no data, the cycle would be wasted, cannot consume data available in other VCs??
    // To send to left neighbour, we have to choose from available VC3s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT
    rule add_to_link_left0(counter == 2'b00 || counter == 2'b10);
        $display("add_to_link_left0 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left1(counter == 2'b01 || counter == 2'b11);
        $display("add_to_link_left1 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_l2.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left2(counter == 2'b00 || counter == 2'b10);
        $display("add_to_link_left2 -> my_addr %d",my_addr.netAddress);    
        Flit data_left_dateline=defaultValue;
        data_left_dateline <- router_right.get_valueVC4();
        output_link_left_dateline.enq(data_left_dateline);
    endrule


    rule add_to_link_left3(counter == 2'b01 || counter == 2'b11);
        $display("add_to_link_left3 -> my_addr %d",my_addr.netAddress);    
        Flit data_left_dateline=defaultValue;
        data_left_dateline <- router_l2.get_valueVC4();
        output_link_left_dateline.enq(data_left_dateline);
    endrule



    //NOTE LLOYD This can be improved
    //If chosen VC (counter) has no data, the cycle would be wasted, cannot consume data available in other VCs??
    // To send to right neighbour, we have to choose from available VC5s and VC6s
    // The chosen flit is added to the OUTPUT_LINK_RIGHT
    

    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
    method ActionValue#(Flit) get_value_to_left();
        let data_to_left = output_link_left.first();
        output_link_left.deq();
        return data_to_left;
    endmethod
    method ActionValue#(Flit) get_value_to_left_dateline();
        let data_to_left_dateline = output_link_left_dateline.first();
        output_link_left_dateline.deq();
        return data_to_left_dateline;
    endmethod

    method ActionValue#(Flit) get_value_to_l2();
        let data_to_l2 = output_link_l2.first();
        output_link_l2.deq();
        return data_to_l2;
    endmethod


    // Method to take the flit from OUTPUT_LINK_RIGHT and return 
    method ActionValue#(Flit) get_value_to_right();
        let data_to_right = output_link_right.first();
        output_link_right.deq();
        return data_to_right;
    endmethod
    method ActionValue#(Flit) get_value_to_right_dateline();
        let data_to_right_dateline = output_link_right_dateline.first();
        output_link_right_dateline.deq();
        return data_to_right_dateline;
    endmethod

      // Methods to take care of input links 
    // (ie) the flits that come from left neighbour are inserted to the router_left's input link buffer
    method Action put_value_from_left(Flit data_left);
        router_left.put_value(data_left);
    endmethod
    method Action put_value_from_left_dateline(Flit data_left);
        router_left.put_value_dateline(data_left);
    endmethod

    // The flits that come from right neighbour are inserted to the router_right's input link buffer
    method Action put_value_from_right(Flit data_right);
        router_right.put_value(data_right);
    endmethod
    method Action put_value_from_right_dateline(Flit data_right);
        router_right.put_value_dateline(data_right);
    endmethod


    method Action put_value_from_l2(Flit data_l2);
        router_l2.put_value(data_l2);
    endmethod  

endmodule

endpackage: RingNodeL1VC
