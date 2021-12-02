package Router;
// This package contains all the different kinds of 
// routers as separate modules

// FIFO used as buffers in routers
import FIFO :: * ;
import Core :: * ;

interface IfcChainRouter ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action PutValueLeft(int data);
    method int GetValueLeft(int data);

    method Action PutValueRight(int data);
    method int GetValueRight(int data);
    
endinterface

// This router sends both in left right directions
module mkChainRouter(IfcChainRouter);

    Reg#(int)   my_id   <- mkReg(*insert its id here*) // using python
    
    FIFO#(int)  left_send       <- mkSizedFIFO(5);  // to send data to left router
    FIFO#(int)  left_receive    <- mkSizedFIFO(5); // to get data from left router
    FIFO#(int)  right_send      <- mkSizedFIFO(5); // to send data to right router
    FIFO#(int)  right_receive   <- mkSizedFIFO(5); // to receive data from right router

    FIFO#(int)  core_send      <- mkSizedFIFO(2); // to send data to associated core
    FIFO#(int)  core_receive   <- mkSizedFIFO(2); // to receive data from associated core



    
    

endmodule



endpackage : Router
