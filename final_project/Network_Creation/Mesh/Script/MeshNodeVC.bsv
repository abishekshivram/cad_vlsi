package MeshNodeVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import MeshRouterVC :: *;


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

module mkMeshNode #(parameter Address my_addr, parameter bit level) (IfcMeshNode);

    Reg#(bit) lvl <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)

    // Core and three routers - core, left link, right link instantiation
    let core            <- mkCore(my_addr); 
    let router_left     <- mkMeshRouterVC(my_addr); 
    let router_right    <- mkMeshRouterVC(my_addr); 
    let router_up       <- mkMeshRouterVC(my_addr);
    let router_down     <- mkMeshRouterVC(my_addr);
    let router_core     <- mkMeshRouterVC(my_addr);

    Reg#(Bit#(3)) counter   <- mkReg(0);

    // This counter is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter <= counter + 1;
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
    // in a round robin fashion (implemented through 2 bit counter) (2 bit because we have 4 VCs to choose from)
    rule outputLinkCore0(counter == 3'b000);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC1();
        core.put_flit(data_core);
    endrule


    rule outputLinkCore1(counter == 3'b001);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC1();
        core.put_flit(data_core);
    endrule


    rule outputLinkCore2(counter == 3'b010);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC1();
        core.put_flit(data_core);
    endrule


    rule outputLinkCore3(counter == 3'b011);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
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
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC2();
        core.put_flit(data_core);
    endrule


    rule outputLinkCore6(counter == 3'b110);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_up.get_valueVC2();
        core.put_flit(data_core);
    endrule


    rule outputLinkCore7(counter == 3'b111);
        $display("here flit is put into core from router left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_down.get_valueVC2();
        core.put_flit(data_core);
    endrule




    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left    <- mkFIFO;
    FIFO#(Flit) output_link_right   <- mkFIFO;
    FIFO#(Flit) output_link_up      <- mkFIFO;
    FIFO#(Flit) output_link_down    <- mkFIFO;
    

    // Sending to left neighbour
    rule add_to_link_left0(counter == 3'b000);
        $display("add_to_link_left0 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left1(counter == 3'b001);
        $display("add_to_link_left1 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left2(counter == 3'b010);
        $display("add_to_link_left2 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left3(counter == 3'b011);
        $display("add_to_link_left3 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left4(counter == 3'b100);
        $display("add_to_link_left4 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left5(counter == 3'b101);
        $display("add_to_link_left5 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_up.get_valueVC4();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left6(counter == 3'b110);
        $display("add_to_link_left6 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_down.get_valueVC4();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left7(counter == 3'b111);
        $display("add_to_link_left7 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC4();
        output_link_left.enq(data_left);
    endrule



    // Sending to right neighbour
    rule add_to_link_right0(counter == 3'b000);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right1(counter == 3'b001);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right2(counter == 3'b010);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right3(counter == 3'b011);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right4(counter == 3'b100);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_up.get_valueVC6();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right5(counter == 3'b101);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_down.get_valueVC6();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right6(counter == 3'b110);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC6();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right7(counter == 3'b111);
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule


    // Sending to up neighbour
    rule add_to_link_up0(counter == 3'b000);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_down.get_valueVC7();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up1(counter == 3'b001);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_core.get_valueVC7();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up2(counter == 3'b010);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_left.get_valueVC7();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up3(counter == 3'b011);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_right.get_valueVC7();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up4(counter == 3'b100);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_down.get_valueVC8();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up5(counter == 3'b101);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_core.get_valueVC8();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up6(counter == 3'b110);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_left.get_valueVC8();
        output_link_up.enq(data_up);
    endrule


    rule add_to_link_up7(counter == 3'b111);
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_right.get_valueVC8();
        output_link_up.enq(data_up);
    endrule



    // Sending to down neighbour
    rule add_to_link_down0(counter == 3'b000);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_down.get_valueVC9();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down1(counter == 3'b001);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_core.get_valueVC9();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down2(counter == 3'b010);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_left.get_valueVC9();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down3(counter == 3'b011);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_right.get_valueVC9();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down4(counter == 3'b100);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_down.get_valueVC10();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down5(counter == 3'b101);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_core.get_valueVC10();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down6(counter == 3'b110);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_left.get_valueVC10();
        output_link_down.enq(data_down);
    endrule


    rule add_to_link_down7(counter == 3'b111);
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_right.get_valueVC10();
        output_link_down.enq(data_down);
    endrule


    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
    method ActionValue#(Flit) get_value_to_left();
        let data_to_left = output_link_left.first();
        output_link_left.deq();
        return data_to_left;
    endmethod


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

    method Action put_value_from_right(Flit data_right);
        router_right.put_value(data_right);
    endmethod

    method Action put_value_from_up(Flit data_up);
        router_up.put_value(data_up);
    endmethod

    method Action put_value_from_down(Flit data_down);
        router_down.put_value(data_down);
    endmethod 

endmodule

endpackage: MeshNodeVC
