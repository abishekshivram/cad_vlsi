package HypercubeL2NodesVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;

import HypercubeRouterL2HeadVC :: *;
import HypercubeRouterL2VC :: *;


interface IfcHypercubeHeadNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router

    method Action put_value_from_l1(Flit data_l1);

    method Action put_value_from_lsb(Flit data_lsb);
    method Action put_value_from_mid(Flit data_mid);
    method Action put_value_from_msb(Flit data_msb);
            
    method ActionValue#(Flit) get_value_to_l1();

    method ActionValue#(Flit) get_value_to_lsb();
    method ActionValue#(Flit) get_value_to_mid();
    method ActionValue#(Flit) get_value_to_msb();

endinterface


interface IfcHypercubeNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_lsb(Flit data_lsb);
    method Action put_value_from_mid(Flit data_mid);
    method Action put_value_from_msb(Flit data_msb);
            
    method ActionValue#(Flit) get_value_to_lsb();
    method ActionValue#(Flit) get_value_to_mid();
    method ActionValue#(Flit) get_value_to_msb();

endinterface



// HEAD NODE OF HYPERCUBE NETWORK - NODE0
(* synthesize *)

module mkHypercubeNode0VC #(parameter Address my_addr) (IfcHypercubeHeadNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 

    let router_core <- mkHypercubeRouterL2HeadVC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2HeadVC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2HeadVC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2HeadVC(my_addr);
    let router_l1   <- mkHypercubeRouterL2HeadVC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore00(counter_router==2'b00);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC1();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore01(counter_router==2'b01);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC1();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore02(counter_router==2'b10);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC1();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore03(counter_router==2'b11);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_l1.get_valueVC1();
        core.put_flit(data_core);
    endrule



    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    FIFO#(Flit) output_link_l1      <- mkFIFO;
    
    
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
    

    rule send_from_core_to_l1 (counter_router==2'b00);
        Flit data;
        data <- router_core.get_valueVCl1();
        output_link_l1.enq(data);
    endrule
    rule send_from_lsb_to_l1 (counter_router==2'b01);
        Flit data;
        data <- router_lsb.get_valueVCl1();
        output_link_l1.enq(data);
    endrule
    rule send_from_mid_to_l1 (counter_router==2'b10);
        Flit data;
        data <- router_mid.get_valueVCl1();
        output_link_l1.enq(data);
    endrule
    rule send_from_msb_to_l1 (counter_router==2'b11);
        Flit data;
        data <- router_msb.get_valueVCl1();
        output_link_l1.enq(data);
    endrule




    rule send_from_vc2_ie_to_lsbcore0 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midcore0 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbcore0 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_msbcore0 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC5();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbcore0 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midcore0 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbcore0 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsblsb0 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midlsb0 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsblsb0 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_msblsb0 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsblsb0 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midlsb0 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsblsb0 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmid0 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midmid0 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmid0 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_msbmid0 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmid0 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midmid0 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmid0 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmsb0 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midmsb0 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmsb0 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_msbmsb0 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmsb0 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midmsb0 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmsb0 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
    method ActionValue#(Flit) get_value_to_l1();
        let data_to_l1 = output_link_l1.first();
        output_link_l1.deq();
        return data_to_l1;
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
    method Action put_value_from_l1(Flit data_l1);
        router_l1.put_value(data_l1);
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



(* synthesize *)

module mkHypercubeNode1VC #(parameter Address my_addr) (IfcHypercubeNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 
    let router_core <- mkHypercubeRouterL2VC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore10(counter_router==2'b00);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC2();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore11(counter_router==2'b01);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC2();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore12(counter_router==2'b10);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC2();
        core.put_flit(data_core);
    endrule





    // // // // // 
    //          //
    //          //
    //    HI    //
    //          //
    //          //
    // // // // //

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    
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



    rule send_from_vc1_ie_to_lsbcore1 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbcore1 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midcore1 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbcore1 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_msbcore1 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC6();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbcore1 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midcore1 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC8();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsblsb1 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsblsb1 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midlsb1 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsblsb1 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_msblsb1 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsblsb1 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midlsb1 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmid1 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmid1 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midmid1 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmid1 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_msbmid1 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmid1 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midmid1 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmsb1 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmsb1 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midmsb1 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmsb1 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_msbmsb1 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmsb1 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midmsb1 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_mid.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
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



(* synthesize *)

module mkHypercubeNode2VC #(parameter Address my_addr) (IfcHypercubeNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 
    let router_core <- mkHypercubeRouterL2VC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore20(counter_router==2'b00);
        $display("here flit is put into core from router left vc3; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC3();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore21(counter_router==2'b01);
        $display("here flit is put into core from router left vc3; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC3();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore22(counter_router==2'b10);
        $display("here flit is put into core from router left vc3; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC3();
        core.put_flit(data_core);
    endrule





    // // // // // 
    //          //
    //          //
    //    HI    //
    //          //
    //          //
    // // // // //

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    
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



    rule send_from_vc1_ie_to_midcore2 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbcore2 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbcore2 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midcore2 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbcore2 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_msbcore2 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC7();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbcore2 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_midlsb2 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsblsb2 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsblsb2 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midlsb2 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsblsb2 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_msblsb2 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsblsb2 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_midmid2 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmid2 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmid2 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midmid2 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmid2 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_msbmid2 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmid2 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_midmsb2 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmsb2 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmsb2 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midmsb2 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmsb2 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_msbmsb2 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmsb2 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
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



(* synthesize *)

module mkHypercubeNode3VC #(parameter Address my_addr) (IfcHypercubeNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 
    let router_core <- mkHypercubeRouterL2VC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore30(counter_router==2'b00);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC4();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore31(counter_router==2'b01);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC4();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore32(counter_router==2'b10);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC4();
        core.put_flit(data_core);
    endrule





    // // // // // 
    //          //
    //          //
    //    HI    //
    //          //
    //          //
    // // // // //

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    
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



    rule send_from_vc1_ie_to_lsbcore3 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midcore3 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbcore3 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbcore3 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midcore3 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbcore3 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_msbcore3 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC8();
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



(* synthesize *)

module mkHypercubeNode4VC #(parameter Address my_addr) (IfcHypercubeNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 
    let router_core <- mkHypercubeRouterL2VC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore40(counter_router==2'b00);
        $display("here flit is put into core from router left vc5; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC5();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore41(counter_router==2'b01);
        $display("here flit is put into core from router left vc5; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC5();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore42(counter_router==2'b10);
        $display("here flit is put into core from router left vc5; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC5();
        core.put_flit(data_core);
    endrule





    // // // // // 
    //          //
    //          //
    //    HI    //
    //          //
    //          //
    // // // // //

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    
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



    rule send_from_vc1_ie_to_msbcore4 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC1();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbcore4 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midcore4 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbcore4 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbcore4 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midcore4 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbcore4 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_msblsb4 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsblsb4 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midlsb4 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsblsb4 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsblsb4 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midlsb4 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsblsb4 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_msbmid4 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmid4 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midmid4 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmid4 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmid4 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midmid4 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmid4 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_msbmsb4 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmsb4 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_midmsb4 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmsb4 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmsb4 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_midmsb4 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmsb4 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
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



(* synthesize *)

module mkHypercubeNode5VC #(parameter Address my_addr) (IfcHypercubeNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 
    let router_core <- mkHypercubeRouterL2VC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore50(counter_router==2'b00);
        $display("here flit is put into core from router left vc6; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC6();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore51(counter_router==2'b01);
        $display("here flit is put into core from router left vc6; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC6();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore52(counter_router==2'b10);
        $display("here flit is put into core from router left vc6; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC6();
        core.put_flit(data_core);
    endrule





    // // // // // 
    //          //
    //          //
    //    HI    //
    //          //
    //          //
    // // // // //

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    
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



    rule send_from_vc1_ie_to_lsbcore5 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_msbcore5 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC2();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbcore5 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midcore5 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbcore5 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbcore5 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midcore5 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC8();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsblsb5 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_msblsb5 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsblsb5 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midlsb5 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsblsb5 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsblsb5 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midlsb5 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmid5 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_msbmid5 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmid5 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midmid5 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmid5 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmid5 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midmid5 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmsb5 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_msbmsb5 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmsb5 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_midmsb5 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmsb5 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmsb5 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_midmsb5 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_mid.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
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



(* synthesize *)

module mkHypercubeNode6VC #(parameter Address my_addr) (IfcHypercubeNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 
    let router_core <- mkHypercubeRouterL2VC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore60(counter_router==2'b00);
        $display("here flit is put into core from router left vc7; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC7();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore61(counter_router==2'b01);
        $display("here flit is put into core from router left vc7; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC7();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore62(counter_router==2'b10);
        $display("here flit is put into core from router left vc7; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC7();
        core.put_flit(data_core);
    endrule





    // // // // // 
    //          //
    //          //
    //    HI    //
    //          //
    //          //
    // // // // //

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    
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



    rule send_from_vc1_ie_to_midcore6 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbcore6 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_msbcore6 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC3();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbcore6 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midcore6 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbcore6 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbcore6 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_midlsb6 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsblsb6 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_msblsb6 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsblsb6 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midlsb6 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsblsb6 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsblsb6 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_midmid6 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmid6 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_msbmid6 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmid6 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midmid6 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmid6 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmid6 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_midmsb6 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc2_ie_to_lsbmsb6 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc3_ie_to_msbmsb6 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc4_ie_to_lsbmsb6 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc5_ie_to_midmsb6 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc6_ie_to_lsbmsb6 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc8_ie_to_lsbmsb6 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
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



(* synthesize *)

module mkHypercubeNode7VC #(parameter Address my_addr) (IfcHypercubeNode);

     

    // Core and three routers - core, left link, right link instantiation
    Address head_node_addr; head_node_addr.netAddress = my_addr.netAddress; head_node_addr.nodeAddress = 0; 
    let core        <- mkCore(my_addr, head_node_addr); 
    let router_core <- mkHypercubeRouterL2VC(my_addr); 
    let router_lsb  <- mkHypercubeRouterL2VC(my_addr); 
    let router_mid  <- mkHypercubeRouterL2VC(my_addr); 
    let router_msb  <- mkHypercubeRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            $display("Into router core: %d",my_addr.nodeAddress);
            router_core.put_value(flit_generated);
        end
    endrule

    
    // FROM VC TO CORE
    rule outputLinkCore70(counter_router==2'b00);
        $display("here flit is put into core from router left vc8; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC8();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore71(counter_router==2'b01);
        $display("here flit is put into core from router left vc8; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC8();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore72(counter_router==2'b10);
        $display("here flit is put into core from router left vc8; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC8();
        core.put_flit(data_core);
    endrule





    // // // // // 
    //          //
    //          //
    //    HI    //
    //          //
    //          //
    // // // // //

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_lsb     <- mkFIFO;
    FIFO#(Flit) output_link_mid     <- mkFIFO;
    FIFO#(Flit) output_link_msb     <- mkFIFO;
    
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



    rule send_from_vc1_ie_to_lsbcore7 (counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_core.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midcore7 (counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_core.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbcore7 (counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_core.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_msbcore7 (counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_core.get_valueVC4();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbcore7 (counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_core.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midcore7 (counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_core.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbcore7 (counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_core.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsblsb7 (counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midlsb7 (counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsblsb7 (counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_msblsb7 (counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsblsb7 (counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midlsb7 (counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsblsb7 (counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmid7 (counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midmid7 (counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmid7 (counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_msbmid7 (counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmid7 (counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midmid7 (counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmid7 (counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc1_ie_to_lsbmsb7 (counter_router == 2'b11 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc2_ie_to_midmsb7 (counter_router == 2'b11 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc3_ie_to_lsbmsb7 (counter_router == 2'b11 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc4_ie_to_msbmsb7 (counter_router == 2'b11 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_msb.enq(data);
    endrule
    rule send_from_vc5_ie_to_lsbmsb7 (counter_router == 2'b11 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule
    rule send_from_vc6_ie_to_midmsb7 (counter_router == 2'b11 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_mid.enq(data);
    endrule
    rule send_from_vc7_ie_to_lsbmsb7 (counter_router == 2'b11 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule




    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
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



endpackage: HypercubeL2NodesVC
