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
    method Bool is_flit_generated();
    //Returns the generated flit    
    method Flit get_generated_flit();
    //Set the source address for this core    
    //method Action setSourceAddress(Address srcAddr);

    //The flit reached its destination. Core consumes it
    method Action put_flit(Flit flit);

endinterface: CoreInterface


(* synthesize *)
module mkCore#(parameter Address sourceAddress, parameter Address head_node_addr ) (CoreInterface);

    Reg#(Flit) flitReg              <- mkReg(?); //Uninitialised register to store generated flit
    Reg#(Bool) flitValidStat        <- mkReg(False); //To indicate the content of flitReg is valid or not
    Reg#(Address) myAddress         <- mkReg(sourceAddress); //Register storing the Address of this Core/Node
    Reg#(Address) head_node_address <- mkReg(head_node_addr); //Register storing the Address of this Core/Node

    Reg#(Flit) flitConsumeReg       <- mkReg(?); //A register to store the consumed flit

    LFSR#(Bit#(16)) lfsr            <- mkLFSR_16; //Lnear Feedback Shift Register for generating random patterns
    Reg#(Bool) fireOnceFlag         <- mkReg(True);  
    Reg#(ClockCount) clockCount     <- mkReg(0); //A register to store the clock pulse count
    
    MaxAddressInterface l2AddressLengths <- mkMaxAddress; //instantiates mkMaxAddress from parameters.bsv


    //A rule to fire only once to seed the LFSR
    (* preempts = "fireOnce, (generateFlit,resetFlitStat)" *)
    rule fireOnce (fireOnceFlag);
        fireOnceFlag <= False;
        // *NOTE* Each core to be seeded differently, otherwise all the cores will 
        // be generating flits in a synchronised fashin (same clock generate)
        lfsr.seed('h11);
    endrule

    //Counts the clock pulse, always fire
    rule clockCounter;
        clockCount <= clockCount+1;
        if(myAddress.netAddress==fromInteger(0)) begin // To prevent all the cores from printing the same statement
            if(myAddress.nodeAddress==fromInteger(0)) begin
                $display("\nClock Cycle: %d",clockCount);
            end
        end    
    endrule

    //This rule fires randomly for different core instantiations (32768=2^16/2)
    //This is meant for generating valid flits randomly
    (* preempts = "generateFlit, resetFlitStat" *)
    //rule generateFlit(lfsr.value() < 32768); 
    rule generateFlit(clockCount==3 || clockCount==5); //NOTE for testing. Generate only 1 flit
        //if(myAddress.netAddress==fromInteger(0)) begin //NOTE Test line: Generate flit from Net 0, Node 0 only.
            //if(myAddress.nodeAddress==fromInteger(0)) begin 
            
                Flit flit;
                flit.srcAddress.netAddress          = myAddress.netAddress;
                flit.srcAddress.nodeAddress         = myAddress.nodeAddress;

                let destNetAddress                  = unpack(lfsr.value()%fromInteger(l1NodeCount));
                flit.finalDstAddress.netAddress     = destNetAddress;
                //flit.finalDstAddress.netAddress     = fromInteger(2);//NOTE- for testing

                let destNodeAddress                 = unpack(lfsr.value()%pack(l2AddressLengths.getMaxAddress(destNetAddress)));
                flit.finalDstAddress.nodeAddress    = destNodeAddress;
                //flit.finalDstAddress.nodeAddress    = fromInteger(5);//NOTE- for testing

                if(flit.srcAddress.netAddress==flit.finalDstAddress.netAddress) begin
                    flit.currentDstAddress.netAddress   = flit.finalDstAddress.netAddress;
                    flit.currentDstAddress.nodeAddress  = flit.finalDstAddress.nodeAddress;
                end
                else begin
                    flit.currentDstAddress.netAddress   = head_node_address.netAddress;
                    flit.currentDstAddress.nodeAddress  = head_node_address.nodeAddress;
                end
                
                flit.payload                        = clockCount;

                flitReg                             <= flit;
                flitValidStat                       <= True;
                $display("<<<<<<<<<<<<<<<<<<<Flit generated | Source: %d (Network),%d (Node) | Destination: -> %d (Network),%d (Node)",flit.srcAddress.netAddress,flit.srcAddress.nodeAddress,flit.finalDstAddress.netAddress,flit.finalDstAddress.nodeAddress);

            //end
        //end    
        lfsr.next();
    endrule

    //If the generateFlit rule is not fired, this rule sets the flit as invalid one
    rule resetFlitStat;
        flitValidStat <= False;
        lfsr.next();
    endrule

    method Bool is_flit_generated();
        return flitValidStat;
    endmethod

    method Flit get_generated_flit();
        return flitReg;
    endmethod

    method Action put_flit(Flit flit);
        flitConsumeReg <=flit; //flitConsumeReg needed? 
        //$display("Transmission delay from-%x,%x- to-%x,%x is -%x- cycles");
        $display(">>>>>>>>>>>>>>> Flit received with payload: %h  | Source: %d (Network),%d (Node) | Destination: -> %d (Network),%d (Node) | MyAddress: -> %d (Network),%d (Node)", flit.payload,flit.srcAddress.netAddress,flit.srcAddress.nodeAddress,flit.finalDstAddress.netAddress,flit.finalDstAddress.nodeAddress,myAddress.netAddress,myAddress.nodeAddress);
    endmethod

    
endmodule: mkCore

endpackage: Core
