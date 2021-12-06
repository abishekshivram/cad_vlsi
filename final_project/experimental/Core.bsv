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
    //Does this core have a valid flit to supply? returns True/False
    method Bool isFlitGenerated();
    //Returns the generated flit    
    method Flit getGeneratedFlit();
    //Set the source address for this core    
    method Action setSourceAddress(Address srcAddr);
endinterface: CoreInterface


(* synthesize *)
module mkCore(CoreInterface);

    Reg#(Flit) flitReg <- mkReg(?); //Uninitialised register to store generated flit
    Reg#(Bool) flitValidStat <- mkReg(False); //To indicate the content of flitReg is valid or not
    Reg#(Address) srcAddress <- mkReg(?); //Register storing the Address of this Core/Node

    LFSR#(Bit#(16)) lfsr <- mkLFSR_16; //Lnear Feedback Shift Register for generating random patterns
    Reg#(Bool) fireOnceFlag <- mkReg(True);  
    Reg#(PayloadLen) clockCount <- mkReg(0); //A register to store the clock pulse count
    MaxAddressInterface l2AddressLengths <- mkMaxAddress; //instantiates mkMaxAddress from parameters.bsv


    //A rule to fire only once to seed the LFSR
    (* preempts = "fireOnce, (generateFlit,resetFlitStat)" *)
    rule fireOnce (fireOnceFlag);
        fireOnceFlag <= False;
        lfsr.seed('h11);
    endrule: fireOnce

    //Counts the clock pulse, always fire
    rule clockCounter(True);
        clockCount <= clockCount+1;
    endrule: clockCounter


    //This rule fires randomly for different core instantiations (32768=2^16/2)
    //This is meant for generating valid flits randomly
    (* preempts = "generateFlit, resetFlitStat" *)
    rule generateFlit(lfsr.value() < 32768); 
        
        Flit flit;
        flit.srcAddress.netAddress=srcAddress.netAddress;
        flit.srcAddress.nodeAddress=srcAddress.nodeAddress;

        let destNetAddress=unpack(lfsr.value()%fromInteger(l1NodeCount));
        flit.finalDstAddress.netAddress=destNetAddress;

        let destNodeAddress=unpack(lfsr.value()%pack(l2AddressLengths.getMaxAddress(destNetAddress)));
        flit.finalDstAddress.nodeAddress=destNodeAddress;

        flit.currentDstAddress.netAddress=fromInteger(0);
        flit.currentDstAddress.nodeAddress=fromInteger(0);
        flit.payload=clockCount;

        flitReg <= flit;
        flitValidStat <= True;
        lfsr.next();
    endrule: generateFlit

    //If the generateFlit rule is not fired, this rule sets the flit as invalid one
    rule resetFlitStat;
        flitValidStat <= False;
        lfsr.next();
    endrule:resetFlitStat

    method Bool isFlitGenerated();
        return flitValidStat;
    endmethod:isFlitGenerated

    method Flit getGeneratedFlit();
        return flitReg;
    endmethod:getGeneratedFlit

    method Action setSourceAddress(Address srcAddr);
        srcAddress <= srcAddr;
    endmethod:setSourceAddress

    
endmodule: mkCore

endpackage: Core
