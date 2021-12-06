package ChainNodeVC;

import FIFO :: * ;
import Core :: * ;
import ChainRouterVC :: *;


interface IfcChainNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value_from_left(int data_left);
    method Action put_value_from_right(int data_right);

    method ActionValue#(int) get_value_to_left();
    method ActionValue#(int) get_value_to_right();

endinterface


(* synthesize *)

module mkChainNode #(parameter Bit#(3) set_id, parameter bit level) (IfcChainNode);

    Reg#(bit)       lvl     <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)
    Reg#(Bit#(3))   my_id   <- mkReg(set_id); // register to contain the name of the node

    let int_id = unpack({'0, (set_id)}); // converting three bits name to an int variable


    // A node contains three routers and one core (L2 level only)
    let core <- mkCore(int_id); // core instantiation
    // Three routers - core, left link, right link
    let router_left     <- mkChainRouterVC(); // takes input from left neighbour and puts in corresponding VC
    let router_right    <- mkChainRouterVC();
    let router_core     <- mkChainRouterVC();

    Reg#(Bit#(2)) counter   <- mkReg(0);

    // This counter is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter <= counter + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.return_data();
        router_core.put_value(flit_generated);
    endrule



    
    // VC1 and VC2 are used to send data to the core (as decided earlier)
    // Rule - Output link - connecting to associated core
    // In this rule, we choose VC1 or VC2 from router_left or router_right (router_core cannot send to itself)
    // in a round robin fashion (implemented through 2 bit counter) (2 bit because we have 4 VCs to choose from)
    rule outputLinkCore;
        
        // Variable to temporarily store the returned data
        int data_core = 0;
        
        // The data(flit) is taken from the choosen VC
        case(counter) matches 
            2'b00: data_core <- router_left.get_valueVC1();
            2'b01: data_core <- router_right.get_valueVC1();
            2'b10: data_core <- router_left.get_valueVC2();
            2'b11: data_core <- router_right.get_valueVC2();
        endcase
        // The data(flit) is put into the core to be consumed
        core.put_data(data_core);
    endrule

    // Without these buffer, there was error compiling 
    // (ie) to send directly from VC to next input link buffer, it showed error (below commented code)
    // These output link buffers were added to store the flit from VC in FIFO order and send them to next INPUT LINK
    FIFO#(int) output_link_left <- mkFIFO;
    FIFO#(int) output_link_right <- mkFIFO;

    // To send to left neighbour, we have to choose from available VC3s and VC4s
    // The chosen flit is added to the OUTPUT_LINK_LEFT
    rule add_to_link_left;
        int data_left = 0;
        case(counter) matches
            2'b00:  data_left <- router_right.get_valueVC3();
            2'b01:  data_left <- router_core.get_valueVC3();
            2'b10:  data_left <- router_right.get_valueVC4();
            2'b11:  data_left <- router_core.get_valueVC4();
        endcase
        output_link_left.enq(data_left);
    endrule

    // To send to right neighbour, we have to choose from available VC5s and VC6s
    // The chosen flit is added to the OUTPUT_LINK_RIGHT
    rule add_to_link_right;
        int data_right = 0;
        case(counter) matches
            2'b00: data_right <- router_core.get_valueVC5();
            2'b01: data_right <- router_left.get_valueVC5();
            2'b10: data_right <- router_core.get_valueVC6();
            2'b11: data_right <- router_left.get_valueVC6();
        endcase
        output_link_right.enq(data_right);
    endrule

    // Method to take the flit from OUTPUT_LINK_LEFT and return 
    // This is invoked in NOC.bsv where final connections are made
    method ActionValue#(int) get_value_to_left();
        let data_to_left = output_link_left.first();
        output_link_left.deq();
        return data_to_left;
    endmethod

    // Method to take the flit from OUTPUT_LINK_RIGHT and return 
    method ActionValue#(int) get_value_to_right();
        let data_to_right = output_link_right.first();
        output_link_right.deq();
        return data_to_right;
    endmethod

    // These did not work, so an output link buffer was made (as seen in above lines)

    // // VC3 and VC4 are used to send data to the left neighbour
    // // Method - Output link - connecting to left neighbour
    // method int get_value_to_left();
    //     int data_left;
    //     case(counter) matches
    //                 2'b00:  data_left <- router_right.get_valueVC3();
    //                 2'b01:  data_left <- router_core.get_valueVC3();
    //                 2'b10:  data_left <- router_right.get_valueVC4();
    //                 2'b11:  data_left <- router_core.get_valueVC4();
    //     endcase
    //     return data_left;
    // endmethod

    // // VC5 and VC6 are used to send data to the right neighbour
    // // Method - Output link - connecting to right neighbour
    // method int get_value_to_right();
    //     int data_right;
    //     case(unpack(counter)) matches
    //                 0: data_right <- router_core.get_valueVC5();
    //                 1: data_right <- router_left.get_valueVC5();
    //                 2: data_right <- router_core.get_valueVC6();
    //                 3: data_right <- router_left.get_valueVC6();
    //     endcase
    //     return data_right;
    // endmethod

    // Methods to take care of input links 
    // (ie) the flits that come from left neighbour are inserted to the router_left's input link buffer
    method Action put_value_from_left(int data_left);
        router_left.put_value(data_left);
    endmethod

    // The flits that come from right neighbour are inserted to the router_right's input link buffer
    method Action put_value_from_right(int data_right);
        router_right.put_value(data_right);
    endmethod

  

endmodule

endpackage: ChainNodeVC