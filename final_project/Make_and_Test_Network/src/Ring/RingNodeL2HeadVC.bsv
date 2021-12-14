package RingNodeL2HeadVC;

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;
import RingRouterL2HeadVC :: *;


interface IfcRingL2HeadNode;

    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_l1(Flit data_from_L1);
    method ActionValue#(Flit) get_value_to_l1();

    method Action put_value_from_left(Flit data_left);
    method Action put_value_from_right(Flit data_right);

    method ActionValue#(Flit) get_value_to_left();
    method ActionValue#(Flit) get_value_to_right();

    method Action put_value_from_left_dateline(Flit data_left);
    method Action put_value_from_right_dateline(Flit data_right);

    method ActionValue#(Flit) get_value_to_left_dateline();
    method ActionValue#(Flit) get_value_to_right_dateline();

endinterface


(* synthesize *)

module mkRingL2HeadNode #(parameter Address my_addr, parameter NodeAddress maxNodeAddress, parameter Address head_node_addr) (IfcRingL2HeadNode);

    // Reg#(bit) lvl <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)

    // Core and three routers - core, left link, right link instantiation
    let core            <- mkCore(my_addr,head_node_addr); 
    let router_left     <- mkRingRouterL2HeadVC(my_addr,maxNodeAddress); // takes input from left neighbour and puts in corresponding VC
    let router_right    <- mkRingRouterL2HeadVC(my_addr,maxNodeAddress);
    let router_core     <- mkRingRouterL2HeadVC(my_addr,maxNodeAddress);
    let router_L1       <- mkRingRouterL2HeadVC(my_addr,maxNodeAddress);

    Reg#(Bit#(3)) counter   <- mkReg(0);

    //A counter to help deciding when to display link utilisation
    Reg#(LinkUtiliPrInterval) link_util_print_interval <- mkReg(0); 
    rule incr_link_util_print_interval;
        link_util_print_interval <= link_util_print_interval+1;
    endrule
    rule print_link_utilisation(link_util_print_interval==0);
        let rl=router_left.get_link_util_counter();
        let rr=router_right.get_link_util_counter();
        let rl1=router_L1.get_link_util_counter();
        //Needed- router_l2??
        $display("@@@@@@@@@@@@@@@ Link utilisation at Node:%h,%h | : Left Link->%d, Right Link->%d, L1 link->%d",my_addr.netAddress,my_addr.nodeAddress,rl,rr,rl1);
    endrule
    
    // This counter is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        if(counter == 3'b101) counter <= 0;
        else counter <= counter + 1;
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
        $display("here flit is put into core from router_right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore2(counter == 3'b010);
        $display("here flit is put into core from router_l1right vc1; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_L1.get_valueVC1();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore3(counter == 3'b011);
        $display("here flit is put into core from router_left vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_left.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore4(counter == 3'b100);
        $display("here flit is put into core from router_right vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_right.get_valueVC2();
        core.put_flit(data_core);
    endrule

    rule outputLinkCore5(counter == 3'b101);
        $display("here flit is put into core from router_l1 vc2; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_L1.get_valueVC2();
        core.put_flit(data_core);
    endrule

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(Flit) output_link_left            <- mkFIFO;
    FIFO#(Flit) output_link_right           <- mkFIFO;
    FIFO#(Flit) output_link_left_dateline   <- mkFIFO;
    FIFO#(Flit) output_link_right_dateline  <- mkFIFO;
    FIFO#(Flit) output_link_l1              <- mkFIFO;

    rule add_to_link_right0(counter == 3'b000 || counter == 3'b011);
        $display("add_to_link_right0-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_core.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right1(counter == 3'b001 || counter == 3'b100);
        $display("add_to_link_right1-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_left.get_valueVC5();
        output_link_right.enq(data_right);
    endrule

    rule add_to_link_right2(counter == 3'b010 || counter == 3'b101);
        $display("add_to_link_right2-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_L1.get_valueVC5();
        output_link_right.enq(data_right);
    endrule


    rule add_to_link_right3(counter == 3'b000 || counter == 3'b011);
        $display("add_to_link_right3-> my_addr %d",my_addr.netAddress);    
        Flit data_right_dateline=defaultValue;
        data_right_dateline <- router_core.get_valueVC6();
        output_link_right_dateline.enq(data_right_dateline);
    endrule


    rule add_to_link_right4(counter == 3'b001 || counter == 3'b100);
        $display("add_to_link_right4-> my_addr %d",my_addr.netAddress);    
        Flit data_right_dateline=defaultValue;
        data_right_dateline <- router_left.get_valueVC6();
        output_link_right_dateline.enq(data_right_dateline);
    endrule

    rule add_to_link_right5(counter == 3'b010 || counter == 3'b101);
        $display("add_to_link_right5-> my_addr %d",my_addr.netAddress);    
        Flit data_right_dateline=defaultValue;
        data_right_dateline <- router_L1.get_valueVC6();
        output_link_right_dateline.enq(data_right_dateline);
    endrule

    //NOTE LLOYD This can be improved
    //If chosen VC (counter) has no data, the cycle would be wasted, cannot consume data available in other VCs??
    // To send to left neighbour, we have to choose from available VC3s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT
    rule add_to_link_left0(counter == 3'b000 || counter == 3'b011);
        $display("add_to_link_left0 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_right.get_valueVC3();
        output_link_left.enq(data_left);
    endrule


    rule add_to_link_left1(counter == 3'b001 || counter == 3'b100);
        $display("add_to_link_left1 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_core.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left2(counter == 3'b010 || counter == 3'b101);
        $display("add_to_link_left2 -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_L1.get_valueVC3();
        output_link_left.enq(data_left);
    endrule

    rule add_to_link_left3(counter == 3'b000 || counter == 3'b011);
        $display("add_to_link_left3 -> my_addr %d",my_addr.netAddress);    
        Flit data_left_dateline=defaultValue;
        data_left_dateline <- router_right.get_valueVC4();
        output_link_left_dateline.enq(data_left_dateline);
    endrule


    rule add_to_link_left4(counter == 3'b001 || counter == 3'b100);
        $display("add_to_link_left4 -> my_addr %d",my_addr.netAddress);    
        Flit data_left_dateline=defaultValue;
        data_left_dateline <- router_core.get_valueVC4();
        output_link_left_dateline.enq(data_left_dateline);
    endrule

    rule add_to_link_left5(counter == 3'b010 || counter == 3'b101);
        $display("add_to_link_left5 -> my_addr %d",my_addr.netAddress);    
        Flit data_left_dateline=defaultValue;
        data_left_dateline <- router_L1.get_valueVC4();
        output_link_left_dateline.enq(data_left_dateline);
    endrule



    // Router to l1 connection
    rule add_to_link_l1_0(counter == 3'b000);
        $display("add_to_link_l1_0-> my_addr %d",my_addr.netAddress);    
        Flit data_l1=defaultValue;
        data_l1 <- router_core.get_valueVC7();
        output_link_l1.enq(data_l1);
    endrule


    rule add_to_link_l1_1(counter == 3'b001);
        $display("add_to_link_l1_1-> my_addr %d",my_addr.netAddress);    
        Flit data_l1=defaultValue;
        data_l1 <- router_left.get_valueVC7();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_2(counter == 3'b010);
        $display("add_to_link_l1_2-> my_addr %d",my_addr.netAddress);    
        Flit data_l1=defaultValue;
        data_l1 <- router_right.get_valueVC7();
        output_link_l1.enq(data_l1);
    endrule


    rule add_to_link_l1_3(counter == 3'b011);
        $display("add_to_link_l1_3-> my_addr %d",my_addr.netAddress);    
        Flit data_l1=defaultValue;
        data_l1 <- router_core.get_valueVC8();
        output_link_l1.enq(data_l1);
    endrule


    rule add_to_link_l1_4(counter == 3'b100);
        $display("add_to_link_l1_4-> my_addr %d",my_addr.netAddress);    
        Flit data_l1=defaultValue;
        data_l1 <- router_left.get_valueVC8();
        output_link_l1.enq(data_l1);
    endrule

    rule add_to_link_l1_5(counter == 3'b101);
        $display("add_to_link_l1_5-> my_addr %d",my_addr.netAddress);    
        Flit data_l1=defaultValue;
        data_l1 <- router_right.get_valueVC8();
        output_link_l1.enq(data_l1);
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
    
    // Flit is added to router L1
    method Action put_value_from_l1(Flit data_from_L1);
        router_L1.put_value(data_from_L1);
    endmethod

  

endmodule

endpackage: RingNodeL2HeadVC
