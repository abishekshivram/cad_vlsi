package ButterflyL2NodeVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;


interface IfcButterflyL2Node;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value(Flit data);
    method ActionValue#(Flit) get_value();

endinterface


(* synthesize *)

// module mkButterflyNode #(parameter Address my_addr, parameter bit level) (IfcButterflyNode);
module mkButterflyL2Node #(parameter Address my_addr, parameter Address head_node_addr) (IfcButterflyL2Node);

    // Reg#(bit) lvl <- mkReg(level); // 0 for low level (L2), 1 for high level (L1)

    // Core and three routers - core, left link, right link instantiation
    let core                <- mkCore(my_addr, head_node_addr);
    FIFO#(Flit) output_link <- mkFIFO;
    
    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True)
            output_link.enq(flit_generated);
    endrule


    method ActionValue#(Flit) get_value();
        let data = output_link.first();
        output_link.deq();
        return data;
    endmethod

    method Action put_value(Flit data);
        core.put_flit(data);
    endmethod

endmodule

endpackage: ButterflyL2NodeVC
