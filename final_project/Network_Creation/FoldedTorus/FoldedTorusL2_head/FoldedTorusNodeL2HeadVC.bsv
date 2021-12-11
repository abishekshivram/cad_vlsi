package FoldedTorusNodeL2HeadVC;

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;

import FoldedTorusRouterL2HeadVC::*;

interface IfcFoldedTorusL2Head ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);
    method Action put_value_from_up(Flit data_up);
    method Action put_value_from_down(Flit data_down);
    method Action put_value_from_l1(Flit data_from_L1);


    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();
    method ActionValue#(Flit) get_value_to_up();
    method ActionValue#(Flit) get_value_to_down();
    method ActionValue#(Flit) get_value_to_l1();


    // method Action put_value_from_left_dateline(Flit data_left);
    // method Action put_value_from_right_dateline(Flit data_right);
    method Action put_value_from_up_dateline(Flit data_up);
    method Action put_value_from_down_dateline(Flit data_down);

    // method ActionValue#(Flit) get_value_to_left_dateline();
    // method ActionValue#(Flit) get_value_to_right_dateline();
    method ActionValue#(Flit) get_value_to_up_dateline();
    method ActionValue#(Flit) get_value_to_down_dateline();
endinterface


(* synthesize *)

module mkFoldedTorusL2HeadNode  #(parameter Address my_addr, parameter Address head_node_addr, parameter NodeAddressX maxXAddress, parameter NodeAddressY maxYAddress) (IfcFoldedTorusL2Head);

    // Core and three routers - core, left link, right link instantiation
    let core                <- mkCore(my_addr,head_node_addr); 
    //Left, right routers
    let router_left         <- mkFoldedTorusRouterL2HeadVC(my_addr,maxXAddress,maxYAddress); // takes input from left neighbour and puts in corresponding VC
    let router_right        <- mkFoldedTorusRouterL2HeadVC(my_addr,maxXAddress,maxYAddress);
    let router_up           <- mkFoldedTorusRouterL2HeadVC(my_addr,maxXAddress,maxYAddress);
    let router_down         <- mkFoldedTorusRouterL2HeadVC(my_addr,maxXAddress,maxYAddress);
    let router_L1           <- mkFoldedTorusRouterL2HeadVC(my_addr,maxXAddress,maxYAddress);
    let router_core         <- mkFoldedTorusRouterL2HeadVC(my_addr,maxXAddress,maxYAddress);

    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left <- mkFIFO;
    FIFO#(Flit) output_link_right <- mkFIFO;
    FIFO#(Flit) output_link_up <- mkFIFO;
    FIFO#(Flit) output_link_down <- mkFIFO;
    FIFO#(Flit) output_link_l1 <- mkFIFO;

    // FIFO#(Flit) output_link_left_dateline   <- mkFIFO;
    // FIFO#(Flit) output_link_right_dateline  <- mkFIFO;
    FIFO#(Flit) output_link_up_dateline <- mkFIFO;
    FIFO#(Flit) output_link_down_dateline <- mkFIFO;

    // This counter is used by arbiters to choose VC to send out data
    Reg#(Bit#(4)) counter   <- mkReg(0); 
    rule count_every_cycle;
        if(counter == 4'b1001) counter <= 0;
        else counter <= counter + 1;
    endrule

    //If core generated a flit, move it to core router    
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            router_core.put_value(flit_generated);
            $display("<<<<<<<<<<<<<<<<<<<Flit generated | Source: %d (Network),%d (Node) | Destination: -> %d (Network),%d (Node)",flit_generated.srcAddress.netAddress,flit_generated.srcAddress.nodeAddress,flit_generated.finalDstAddress.netAddress,flit_generated.finalDstAddress.nodeAddress);
        end
    endrule

      
    //NOTE LLOYD This (Round robin arbiter) can be improved
    //If chosen VC (counter) has no data, the cycle would be wasted, cannot consume data available in other VCs??
    
    // VC1 and VC2 are used to send data to the core (as decided earlier)
    // Rule - Output link - connecting to associated core
    // In this rule, we choose VC1 or VC2 from router_left or router_right,router_head_left,router_head_right (router_core cannot send to itself)
    // in a round robin fashion (implemented through 3 bit counter) (3 bit because we have 8 VCs to choose from)
    
    rule outputLinkCore0(counter == 4'b0000);
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC1();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore1(counter == 4'b0001);
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore2(counter == 4'b0010);
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore3(counter == 4'b0011);
        Flit data_core=defaultValue;
        data_core <- router_down.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore4(counter == 4'b0100);
        Flit data_core=defaultValue;
        data_core <- router_L1.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore5(counter == 4'b0101);
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC2();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore6(counter == 4'b0110);
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore7(counter == 4'b0111);
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore8(counter == 4'b1000);
        Flit data_core=defaultValue;
        data_core <- router_down.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore9(counter == 4'b1001);
        Flit data_core=defaultValue;
        data_core <- router_L1.get_valueVC2();
        core.put_flit(data_core);
    endrule

    // To send to right neighbour, we have to choose from available VC5s and VC6s
    // The chosen flit is added to the OUTPUT_LINK_RIGHT

    rule add_to_link_right0(counter == 4'b0000);
        $display("add_to_link_right0-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right1(counter == 4'b0001);
        $display("add_to_link_right1-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right2(counter == 4'b0010);
        $display("add_to_link_right2-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right3(counter == 4'b0011);
        $display("add_to_link_right3-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right4(counter == 4'b0100);
        $display("add_to_link_right4-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_L1.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right5(counter == 4'b0101);
        $display("add_to_link_right5-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right6(counter == 4'b0110);
        $display("add_to_link_right6-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right7(counter == 4'b0111);
        $display("add_to_link_right7-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right8(counter == 4'b1000);
        $display("add_to_link_right8-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right9(counter == 4'b1001);
        $display("add_to_link_right9-> my_addr %d",my_addr);    
        Flit data_right=defaultValue;
        data_right <- router_L1.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    // To send to left neighbour, we have to choose from available VC7s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT

    rule add_to_link_left0(counter == 4'b0000);
        $display("add_to_link_left0-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left1(counter == 4'b0001);
        $display("add_to_link_left1-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left2(counter == 4'b0010);
        $display("add_to_link_left2-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left3(counter == 4'b0011);
        $display("add_to_link_left3-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left4(counter == 4'b0100);
        $display("add_to_link_left4-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_L1.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left5(counter == 4'b0101);
        $display("add_to_link_left5-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left6(counter == 4'b0110);
        $display("add_to_link_left6-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left7(counter == 4'b0111);
        $display("add_to_link_left7-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left8(counter == 4'b1000);
        $display("add_to_link_left8-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left9(counter == 4'b1001);
        $display("add_to_link_left9-> my_addr %d",my_addr);    
        Flit data_left=defaultValue;
        data_left <- router_L1.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    // To send to up neighbour, we have to choose from available VC7s and VC8s
    // The chosen flit is added to the OUTPUT_LINK_UP

    rule add_to_link_up0(counter == 4'b0000 || counter == 4'b0101);
        $display("add_to_link_up0-> my_addr %d",my_addr);    
        Flit data_up=defaultValue;
        data_up <- router_core.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up1(counter == 4'b0001 || counter == 4'b0110);
        $display("add_to_link_up1-> my_addr %d",my_addr);    
        Flit data_up=defaultValue;
        data_up <- router_left.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up2(counter == 4'b0010 || counter == 4'b0111);
        $display("add_to_link_up2-> my_addr %d",my_addr);    
        Flit data_up=defaultValue;
        data_up <- router_right.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up3(counter == 4'b0011 || counter == 4'b100);
        $display("add_to_link_up3-> my_addr %d",my_addr);    
        Flit data_up=defaultValue;
        data_up <- router_down.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up4(counter == 4'b0100 || counter == 4'b1001);
        $display("add_to_link_up4-> my_addr %d",my_addr);    
        Flit data_up=defaultValue;
        data_up <- router_L1.get_valueVC7();
        output_link_up.enq(data_up);
    endrule



    rule add_to_link_up0_dateline(counter == 4'b0000 || counter == 4'b0101);
        $display("add_to_link_up0_dateline-> my_addr %d",my_addr);    
        Flit data_up_dateline=defaultValue;
        data_up_dateline <- router_core.get_valueVC8();
        output_link_up_dateline.enq(data_up_dateline);
    endrule

    rule add_to_link_up1_dateline(counter == 4'b0001 || counter == 4'b0110);
        $display("add_to_link_up1_dateline-> my_addr %d",my_addr);    
        Flit data_up_dateline=defaultValue;
        data_up_dateline <- router_left.get_valueVC8();
        output_link_up_dateline.enq(data_up_dateline);
    endrule

    rule add_to_link_up2_dateline(counter == 4'b0010 || counter == 4'b0111);
        $display("add_to_link_up2_dateline-> my_addr %d",my_addr);    
        Flit data_up_dateline=defaultValue;
        data_up_dateline <- router_right.get_valueVC8();
        output_link_up_dateline.enq(data_up_dateline);
    endrule

    rule add_to_link_up3_dateline(counter == 4'b0011 || counter == 4'b100);
        $display("add_to_link_up3_dateline-> my_addr %d",my_addr);    
        Flit data_up_dateline=defaultValue;
        data_up_dateline <- router_down.get_valueVC8();
        output_link_up_dateline.enq(data_up_dateline);
    endrule

    rule add_to_link_up4_dateline(counter == 4'b0100 || counter == 4'b1001);
        $display("add_to_link_up4_dateline-> my_addr %d",my_addr);    
        Flit data_up_dateline=defaultValue;
        data_up_dateline <- router_L1.get_valueVC8();
        output_link_up_dateline.enq(data_up_dateline);
    endrule


    // To send to down neighbour, we have to choose from available VC9s and VC10s
    // The chosen flit is added to the OUTPUT_LINK_DOWN

    rule add_to_link_down0(counter == 4'b0000 || counter == 4'b0101);
        $display("add_to_link_down0-> my_addr %d",my_addr);    
        Flit data_down=defaultValue;
        data_down <- router_core.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down1(counter == 4'b0001 || counter == 4'b0110);
        $display("add_to_link_down1-> my_addr %d",my_addr);    
        Flit data_down=defaultValue;
        data_down <- router_left.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down2(counter == 4'b0010 || counter == 4'b0111);
        $display("add_to_link_down2-> my_addr %d",my_addr);    
        Flit data_down=defaultValue;
        data_down <- router_right.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down3(counter == 4'b0011 || counter == 4'b1000);
        $display("add_to_link_down3-> my_addr %d",my_addr);    
        Flit data_down=defaultValue;
        data_down <- router_up.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down4(counter == 4'b0100 || counter == 4'b1001);
        $display("add_to_link_down4-> my_addr %d",my_addr);    
        Flit data_down=defaultValue;
        data_down <- router_L1.get_valueVC9();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down0_dateline(counter == 4'b0000 || counter == 4'b0101);
        $display("add_to_link_down0_dateline-> my_addr %d",my_addr);    
        Flit data_down_dateline=defaultValue;
        data_down_dateline <- router_core.get_valueVC10();
        output_link_down_dateline.enq(data_down_dateline);
    endrule

    rule add_to_link_down1_dateline(counter == 4'b0001 || counter == 4'b0110);
        $display("add_to_link_down1_dateline-> my_addr %d",my_addr);    
        Flit data_down_dateline=defaultValue;
        data_down_dateline <- router_left.get_valueVC10();
        output_link_down_dateline.enq(data_down_dateline);
    endrule

    rule add_to_link_down2_dateline(counter == 4'b0010 || counter == 4'b0111);
        $display("add_to_link_down2_dateline-> my_addr %d",my_addr);    
        Flit data_down_dateline=defaultValue;
        data_down_dateline <- router_right.get_valueVC10();
        output_link_down_dateline.enq(data_down_dateline);
    endrule

    rule add_to_link_down3_dateline(counter == 4'b0011 || counter == 4'b1000);
        $display("add_to_link_down3_dateline-> my_addr %d",my_addr);    
        Flit data_down_dateline=defaultValue;
        data_down_dateline <- router_up.get_valueVC10();
        output_link_down_dateline.enq(data_down_dateline);
    endrule

    rule add_to_link_down4_dateline(counter == 4'b0100 || counter == 4'b1001);
        $display("add_to_link_down4_dateline-> my_addr %d",my_addr);    
        Flit data_down_dateline=defaultValue;
        data_down_dateline <- router_L1.get_valueVC10();
        output_link_down_dateline.enq(data_down_dateline);
    endrule


    // VC to L1

    rule add_to_link_l1_0(counter == 4'b0000);
        $display("add_to_link_l1_0-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_core.get_valueVC11();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_1(counter == 4'b0001);
        $display("add_to_link_l1_1-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_right.get_valueVC11();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_2(counter == 4'b0010);
        $display("add_to_link_l1_2-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_up.get_valueVC11();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_3(counter == 4'b0011);
        $display("add_to_link_l1_3-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_down.get_valueVC11();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_4(counter == 4'b0100);
        $display("add_to_link_l1_4-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_left.get_valueVC11();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_5(counter == 4'b0101);
        $display("add_to_link_l1_5-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_core.get_valueVC12();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_6(counter == 4'b0110);
        $display("add_to_link_l1_6-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_right.get_valueVC12();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_7(counter == 4'b0111);
        $display("add_to_link_l1_7-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_up.get_valueVC12();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_8(counter == 4'b1000);
        $display("add_to_link_l1_8-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_down.get_valueVC12();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_9(counter == 4'b1001);
        $display("add_to_link_l1_9-> my_addr %d",my_addr);    
        Flit data_l1=defaultValue;
        data_l1 <- router_left.get_valueVC12();
        output_link_l1.enq(data_l1);
    endrule


    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
    method ActionValue#(Flit) get_value_to_left();
        let data_to_left = output_link_left.first();
        output_link_left.deq();
        return data_to_left;
    endmethod

    // Method to take the flit from OUTPUT_LINK_RIGHT and return 
    method ActionValue#(Flit) get_value_to_right();
        let data_to_right = output_link_right.first();
        output_link_right.deq();
        return data_to_right;
    endmethod

    method ActionValue#(Flit) get_value_to_up();
        let data_to_up = output_link_up.first();
        output_link_up.deq();
        return data_to_up;
    endmethod

    method ActionValue#(Flit) get_value_to_up_dateline();
        let data_to_up_dateline = output_link_up_dateline.first();
        output_link_up_dateline.deq();
        return data_to_up_dateline;
    endmethod


    method ActionValue#(Flit) get_value_to_down();
        let data_to_down = output_link_down.first();
        output_link_down.deq();
        return data_to_down;
    endmethod
    
    method ActionValue#(Flit) get_value_to_down_dateline();
        let data_to_down_dateline = output_link_down_dateline.first();
        output_link_down_dateline.deq();
        return data_to_down_dateline;
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        let data_to_l1 = output_link_l1.first();
        output_link_l1.deq();
        return data_to_l1;
    endmethod

    // Methods to take care of input links 
    // (ie) the flits that come from left neighbour are inserted to the router_left's input link buffer
    method Action put_value_from_left(Flit data_left);
        router_left.put_value(data_left);
    endmethod

    // The flits that come from right neighbour are inserted to the router_right's input link buffer
    method Action put_value_from_right(Flit data_right);
        router_right.put_value(data_right);
    endmethod

    method Action put_value_from_up(Flit data_up);
        router_up.put_value(data_up);
    endmethod
    
    method Action put_value_from_up_dateline(Flit data_up);
        router_up.put_value_dateline(data_up);
    endmethod

    method Action put_value_from_down(Flit data_down);
        router_down.put_value(data_down);
    endmethod

    method Action put_value_from_down_dateline(Flit data_down);
        router_down.put_value_dateline(data_down);
    endmethod

    // Flit is added to router L1
    method Action put_value_from_l1(Flit data_from_L1);
        router_L1.put_value(data_from_L1);
    endmethod

endmodule: mkFoldedTorusL2HeadNode

endpackage: FoldedTorusNodeL2HeadVC