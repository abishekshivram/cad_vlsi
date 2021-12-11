package HypercubeL1Node3VC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import HypercubeRouterL1VC :: *;


interface IfcHypercubeL1Node;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router

    method Action put_value_from_l2(Flit data_l2);

    method Action put_value_from_lsb(Flit data_lsb);
    method Action put_value_from_mid(Flit data_mid);
    method Action put_value_from_msb(Flit data_msb);
            
    method ActionValue#(Flit) get_value_to_l2();

    method ActionValue#(Flit) get_value_to_lsb();
    method ActionValue#(Flit) get_value_to_mid();
    method ActionValue#(Flit) get_value_to_msb();

endinterface


(* synthesize *)

module mkHypercubeL1Node3VC #(parameter Address my_addr) (IfcHypercubeL1Node);

    let router_l2   <- mkHypercubeRouterL1VC(my_addr);

    let router_lsb  <- mkHypercubeRouterL1VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL1VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL1VC(my_addr);


    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    FIFO#(Flit) output_link_l2      <- mkFIFO;


    
    // FROM VC TO CORE
    rule outputLinkl2_30(counter_router==2'b00);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC4();
        output_link_l2.enq(data_core);
    endrule
    rule outputLinkl2_31(counter_router==2'b01);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC4();
        output_link_l2.enq(data_core);
    endrule
    rule outputLinkl2_32(counter_router==2'b10);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC4();
        output_link_l2.enq(data_core);
    endrule




    

    
    Reg#(Bit#(2)) counter_lsb       <- mkReg(0);
    // This counter_lsb is used by arbiters to choose VC to send out data
    rule count_lsb;
        if(counter_router == 2'b11) begin
            counter_lsb <= counter_lsb + 2;
        end
        else begin
            counter_lsb <= counter_lsb + 1;
        end
    endrule

    Reg#(Bit#(1)) counter_mid  <- mkReg(0);
    // This counter_lsb is used by arbiters to choose VC to send out data
    rule count_mid;
        if(counter_router == 2'b11) begin
            counter_mid <= counter_mid;
        end
        else begin
            counter_mid <= counter_mid + 1;
        end
    endrule



    rule send_from_vc1_ie_to_lsbl23 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_l2.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midl23 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_l2.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbl23 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_l2.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbl23 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_l2.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midl23 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_l2.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbl23 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_l2.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_msbl23 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_l2.get_valueVC8();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsblsb3 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midlsb3 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsblsb3 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsblsb3 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midlsb3 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsblsb3 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_msblsb3 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmid3 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midmid3 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmid3 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmid3 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midmid3 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmid3 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_msbmid3 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmsb3 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midmsb3 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmsb3 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmsb3 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midmsb3 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmsb3 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_msbmsb3 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_msb.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
    
    method ActionValue#(Flit) get_value_to_l2();
        let data_to_l2 = output_link_l2.first();
        output_link_l2.deq();
        return data_to_l2;
    endmethod
    method ActionValue#(Flit) get_value_to_lsb();
        let data_to_lsb = output_link_lsb.first();
        output_link_lsb.deq();
        return data_to_lsb;
    endmethod
     method ActionValue#(Flit) get_value_to_mid();
        let data_to_mid = output_link_mid.first();
        output_link_mid.deq();
        return data_to_mid;
    endmethod
     method ActionValue#(Flit) get_value_to_msb();
        let data_to_msb = output_link_msb.first();
        output_link_msb.deq();
        return data_to_msb;
    endmethod


    // Methods to take care of input links 
    // (ie) the flits that come from left neighbour are inserted to the router_left's input link buffer
    
    method Action put_value_from_l2(Flit data_l2);
        router_l2.put_value(data_l2);
    endmethod

    method Action put_value_from_lsb(Flit data_lsb);
        router_lsb.put_value(data_lsb);
    endmethod

    method Action put_value_from_mid(Flit data_mid);
        router_mid.put_value(data_mid);
    endmethod

    method Action put_value_from_msb(Flit data_msb);
        router_msb.put_value(data_msb);
    endmethod


endmodule

endpackage: HypercubeNode3VC
