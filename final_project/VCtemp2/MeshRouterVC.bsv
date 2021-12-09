/*************************************************************************************
CS6230:CAD for VLSI Systems - Final Project
Name: Implementation of a configuralble NoC using Python and bluespec
Team Name: Kilbees
Team Members: Abishekshivram AM (EE18B002)
              Gayatri Ramanathan Ratnam (EE18B006)
              Lloyd K L (CS21M001)
Description: The Mesh router implementation
Last updated on: 09-Dec-2021
**************************************************************************************/

package MeshRouterVC;
// This package contains the router - which implements the routing algorithm for the mesh topology
// Routing algorithm works as follows:
// For each link, two VCs are allocated. For example, in each node in mesh topology, we have
// maximum 5 links  (core, left neighbour, right neighbour,top neighbour, bottom neighbour,). So 6 VCs are made and VC1,2 allocated to core, 
// VC3,4 allocated to left neighbour, VC5,6 allocated to right neighbour, VC7,8 allocated to top neighbour, VC9,10 allocated to bottom neighbour


import Shared::*;
import FIFO :: * ;
import Parameters :: * ;

interface IfcMeshRouterVC ;
    // Put value is used to insert data to the router
    
    method Action put_value (Flit flit);

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
        
    method ActionValue#(Flit) get_valueVC11();
    method ActionValue#(Flit) get_valueVC12();
    method ActionValue#(Flit) get_valueVC13();
    method ActionValue#(Flit) get_valueVC14();
    method ActionValue#(Flit) get_valueVC15();
    method ActionValue#(Flit) get_valueVC16();
    method ActionValue#(Flit) get_valueVC17();
    method ActionValue#(Flit) get_valueVC18();   
    
endinterface


(* synthesize *)

// This router sends both in left right directions. 
// For the nodes at the extremes, we can just not use two links (leftmost node's left link and rightmost node's right link)
module mkMeshRouterVC #(parameter Address my_addr,parameter Bool is_head_nod) (IfcMeshRouterVC);

    function Action print_flit_details(Flit flit_to_print);
        return action
            $display("\nPrinting Flit details:");
            $display("Flit Source      address: NetworkID: %h | NodeID: %h", flit_to_print.srcAddress.netAddress, flit_to_print.srcAddress.nodeAddress);
            $display("Flit Destination address: NetworkID: %h | NodeID: %h", flit_to_print.finalDstAddress.netAddress, flit_to_print.finalDstAddress.nodeAddress);
            $display("Flit Current Dst address: NetworkID: %h | NodeID: %h\n", flit_to_print.currentDstAddress.netAddress, flit_to_print.currentDstAddress.nodeAddress);
        endaction;
    endfunction

    Reg#(Bool)  is_head_node <- mkReg(is_head_nod); // True indicates head node, False other nodes

    // Input link for the router
    FIFO#(Flit)  input_link  <- mkFIFO; // to get data from neighbouring router and core
    
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

    // To store the flits that are sent to L1 routing, NETWORK on left
    FIFO#(Flit)  vir_chnl_11  <- mkFIFO; // Virtual Channel 1
    FIFO#(Flit)  vir_chnl_12  <- mkFIFO; // Virtual Channel 2
        
    // To store the flits that are sent to L1 routing, NETWORK on right
    FIFO#(Flit)  vir_chnl_13  <- mkFIFO; // Virtual Channel 3
    FIFO#(Flit)  vir_chnl_14  <- mkFIFO; // Virtual Channel 4
        
    // To store the flits that are sent to L1 routing, NETWORK above (up)
    FIFO#(Flit)  vir_chnl_15  <- mkFIFO; // Virtual Channel 5
    FIFO#(Flit)  vir_chnl_16  <- mkFIFO; // Virtual Channel 6
    
    // To store the flits that are sent to L1 routing, NETWORK below (down)
    FIFO#(Flit)  vir_chnl_17  <- mkFIFO; // Virtual Channel 7
    FIFO#(Flit)  vir_chnl_18  <- mkFIFO; // Virtual Channel 8
        

    // Since we have TWO VIRUTAL CHANNELs for each flit's next path, we have one bit cycle
    // that chooses one VC in a round robin fashion.
    Reg#(bit) cycle  <- mkReg(0);
    rule invert_cycle;
        cycle <= cycle + 1;     // Cycle variable oscillates between 0 and 1
    endrule

    // Connect input_link to respective VC
    // This rules fires every alternate cycle, and chooses odd named Virtual Channels (VC1, VC3, VC5...)
    rule read_input_link_and_send_to_VC_odd(cycle == 1);

        let flit = input_link.first();
        input_link.deq();

        // Extracting the X and Y coordinates
        NodeAddressX my_nod_addr_x          = pack(my_addr.nodeAddress)[valueOf(NodeAddressLen)-1:valueOf(NodeAddressXLen)];
		NodeAddressY my_nod_addr_y          = pack(my_addr.nodeAddress)[valueOf(NodeAddressXLen)-1:0];
        NetAddressX my_net_addr_x           = pack(my_addr.netAddress)[valueOf(NetAddressLen)-1:valueOf(NetAddressXLen)];
		NetAddressY my_net_addr_y           = pack(my_addr.netAddress)[valueOf(NetAddressXLen)-1:0];

        NodeAddressX curr_dest_nod_addr_x   = pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressLen)-1:valueOf(NodeAddressXLen)];
		NodeAddressY curr_dest_nod_addr_y   = pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressXLen)-1:0];
        NetAddressX curr_dest_net_addr_x    = pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressLen)-1:valueOf(NetAddressXLen)];
		NetAddressY curr_dest_net_addr_y    = pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressXLen)-1:0];

        NodeAddressX final_dest_nod_addr_x  = pack(flit.finalDstAddress.nodeAddress)[valueOf(NodeAddressLen)-1:valueOf(NodeAddressXLen)];
		NodeAddressY final_dest_nod_addr_y  = pack(flit.finalDstAddress.nodeAddress)[valueOf(NodeAddressXLen)-1:0];
        NetAddressX final_dest_net_addr_x   = pack(flit.finalDstAddress.netAddress)[valueOf(NetAddressLen)-1:valueOf(NetAddressXLen)];
		NetAddressY final_dest_net_addr_y   = pack(flit.finalDstAddress.netAddress)[valueOf(NetAddressXLen)-1:0];

        if(flit.finalDstAddress == my_addr) begin //For this node, send to core
            $display("Odd cycle: vir_chnl_1.enq at addr:%h, payload:%d", my_addr,flit.payload);
            vir_chnl_1.enq(flit);// Reached the destination - core will consume
        end
        else begin
            if(is_head_nod==False) begin
                if(curr_dest_nod_addr_x == my_nod_addr_x) begin // Do Y routing - since X coordinates are same
                    if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                        $display("Odd cycle: vir_chnl_7.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_7.enq(flit);// The current flit has to go up in L2 network
                    end
                    else begin
                        $display("Odd cycle: vir_chnl_9.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_9.enq(flit);// The current flit has to go down in L2 network
                    end
                end
                else begin //Do X routing
                    if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                        $display("Odd cycle: vir_chnl_3.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_3.enq(flit);// The current flit has to go to left in L2 network
                    end
                    else begin
                        $display("Odd cycle: vir_chnl_5.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_5.enq(flit);// The current flit has to go to right in L2 network
                    end
                end
            end
            else begin //Headnode
                if(flit.finalDstAddress.netAddress == my_addr.netAddress) begin //Do L2 routing in head node
                    if(curr_dest_nod_addr_x == my_nod_addr_x) begin // Do Y routing - since X coordinates are same
                        if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                            $display("Odd cycle: vir_chnl_7.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_7.enq(flit);// The current flit has to go up in L2 network
                        end
                        else begin
                            $display("Odd cycle: vir_chnl_9.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_9.enq(flit);// The current flit has to go down in L2 network
                        end
                    end
                    else begin //Do X routing
                        if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                            $display("Odd cycle: vir_chnl_3.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_3.enq(flit);// The current flit has to go to left in L2 network
                        end
                        else begin
                            $display("Odd cycle: vir_chnl_5.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_5.enq(flit);// The current flit has to go to right in L2 network
                        end
                    end
                end
                else begin //Do L1 Routing
                    flit.currentDstAddress = flit.finalDstAddress;
                    if(curr_dest_net_addr_x == my_net_addr_x) begin // Do Y routing - since X coordinates are same
                        if(curr_dest_net_addr_y < my_net_addr_y) begin 
                            $display("Odd cycle: vir_chnl_15.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_15.enq(flit);// The current flit has to go up in L1 network
                        end
                        else begin
                            $display("Odd cycle: vir_chnl_17.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_17.enq(flit);// The current flit has to go down in L1 network
                        end
                    end
                    else begin //Do X routing
                        if(curr_dest_net_addr_x < my_net_addr_x) begin 
                            $display("Odd cycle: vir_chnl_11.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_11.enq(flit);// The current flit has to go to left in L1 network
                        end
                        else begin
                            $display("Odd cycle: vir_chnl_13.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_13.enq(flit);// The current flit has to go to right in L1 network
                        end
                    end
                end
            end
        end        

    endrule


    // Connect input_link to respective VC
    // This rules fires every alternate cycle, and chooses even named Virtual Channels (VC2, VC4, VC6...)
    rule read_input_link_and_send_to_VC_even(cycle == 0);

        let flit = input_link.first();
        input_link.deq();

        // Extracting the X and Y coordinates
        NodeAddressX my_nod_addr_x          = pack(my_addr.nodeAddress)[valueOf(NodeAddressLen)-1:valueOf(NodeAddressXLen)];
		NodeAddressY my_nod_addr_y          = pack(my_addr.nodeAddress)[valueOf(NodeAddressXLen)-1:0];
        NetAddressX my_net_addr_x           = pack(my_addr.netAddress)[valueOf(NetAddressLen)-1:valueOf(NetAddressXLen)];
		NetAddressY my_net_addr_y           = pack(my_addr.netAddress)[valueOf(NetAddressXLen)-1:0];

        NodeAddressX curr_dest_nod_addr_x   = pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressLen)-1:valueOf(NodeAddressXLen)];
		NodeAddressY curr_dest_nod_addr_y   = pack(flit.currentDstAddress.nodeAddress)[valueOf(NodeAddressXLen)-1:0];
        NetAddressX curr_dest_net_addr_x    = pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressLen)-1:valueOf(NetAddressXLen)];
		NetAddressY curr_dest_net_addr_y    = pack(flit.currentDstAddress.netAddress)[valueOf(NetAddressXLen)-1:0];

        NodeAddressX final_dest_nod_addr_x  = pack(flit.finalDstAddress.nodeAddress)[valueOf(NodeAddressLen)-1:valueOf(NodeAddressXLen)];
		NodeAddressY final_dest_nod_addr_y  = pack(flit.finalDstAddress.nodeAddress)[valueOf(NodeAddressXLen)-1:0];
        NetAddressX final_dest_net_addr_x   = pack(flit.finalDstAddress.netAddress)[valueOf(NetAddressLen)-1:valueOf(NetAddressXLen)];
		NetAddressY final_dest_net_addr_y   = pack(flit.finalDstAddress.netAddress)[valueOf(NetAddressXLen)-1:0];

        if(flit.finalDstAddress == my_addr) begin //For this node, send to core
            $display("Even cycle: vir_chnl_2.enq at addr:%h, payload:%d", my_addr,flit.payload);
            vir_chnl_2.enq(flit);// Reached the destination - core will consume
        end
        else begin
            if(is_head_nod==False) begin
                if(curr_dest_nod_addr_x == my_nod_addr_x) begin // Do Y routing - since X coordinates are same
                    if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                        $display("Even cycle: vir_chnl_8.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_8.enq(flit);// The current flit has to go up in L2 network
                    end
                    else begin
                        $display("Even cycle: vir_chnl_10.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_10.enq(flit);// The current flit has to go down in L2 network
                    end
                end
                else begin //Do X routing
                    if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                        $display("Even cycle: vir_chnl_4.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_4.enq(flit);// The current flit has to go to left in L2 network
                    end
                    else begin
                        $display("Even cycle: vir_chnl_6.enq at addr:%h, payload:%d", my_addr,flit.payload);
                        vir_chnl_6.enq(flit);// The current flit has to go to right in L2 network
                    end
                end
            end
            else begin //Headnode
                if(flit.finalDstAddress.netAddress == my_addr.netAddress) begin //Do L2 routing in head node
                    if(curr_dest_nod_addr_x == my_nod_addr_x) begin // Do Y routing - since X coordinates are same
                        if(curr_dest_nod_addr_y < my_nod_addr_y) begin 
                            $display("Even cycle: vir_chnl_8.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_8.enq(flit);// The current flit has to go up in L2 network
                        end
                        else begin
                            $display("Even cycle: vir_chnl_10.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_10.enq(flit);// The current flit has to go down in L2 network
                        end
                    end
                    else begin //Do X routing
                        if(curr_dest_nod_addr_x < my_nod_addr_x) begin 
                            $display("Even cycle: vir_chnl_4.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_4.enq(flit);// The current flit has to go to left in L2 network
                        end
                        else begin
                            $display("Even cycle: vir_chnl_6.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_6.enq(flit);// The current flit has to go to right in L2 network
                        end
                    end
                end
                else begin //Do L1 Routing
                    flit.currentDstAddress = flit.finalDstAddress;
                    if(curr_dest_net_addr_x == my_net_addr_x) begin // Do Y routing - since X coordinates are same
                        if(curr_dest_net_addr_y < my_net_addr_y) begin 
                            $display("Even cycle: vir_chnl_16.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_16.enq(flit);// The current flit has to go up in L1 network
                        end
                        else begin
                            $display("Even cycle: vir_chnl_18.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_18.enq(flit);// The current flit has to go down in L1 network
                        end
                    end
                    else begin //Do X routing
                        if(curr_dest_net_addr_x < my_net_addr_x) begin 
                            $display("Even cycle: vir_chnl_12.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_12.enq(flit);// The current flit has to go to left in L1 network
                        end
                        else begin
                            $display("Even cycle: vir_chnl_14.enq at addr:%h, payload:%d", my_addr,flit.payload);
                            vir_chnl_14.enq(flit);// The current flit has to go to right in L1 network
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
        $display("Router(Addr: %h) received the flit into its Input Link", my_addr);
        print_flit_details(flit);
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

    method ActionValue#(Flit) get_valueVC11();
        $display("get_valueVC11 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_11.first();
         vir_chnl_11.deq();
        return temp;
    endmethod

    method ActionValue#(Flit) get_valueVC12();
        $display("get_valueVC12 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_12.first();
         vir_chnl_12.deq();
        return temp;
    endmethod
    
    method ActionValue#(Flit) get_valueVC13();
        $display("get_valueVC13 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_13.first();
         vir_chnl_13.deq();
        return temp;
    endmethod
    
    method ActionValue#(Flit) get_valueVC14();
        $display("get_valueVC14 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_14.first();
         vir_chnl_14.deq();
        return temp;
    endmethod    

    method ActionValue#(Flit) get_valueVC15();
        $display("get_valueVC15 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_15.first();
         vir_chnl_15.deq();
        return temp;
    endmethod

    method ActionValue#(Flit) get_valueVC16();
        $display("get_valueVC16 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_16.first();
         vir_chnl_16.deq();
        return temp;
    endmethod
    
    method ActionValue#(Flit) get_valueVC17();
        $display("get_valueVC17 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_17.first();
         vir_chnl_17.deq();
        return temp;
    endmethod
    
    method ActionValue#(Flit) get_valueVC18();
        $display("get_valueVC18 method called at Router(Addr: %h)", my_addr);
         let temp = vir_chnl_18.first();
         vir_chnl_18.deq();
        return temp;
    endmethod

endmodule: mkMeshRouterVC

endpackage : MeshRouterVC
