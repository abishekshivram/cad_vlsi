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



typedef FIFO#(Flit) BufferItem;

(* synthesize *)
module mkNode (Empty);

    //Vector#(3,BufferItem) inBuffer; //Pos 0 is reserved for core to generate traffic. pos 1,2, etc.. can be used by input links
    BufferItem inBuffer[3]; //Pos 0 is reserved for core to generate traffic. pos 1,2, etc.. can be used by input links
    BufferItem outBuffer[3][3]; //The dimensions are incorrect, to be thoughtout well
    //NOTE the above array may need to be inited - refer page 164, last para

    //Put together sufficient number of routers
    //Put together sufficient number of arbiters

    

    CoreInterface core <- mkCore;
    
    for (int i = 0; i < 3; i = i + 1)
        inBuffer[i] <- mkSizedFIFO(5); //NOTE test line

    rule fireOnce;//make this a fireonce rule
        Address srcAddr;
        srcAddr.netAddress=fromInteger(15);//To be set properly
        srcAddr.nodeAddress=fromInteger(17);//To be set properl
        core.setSourceAddress(srcAddr);
    endrule: fireOnce

    rule fireme;
        //core.tempCorePushFifo(flit);
        let flitReady = core.isFlitGenerated();
        let flit =core.getGeneratedFlit();
        if(flitReady==True)
            $display("Flit Generated");
        $display("Flit Values-> %x,%x,%x",flit.finalDstAddress.netAddress,flit.finalDstAddress.nodeAddress,flit.payload);
    endrule:fireme


endmodule: mkNode

endpackage: Node
