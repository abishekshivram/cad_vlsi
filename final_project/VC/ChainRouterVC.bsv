package ChainRouterVC;

// FIFO used as buffers in routers
import FIFO :: * ;


interface IfcChainRouterVC ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value (int data);

    // Each output link gets two VC channel (for chain, we have: left, right, core)
    // Hence, we need 6 VCs
    method ActionValue#(int) get_valueVC1();
    method ActionValue#(int) get_valueVC2();
    method ActionValue#(int) get_valueVC3();
    method ActionValue#(int) get_valueVC4();
    method ActionValue#(int) get_valueVC5();
    method ActionValue#(int) get_valueVC6();
    
endinterface

(* synthesize *)

// This router sends both in left right directions
module mkChainRouterVC (IfcChainRouterVC);

    //Reg#(bit)   level       <- mkReg(0); // 0 for low level (L2), 1 for high level (L1)
    Reg#(Bit#(3))   my_id   <- mkReg(3'b001); // using python - *insert the id and bits, assumed 3*
    
    // Input link for the router
    FIFO#(int)  input_link   <- mkFIFO; // to get data from left router

    // To store the flits that are sent to core
    FIFO#(int)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(int)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2

    // To store the flits that are sent to left
    FIFO#(int)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(int)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    
    // To store the flits that are sent to right
    FIFO#(int)  vir_chnl_5  <- mkFIFO; // Virtual Channel 5
    FIFO#(int)  vir_chnl_6  <- mkFIFO; // Virtual Channel 6

    Reg#(bit) cycle  <- mkReg(0);

    rule invert_cycle;
        cycle <= cycle + 1;
    endrule

    // Connect input_link to respective VC
    rule read_input_link_and_send_to_VC_odd(cycle == 1);
        int flit = input_link.first();
        input_link.deq();
        //Bit#(3) extracted_id = pack(*variable that contains id from struct*); //*assumed 3 bits, change it using python*
        Bit#(3) extracted_id = pack(flit)[31:29];
        
        // Reached the destination
        if(extracted_id == my_id)  begin
            vir_chnl_1.enq(flit);
        end
        // go to left 
        else if(extracted_id < my_id)  begin
            vir_chnl_3.enq(flit);
        end
        // go to right
        else  begin
            vir_chnl_5.enq(flit);
        end
    endrule

    rule read_input_link_and_send_to_VC_even(cycle == 0);

        int flit = input_link.first();
        input_link.deq();
        //Bit#(3) extracted_id = pack(*variable that contains id from struct*); //*assumed 3 bits, change it using python*
        Bit#(3) extracted_id = pack(flit)[31:29];
        
        // Reached the destination
        if(extracted_id == my_id)  begin
            vir_chnl_2.enq(flit);
        end
        // go to left 
        else if(extracted_id < my_id)  begin
            vir_chnl_4.enq(flit);
        end
        // go to right
        else  begin
            vir_chnl_6.enq(flit);
        end
    endrule


    method Action put_value(int data);
        // Data that comes from left neighbour router is put into the buffer
        input_link.enq(data);
    endmethod

    method ActionValue#(int) get_valueVC1();
        int temp1 = vir_chnl_1.first();
        vir_chnl_1.deq();
        return temp1;
    endmethod

    method ActionValue#(int) get_valueVC2();
        int temp2 = vir_chnl_2.first();
        vir_chnl_2.deq();
        return temp2;
    endmethod

    method ActionValue#(int) get_valueVC3();
        int temp3 = vir_chnl_3.first();
        vir_chnl_3.deq();
        return temp3;
    endmethod

    method ActionValue#(int) get_valueVC4();
        int temp4 = vir_chnl_4.first();
        vir_chnl_4.deq();
        return temp4;
    endmethod

    method ActionValue#(int) get_valueVC5();
        int temp5 = vir_chnl_5.first();
        vir_chnl_5.deq();
        return temp5;
    endmethod

    method ActionValue#(int) get_valueVC6();
        int temp6 = vir_chnl_6.first();
        vir_chnl_6.deq();
        return temp6;
    endmethod



endmodule

endpackage : ChainRouterVC
