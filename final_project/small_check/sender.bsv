package sender;
// This package contains the router - which implements the routing algorithm for the chain topology
// Routing algorithm works as follows:
// For each link, two VCs are allocated. For example, in each node in chain topology, we have
// 3 links (core, left neighbour, right neighbour). So 6 VCs are made and VC1,2 allocated to core, 
// VC3,4 allocated to left neighbour, VC5,6 allocated to right neighbour
// This routing can be seen in line 58: Two rules are written that connects the Input link to the respective VC



// FIFO used as buffers in routers
import FIFO :: * ;



interface IfcChainRouterVC ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value (int flit);

    // Each output link gets two VC channel (for chain, we have: left, right, core)
    // Hence, we need 6 VCs
    // Each of the following methods will dequeue (ACTION) an element from the VC and return it (VALUE)
    method ActionValue#(int) get_valueVC1();
    method ActionValue#(int) get_valueVC2();
    method ActionValue#(int) get_valueVC3();
    method ActionValue#(int) get_valueVC4();
    method ActionValue#(int) get_valueVC5();
    method ActionValue#(int) get_valueVC6();
    
endinterface

(* synthesize *)
module mkcheck(Empty);

    let router1 <- mkChainRouterVC(0);
    let router2 <- mkChainRouterVC(1);

    Reg#(int) check1 <- mkReg(0);
    Reg#(int) check2 <- mkReg(0);

    Reg#(int) counter <- mkReg(0);
    
    rule update_counter;
        counter <= counter+1;
    endrule

    rule check1_update1(counter==0);
        router1.put_value(unpack('1));
        $display("put at 0");
    endrule
    
    rule check1_update2(counter==1);
        router1.put_value(unpack({1'b1, 31'b0}));
        $display("put at 1");
    endrule

    rule two_cycle1(counter>=2);
        let data2 <- router1.get_valueVC1();
        $display("counter==%d, data=%h from VC1", counter, data2);
    endrule


    rule two_cycle2(counter>=2);
        let data3 <- router1.get_valueVC2();
        $display("counter==%d, data=%h from VC2", counter, data3);
    endrule

    rule two_cycle3(counter>=2);
        let data4 <- router1.get_valueVC3();
        $display("counter==%d, data=%h from VC3", counter, data4);
    endrule

    rule two_cycle4(counter>=2);
        let data5 <- router1.get_valueVC4();
        $display("counter==%d, data=%h from VC4", counter, data5);
    endrule

    rule two_cycle5(counter>=2);
        let data6 <- router1.get_valueVC5();
        $display("counter==%d, data=%h from VC5", counter, data6);
    endrule

    rule two_cycle6(counter>=2);
        let data7 <- router1.get_valueVC6();
        $display("counter==%d, data=%h from VC6", counter, data7);
    endrule

endmodule







(* synthesize *)
// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkChainRouterVC #(parameter int my_addr) (IfcChainRouterVC);

    // Right now, it has been commented, we may need it for L1, L2 routing
    //Reg#(bit)   level       <- mkReg(0); // 0 for low level (L2), 1 for high level (L1)
    Reg#(int)   my_id   <- mkReg(my_addr); // using python - *insert the id and bits, assumed 3*
    

    // Input link for the router
    FIFO#(int)  input_link   <- mkFIFO; // to get data from left router


    // To store the ints that are sent to core
    FIFO#(int)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(int)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2


    // To store the ints that are sent to left
    FIFO#(int)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(int)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    

    // To store the ints that are sent to right
    FIFO#(int)  vir_chnl_5  <- mkFIFO; // Virtual Channel 5
    FIFO#(int)  vir_chnl_6  <- mkFIFO; // Virtual Channel 6

    // Since we have two VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);

    // Cycle variable oscillates between 0 and 1
    rule invert_cycle;
        cycle <= cycle + 1;
    endrule

    // Connect input_link to respective VC
    // This rules fires every alternate cycle, and chooses even named Virtual Channels (VC1, VC3, VC5)
    rule read_input_link_and_send_to_VC_odd(cycle == 1);
        
        // int flit should be changed to Flit data structure! -Lloyd changed
        let flit = input_link.first();
        input_link.deq();

        // Assumption (not correct): Address is 3 bits. We need to change it!
        int extracted_id = unpack({'0,pack(flit)[31]});
        
        // Reached the destination - core will consume
        if(extracted_id == my_id)  begin
            vir_chnl_1.enq(flit);
        end
        // The current flit has to go to left 
        else if(extracted_id < my_id)  begin
            vir_chnl_3.enq(flit);
        end
        // The current flit has to go to right
        else  begin
            vir_chnl_5.enq(flit);
        end
    endrule

    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC2, VC4, VC6)
    rule read_input_link_and_send_to_VC_even(cycle == 0);

        let flit = input_link.first();
        input_link.deq();
        int extracted_id = unpack({'0,pack(flit)[31]});
        
        // Reached the destination - core will consume
        if(extracted_id == my_id)  begin
            vir_chnl_2.enq(flit);
        end
        // The current flit has to go to left 
        else if(extracted_id < my_id)  begin
            vir_chnl_4.enq(flit);
        end
        // The current flit has to go to right
        else  begin
            vir_chnl_6.enq(flit);
        end
    endrule

    // Method to get the flit into the node
    method Action put_value(int flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link.enq(flit);
    endmethod


    // Following are the six methods (corresponding to six available VCs) 
    // These methods return the flit so that it can reach the next node in its path
    // The VC1, VC2 methods will be invoked to send the flits to the core (as we fixed earlier, line:4)
    method ActionValue#(int) get_valueVC1();
        let temp1 = vir_chnl_1.first();
        vir_chnl_1.deq();
        return temp1;
    endmethod

    method ActionValue#(int) get_valueVC2();
        let temp2 = vir_chnl_2.first();
        vir_chnl_2.deq();
        return temp2;
    endmethod

    method ActionValue#(int) get_valueVC3();
        let temp3 = vir_chnl_3.first();
        vir_chnl_3.deq();
        return temp3;
    endmethod

    method ActionValue#(int) get_valueVC4();
        let temp4 = vir_chnl_4.first();
        vir_chnl_4.deq();
        return temp4;
    endmethod

    method ActionValue#(int) get_valueVC5();
        let temp5 = vir_chnl_5.first();
        vir_chnl_5.deq();
        return temp5;
    endmethod

    method ActionValue#(int) get_valueVC6();
        let temp6 = vir_chnl_6.first();
        vir_chnl_6.deq();
        return temp6;
    endmethod



endmodule

endpackage : sender
