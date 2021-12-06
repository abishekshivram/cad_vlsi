/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: Implementation of core - which generates valid flits in random, and consumes flit destined to it
Last updated on: 09-Dec-2021
**************************************************************************************/

package Core;

import Parameters::*;
import Shared::*;
import FIFO::*;
import LFSR::*;

interface CoreInterface;
    method Bool isFlitGenerated();
    method Flit getGeneratedFlit();
endinterface: CoreInterface


(* synthesize *)
module mkCore(CoreInterface);
//The core should know its network address and node address
//declare varibale for source address and set it at the time of each core module creation


    Reg#(Flit) flitReg <- mkReg(?); //Uninitialised register to store generated flit
    Reg#(Bool) flitStat <- mkReg(False); //To indicate the content of flitReg is valid or not

    LFSR#(Bit#(8)) lfsr <- mkLFSR_8; //Lnear Feedback Shift Register for generating random patterns
    Reg#(Bool) fireOnceFlag <- mkReg(True);

    //A rule to fire only once to seed the LFSR
    (* preempts = "fireOnce, (generateFlit,resetFlitStat)" *)
    rule fireOnce (fireOnceFlag);
        $display("####### fireOnce");
        fireOnceFlag <= False;
        lfsr.seed('h11);
    endrule: fireOnce


    (* preempts = "generateFlit, resetFlitStat" *)
    rule generateFlit(lfsr.value() < 128); //This rule to be fired randomly for different core instantiation
        $display("####### generateFlit %x",lfsr.value());
        Flit flit;
        flit.srcAddress.netAddress=fromInteger(5); //To be set properly
        flit.srcAddress.nodeAddress=fromInteger(6);//To be set properly

        flit.finalDstAddress.netAddress=fromInteger(5);//To be set properly
        flit.finalDstAddress.nodeAddress=fromInteger(6);//To be set properly

        flit.currentDstAddress.netAddress=fromInteger(0);
        flit.currentDstAddress.nodeAddress=fromInteger(0);
        flit.payload=0;//current clock count

        flitReg <= flit;
        flitStat <= True;
        lfsr.next();
    endrule: generateFlit

    rule resetFlitStat;
        $display("####### resetFlitStat %x",lfsr.value());
        flitStat <= False;
        lfsr.next();
    endrule:resetFlitStat

    method Bool isFlitGenerated();
        return flitStat;//To be completed
    endmethod:isFlitGenerated

    method Flit getGeneratedFlit();
        return flitReg;
    endmethod:getGeneratedFlit
    
endmodule: mkCore

endpackage: Core
