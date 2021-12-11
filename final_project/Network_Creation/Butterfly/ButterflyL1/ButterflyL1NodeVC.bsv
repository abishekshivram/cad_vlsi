package ButterflyL1NodeVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;


interface IfcButterflyL1Node;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value(Flit data);
    method ActionValue#(Flit) get_value();

    method Action put_value_from_l2(Flit data_l2);
    method ActionValue#(Flit) get_value_to_l2();

endinterface


(* synthesize *)

// module mkButterflyNode #(parameter Address my_addr, parameter bit level) (IfcButterflyNode);
module mkButterflyL1Node #(parameter Address my_addr) (IfcButterflyL1Node);

    FIFO#(Flit) output_link     <- mkFIFO; // Whatever that we have to insert to route to other side
    FIFO#(Flit) output_link_l2  <- mkFIFO;
    // Arbiter - connecting Output links to VC


    method ActionValue#(Flit) get_value();
        let data = output_link.first();
        output_link.deq();
        return data;
    endmethod

    method Action put_value(Flit data);
        output_link_l2.enq(data);
    endmethod

    method ActionValue#(Flit) get_value_to_l2();
        let data = output_link_l2.first();
        output_link_l2.deq();
        return data;
    endmethod

    method Action put_value_from_l2(Flit data);
        output_link.enq(data);
    endmethod

endmodule

endpackage: ButterflyL1NodeVC
