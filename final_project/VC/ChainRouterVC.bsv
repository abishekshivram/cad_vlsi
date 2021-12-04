package ChainRouterVC;

// FIFO used as buffers in routers
import FIFO :: * ;
import Core :: * ;

interface IfcChainRouterVC ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action PutValue(int data);

    // Each output link gets two VC channel (for chain, we have: left, right, core)
    // Hence, we need 6 VCs
    method ActionValue#(int) GetValueVC1();
    method ActionValue#(int) GetValueVC2();
    method ActionValue#(int) GetValueVC3();
    method ActionValue#(int) GetValueVC4();
    method ActionValue#(int) GetValueVC5();
    method ActionValue#(int) GetValueVC6();
    
endinterface


// This router sends both in left right directions
module mkChainRouterVC (IfcChainRouterVC);

    //Reg#(bit)   level       <- mkReg(0); // 0 for low level (L2), 1 for high level (L1)
    //Reg#(Bit#(3))   my_id   <- mkReg(set_id); // using python - *insert the id and bits, assumed 3*
    
    // Input link for the router
    FIFO#(int)  IL   <- mkSizedFIFO(5); // to get data from left router

    // To store the flits that are sent to core
    FIFO#(int)  VC1  <- mkSizedFIFO(5); // Virtual Channel 1
    FIFO#(int)  VC2  <- mkSizedFIFO(5); // Virtual Channel 2

    // To store the flits that are sent to left
    FIFO#(int)  VC3  <- mkSizedFIFO(5); // Virtual Channel 3
    FIFO#(int)  VC4  <- mkSizedFIFO(5); // Virtual Channel 4
    
    // To store the flits that are sent to right
    FIFO#(int)  VC5  <- mkSizedFIFO(5); // Virtual Channel 5
    FIFO#(int)  VC6  <- mkSizedFIFO(5); // Virtual Channel 6

    Reg#(bit) cycle  <- mkReg(0);

    rule invert_cycle;
        cycle <= cycle + 1;
    endrule

    // Connect IL to respective VC
    rule read_IL_and_send_to_VC_odd(cycle == 1);
        let flit = IL.first;
        IL.deq;
        //Bit#(3) extracted_id = pack(*variable that contains id from struct*); //*assumed 3 bits, change it using python*
        Bit#(3) extracted_id = pack(flit);
        
        // Reached the destination
        if(extracted_id == my_id){
            VC1.enq(flit);
        }
        // go to left 
        else if(extracted_id < my_id){
            VC3.enq(flit);
        }
        // go to right
        else{
            VC5.enq(flit);
        }
    endrule

    rule read_IL_and_send_to_VC_even(cycle == 0);
        let flit = IL.first;
        IL.deq;
        //Bit#(3) extracted_id = pack(*variable that contains id from struct*); //*assumed 3 bits, change it using python*
        Bit#(3) extracted_id = pack(flit);
        
        // Reached the destination
        if(extracted_id == my_id){
            VC2.enq(flit);
        }
        // go to left 
        else if(extracted_id < my_id){
            VC4.enq(flit);
        }
        // go to right
        else{
            VC6.enq(flit);
        }
    endrule


    method Action PutValue(int data);
        // Data that comes from left neighbour router is put into the buffer
        IL.enq(data);
    endmethod

    method ActionValue#(int) GetValueVC1();
        let temp1 = VC1.first;
        VC1.deq;
        return temp1
    endmethod

    method ActionValue#(int) GetValueVC2();
        let temp2 = VC2.first;
        VC2.deq;
        return temp2
    endmethod

    method ActionValue#(int) GetValueVC3();
        let temp3 = VC3.first;
        VC3.deq;
        return temp3
    endmethod

    method ActionValue#(int) GetValueVC4();
        let temp4 = VC4.first;
        VC4.deq;
        return temp4
    endmethod

    method ActionValue#(int) GetValueVC5();
        let temp5 = VC5.first;
        VC5.deq;
        return temp5
    endmethod

    method ActionValue#(int) GetValueVC6();
        let temp6 = VC6.first;
        VC6.deq;
        return temp6
    endmethod



endmodule

endpackage : ChainRouterVC
