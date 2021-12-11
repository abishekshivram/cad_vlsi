package ChainNodeL2VC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import ChainRouterL2VC :: *;


interface IfcChainL2Node;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);

    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();

endinterface


(* synthesize *)

module mkChainL2Node #(parameter Address my_addr, parameter Address head_node_addr) (IfcChainL2Node);


    // Core and three routers - core, left link, right link instantiation
    let core            <- mkCore(my_addr, head_node_addr); 
    let router_left     <- mkChainRouterL2VC(my_addr); // takes input from left neighbour and puts in corresponding VC
    let router_right    <- mkChainRouterL2VC(my_addr);
    let router_core     <- mkChainRouterL2VC(my_addr);

    Reg#(Bit#(2)) counter   <- mkReg(0);

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
    
    rule outputLinkCore0(counter == 2'b00);
        $display("here flit is put into core from router left vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC1();
        core.put_flit(data_core);
    endrule
    
    rule outputLinkCore1(counter == 2'b01);
        $display("here flit is put into core from router_right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore2(counter == 2'b10);
        $display("here flit is put into core from router_left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore3(counter == 2'b11);
        $display("here flit is put into core from router_right vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC2();
        core.put_flit(data_core);
    endrule


    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left <- mkFIFO;
    FIFO#(Flit) output_link_right <- mkFIFO;

    rule add_to_link_right0(counter == 2'b00);
        $display("add_to_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right1(counter == 2'b01);
        $display("add_to_link_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right2(counter == 2'b10);
        $display("add_to_link_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC6();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right3(counter == 2'b11);
        $display("add_to_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC6();
        output_link_right.enq(data_right);
    endrule

    //NOTE LLOYD This can be improved
    //If chosen VC (counter) has no data, the cycle would be wasted, cannot consume data available in other VCs??
    // To send to left neighbour, we have to choose from available VC3s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT
    rule add_to_link_left0(counter == 2'b00);
        $display("add_to_link_left0 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left1(counter == 2'b01);
        $display("add_to_link_left1 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left2(counter == 2'b10);
        $display("add_to_link_left2 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC4();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left3(counter == 2'b11);
        $display("add_to_link_left3 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC4();
        output_link_left.enq(data_left);
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

    // Method to take the flit from OUTPUT_LINK_RIGHT and return 
    method ActionValue#(Flit) get_value_to_right();
        let data_to_right = output_link_right.first();
        output_link_right.deq();
        return data_to_right;
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

  

endmodule

endpackage: ChainNodeL2VC
