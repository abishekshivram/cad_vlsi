package nodeVC;

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

    Reg#(bit)   lvl      <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)
    Reg#(Bit#(3))   my_id   <- mkReg(set_id); // using python - *insert the id and bits, assumed 3*
    
    let int_id = unpack({'0, (set_id)});

    let core <- mkCore(int_id);
    /*
    method Action put_data(int data);
    method int return_data();
    */

    // Three routers - core, left link, right link
    let router_left     <- mkChainRouterVC();
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



    
    // VC1 and VC2 are used to send data to the core
    // Rule - Output link - connecting to associated core
    rule outputLinkCore;
        int data_core = 0;
        //let data = case(unpack(counter)) matches 
        case(counter) matches 
            2'b00: data_core <- router_left.get_valueVC1();
            2'b01: data_core <- router_right.get_valueVC1();
            2'b10: data_core <- router_left.get_valueVC2();
            2'b11: data_core <- router_right.get_valueVC2();
        endcase
        core.put_data(data_core);
    endrule


    FIFO#(int) output_link_left <- mkFIFO;
    FIFO#(int) output_link_right <- mkFIFO;

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

    method ActionValue#(int) get_value_to_left();
        let data_to_left = output_link_left.first();
        output_link_left.deq();
        return data_to_left;
    endmethod

    method ActionValue#(int) get_value_to_right();
        let data_to_right = output_link_right.first();
        output_link_right.deq();
        return data_to_right;
    endmethod
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
    method Action put_value_from_left(int data_left);
        router_left.put_value(data_left);
    endmethod

    method Action put_value_from_right(int data_right);
        router_right.put_value(data_right);
    endmethod

  

endmodule

endpackage: nodeVC