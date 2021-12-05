/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: Implementaion of Node by composing different components
Last updated on: 09-Dec-2021
**************************************************************************************/

package Node;

import Shared::*;
import Core::*;

import FIFO::*;
import Vector::*;

typedef FIFO#(Flit) BufferItem;

(* synthesize *)
module mkNode (Empty);

    Vector#(3,BufferItem) inBuffer; //Pos 0 is reserved for core to generate traffic. pos 1,2, etc.. can be used by input links
    BufferItem outBuffer[3][3]; //The dimensions are incorrect, to be thoughtout well
    //NOTE the above array may need to be inited - refer page 164, last para

    //Put together sufficient number of routers
    //Put together sufficient number of arbiters
    //Add core
    
    


endmodule: mkNode

endpackage: Node
