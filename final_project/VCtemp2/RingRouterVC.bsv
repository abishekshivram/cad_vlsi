package RingRouterVC;
// This package contains the router - which implements the routing algorithm for the Ring topology
// Routing algorithm works as follows:
// For each link, two VCs are allocated. For example, in each node in Ring topology, we have
// 3 links (core, left neighbour, right neighbour). So 6 VCs are made and VC1,2 allocated to core, 
// VC3,4 allocated to left neighbour, VC5,6 allocated to right neighbour


import Shared::*;
import Core :: * ;
import Parameters::*;

// FIFO used as buffers in routers
import FIFO :: * ;
import FIFOF :: * ;



interface IfcRingRouterVC ;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router
    method Action put_value (Flit flit);
    method Action put_value_dateline (Flit flit);

    // Each output link gets two VC channel (for Ring, we have: left, right, core)
    // Hence, we need 6 VCs
    // Each of the following methods will dequeue (ACTION) an element from the VC and return it (VALUE)
    method ActionValue#(Flit) get_valueVC1();
    method ActionValue#(Flit) get_valueVC2();
    method ActionValue#(Flit) get_valueVC3();
    method ActionValue#(Flit) get_valueVC4();
    method ActionValue#(Flit) get_valueVC5();
    method ActionValue#(Flit) get_valueVC6();

    method LinkUtilisationCounter get_link_util_counter();
    
endinterface


(* synthesize *)

// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkRingRouterVC #(parameter Address my_addr, parameter Bool is_head_nod, parameter NodeAddress maxNodeAddress, parameter NetAddress maxNetAddress) (IfcRingRouterVC);

    function Action print_flit_details(Flit flit_to_print);
        return action
            $display("\nPrinting Flit details:");
            $display("Flit Source      address: NetworkID: %h | NodeID: %h", flit_to_print.srcAddress.netAddress, flit_to_print.srcAddress.nodeAddress);
            $display("Flit Destination address: NetworkID: %h | NodeID: %h", flit_to_print.finalDstAddress.netAddress, flit_to_print.finalDstAddress.nodeAddress);
            $display("Flit Current Dst address: NetworkID: %h | NodeID: %h\n", flit_to_print.currentDstAddress.netAddress, flit_to_print.currentDstAddress.nodeAddress);
        endaction;
    endfunction

 
    // Input link for the router
    FIFO#(Flit)  input_link              <- mkFIFO; // to get data from left router
    FIFOF#(Flit)  input_link_dateline    <- mkFIFOF; // to get data from left router
    
    // To store the flits that are sent to core
    FIFO#(Flit)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(Flit)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2
    
    // To store the flits that are sent to left
    FIFO#(Flit)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(Flit)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    
    // To store the flits that are sent to right
    FIFO#(Flit)  vir_chnl_5  <- mkFIFO; // Virtual Channel 5
    FIFO#(Flit)  vir_chnl_6  <- mkFIFO; // Virtual Channel 6

    // To store the flits that are sent to L1 routing, NETWORK on left
    FIFO#(Flit)  vir_chnl_7  <- mkFIFO; // Virtual Channel 7
    FIFO#(Flit)  vir_chnl_8  <- mkFIFO; // Virtual Channel 8

    // To store the flits that are sent to L1 routing, NETWORK on right
    FIFO#(Flit)  vir_chnl_9  <- mkFIFO; // Virtual Channel 9
    FIFO#(Flit)  vir_chnl_10  <- mkFIFO; // Virtual Channel 10

    Reg#(LinkUtilisationCounter) link_util_counter  <- mkReg(0);

    // Since we have two VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);
    rule invert_cycle;
        cycle <= cycle + 1;     // Cycle variable oscillates between 0 and 1
    endrule

    // Connect input_link to respective VC
    // This rules fires every cycle, and chooses odd named Virtual Channels (VC1, VC3, VC5) 
    // unless the flit passes the date-line: the link connecting the node with max-index and node 0.
    // In this case, the Virtua Channels used will be (VC2,VC4,VC6)

    rule read_input_link_dateline_and_send_to_VC( input_link_dateline.notEmpty() && (  my_addr.nodeAddress != 0 && my_addr.nodeAddress != maxNodeAddress || (cycle==1 && (my_addr.nodeAddress == 0 || my_addr.nodeAddress == maxNodeAddress))));
    // rule read_input_link_dateline_and_send_to_VC( input_link_dateline.notEmpty());
        let flit = input_link_dateline.first();
        input_link_dateline.deq();

        if(flit.finalDstAddress == my_addr) begin //For this node, send to core
            $display("vir_chnl_1.enq at addr:%h, payload:%d", my_addr,flit.payload);
            vir_chnl_2.enq(flit);// Reached the destination - core will consume
        end
        else begin //144
            if (is_head_nod==False) begin
                if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                    $display("vir_chnl_4.enq at addr:%h", my_addr);
                    vir_chnl_4.enq(flit);
                end
                else begin
                    $display("vir_chnl_6.enq at addr:%h", my_addr);
                    vir_chnl_6.enq(flit);
                end
            end
            else begin//107
                if(flit.finalDstAddress.netAddress == my_addr.netAddress) begin //Do L2 routing in head node
                    if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                        $display("vir_chnl_4.enq at addr:%h", my_addr);
                        vir_chnl_4.enq(flit);
                    end
                    else begin
                        $display("vir_chnl_6.enq at addr:%h", my_addr);
                        vir_chnl_6.enq(flit);
                    end
                end
                else begin //Do L1 routing //119
                    flit.currentDstAddress = flit.finalDstAddress;
                    if (flit.currentDstAddress.netAddress < my_addr.netAddress) begin
                        $display("vir_chnl_8.enq at addr:%h", my_addr);
                        vir_chnl_8.enq(flit);
                    end
                    else begin
                        $display("vir_chnl_10.enq at addr:%h", my_addr);
                        vir_chnl_10.enq(flit);
                    end
                end
            end
        end
    
    endrule

    rule read_input_link_and_send_to_VC(my_addr.nodeAddress != 0 && my_addr.nodeAddress != maxNodeAddress);

        let flit = input_link.first();
        input_link.deq();

        if(flit.finalDstAddress == my_addr) begin //For this node, send to core
            $display("vir_chnl_1.enq at addr:%h, payload:%d", my_addr,flit.payload);
            vir_chnl_1.enq(flit);// Reached the destination - core will consume
        end
        else begin
            if (is_head_nod==False) begin
                // The current flit has to go to left 
                if(abs(flit.currentDstAddress.nodeAddress - my_addr.nodeAddress) <= maxNodeAddress/2)  begin
                    if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                        $display("vir_chnl_3.enq at addr:%h", my_addr);
                        vir_chnl_3.enq(flit);
                    end
                    else begin
                        $display("vir_chnl_5.enq at addr:%h", my_addr);
                        vir_chnl_5.enq(flit);
                    end
                end

                // The current flit has to go to right
                else  begin
                    if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                        $display("vir_chnl_5.enq at addr:%h", my_addr);
                        vir_chnl_5.enq(flit);                
                    end
                    else begin
                        $display("vir_chnl_3.enq at addr:%h", my_addr);
                        vir_chnl_3.enq(flit);                
                    end
                end 

            end
            else begin
                if(flit.finalDstAddress.netAddress == my_addr.netAddress) begin //Do L2 routing in head node
                    // The current flit has to go to left 
                    if(abs(flit.currentDstAddress.nodeAddress - my_addr.nodeAddress) <= maxNodeAddress/2)  begin
                        if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                            $display("vir_chnl_3.enq at addr:%h", my_addr);
                            vir_chnl_3.enq(flit);
                        end
                        else begin
                            $display("vir_chnl_5.enq at addr:%h", my_addr);
                            vir_chnl_5.enq(flit);
                        end
                    end

                    // The current flit has to go to right
                    else  begin
                        if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                            $display("vir_chnl_5.enq at addr:%h", my_addr);
                            vir_chnl_5.enq(flit);                
                        end
                        else begin
                            $display("vir_chnl_3.enq at addr:%h", my_addr);
                            vir_chnl_3.enq(flit);                
                        end
                    end 
                end
                else begin //Do L1 routing

                    flit.currentDstAddress = flit.finalDstAddress;
                    // The current flit has to go to left in L1
                    if(abs(flit.currentDstAddress.netAddress - my_addr.netAddress) <= maxNetAddress/2)  begin
                        if (flit.currentDstAddress.netAddress < my_addr.netAddress) begin
                            $display("vir_chnl_7.enq at addr:%h", my_addr);
                            vir_chnl_7.enq(flit);
                        end
                        else begin
                            $display("vir_chnl_9.enq at addr:%h", my_addr);
                            vir_chnl_9.enq(flit);
                        end
                    end

                    // The current flit has to go to right in L1
                    else  begin
                        if (flit.currentDstAddress.netAddress < my_addr.netAddress) begin
                            $display("vir_chnl_9.enq at addr:%h", my_addr);
                            vir_chnl_9.enq(flit);                
                        end
                        else begin
                            $display("vir_chnl_7.enq at addr:%h", my_addr);
                            vir_chnl_7.enq(flit);                
                        end
                    end 
                end

            end
        end

    endrule


    rule read_input_link_and_send_to_VC_extreme( (!input_link_dateline.notEmpty())  || (cycle==0 && (my_addr.nodeAddress == 0 || my_addr.nodeAddress == maxNodeAddress)));
    // rule read_input_link_and_send_to_VC_extreme( (!input_link_dateline.notEmpty()) && (my_addr.nodeAddress == 0 || my_addr.nodeAddress == maxNodeAddress)));
        let flit = input_link.first();
        input_link.deq();

        if(flit.finalDstAddress == my_addr) begin //For this node, send to core
            $display("vir_chnl_1.enq at addr:%h, payload:%d", my_addr,flit.payload);
            vir_chnl_1.enq(flit);// Reached the destination - core will consume
        end
        else begin
            if(is_head_nod==False) begin 
                // The current flit has to go to left 
                if(abs(flit.currentDstAddress.nodeAddress - my_addr.nodeAddress) <= maxNodeAddress/2)  begin
                    if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                        $display("vir_chnl_3.enq at addr:%h", my_addr);
                        vir_chnl_3.enq(flit);
                    end
                    else begin
                        $display("vir_chnl_5.enq at addr:%h", my_addr);
                        vir_chnl_5.enq(flit);
                    end
                end
                // The current flit has to go to right
                else  begin
                    if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                        if (my_addr.nodeAddress == maxNodeAddress) begin
                            $display("vir_chnl_6.enq at addr:%h", my_addr);
                            vir_chnl_6.enq(flit);
                        end
                        else begin
                            $display("vir_chnl_5.enq at addr:%h", my_addr);
                            vir_chnl_5.enq(flit);                
                        end
                    end
                    else begin
                        if (my_addr.nodeAddress == 0) begin
                            $display("vir_chnl_4.enq at addr:%h", my_addr);
                            vir_chnl_4.enq(flit);
                        end
                        else begin
                            $display("vir_chnl_3.enq at addr:%h", my_addr);
                            vir_chnl_3.enq(flit);                
                        end
                    end
                end
            end
            else begin 

                if(flit.finalDstAddress.netAddress == my_addr.netAddress) begin //Do L2 routing in head node
                    // The current flit has to go to left 
                    if(abs(flit.currentDstAddress.nodeAddress - my_addr.nodeAddress) <= maxNodeAddress/2)  begin
                        if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                            $display("vir_chnl_3.enq at addr:%h", my_addr);
                            vir_chnl_3.enq(flit);
                        end
                        else begin
                            $display("vir_chnl_5.enq at addr:%h", my_addr);
                            vir_chnl_5.enq(flit);
                        end
                    end
                    // The current flit has to go to right
                    else  begin
                        if (flit.currentDstAddress.nodeAddress < my_addr.nodeAddress) begin
                            if (my_addr.nodeAddress == maxNodeAddress) begin
                                $display("vir_chnl_6.enq at addr:%h", my_addr);
                                vir_chnl_6.enq(flit);
                            end
                            else begin
                                $display("vir_chnl_5.enq at addr:%h", my_addr);
                                vir_chnl_5.enq(flit);                
                            end
                        end
                        else begin
                            if (my_addr.nodeAddress == 0) begin
                                $display("vir_chnl_4.enq at addr:%h", my_addr);
                                vir_chnl_4.enq(flit);
                            end
                            else begin
                                $display("vir_chnl_3.enq at addr:%h", my_addr);
                                vir_chnl_3.enq(flit);                
                            end
                        end
                    end
                end

                else begin //Do L1 routing
                    flit.currentDstAddress = flit.finalDstAddress;
                    // The current flit has to go to l1 left 
                    if(abs(flit.currentDstAddress.netAddress - my_addr.netAddress) <= maxNetAddress/2)  begin
                        if (flit.currentDstAddress.netAddress < my_addr.netAddress) begin
                            $display("vir_chnl_7.enq at addr:%h", my_addr);
                            vir_chnl_7.enq(flit);
                        end
                        else begin
                            $display("vir_chnl_9.enq at addr:%h", my_addr);
                            vir_chnl_9.enq(flit);
                        end
                    end
                    // The current flit has to go to l1 right
                    else  begin
                        if (flit.currentDstAddress.netAddress < my_addr.netAddress) begin
                            if (my_addr.netAddress == maxNetAddress) begin
                                $display("vir_chnl_10.enq at addr:%h", my_addr);
                                vir_chnl_10.enq(flit);
                            end
                            else begin
                                $display("vir_chnl_9.enq at addr:%h", my_addr);
                                vir_chnl_9.enq(flit);                
                            end
                        end
                        else begin
                            if (my_addr.netAddress == 0) begin
                                $display("vir_chnl_8.enq at addr:%h", my_addr);
                                vir_chnl_8.enq(flit);
                            end
                            else begin
                                $display("vir_chnl_7.enq at addr:%h", my_addr);
                                vir_chnl_7.enq(flit);                
                            end
                        end
                    end
                end
            end
        end

    endrule


    // Method to get the flit into the node
    method Action put_value(Flit flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link.enq(flit);
        print_flit_details(flit);
        $display("Router (Addr: %h) received the flit into its Input Link", my_addr);
        link_util_counter <= link_util_counter+1;
    endmethod

    method LinkUtilisationCounter get_link_util_counter();
        return link_util_counter;
    endmethod

    method Action put_value_dateline(Flit flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link_dateline.enq(flit);
        print_flit_details(flit);
        $display("Router (Addr: %h) received the flit into its Input Link Dateline", my_addr);
    endmethod


    // Following are the six methods (corresponding to six available VCs) 
    // These methods return the flit so that it can reach the next node in its path
    // The VC1, VC2 methods will be invoked to send the flits to the core (as we fixed earlier, line:4)
    method ActionValue#(Flit) get_valueVC1();
        $display("get_valueVC1 called at Router (Addr: %h)", my_addr);
         let temp1 = vir_chnl_1.first();
         vir_chnl_1.deq();
        return temp1;
    endmethod

    method ActionValue#(Flit) get_valueVC2();
        $display("get_valueVC2 called at Router (Addr: %h)", my_addr);
         let temp2 = vir_chnl_2.first();
         vir_chnl_2.deq();
        return  temp2;
    endmethod

    method ActionValue#(Flit) get_valueVC3();
        $display("get_valueVC3 called at Router (Addr: %h)", my_addr);
        let temp3 = vir_chnl_3.first();
        vir_chnl_3.deq();
        return temp3;
    endmethod

    method ActionValue#(Flit) get_valueVC4();
        $display("get_valueVC4 called at Router (Addr: %h)", my_addr);
        let temp4 = vir_chnl_4.first();
        vir_chnl_4.deq();
        return temp4;
    endmethod

    method ActionValue#(Flit) get_valueVC5();
        $display("get_valueVC5 called at Router (Addr: %h)", my_addr);
        let temp5 = vir_chnl_5.first();
        vir_chnl_5.deq();
        return temp5;
    endmethod

    method ActionValue#(Flit) get_valueVC6();
        $display("get_valueVC6 called at Router (Addr: %h)", my_addr);
        let temp6 = vir_chnl_6.first();
        vir_chnl_6.deq();
        return temp6;
    endmethod

endmodule: mkRingRouterVC

endpackage : RingRouterVC
