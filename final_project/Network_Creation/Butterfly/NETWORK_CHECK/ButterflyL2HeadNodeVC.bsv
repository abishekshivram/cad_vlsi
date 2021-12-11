package ButterflyL2HeadNodeVC;

import Shared::*;

import FIFO :: * ;
import Core :: * ;


interface IfcButterflyL2HeadNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value(Flit data);
    method ActionValue#(Flit) get_value();
    
    method ActionValue#(Flit) get_value_to_l1();
    method Action put_value_from_l1(Flit data_from_L1);

endinterface


(* synthesize *)

module mkButterflyL2HeadNode #(parameter Address my_addr, parameter Address head_node_addr) (IfcButterflyL2HeadNode);

    // Core and three routers - core, left link, right link instantiation
    let core                    <- mkCore(my_addr, head_node_addr);
    FIFO#(Flit) output_link     <- mkFIFO;
    FIFO#(Flit) output_link_l1  <- mkFIFO;
    
    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.get_generated_flit();
        if(core.is_flit_generated()==True) begin
            if(flit_generated.finalDstAddress.netAddress == my_addr.netAddress) begin
                output_link.enq(flit_generated);
            end
            else begin
                output_link_l1.enq(flit_generated);
            end
        end
    endrule

    method ActionValue#(Flit) get_value();
        let data = output_link.first();
        output_link.deq();
        return data;
    endmethod

    method Action put_value(Flit data);
        core.put_flit(data);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        let data = output_link_l1.first();
        output_link_l1.deq();
        return data;
    endmethod

    method Action put_value_from_l1(Flit data_from_L1);
        if (data_from_L1.finalDstAddress.nodeAddress == my_addr.nodeAddress) begin
            core.put_flit(data_from_L1);
        end
        else begin
            output_link.enq(data_from_L1);
        end
    endmethod

endmodule

endpackage: ButterflyL2HeadNodeVC
