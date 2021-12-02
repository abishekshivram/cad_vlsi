package Router;
// This package contains all the different kinds of 
// routers as separate modules

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
module mkChainRouter(IfcChainRouter);

    Reg#(Bit#(3))   my_id   <- mkReg(3'b01); // using python - *insert the id and bits, assumed 3*
    
    FIFO#(int)  to_left     <- mkSizedFIFO(5);  // to send data to left router
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

    rule connect_left_right_buffer;
        let data_to_send = from_core.first;
        from_core.deq;
        Bit#(3) extracted_id = pack(temp3); //*assumed 3 bits, change it using python*

        if(extracted_id < my_id){
            to_left.enq(data_to_send);
        }
        else{
            to_right.enq(data_to_send);
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

endpackage : Router