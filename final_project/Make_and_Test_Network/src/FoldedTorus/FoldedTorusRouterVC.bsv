package FoldedTorusRouterVC;
// This package contains the router - which implements the routing algorithm for the FoldedTorus topology
// Routing algorithm works as follows:
// For each link, two VCs are allocated. For example, in each node in FoldedTorus topology, we have
// maximum 5 links  (core, left neighbour, right neighbour,top neighbour, bottom neighbour,). So 6 VCs are made and VC1,2 allocated to core, 
// VC3,4 allocated to left neighbour, VC5,6 allocated to right neighbour, VC7,8 allocated to top neighbour, VC9,10 allocated to bottom neighbour


import Shared::*;
import FIFO :: * ;
import Parameters::* ;
import FIFOF :: * ;

typedef Int#(8) IntAddress;
interface IfcFoldedTorusRouterVC ;
    // Put value is used to insert data to the router
    
    method Action put_value (Flit flit);
    method Action put_value_dateline(Flit flit);

    // Get Value is used to read the value from the router
    // Each of the following methods will dequeue (ACTION) an element from the VC and return it (VALUE)
    method ActionValue#(Flit) get_valueVC1();
    method ActionValue#(Flit) get_valueVC2();
    method ActionValue#(Flit) get_valueVC3();
    method ActionValue#(Flit) get_valueVC4();
    method ActionValue#(Flit) get_valueVC5();
    method ActionValue#(Flit) get_valueVC6();
    method ActionValue#(Flit) get_valueVC7();
    method ActionValue#(Flit) get_valueVC8();   
    method ActionValue#(Flit) get_valueVC9();
    method ActionValue#(Flit) get_valueVC10();
    method LinkUtilisationCounter get_link_util_counter();
    
endinterface


(* synthesize *)

// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkFoldedTorusRouterVC #(parameter Address my_addr, parameter NodeAddressX maxXAddress, parameter NodeAddressY maxYAddress) (IfcFoldedTorusRouterVC);

    function Action print_flit_details(Flit flit_to_print);
        return action
            $display("\nPrinting Flit details:");
            $display("Flit Source      address: NetworkID: %h | NodeID: %h", flit_to_print.srcAddress.netAddress, flit_to_print.srcAddress.nodeAddress);
            $display("Flit Destination address: NetworkID: %h | NodeID: %h", flit_to_print.finalDstAddress.netAddress, flit_to_print.finalDstAddress.nodeAddress);
            $display("Flit Current Dst address: NetworkID: %h | NodeID: %h\n", flit_to_print.currentDstAddress.netAddress, flit_to_print.currentDstAddress.nodeAddress);
        endaction;
    endfunction

    // Reg#(Bool)  is_head_node <- mkReg(is_head_nod); // True indicates head node, False other nodes

    // Input link for the router
    FIFO#(Flit)  input_link  <- mkFIFO; // to get data from neighbouring router and core
    FIFOF#(Flit)  input_link_dateline  <- mkFIFOF; // to get data from neighbouring router and core after crossing the dateline
    
    // To store the flits that are sent to core
    FIFO#(Flit)  vir_chnl_1  <- mkFIFO; // Virtual Channel 1
    FIFO#(Flit)  vir_chnl_2  <- mkFIFO; // Virtual Channel 2
    
    // To store the flits that are sent to left
    FIFO#(Flit)  vir_chnl_3  <- mkFIFO; // Virtual Channel 3
    FIFO#(Flit)  vir_chnl_4  <- mkFIFO; // Virtual Channel 4
    
    // To store the flits that are sent to right
    FIFO#(Flit)  vir_chnl_5  <- mkFIFO; // Virtual Channel 5
    FIFO#(Flit)  vir_chnl_6  <- mkFIFO; // Virtual Channel 6

    // To store the flits that are sent to up
    FIFO#(Flit)  vir_chnl_7  <- mkFIFO; // Virtual Channel 7
    FIFO#(Flit)  vir_chnl_8  <- mkFIFO; // Virtual Channel 8
    
    // To store the flits that are sent to down
    FIFO#(Flit)  vir_chnl_9  <- mkFIFO; // Virtual Channel 9
    FIFO#(Flit)  vir_chnl_10  <- mkFIFO; // Virtual Channel 10
        

    // Since we have TWO VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);
    rule invert_cycle;
        cycle <= cycle + 1;     // Cycle variable oscillates between 0 and 1
    endrule

    Reg#(NodeAddress) maxXAddressReg <- mkReg(zeroExtend(unpack(maxXAddress)));
    Reg#(NodeAddress) maxYAddressReg <- mkReg(zeroExtend(unpack(maxYAddress)));
    Reg#(LinkUtilisationCounter) link_util_counter  <- mkReg(0);
    
    (* descending_urgency = "read_input_link_dateline_and_send_to_VC, read_input_link_and_send_to_VC, read_input_link_and_send_to_VC_extreme" *)
    // Y routing after dateline is left
    rule read_input_link_dateline_and_send_to_VC( input_link_dateline.notEmpty() && (  (my_addr.nodeAddress > maxXAddressReg && my_addr.nodeAddress < maxYAddressReg*(maxXAddressReg+1) )|| (cycle==1 && (my_addr.nodeAddress <= maxXAddressReg) || my_addr.nodeAddress >= maxYAddressReg*(maxXAddressReg+1))));
        let flit = input_link_dateline.first();
        input_link_dateline.deq();

        // Extracting the X and Y coordinates
        IntAddress my_nod_addr_x          = unpack(pack(my_addr.nodeAddress)[valueOf(NodeAddressXLen)-1:0]);
        IntAddress my_nod_addr_y          = unpack(pack(my_addr.nodeAddress)[valueOf(NodeAddressTotalLen)-1:valueOf(NodeAddressXLen)]);
        IntAddress my_net_addr_x           = unpack(pack(my_addr.netAddress)[valueOf(NetAddressXLen)-1:0]);
        IntAddress my_net_addr_y           = unpack(pack(my_addr.netAddress)[valueOf(NetAddressTotalLen)-1:valueOf(NetAddressXLen)]);

        IntAddress curr_dest_nod_addr_x   = unpack(pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressXLen)-1:0]);
        IntAddress curr_dest_nod_addr_y   = unpack(pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressTotalLen)-1:valueOf(NodeAddressXLen)]);
        IntAddress curr_dest_net_addr_x    = unpack(pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressXLen)-1:0]);
        IntAddress curr_dest_net_addr_y    = unpack(pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressTotalLen)-1:valueOf(NetAddressXLen)]);
        
        if(curr_dest_nod_addr_x == my_nod_addr_x &&  curr_dest_nod_addr_y == my_nod_addr_y) begin //For this node, send to core
            if (cycle == 0) begin    
                $display("Even cycle: vir_chnl_2.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_2.enq(flit);// Reached the destination - core will consume
            end
            else begin
                $display("Odd cycle: vir_chnl_1.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_1.enq(flit);// Reached the destination - core will consume
            end
        end

        else if(curr_dest_nod_addr_x == my_nod_addr_x) begin // Do Y routing - since X coordinates are same
            if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                $display("Date line: vir_chnl_8.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_8.enq(flit);// The current flit has to go up in L2 network
            end
            else begin
                $display("Date line: vir_chnl_10.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_10.enq(flit);// The current flit has to go down in L2 network
            end
        end
        else begin
            $display("Error: X direction should be the same if dateline has been entered");
        end
    endrule

    // X and Y routing not involving dateline
    rule read_input_link_and_send_to_VC( my_addr.nodeAddress > maxXAddressReg && my_addr.nodeAddress < maxYAddressReg*(maxXAddressReg+1));
        let flit = input_link.first();
        input_link.deq();
        
        // Extracting the X and Y coordinates
        IntAddress my_nod_addr_x          = unpack(pack(my_addr.nodeAddress)[valueOf(NodeAddressXLen)-1:0]);
        IntAddress my_nod_addr_y          = unpack(pack(my_addr.nodeAddress)[valueOf(NodeAddressTotalLen)-1:valueOf(NodeAddressXLen)]);
        IntAddress my_net_addr_x           = unpack(pack(my_addr.netAddress)[valueOf(NetAddressXLen)-1:0]);
        IntAddress my_net_addr_y           = unpack(pack(my_addr.netAddress)[valueOf(NetAddressTotalLen)-1:valueOf(NetAddressXLen)]);

        IntAddress curr_dest_nod_addr_x   = unpack(pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressXLen)-1:0]);
        IntAddress curr_dest_nod_addr_y   = unpack(pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressTotalLen)-1:valueOf(NodeAddressXLen)]);
        IntAddress curr_dest_net_addr_x    = unpack(pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressXLen)-1:0]);
        IntAddress curr_dest_net_addr_y    = unpack(pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressTotalLen)-1:valueOf(NetAddressXLen)]);

        if(curr_dest_nod_addr_x == my_nod_addr_x && curr_dest_nod_addr_y == my_nod_addr_y) begin //For this node, send to core
            if (cycle == 0) begin    
                $display("Even cycle: vir_chnl_2.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_2.enq(flit);// Reached the destination - core will consume
            end
            else begin
                $display("Odd cycle: vir_chnl_1.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_1.enq(flit);// Reached the destination - core will consume
            end
        end
        
        else if(curr_dest_nod_addr_x == my_nod_addr_x) begin // Do Y routing - since X coordinates are same
            if(abs(curr_dest_nod_addr_y - my_nod_addr_y) <= unpack(maxYAddress/2)) begin
                if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                    $display("Y(up) direction: vir_chnl_7.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_7.enq(flit);// The current flit has to go up in L2 network
                end
                else begin
                    $display("Y(down) direction: vir_chnl_9.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_9.enq(flit);// The current flit has to go down in L2 network
                end
            end
            
            // Will need to pass the date-line at some point, but isn't entering the dateline yet
            else begin
                if(curr_dest_nod_addr_y < my_nod_addr_y) begin   
                    $display("Y(down) direction: vir_chnl_9.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_9.enq(flit); // The current flit has to go down in L2 network
                end
                else begin 
                    $display("Y(up) direction: cycle: vir_chnl_7.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_7.enq(flit); // The current flit has to go up in L2 network
                end
            end
        end
        
        else begin //Do X routing
            // Similar to Mesh X direction routing
            if(abs(curr_dest_nod_addr_x - my_nod_addr_x) <= unpack(maxXAddress/2)) begin
                if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                    if (cycle == 0) begin
                        $display("Even cycle: vir_chnl_4.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_4.enq(flit);// The current flit has to go to left in L2 network
                    end
                    else begin
                        $display("Odd cycle: vir_chnl_3.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_3.enq(flit);// The current flit has to go to left in L2 network
                    end    
                end
                else begin
                    if (cycle == 0) begin
                        $display("Even cycle: vir_chnl_6.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_6.enq(flit);// The current flit has to go to left in L2 network
                    end
                    else begin
                        $display("Odd cycle: vir_chnl_5.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_5.enq(flit);// The current flit has to go to right in L2 network
                    end
                end
            end
            // maxXAddress to 0 traversal
            else begin
                if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                    if (cycle == 0) begin
                        $display("Even cycle: vir_chnl_6.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_6.enq(flit);// The current flit has to go to left in L2 network
                    end
                    else begin
                        $display("Odd cycle: vir_chnl_5.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_5.enq(flit);// The current flit has to go to left in L2 network
                    end
                end
                else begin
                    if (cycle == 0) begin
                        $display("Even cycle: vir_chnl_4.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_4.enq(flit);// The current flit has to go to right in L2 network
                    end
                    else begin
                        $display("Odd cycle: vir_chnl_3.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_3.enq(flit);// The current flit has to go to right in L2 network
                    end  
                end
            end
        end    
    endrule

    // First and last row in Folded Torus
    rule read_input_link_and_send_to_VC_extreme( (!input_link_dateline.notEmpty())  || (cycle==0 && (my_addr.nodeAddress <= maxXAddressReg || my_addr.nodeAddress >= maxYAddressReg*(maxXAddressReg+1))));
        let flit = input_link.first();
        input_link.deq();
        
        // Extracting the X and Y coordinates
        IntAddress my_nod_addr_x          = unpack(pack(my_addr.nodeAddress)[valueOf(NodeAddressXLen)-1:0]);
        IntAddress my_nod_addr_y          = unpack(pack(my_addr.nodeAddress)[valueOf(NodeAddressTotalLen)-1:valueOf(NodeAddressXLen)]);
        IntAddress my_net_addr_x           = unpack(pack(my_addr.netAddress)[valueOf(NetAddressXLen)-1:0]);
        IntAddress my_net_addr_y           = unpack(pack(my_addr.netAddress)[valueOf(NetAddressTotalLen)-1:valueOf(NetAddressXLen)]);

        IntAddress curr_dest_nod_addr_x   = unpack(pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressXLen)-1:0]);
        IntAddress curr_dest_nod_addr_y   = unpack(pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressTotalLen)-1:valueOf(NodeAddressXLen)]);
        IntAddress curr_dest_net_addr_x    = unpack(pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressXLen)-1:0]);
        IntAddress curr_dest_net_addr_y    = unpack(pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressTotalLen)-1:valueOf(NetAddressXLen)]);

        if(curr_dest_nod_addr_x == my_nod_addr_x && curr_dest_nod_addr_y == my_nod_addr_y) begin //For this node, send to core
            if (cycle == 0) begin    
                $display("Even cycle: vir_chnl_2.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_2.enq(flit);// Reached the destination - core will consume
            end
            else begin
                $display("Odd cycle: vir_chnl_1.enq at addr:%h, payload:%d", my_addr,flit.payload);
                vir_chnl_1.enq(flit);// Reached the destination - core will consume
            end
        end        
        else if(curr_dest_nod_addr_x == my_nod_addr_x) begin // Do Y routing - since X coordinates are same            
            // Equivalent to Y-direction mesh routing
            if(abs(curr_dest_nod_addr_y - my_nod_addr_y) <= unpack(maxYAddress/2)) begin
                if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                    $display("Y(up) direction: vir_chnl_7.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_7.enq(flit);// The current flit has to go up in L2 network
                end
                else begin
                    $display("Y(down) direction: vir_chnl_9.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_9.enq(flit);// The current flit has to go down in L2 network
                end
            end
            
            // Will need to pass the date-line now
            else begin
                if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                    // Entry into Date Line
                    if (my_nod_addr_y == unpack(maxYAddress)) begin
                        $display("Date Line: vir_chnl_10.enq at addr:%h, payload:%d", my_addr,flit.payload);        
                        vir_chnl_10.enq(flit); // The current flit has to the first row in L2 network
                    end   
                    // Hasn't entered date line yet
                    else begin 
                        $display("Shouldn't enter vir_chnl_9, should be the last row");    
                        // $display("Y(down) direction: vir_chnl_9.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        // vir_chnl_9.enq(flit); // The current flit has to go down in L2 network
                    end
                end
                else begin
                    // Date line entry
                    if (my_nod_addr_y == 0) begin
                        $display("Date line: vir_chnl_8.enq at addr:%h, payload:%d", my_addr,flit.payload);        
                        vir_chnl_8.enq(flit); // The current flit has to the last row in L2 network
                    end   
                    // Hasn't entered date line yet
                    else begin 
                        // $display("Y(up) direction: cycle: vir_chnl_7.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        // vir_chnl_7.enq(flit); // The current flit has to go up in L2 network
                        $display("shouldn't enter vir_chnl_7. Should be in the first row of Torus");
                    end
                end
            end 
        end
        else begin //Do X routing
            // Similar to Mesh X direction routing
            if(abs(curr_dest_nod_addr_x - my_nod_addr_x) <= unpack(maxXAddress/2)) begin
                if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                    $display("Odd cycle: vir_chnl_3.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_3.enq(flit);// The current flit has to go to left in L2 network
                end
                else begin
                    $display("Odd cycle: vir_chnl_5.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_5.enq(flit);// The current flit has to go to right in L2 network
                end
            end
            // maxXAddress to 0 traversal
            else begin
                if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                    $display("Odd cycle: vir_chnl_5.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_5.enq(flit);// The current flit has to go to left in L2 network
                end
                else begin
                    $display("Odd cycle: vir_chnl_3.enq at addr:%h, payload:%d", my_addr,flit.payload);
                    vir_chnl_3.enq(flit);// The current flit has to go to right in L2 network
                end
            end
        end    

    endrule

    // Method to get the flit into the node
    method Action put_value(Flit flit);
        // Data that comes from left/right/core link is put into the input link buffer
        input_link.enq(flit);
        $display("Router(Addr: %h) received the flit into its Input Link", my_addr);
        link_util_counter <= link_util_counter+1;
        // print_flit_details(flit);
    endmethod

    method Action put_value_dateline(Flit flit);
        // Data that comes from left/right/core link is put into the input link adateline buffer
        input_link_dateline.enq(flit);
        // print_flit_details(flit);
        $display("Router (Addr: %h) received the flit into its Input Link Dateline", my_addr);
        link_util_counter <= link_util_counter+1;
    endmethod
    

    // Following are the six methods (corresponding to six available VCs) 
    // These methods return the flit so that it can reach the next node in its path
    // The VC1, VC2 methods will be invoked to send the flits to the core (as we fixed earlier, line:4)

    method ActionValue#(Flit) get_valueVC1();
        $display("get_valueVC1 method called at Router(Addr: %h)", my_addr);
         let temp1 = vir_chnl_1.first();
         vir_chnl_1.deq();
        return temp1;
    endmethod


    method ActionValue#(Flit) get_valueVC2();
        $display("get_valueVC2 method called at Router(Addr: %h)", my_addr);
         let temp2 = vir_chnl_2.first();
         vir_chnl_2.deq();
        return temp2;
    endmethod


    method ActionValue#(Flit) get_valueVC3();
        $display("get_valueVC3 method called at Router(Addr: %h)", my_addr);
         let temp3 = vir_chnl_3.first();
         vir_chnl_3.deq();
        return temp3;
    endmethod


    method ActionValue#(Flit) get_valueVC4();
        $display("get_valueVC4 method called at Router(Addr: %h)", my_addr);
         let temp4 = vir_chnl_4.first();
         vir_chnl_4.deq();
        return temp4;
    endmethod


    method ActionValue#(Flit) get_valueVC5();
        $display("get_valueVC5 method called at Router(Addr: %h)", my_addr);
         let temp5 = vir_chnl_5.first();
         vir_chnl_5.deq();
        return temp5;
    endmethod


    method ActionValue#(Flit) get_valueVC6();
        $display("get_valueVC6 method called at Router(Addr: %h)", my_addr);
         let temp6 = vir_chnl_6.first();
         vir_chnl_6.deq();
        return temp6;
    endmethod


    method ActionValue#(Flit) get_valueVC7();
        $display("get_valueVC7 method called at Router(Addr: %h)", my_addr);
         let temp7 = vir_chnl_7.first();
         vir_chnl_7.deq();
        return temp7;
    endmethod


    method ActionValue#(Flit) get_valueVC8();
        $display("get_valueVC8 method called at Router(Addr: %h)", my_addr);
         let temp8 = vir_chnl_8.first();
         vir_chnl_8.deq();
        return temp8;
    endmethod


    method ActionValue#(Flit) get_valueVC9();
        $display("get_valueVC9 method called at Router(Addr: %h)", my_addr);
         let temp9 = vir_chnl_9.first();
         vir_chnl_9.deq();
        return temp9;
    endmethod


    method ActionValue#(Flit) get_valueVC10();
        $display("get_valueVC10 method called at Router(Addr: %h)", my_addr);
         let temp10 = vir_chnl_10.first();
         vir_chnl_10.deq();
        return temp10;
    endmethod


    method LinkUtilisationCounter get_link_util_counter();
        return link_util_counter;
    endmethod

endmodule: mkFoldedTorusRouterVC

endpackage : FoldedTorusRouterVC