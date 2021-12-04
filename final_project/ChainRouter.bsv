package ChainRouter;

// FIFO used as buffers in routers
import FIFO :: * ;
import Core :: * ;

interface IfcChainRouter ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action PutValuefromLeft(int data);
    method ActionValue#(int) GetValueLeft();

    method Action PutValuefromRight(int data);
    method ActionValue#(int) GetValueRight();
    
endinterface

// This router sends both in left right directions
module mkChainRouter  #(parameter Bit#(3) set_id, bit level) (IfcChainRouter);

    Reg#(bit)   level       <- mkReg(0); // 0 for low level (L2), 1 for high level (L1)
    Reg#(Bit#(3))   my_id   <- mkReg(set_id); // using python - *insert the id and bits, assumed 3*
    
    // Duplex connections to core and neighbours
    FIFO#(int)  to_left     <- mkSizedFIFO(5); // to send data to left router
    FIFO#(int)  from_left   <- mkSizedFIFO(5); // to get data from left router

    FIFO#(int)  to_right    <- mkSizedFIFO(5); // to send data to right router
    FIFO#(int)  from_right  <- mkSizedFIFO(5); // to receive data from right router

    FIFO#(int)  to_core     <- mkSizedFIFO(2); // to send data to associated core
    FIFO#(int)  from_core   <- mkSizedFIFO(2); // to receive data from associated core

    Ifc_Core    my_core     <- mkCore();

    rule connect_to_core;
        let temp1 = to_core.first;  // Reading the FIRST IN value
        to_core.deq; // Removing the first element after its read
        my_core.put_data(temp1); // Puting the value to the core
    endrule

    rule connect_from_core;
        let temp2 = my_core.return_data();
        from_core.enq(temp2);
    endrule


    /*Problem: whether these rules will fire without any trouble
    Because same buffers are used in all three rules*/
    rule route_packet_from_core;
        let data_to_send1 = from_core.first;
        from_core.deq;
        Bit#(3) extracted_id = pack(*variable that contains id from struct*); //*assumed 3 bits, change it using python*

        if(extracted_id < my_id){
            to_left.enq(data_to_send1);
        }
        else{
            to_right.enq(data_to_send1);
        }
    endrule

    rule route_packet_from_left;
        let data_to_send2 = from_left.first;
        from_left.deq;
        Bit#(3) extracted_id = pack(*variable that contains id from struct*); //*assumed 3 bits, change it using python*

        if(extracted_id < my_id){
            to_left.enq(data_to_send1);
        }
        else{
            to_right.enq(data_to_send1);
        }
    endrule

    rule route_packet_from_right;
        let data_to_send2 = from_right.first;
        from_right.deq;
        Bit#(3) extracted_id = pack(*variable that contains id from struct*); //*assumed 3 bits, change it using python*

        if(extracted_id < my_id){
            to_left.enq(data_to_send2);
        }
        else{
            to_right.enq(data_to_send2);
        }        
    endrule

    method Action PutValuefromLeft(int data);
        // Data that comes from left neighbour router is put into the buffer
        from_left.enq(data);
    endmethod

    method Action PutValuefromRight(int data);
        // Data that comes from right neighbour router is put into the buffer
        from_right.enq(data);
    endmethod

    method ActionValue#(int) GetValueLeft();
        let temp3 = to_left.first;
        to_left.deq;
        return temp3
    endmethod

    method ActionValue#(int) GetValueRight();
        let temp4 = to_right.first;
        to_right.deq;
        return temp4
    endmethod

endmodule

endpackage : ChainRouter
