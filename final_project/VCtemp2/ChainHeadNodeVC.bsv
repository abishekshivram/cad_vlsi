package ChainHeadNodeVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import ChainRouterVC :: *;


interface IfcChainNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);
    method Action put_value_from_head_left(Flit data_head_left);
    method Action put_value_from_head_right(Flit data_head_right);

    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();
    method ActionValue#(Flit) get_value_to_head_left();
    method ActionValue#(Flit) get_value_to_head_right();

endinterface


(* synthesize *)

module mkChainHeadNode #(parameter Address my_addr, parameter Address head_node_addr, parameter Bool is_head_node) (IfcChainNode);

    // Core and three routers - core, left link, right link instantiation
    let core                <- mkCore(my_addr,head_node_addr); 
    //Left, right routers
    let router_left         <- mkChainRouterVC(my_addr,is_head_node); // takes input from left neighbour and puts in corresponding VC
    let router_right        <- mkChainRouterVC(my_addr,is_head_node);
    //HeadLeft, HeadRight routers
    let router_head_left    <- mkChainRouterVC(my_addr,is_head_node); // takes input from L1 left neighbour and puts in corresponding VC
    let router_head_right   <- mkChainRouterVC(my_addr,is_head_node);
    let router_core         <- mkChainRouterVC(my_addr,is_head_node);

    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left <- mkFIFO;
    FIFO#(Flit) output_link_right <- mkFIFO;
    FIFO#(Flit) output_link_head_left <- mkFIFO;
    FIFO#(Flit) output_link_head_right <- mkFIFO;

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
            $display("<<<<<<<<<<<<<<<<<<<Flit generated | Source: %d (Network),%d (Node) | Destination: -> %d (Network),%d (Node)",flit_generated.srcAddress.netAddress,flit_generated.srcAddress.nodeAddress,flit_generated.finalDstAddress.netAddress,flit_generated.finalDstAddress.nodeAddress);
        end
    endrule

      
    //NOTE LLOYD This (Round robin arbiter) can be improved
    //If chosen VC (counter) has no data, the cycle would be wasted, cannot consume data available in other VCs??
    
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
        $display("here flit is put into core from router_head_left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_left.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore3(counter == 3'b011);
        $display("here flit is put into core from router_head_right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore4(counter == 3'b100);
        $display("here flit is put into core from router_left vc2; Arbiter count-%d", counter);      
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
        $display("here flit is put into core from router_head_left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_left.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore7(counter == 3'b111);
        $display("here flit is put into core from router_head_right vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_head_right.get_valueVC2();
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
        data_right <- router_head_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right3(counter == 3'b011);
        $display("add_to_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_right.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right4(counter == 3'b100);
        $display("add_to_link_right4-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right5(counter == 3'b101);
        $display("add_to_link_right5-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right6(counter == 3'b110);
        $display("add_to_link_right6-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right7(counter == 3'b111);
        $display("add_to_link_right7-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_right.get_valueVC6();
        output_link_right.enq(data_right);
    endrule


    // To send to left neighbour, we have to choose from available VC3s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT
    rule add_to_link_left0(counter == 3'b000);
        $display("add_to_link_left0 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left1(counter == 3'b001);
        $display("add_to_link_left1 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left2(counter == 3'b010);
        $display("add_to_link_left2 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_left.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left3(counter == 3'b011);
        $display("add_to_link_left3 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left4(counter == 3'b100);
        $display("add_to_link_left4 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left5(counter == 3'b101);
        $display("add_to_link_left5 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left6(counter == 3'b110);
        $display("add_to_link_left6 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_left.get_valueVC4();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left7(counter == 3'b111);
        $display("add_to_link_left7 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule


    // To send to l1_right neighbour, we have to choose from available VC9s and VC10s
    // The chosen flit is added to the OUTPUT_LINK_RIGHT
    rule add_to_link_head_right0(counter == 3'b000);
        $display("add_to_head_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC9();
        output_link_head_right.enq(data_right);
    endrule

    rule add_to_link_head_right1(counter == 3'b001);
        $display("add_to_head_link_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC9();
        output_link_head_right.enq(data_right);
    endrule

    rule add_to_link_head_right2(counter == 3'b010);
        $display("add_to_head_link_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_right.get_valueVC9();
        output_link_head_right.enq(data_right);
    endrule

    rule add_to_link_head_right3(counter == 3'b011);
        $display("add_to_head_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_left.get_valueVC9();
        output_link_head_right.enq(data_right);
    endrule

    rule add_to_link_head_right4(counter == 3'b100);
        $display("add_to_head_link_right4-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC10();
        output_link_head_right.enq(data_right);
    endrule

    rule add_to_link_head_right5(counter == 3'b101);
        $display("add_to_head_link_right5-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC10();
        output_link_head_right.enq(data_right);
    endrule

    rule add_to_link_head_right6(counter == 3'b110);
        $display("add_to_head_link_right6-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_right.get_valueVC10();
        output_link_head_right.enq(data_right);
    endrule

    rule add_to_link_head_right7(counter == 3'b111);
        $display("add_to_head_link_right7-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_head_left.get_valueVC10();
        output_link_head_right.enq(data_right);
    endrule


    // To send to l1_left neighbour, we have to choose from available VC7s and VC8s
    // The chosen flit is added to the OUTPUT_LINK_LEFT
    rule add_to_head_link_left0(counter == 3'b000);
        $display("add_to_head_link_left0 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC7();
        output_link_head_left.enq(data_left);
    endrule

    rule add_to_head_link_left1(counter == 3'b001);
        $display("add_to_head_link_left1 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC7();
        output_link_head_left.enq(data_left);
    endrule

    rule add_to_head_link_left2(counter == 3'b010);
        $display("add_to_head_link_left2 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_left.get_valueVC7();
        output_link_head_left.enq(data_left);
    endrule

    rule add_to_head_link_left3(counter == 3'b011);
        $display("add_to_head_link_left3 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_right.get_valueVC7();
        output_link_head_left.enq(data_left);
    endrule

    rule add_to_head_link_left4(counter == 3'b100);
        $display("add_to_head_link_left4 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC8();
        output_link_head_left.enq(data_left);
    endrule

    rule add_to_head_link_left5(counter == 3'b101);
        $display("add_to_head_link_left5 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC8();
        output_link_head_left.enq(data_left);
    endrule

    rule add_to_head_link_left6(counter == 3'b110);
        $display("add_to_head_link_left6 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_left.get_valueVC8();
        output_link_head_left.enq(data_left);
    endrule

    rule add_to_head_link_left7(counter == 3'b111);
        $display("add_to_head_link_left7 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_head_right.get_valueVC8();
        output_link_head_left.enq(data_left);
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

      // Methods to take care of input links 
    // (ie) the flits that come from left neighbour are inserted to the router_left's input link buffer
    method Action put_value_from_left(Flit data_left);
        router_left.put_value(data_left);
    endmethod

    // The flits that come from right neighbour are inserted to the router_right's input link buffer
    method Action put_value_from_right(Flit data_right);
        router_right.put_value(data_right);
    endmethod

    method Action put_value_from_head_left(Flit data_head_left);
        router_head_left.put_value(data_head_left);
    endmethod

    method Action put_value_from_head_right(Flit data_head_right);
        router_head_right.put_value(data_head_right);
    endmethod
  
endmodule: mkChainHeadNode

endpackage: ChainHeadNodeVC
