package HypercubeNodeVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import HypercubeRouterVC :: *;


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


(* synthesize *)

module mkHypercubeNode #(parameter Address my_addr, parameter bit level) (IfcHypercubeNode);

    Reg#(bit) lvl <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)

    // Core and three routers - core, left link, right link instantiation
    let core        <- mkCore(my_addr); 
    let router_core <- mkHypercubeRouterVC(my_addr); 
    let router_lsb  <- mkHypercubeRouterVC(my_addr); 
    let router_mid  <- mkHypercubeRouterVC(my_addr); 
    let router_msb  <- mkHypercubeRouterVC(my_addr);

    Reg#(Bit#(2)) counter_router   <- mkReg(0);

    // This counter_router is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        if(counter_router == 2) counter_router <= 0;
        else counter_router <= counter_router + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True)
            router_core.put_value(flit_generated);
    endrule

    
    // VC1 and VC2 are used to send data to the core (as decided earlier)
    // Rule - Output link - connecting to associated core
    // In this rule, we choose VC1 or VC2 from router_left or router_right (router_core cannot send to itself)
    // in a round robin fashion (implemented through 2 bit counter_router) (2 bit because we have 4 VCs to choose from)

    // Most of the below rules will go to "NEVER_FIRE" because of my_addr.nodeAddress condition
    `ifdef (my_addr.nodeAddress==0)
    rule outputLinkCore00(my_addr.nodeAddress == 0 && counter_router==2'b00);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC1();
        core.put_flit(data_core);
    endrule
    `endif
    
    rule outputLinkCore01(my_addr.nodeAddress == 0 && counter_router==2'b01);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC1();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore02(my_addr.nodeAddress == 0 && counter_router==2'b10);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore10(my_addr.nodeAddress == 1 && counter_router==2'b00);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC2();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore11(my_addr.nodeAddress == 1 && counter_router==2'b01);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC2();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore12(my_addr.nodeAddress == 1 && counter_router==2'b10);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC2();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore20(my_addr.nodeAddress == 2 && counter_router==2'b00);
        $display("here flit is put into core from router left vc3; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC3();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore21(my_addr.nodeAddress == 2 && counter_router==2'b01);
        $display("here flit is put into core frommy_addr router left vc3; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC3();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore22(my_addr.nodeAddress == 2 && counter_router==2'b10);
        $display("here flit is put into core from router left vc3; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC3();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore30(my_addr.nodeAddress == 3 && counter_router==2'b00);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC4();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore31(my_addr.nodeAddress == 3 && counter_router==2'b01);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC4();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore32(my_addr.nodeAddress == 3 && counter_router==2'b10);
        $display("here flit is put into core from router left vc4; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC4();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore40(my_addr.nodeAddress == 4 && counter_router==2'b00);
        $display("here flit is put into core from router left vc5; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC5();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore41(my_addr.nodeAddress == 4 && counter_router==2'b01);
        $display("here flit is put into core from router left vc5; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC5();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore42(my_addr.nodeAddress == 4 && counter_router==2'b10);
        $display("here flit is put into core from router left vc5; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC5();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore50(my_addr.nodeAddress == 5 && counter_router==2'b00);
        $display("here flit is put into core from router left vc6; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC6();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore51(my_addr.nodeAddress == 5 && counter_router==2'b01);
        $display("here flit is put into core from router left vc6; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC6();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore52(my_addr.nodeAddress == 5 && counter_router==2'b10);
        $display("here flit is put into core from router left vc6; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC6();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore60(my_addr.nodeAddress == 6 && counter_router==2'b00);
        $display("here flit is put into core from router left vc7; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC7();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore61(my_addr.nodeAddress == 6 && counter_router==2'b01);
        $display("here flit is put into core from router left vc7; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC7();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore62(my_addr.nodeAddress == 6 && counter_router==2'b10);
        $display("here flit is put into core from router left vc7; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC7();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore70(my_addr.nodeAddress == 7 && counter_router==2'b00);
        $display("here flit is put into core from router left vc8; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC8();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore71(my_addr.nodeAddress == 7 && counter_router==2'b01);
        $display("here flit is put into core from router left vc8; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC8();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore72(my_addr.nodeAddress == 7 && counter_router==2'b10);
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
    
    Reg#(Bit#(2)) counter_lsb  <- mkReg(0);
    // This counter_lsb is used by arbiters to choose VC to send out data
    rule count_lsb;
        counter_lsb <= counter_lsb + 1;
    endrule

    Reg#(Bit#(1)) counter_mid  <- mkReg(0);
    // This counter_lsb is used by arbiters to choose VC to send out data
    rule count_mid;
        counter_mid <= counter_mid + 1;
    endrule






    rule send_from_vc2_ie_to_lsblsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_midlsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsblsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_msblsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsblsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_midlsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsblsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmid0 (my_addr.nodeAddress == 0 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_midmid0 (my_addr.nodeAddress == 0 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmid0 (my_addr.nodeAddress == 0 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_msbmid0 (my_addr.nodeAddress == 0 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmid0 (my_addr.nodeAddress == 0 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_midmid0 (my_addr.nodeAddress == 0 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmid0 (my_addr.nodeAddress == 0 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_midmsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_msbmsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_midmsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmsb0 (my_addr.nodeAddress == 0 && counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsblsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsblsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_midlsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsblsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_msblsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsblsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_midlsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmid1 (my_addr.nodeAddress == 1 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmid1 (my_addr.nodeAddress == 1 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_midmid1 (my_addr.nodeAddress == 1 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmid1 (my_addr.nodeAddress == 1 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_msbmid1 (my_addr.nodeAddress == 1 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmid1 (my_addr.nodeAddress == 1 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_midmid1 (my_addr.nodeAddress == 1 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_midmsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_msbmsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_midmsb1 (my_addr.nodeAddress == 1 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc1_ie_to_midlsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsblsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsblsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_midlsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsblsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_msblsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsblsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_midmid2 (my_addr.nodeAddress == 2 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmid2 (my_addr.nodeAddress == 2 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmid2 (my_addr.nodeAddress == 2 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_midmid2 (my_addr.nodeAddress == 2 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmid2 (my_addr.nodeAddress == 2 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_msbmid2 (my_addr.nodeAddress == 2 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmid2 (my_addr.nodeAddress == 2 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_midmsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_midmsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_msbmsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmsb2 (my_addr.nodeAddress == 2 && counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsblsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_midlsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsblsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsblsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_midlsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsblsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_msblsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmid3 (my_addr.nodeAddress == 3 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_midmid3 (my_addr.nodeAddress == 3 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmid3 (my_addr.nodeAddress == 3 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmid3 (my_addr.nodeAddress == 3 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_midmid3 (my_addr.nodeAddress == 3 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmid3 (my_addr.nodeAddress == 3 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_msbmid3 (my_addr.nodeAddress == 3 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_midmsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_midmsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_msbmsb3 (my_addr.nodeAddress == 3 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc1_ie_to_msblsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsblsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_midlsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsblsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsblsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_midlsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsblsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_msbmid4 (my_addr.nodeAddress == 4 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmid4 (my_addr.nodeAddress == 4 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_midmid4 (my_addr.nodeAddress == 4 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmid4 (my_addr.nodeAddress == 4 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmid4 (my_addr.nodeAddress == 4 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_midmid4 (my_addr.nodeAddress == 4 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmid4 (my_addr.nodeAddress == 4 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_msbmsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_midmsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_midmsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmsb4 (my_addr.nodeAddress == 4 && counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsblsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_msblsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsblsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_midlsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsblsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsblsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_midlsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmid5 (my_addr.nodeAddress == 5 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_msbmid5 (my_addr.nodeAddress == 5 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmid5 (my_addr.nodeAddress == 5 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_midmid5 (my_addr.nodeAddress == 5 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmid5 (my_addr.nodeAddress == 5 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmid5 (my_addr.nodeAddress == 5 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_midmid5 (my_addr.nodeAddress == 5 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_msbmsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_midmsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_midmsb5 (my_addr.nodeAddress == 5 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc1_ie_to_midlsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsblsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_msblsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsblsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_midlsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsblsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsblsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_midmid6 (my_addr.nodeAddress == 6 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmid6 (my_addr.nodeAddress == 6 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_msbmid6 (my_addr.nodeAddress == 6 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmid6 (my_addr.nodeAddress == 6 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_midmid6 (my_addr.nodeAddress == 6 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmid6 (my_addr.nodeAddress == 6 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmid6 (my_addr.nodeAddress == 6 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_midmsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc2_ie_to_lsbmsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc3_ie_to_msbmsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc4_ie_to_lsbmsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc5_ie_to_midmsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc6_ie_to_lsbmsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc8_ie_to_lsbmsb6 (my_addr.nodeAddress == 6 && counter_router == 2'b10 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC8();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsblsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b00 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_midlsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b00 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC2();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsblsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b00 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_msblsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b00 );
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC4();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsblsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b00 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_midlsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b00 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC6();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsblsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b00 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_lsb.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmid7 (my_addr.nodeAddress == 7 && counter_router == 2'b01 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_midmid7 (my_addr.nodeAddress == 7 && counter_router == 2'b01 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC2();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmid7 (my_addr.nodeAddress == 7 && counter_router == 2'b01 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_msbmid7 (my_addr.nodeAddress == 7 && counter_router == 2'b01 );
        Flit data=defaultValue;
        data <- router_mid.get_valueVC4();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmid7 (my_addr.nodeAddress == 7 && counter_router == 2'b01 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_midmid7 (my_addr.nodeAddress == 7 && counter_router == 2'b01 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC6();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmid7 (my_addr.nodeAddress == 7 && counter_router == 2'b01 && counter_lsb==2'b11);
        Flit data=defaultValue;
        data <- router_mid.get_valueVC7();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc1_ie_to_lsbmsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b10 && counter_lsb==2'b00);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC1();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc2_ie_to_midmsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b10 && counter_mid==1'b0);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC2();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc3_ie_to_lsbmsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b10 && counter_lsb==2'b01);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC3();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc4_ie_to_msbmsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b10 );
        Flit data=defaultValue;
        data <- router_msb.get_valueVC4();
        output_link_msb.enq(data);
    endrule

    rule send_from_vc5_ie_to_lsbmsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b10 && counter_lsb==2'b10);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC5();
        output_link_lsb.enq(data);
    endrule

    rule send_from_vc6_ie_to_midmsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b10 && counter_mid==1'b1);
        Flit data=defaultValue;
        data <- router_msb.get_valueVC6();
        output_link_mid.enq(data);
    endrule

    rule send_from_vc7_ie_to_lsbmsb7 (my_addr.nodeAddress == 7 && counter_router == 2'b10 && counter_lsb==2'b11);
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

endpackage: HypercubeNodeVC
