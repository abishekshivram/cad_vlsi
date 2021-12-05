package: nodeVC

import FIFO :: * ;
import Core :: * ;
import ChainRouterVC :: *;

interface IfcNode;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action PutValuefromLeft(int data);
    method Action PutValuefromRight(int data);

    method ActionValue#(int) GetValuetoLeft();
    method ActionValue#(int) GetValuetoRight();

endinterface

module mkChainNode(IfcNode);

    let core <- mkCore();
    /*
    method Action put_data(int data);
    method int return_data();
    */

    // Three routers - core, left link, right link
    let router_left     <- mkChainRouterVC();
    let router_right    <- mkChainRouterVC();
    let router_core     <- mkChainRouterVC();

    Reg#(Bit#(3)) counter   <- mkReg(0);

    // This counter is used by arbiters to choose VC to send out data
    rule count_every_cycle;
        counter <= counter + 1;
    endrule

    // Arbiter - connecting Output links to VC
    rule core_to_router;
        let flit_generated = core.return_data();
        router_core.PutValue(flit_generated);
    endrule


    // VC1 and VC2 are used to send data to the core
    // Rule - Output link - connecting to associated core
    rule OutputLinkCore;
        let data = case(counter)
                    0: router_left.GetValueVC1();
                    1: router_right.GetValueVC1();
                    2: router_left.GetValueVC2();
                    3: router_right.GetValueVC2();
        endcase
        core.put_data(data);
    endrule

    // VC3 and VC4 are used to send data to the left neighbour
    // Method - Output link - connecting to left neighbour
    method ActionValue#(int) GetValuetoLeft();
        let data = case(counter)
                    0: router_right.GetValueVC3();
                    1: router_core.GetValueVC3();
                    2: router_right.GetValueVC4();
                    3: router_core.GetValueVC4();
        endcase
        return data;
    endmethod

    // VC5 and VC6 are used to send data to the right neighbour
    // Method - Output link - connecting to right neighbour
    method ActionValue#(int) GetValuetoRight();
        let data = case(counter)
                    0: router_core.GetValueVC5();
                    1: router_left.GetValueVC5();
                    2: router_core.GetValueVC6();
                    3: router_left.GetValueVC6();
        endcase
        return data;
    endmethod

    // Methods to take care of input links
    method Action PutValuefromLeft(int data);
        router_left.PutValue(data);
    endmethod

    method Action PutValuefromRight(int data);
        router_right.PutValue(data);
    endmethod

    method Action PutValuefromCore(int data);
        router_core.PutValue(data);
    endmethod

endmodule

endpackage: nodeVC