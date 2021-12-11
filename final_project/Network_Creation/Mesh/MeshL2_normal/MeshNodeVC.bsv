package MeshNodeVC;

import Parameters:: *;
import Shared::*;

import FIFO :: * ;
import Core :: * ;

import MeshRouterVC::*;

interface IfcMeshNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);
    method Action put_value_from_up(Flit data_up);
    method Action put_value_from_down(Flit data_down);

    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();
    method ActionValue#(Flit) get_value_to_up();
    method ActionValue#(Flit) get_value_to_down();
endinterface


(* synthesize *)

module mkMeshNode #(parameter Address my_addr, parameter Address head_node_addr) (IfcMeshNode);

    // Core and three routers - core, left link, right link instantiation
    let core                <- mkCore(my_addr,head_node_addr); 
    //Left, right routers
    let router_left         <- mkMeshRouterVC(my_addr); // takes input from left neighbour and puts in corresponding VC
    let router_right        <- mkMeshRouterVC(my_addr);
    let router_up           <- mkMeshRouterVC(my_addr);
    let router_down         <- mkMeshRouterVC(my_addr);
    
    let router_core         <- mkMeshRouterVC(my_addr);

    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left <- mkFIFO;
    FIFO#(Flit) output_link_right <- mkFIFO;
    FIFO#(Flit) output_link_up <- mkFIFO;
    FIFO#(Flit) output_link_down <- mkFIFO;

    //A counter to help deciding when to display link utilisation
    Reg#(LinkUtiliPrInterval) link_util_print_interval <- mkReg(0); 
    rule incr_link_util_print_interval;
        link_util_print_interval <= link_util_print_interval+1;
    endrule
    rule print_link_utilisation(link_util_print_interval==0);
        let rl=router_left.get_link_util_counter();
        let rr=router_right.get_link_util_counter();
        let ru=router_up.get_link_util_counter();
        let rd=router_down.get_link_util_counter();
        $display("@@@@@@@@@@@@@@@ Link utilisation at Node:%h,%h | : Left Link->%d, Right Link->%d, Up Link->%d, Down Link->%d",my_addr.netAddress,my_addr.nodeAddress,rl,rr,ru,rd);
    endrule

    // This counter is used by arbiters to choose VC to send out data
    Reg#(Bit#(3)) counter   <- mkReg(0); 
    rule count_every_cycle;
        counter <= counter + 1;
    endrule

    //If core generated a flit, move it to core router    
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            router_core.put_value(flit_generated);
            $display("<<<<<<<<<<<<<<<<<<<Flit generated | Source: %h (Network),%h (Node) | Destination: -> %h (Network),%h (Node)",flit_generated.srcAddress.netAddress,flit_generated.srcAddress.nodeAddress,flit_generated.finalDstAddress.netAddress,flit_generated.finalDstAddress.nodeAddress);
        end
    endrule

      
    // VC1 and VC2 are used to send data to the core (as decided earlier)
    // Rule - Output link - connecting to associated core
    // In this rule, we choose VC1 or VC2 from router_left or router_right,router_head_left,router_head_right (router_core cannot send to itself)
    // in a round robin fashion (implemented through 3 bit counter) (3 bit because we have 8 VCs to choose from)
    
    rule outputLinkCore0(counter == 3'b000);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC1();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore1(counter == 3'b001);
        $display("here flit is put into core from router_right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore2(counter == 3'b010);
        $display("here flit is put into core from router up vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore3(counter == 3'b011);
        $display("here flit is put into core from router_down vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_down.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore4(counter == 3'b100);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC2();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore5(counter == 3'b101);
        $display("here flit is put into core from router_right vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore6(counter == 3'b110);
        $display("here flit is put into core from router up vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore7(counter == 3'b111);
        $display("here flit is put into core from router_down vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_down.get_valueVC2();
        core.put_flit(data_core);
    endrule

    // To send to right neighbour, we have to choose from available VC5s and VC6s
    // The chosen flit is added to the OUTPUT_LINK_RIGHT

    rule add_to_link_right0(counter == 3'b000);
        $display("add_to_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right1(counter == 3'b001);
        $display("add_to_link_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right2(counter == 3'b010);
        $display("add_to_link_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right3(counter == 3'b011);
        $display("add_to_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right4(counter == 3'b100);
        $display("add_to_link_right8-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right5(counter == 3'b101);
        $display("add_to_link_right9-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right6(counter == 3'b110);
        $display("add_to_link_right10-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right7(counter == 3'b111);
        $display("add_to_link_right11-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    // To send to left neighbour, we have to choose from available VC7s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT

    rule add_to_link_left0(counter == 3'b000);
        $display("add_to_link_left0-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left1(counter == 3'b001);
        $display("add_to_link_left1-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left2(counter == 3'b010);
        $display("add_to_link_left2-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left3(counter == 3'b011);
        $display("add_to_link_left3-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left4(counter == 3'b100);
        $display("add_to_link_left8-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left5(counter == 3'b101);
        $display("add_to_link_left9-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left6(counter == 3'b110);
        $display("add_to_link_left10-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left7(counter == 3'b111);
        $display("add_to_link_left11-> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC4();
        output_link_left.enq(data_left);
    endrule


    // To send to up neighbour, we have to choose from available VC7s and VC8s
    // The chosen flit is added to the OUTPUT_LINK_UP

    rule add_to_link_up0(counter == 3'b000);
        $display("add_to_link_up0-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_core.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up1(counter == 3'b001);
        $display("add_to_link_up1-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_left.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up2(counter == 3'b010);
        $display("add_to_link_up2-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_right.get_valueVC7();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up3(counter == 3'b011);
        $display("add_to_link_up3-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_down.get_valueVC7();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up4(counter == 3'b100);
        $display("add_to_link_up8-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_core.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up5(counter == 3'b101);
        $display("add_to_link_up9-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_left.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up6(counter == 3'b110);
        $display("add_to_link_up10-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_right.get_valueVC8();
        output_link_up.enq(data_up);
    endrule

    rule add_to_link_up7(counter == 3'b111);
        $display("add_to_link_up11-> my_addr %d",my_addr.netAddress);    
        Flit data_up=defaultValue;
        data_up <- router_down.get_valueVC8();
        output_link_up.enq(data_up);
    endrule


    // To send to down neighbour, we have to choose from available VC9s and VC10s
    // The chosen flit is added to the OUTPUT_LINK_DOWN

    rule add_to_link_down0(counter == 3'b000);
        $display("add_to_link_down0-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_core.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down1(counter == 3'b001);
        $display("add_to_link_down1-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_left.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down2(counter == 3'b010);
        $display("add_to_link_down2-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_right.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down3(counter == 3'b011);
        $display("add_to_link_down3-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_up.get_valueVC9();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down4(counter == 3'b100);
        $display("add_to_link_down8-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_core.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down5(counter == 3'b101);
        $display("add_to_link_down9-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_left.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down6(counter == 3'b110);
        $display("add_to_link_down10-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_right.get_valueVC10();
        output_link_down.enq(data_down);
    endrule

    rule add_to_link_down7(counter == 3'b111);
        $display("add_to_link_down11-> my_addr %d",my_addr.netAddress);    
        Flit data_down=defaultValue;
        data_down <- router_up.get_valueVC10();
        output_link_down.enq(data_down);
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
 
endmodule: mkMeshNode

endpackage: MeshNodeVC
