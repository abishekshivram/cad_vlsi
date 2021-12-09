package MeshHeadNodeVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import MeshRouterVC :: *;


interface IfcMeshHeadNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);
    method Action put_value_from_up(Flit data_up);
    method Action put_value_from_down(Flit data_down);

    method Action put_value_from_head_left(Flit data_head_left);
    method Action put_value_from_head_right(Flit data_head_right);
    method Action put_value_from_head_up(Flit data_head_left);
    method Action put_value_from_head_down(Flit data_head_right);

    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();
    method ActionValue#(Flit) get_value_to_up();
    method ActionValue#(Flit) get_value_to_down();
    method ActionValue#(Flit) get_value_to_head_left();
    method ActionValue#(Flit) get_value_to_head_right();
    method ActionValue#(Flit) get_value_to_head_up();
    method ActionValue#(Flit) get_value_to_head_down();

endinterface


(* synthesize *)

module mkMeshHeadNode #(parameter Address my_addr, parameter Address head_node_addr, parameter Bool is_head_node) (IfcMeshHeadNode);

    // Core and three routers - core, left link, right link instantiation
    let core                <- mkCore(my_addr,head_node_addr); 
    //Left, right routers
    let router_left         <- mkMeshRouterVC(my_addr,is_head_node); // takes input from left neighbour and puts in corresponding VC
    let router_right        <- mkMeshRouterVC(my_addr,is_head_node);
    let router_up           <- mkMeshRouterVC(my_addr,is_head_node);
    let router_down         <- mkMeshRouterVC(my_addr,is_head_node);
    //HeadLeft, HeadRight routers
    let router_head_left    <- mkMeshRouterVC(my_addr,is_head_node); // takes input from L1 left neighbour and puts in corresponding VC
    let router_head_right   <- mkMeshRouterVC(my_addr,is_head_node);
    let router_head_up      <- mkMeshRouterVC(my_addr,is_head_node); 
    let router_head_down    <- mkMeshRouterVC(my_addr,is_head_node);
    let router_core         <- mkMeshRouterVC(my_addr,is_head_node);

    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left <- mkFIFO;
    FIFO#(Flit) output_link_right <- mkFIFO;
    FIFO#(Flit) output_link_up <- mkFIFO;
    FIFO#(Flit) output_link_down <- mkFIFO;
    FIFO#(Flit) output_link_head_left <- mkFIFO;
    FIFO#(Flit) output_link_head_right <- mkFIFO;
    FIFO#(Flit) output_link_head_up <- mkFIFO;
    FIFO#(Flit) output_link_head_down <- mkFIFO;

    // This counter is used by arbiters to choose VC to send out data
    Reg#(Bit#(4)) counter   <- mkReg(0); 
    rule count_every_cycle;
        counter <= counter + 1;
    endrule

    //If core generated a flit, move it to core router    
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True)
            router_core.put_value(flit_generated);
    endrule

      
    //NOTE LLOYD This (Round robin arbiter) can be improved
    //If chosen VC (counter) has no data, the cycle would be wasted, cannot consume data available in other VCs??
    
    // VC1 and VC2 are used to send data to the core (as decided earlier)
    // Rule - Output link - connecting to associated core
    // In this rule, we choose VC1 or VC2 from router_left or router_right,router_head_left,router_head_right (router_core cannot send to itself)
    // in a round robin fashion (implemented through 3 bit counter) (3 bit because we have 8 VCs to choose from)
    
    rule outputLinkCore0(counter == 4'b0000);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC1();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore1(counter == 4'b0001);
        $display("here flit is put into core from router_right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore2(counter == 4'b0010);
        $display("here flit is put into core from router up vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore3(counter == 4'b0011);
        $display("here flit is put into core from router_down vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_down.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore4(counter == 4'b0100);
        $display("here flit is put into core from router_head_left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_left.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore5(counter == 4'b0101);
        $display("here flit is put into core from router_head_right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore6(counter == 4'b0110);
        $display("here flit is put into core from router_head_up vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_up.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore7(counter == 4'b0111);
        $display("here flit is put into core from router_head_down vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_down.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore8(counter == 4'b1000);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC2();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore9(counter == 4'b1001);
        $display("here flit is put into core from router_right vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore10(counter == 4'b1010);
        $display("here flit is put into core from router up vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore11(counter == 4'b1011);
        $display("here flit is put into core from router_down vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_down.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore12(counter == 4'b1100);
        $display("here flit is put into core from router_head_left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_left.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore13(counter == 4'b1101);
        $display("here flit is put into core from router_head_right vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_right.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore14(counter == 4'b1110);
        $display("here flit is put into core from router_head_up vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_up.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore15(counter == 4'b1111);
        $display("here flit is put into core from router_head_down vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_down.get_valueVC2();
        core.put_flit(data_core);
    endrule    

    // To send to right neighbour, we have to choose from available VC5s and VC6s
    // The chosen flit is added to the OUTPUT_LINK_RIGHT

    rule add_to_link_right0(counter == 4'b0000);
        $display("add_to_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right1(counter == 4'b0001);
        $display("add_to_link_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right2(counter == 4'b0010);
        $display("add_to_link_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right3(counter == 4'b0011);
        $display("add_to_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right4(counter == 4'b0100);
        $display("add_to_link_right4-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right5(counter == 4'b0101);
        $display("add_to_link_right5-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_right.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right6(counter == 4'b0110);
        $display("add_to_link_right6-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_up.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right7(counter == 4'b0111);
        $display("add_to_link_right7-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_down.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right8(counter == 4'b1000);
        $display("add_to_link_right8-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right9(counter == 4'b1001);
        $display("add_to_link_right9-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right10(counter == 4'b1010);
        $display("add_to_link_right10-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right11(counter == 4'b1011);
        $display("add_to_link_right11-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right12(counter == 4'b1100);
        $display("add_to_link_right12-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right13(counter == 4'b1101);
        $display("add_to_link_right13-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_right.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right14(counter == 4'b1110);
        $display("add_to_link_right14-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_up.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right15(counter == 4'b1111);
        $display("add_to_link_right15-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_down.get_valueVC6();
        output_link_right.enq(data_right);
    endrule    

    // To send to left neighbour, we have to choose from available VC7s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT

    rule add_to_link_left0(counter == 4'b0000);
        $display("add_to_link_left0-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left1(counter == 4'b0001);
        $display("add_to_link_left1-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left2(counter == 4'b0010);
        $display("add_to_link_left2-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left3(counter == 4'b0011);
        $display("add_to_link_left3-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left4(counter == 4'b0100);
        $display("add_to_link_left4-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_left.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left5(counter == 4'b0101);
        $display("add_to_link_left5-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left6(counter == 4'b0110);
        $display("add_to_link_left6-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_up.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left7(counter == 4'b0111);
        $display("add_to_link_left7-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_down.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left8(counter == 4'b1000);
        $display("add_to_link_left8-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left9(counter == 4'b1001);
        $display("add_to_link_left9-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left10(counter == 4'b1010);
        $display("add_to_link_left10-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left11(counter == 4'b1011);
        $display("add_to_link_left11-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left12(counter == 4'b1100);
        $display("add_to_link_left12-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_left.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left13(counter == 4'b1101);
        $display("add_to_link_left13-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left14(counter == 4'b1110);
        $display("add_to_link_left14-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_up.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left15(counter == 4'b1111);
        $display("add_to_link_left15-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_down.get_valueVC4();
        output_link_left.enq(data_left);
    endrule    


    // To send to up neighbour, we have to choose from available VC7s and VC8s
    // The chosen flit is added to the OUTPUT_LINK_UP

    rule add_to_link_up0(counter == 4'b0000);
        $display("add_to_link_up0-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_core.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up1(counter == 4'b0001);
        $display("add_to_link_up1-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_left.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up2(counter == 4'b0010);
        $display("add_to_link_up2-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_right.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up3(counter == 4'b0011);
        $display("add_to_link_up3-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_down.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up4(counter == 4'b0100);
        $display("add_to_link_up4-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_left.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up5(counter == 4'b0101);
        $display("add_to_link_up5-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_right.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up6(counter == 4'b0110);
        $display("add_to_link_up6-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_up.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up7(counter == 4'b0111);
        $display("add_to_link_up7-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_down.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up8(counter == 4'b1000);
        $display("add_to_link_up8-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_core.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up9(counter == 4'b1001);
        $display("add_to_link_up9-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_left.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up10(counter == 4'b1010);
        $display("add_to_link_up10-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_right.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up11(counter == 4'b1011);
        $display("add_to_link_up11-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_down.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up12(counter == 4'b1100);
        $display("add_to_link_up12-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_left.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up13(counter == 4'b1101);
        $display("add_to_link_up13-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_right.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up14(counter == 4'b1110);
        $display("add_to_link_up14-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_up.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up15(counter == 4'b1111);
        $display("add_to_link_up15-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_head_down.get_valueVC8();
        output_link_up.enq(data_up);
    endrule    



    // To send to down neighbour, we have to choose from available VC9s and VC10s
    // The chosen flit is added to the OUTPUT_LINK_DOWN

    rule add_to_link_down0(counter == 4'b0000);
        $display("add_to_link_down0-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_core.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down1(counter == 4'b0001);
        $display("add_to_link_down1-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_left.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down2(counter == 4'b0010);
        $display("add_to_link_down2-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_right.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down3(counter == 4'b0011);
        $display("add_to_link_down3-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_up.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down4(counter == 4'b0100);
        $display("add_to_link_down4-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_left.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down5(counter == 4'b0101);
        $display("add_to_link_down5-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_right.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down6(counter == 4'b0110);
        $display("add_to_link_down6-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_up.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down7(counter == 4'b0111);
        $display("add_to_link_down7-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_down.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down8(counter == 4'b1000);
        $display("add_to_link_down8-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_core.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down9(counter == 4'b1001);
        $display("add_to_link_down9-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_left.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down10(counter == 4'b1010);
        $display("add_to_link_down10-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_right.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down11(counter == 4'b1011);
        $display("add_to_link_down11-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_up.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down12(counter == 4'b1100);
        $display("add_to_link_down12-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_left.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down13(counter == 4'b1101);
        $display("add_to_link_down13-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_right.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down14(counter == 4'b1110);
        $display("add_to_link_down14-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_up.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down15(counter == 4'b1111);
        $display("add_to_link_down15-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_head_down.get_valueVC10();
        output_link_down.enq(data_down);
    endrule    



    // To send to head_left neighbour, we have to choose from available VC11 and VC12s
    // The chosen flit is added to the OUTPUT_LINK_HEAD_LEFT

    rule add_to_link_head_left0(counter == 4'b0000);
        $display("add_to_link_head_left0-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_core.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left1(counter == 4'b0001);
        $display("add_to_link_head_left1-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_left.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left2(counter == 4'b0010);
        $display("add_to_link_head_left2-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_right.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left3(counter == 4'b0011);
        $display("add_to_link_head_left3-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_up.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left4(counter == 4'b0100);
        $display("add_to_link_head_left4-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_down.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left5(counter == 4'b0101);
        $display("add_to_link_head_left5-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_head_right.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left6(counter == 4'b0110);
        $display("add_to_link_head_left6-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_head_up.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left7(counter == 4'b0111);
        $display("add_to_link_head_left7-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_head_down.get_valueVC11();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left8(counter == 4'b1000);
        $display("add_to_link_head_left8-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_core.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left9(counter == 4'b1001);
        $display("add_to_link_head_left9-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_left.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left10(counter == 4'b1010);
        $display("add_to_link_head_left10-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_right.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left11(counter == 4'b1011);
        $display("add_to_link_head_left11-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_up.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left12(counter == 4'b1100);
        $display("add_to_link_head_left12-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_down.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left13(counter == 4'b1101);
        $display("add_to_link_head_left13-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_head_right.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left14(counter == 4'b1110);
        $display("add_to_link_head_left14-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_head_up.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule

    rule add_to_link_head_left15(counter == 4'b1111);
        $display("add_to_link_head_left15-> my_addr %d",my_addr.netAddress);    
        Flit data_head_left=defaultValue;
        data_head_left <- router_head_down.get_valueVC12();
        output_link_head_left.enq(data_head_left);
    endrule    
    



    // To send to head_right neighbour, we have to choose from available VC13 and VC14s
    // The chosen flit is added to the OUTPUT_LINK_HEAD_RIGHT

    rule add_to_link_head_right0(counter == 4'b0000);
        $display("add_to_link_head_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_core.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right1(counter == 4'b0001);
        $display("add_to_link_head_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_left.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right2(counter == 4'b0010);
        $display("add_to_link_head_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_right.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right3(counter == 4'b0011);
        $display("add_to_link_head_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_up.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right4(counter == 4'b0100);
        $display("add_to_link_head_right4-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_down.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right5(counter == 4'b0101);
        $display("add_to_link_head_right5-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_head_left.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right6(counter == 4'b0110);
        $display("add_to_link_head_right6-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_head_up.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right7(counter == 4'b0111);
        $display("add_to_link_head_right7-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_head_down.get_valueVC13();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right8(counter == 4'b1000);
        $display("add_to_link_head_right8-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_core.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right9(counter == 4'b1001);
        $display("add_to_link_head_right9-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_left.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right10(counter == 4'b1010);
        $display("add_to_link_head_right10-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_right.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right11(counter == 4'b1011);
        $display("add_to_link_head_right11-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_up.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right12(counter == 4'b1100);
        $display("add_to_link_head_right12-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_down.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right13(counter == 4'b1101);
        $display("add_to_link_head_right13-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_head_left.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right14(counter == 4'b1110);
        $display("add_to_link_head_right14-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_head_up.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule

    rule add_to_link_head_right15(counter == 4'b1111);
        $display("add_to_link_head_right15-> my_addr %d",my_addr.netAddress);    
        Flit data_head_right=defaultValue;
        data_head_right <- router_head_down.get_valueVC14();
        output_link_head_right.enq(data_head_right);
    endrule    


    // To send to head_up neighbour, we have to choose from available VC15 and VC16s
    // The chosen flit is added to the OUTPUT_LINK_HEAD_UP

    rule add_to_link_head_up0(counter == 4'b0000);
        $display("add_to_link_head_up0-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_core.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up1(counter == 4'b0001);
        $display("add_to_link_head_up1-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_left.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up2(counter == 4'b0010);
        $display("add_to_link_head_up2-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_right.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up3(counter == 4'b0011);
        $display("add_to_link_head_up3-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_up.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up4(counter == 4'b0100);
        $display("add_to_link_head_up4-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_down.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up5(counter == 4'b0101);
        $display("add_to_link_head_up5-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_head_left.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up6(counter == 4'b0110);
        $display("add_to_link_head_up6-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_head_right.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up7(counter == 4'b0111);
        $display("add_to_link_head_up7-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_head_down.get_valueVC15();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up8(counter == 4'b1000);
        $display("add_to_link_head_up8-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_core.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up9(counter == 4'b1001);
        $display("add_to_link_head_up9-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_left.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up10(counter == 4'b1010);
        $display("add_to_link_head_up10-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_right.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up11(counter == 4'b1011);
        $display("add_to_link_head_up11-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_up.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up12(counter == 4'b1100);
        $display("add_to_link_head_up12-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_down.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up13(counter == 4'b1101);
        $display("add_to_link_head_up13-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_head_left.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up14(counter == 4'b1110);
        $display("add_to_link_head_up14-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_head_right.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule

    rule add_to_link_head_up15(counter == 4'b1111);
        $display("add_to_link_head_up15-> my_addr %d",my_addr.netAddress);    
        Flit data_head_up=defaultValue;
        data_head_up <- router_head_down.get_valueVC16();
        output_link_head_up.enq(data_head_up);
    endrule    

    // To send to head_down neighbour, we have to choose from available VC17 and VC18s
    // The chosen flit is added to the OUTPUT_LINK_HEAD_DOWN

    rule add_to_link_head_down0(counter == 4'b0000);
        $display("add_to_link_head_down0-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_core.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down1(counter == 4'b0001);
        $display("add_to_link_head_down1-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_left.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down2(counter == 4'b0010);
        $display("add_to_link_head_down2-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_right.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down3(counter == 4'b0011);
        $display("add_to_link_head_down3-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_up.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down4(counter == 4'b0100);
        $display("add_to_link_head_down4-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_down.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down5(counter == 4'b0101);
        $display("add_to_link_head_down5-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_head_left.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down6(counter == 4'b0110);
        $display("add_to_link_head_down6-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_head_right.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down7(counter == 4'b0111);
        $display("add_to_link_head_down7-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_head_up.get_valueVC17();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down8(counter == 4'b1000);
        $display("add_to_link_head_down8-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_core.get_valueVC18();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down9(counter == 4'b1001);
        $display("add_to_link_head_down9-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_left.get_valueVC18();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down10(counter == 4'b1010);
        $display("add_to_link_head_down10-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_right.get_valueVC18();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down11(counter == 4'b1011);
        $display("add_to_link_head_down11-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_up.get_valueVC18();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down12(counter == 4'b1100);
        $display("add_to_link_head_down12-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_down.get_valueVC18();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down13(counter == 4'b1101);
        $display("add_to_link_head_down13-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_head_left.get_valueVC18();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down14(counter == 4'b1110);
        $display("add_to_link_head_down14-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_head_right.get_valueVC18();
        output_link_head_down.enq(data_head_down);
    endrule

    rule add_to_link_head_down15(counter == 4'b1111);
        $display("add_to_link_head_down15-> my_addr %d",my_addr.netAddress);    
        Flit data_head_down=defaultValue;
        data_head_down <- router_head_up.get_valueVC18();
        output_link_head_down.enq(data_head_down);
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

    method ActionValue#(Flit) get_value_to_down();
        let data_to_down = output_link_down.first();
        output_link_down.deq();
        return data_to_down;
    endmethod

    method ActionValue#(Flit) get_value_to_head_left();
        let data_to_head_left = output_link_head_left.first();
        output_link_head_left.deq();
        return data_to_head_left;        
    endmethod

    method ActionValue#(Flit) get_value_to_head_right();
        let data_to_head_right = output_link_head_right.first();
        output_link_head_right.deq();
        return data_to_head_right;
    endmethod

    method ActionValue#(Flit) get_value_to_head_up();
        let data_to_head_up = output_link_head_up.first();
        output_link_head_up.deq();
        return data_to_head_up;
    endmethod

    method ActionValue#(Flit) get_value_to_head_down();
        let data_to_head_down = output_link_head_down.first();
        output_link_head_down.deq();
        return data_to_head_down;
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

    method Action put_value_from_down(Flit data_down);
        router_down.put_value(data_down);
    endmethod

    method Action put_value_from_head_left(Flit data_head_left);
        router_head_left.put_value(data_head_left);
    endmethod

    method Action put_value_from_head_right(Flit data_head_right);
        router_head_right.put_value(data_head_right);
    endmethod

    method Action put_value_from_head_up(Flit data_head_up);
        router_head_up.put_value(data_head_up);
    endmethod

    method Action put_value_from_head_down(Flit data_head_down);
        router_head_down.put_value(data_head_down);
    endmethod
  
endmodule: mkMeshHeadNode

endpackage: MeshHeadNodeVC
