package Noc;
// This package instantiates all the nodes and connects them

//import Network1:: *;
//import Network2:: *;
//import Network3:: *;

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import ChainRouterVC :: *;
import ChainNodeVC :: *;
import ChainHeadNodeVC :: *;

(* synthesize *)
module mkNoc(Empty);

    //Empty network1 <- mkNetwork1;
    //Empty network2 <- mkNetwork2;
    //Empty network3 <- mkNetwork3;

    //Setting up L2 network 0. A chain with 6 nodes.
    // In this example, 6 nodes are linked in a chain fashion.
    Address node_0_0_address;  node_0_0_address.netAddress=0;  node_0_0_address.nodeAddress=0;
    Address node_0_1_address;  node_0_1_address.netAddress=0;  node_0_1_address.nodeAddress=1;
    Address node_0_2_address;  node_0_2_address.netAddress=0;  node_0_2_address.nodeAddress=2;
    Address node_0_3_address;  node_0_3_address.netAddress=0;  node_0_3_address.nodeAddress=3;
    Address node_0_4_address;  node_0_4_address.netAddress=0;  node_0_4_address.nodeAddress=4;
    Address node_0_5_address;  node_0_5_address.netAddress=0;  node_0_5_address.nodeAddress=5;
    Address head_node_address_net_0=node_0_3_address;
    let node_0_0   <- mkChainNode(node_0_0_address, head_node_address_net_0,False);
    let node_0_1   <- mkChainNode(node_0_1_address, head_node_address_net_0,False);
    let node_0_2   <- mkChainNode(node_0_2_address, head_node_address_net_0,False);

    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    
    let node_0_3   <- mkChainHeadNode(node_0_3_address, head_node_address_net_0,True); // Head node
    let node_0_4   <- mkChainNode(node_0_4_address, head_node_address_net_0,False);
    let node_0_5   <- mkChainNode(node_0_5_address, head_node_address_net_0,False);
    
    // Connecting nodes - following are the interface of the nodes
    // First (below) all LEFT TO RIGHT connections are made
    // (ie) Flit goes from Node 0 to Node 1 (right direction travel, hence L2R(left 2 right)) 
    rule connect_Node_0_0_to_Node_0_1_L2R;
        let data01_L2R <- node_0_0.get_value_to_right();
        node_0_1.put_value_from_left(data01_L2R);
    endrule

    rule connect_Node_0_1_to_Node_0_2_L2R;
        let data12_L2R <- node_0_1.get_value_to_right();
        node_0_2.put_value_from_left(data12_L2R);
    endrule

    rule connect_Node_0_2_to_Node_0_3_L2R;
        let data23_L2R <- node_0_2.get_value_to_right();
        node_0_3.put_value_from_left(data23_L2R);
    endrule

    rule connect_Node_0_3_to_Node_0_4_L2R;
        let data34_L2R <- node_0_3.get_value_to_right();
        node_0_4.put_value_from_left(data34_L2R);
    endrule

    rule connect_Node_0_4_to_Node_0_5_L2R;
        let data45_L2R <- node_0_4.get_value_to_right();
        node_0_5.put_value_from_left(data45_L2R);
    endrule

    // Now (below) all RIGHT TO LEFT connections are made
    rule connect_Node_0_1_to_Node_0_0_R2L;
        let data10_R2L <- node_0_1.get_value_to_left();
        node_0_0.put_value_from_right(data10_R2L);
    endrule

    rule connect_Node_0_2_to_Node_0_1_R2L;
        let data21_R2L <- node_0_2.get_value_to_left();
        node_0_1.put_value_from_right(data21_R2L);
    endrule

    rule connect_Node_0_3_to_Node_0_2_R2L;
        let data32_R2L <- node_0_3.get_value_to_left();
        node_0_2.put_value_from_right(data32_R2L);
    endrule

    rule connect_Node_0_4_to_Node_0_3_R2L;
        let data43_R2L <- node_0_4.get_value_to_left();
        node_0_3.put_value_from_right(data43_R2L);
    endrule

    rule connect_Node_0_5_to_Node_0_4_R2L;
        let data54_R2L <- node_0_5.get_value_to_left();
        node_0_4.put_value_from_right(data54_R2L);
    endrule

    //Setting up L2 network 1. A chain with 6 nodes.
    // In this example, 6 nodes are linked in a chain fashion.
    Address node_1_0_address;  node_1_0_address.netAddress=1;  node_1_0_address.nodeAddress=0;
    Address node_1_1_address;  node_1_1_address.netAddress=1;  node_1_1_address.nodeAddress=1;
    Address node_1_2_address;  node_1_2_address.netAddress=1;  node_1_2_address.nodeAddress=2;
    Address node_1_3_address;  node_1_3_address.netAddress=1;  node_1_3_address.nodeAddress=3;
    Address node_1_4_address;  node_1_4_address.netAddress=1;  node_1_4_address.nodeAddress=4;
    Address node_1_5_address;  node_1_5_address.netAddress=1;  node_1_5_address.nodeAddress=5;
    Address head_node_address_net_1=node_1_3_address;
    let node_1_0   <- mkChainNode(node_1_0_address, head_node_address_net_1,False);
    let node_1_1   <- mkChainNode(node_1_1_address, head_node_address_net_1,False);
    let node_1_2   <- mkChainNode(node_1_2_address, head_node_address_net_1,False);

    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    
    let node_1_3   <- mkChainHeadNode(node_1_3_address, head_node_address_net_1,True); // Head node
    let node_1_4   <- mkChainNode(node_1_4_address, head_node_address_net_1,False);
    let node_1_5   <- mkChainNode(node_1_5_address, head_node_address_net_1,False);
    
    // Connecting nodes - following are the interface of the nodes
    // First (below) all LEFT TO RIGHT connections are made
    // (ie) Flit goes from Node 0 to Node 1 (right direction travel, hence L2R(left 2 right)) 
    rule connect_Node_1_0_to_Node_1_1_L2R;
        let data01_L2R <- node_1_0.get_value_to_right();
        node_1_1.put_value_from_left(data01_L2R);
    endrule

    rule connect_Node_1_1_to_Node_1_2_L2R;
        let data12_L2R <- node_1_1.get_value_to_right();
        node_1_2.put_value_from_left(data12_L2R);
    endrule

    rule connect_Node_1_2_to_Node_1_3_L2R;
        let data23_L2R <- node_1_2.get_value_to_right();
        node_1_3.put_value_from_left(data23_L2R);
    endrule

    rule connect_Node_1_3_to_Node_1_4_L2R;
        let data34_L2R <- node_1_3.get_value_to_right();
        node_1_4.put_value_from_left(data34_L2R);
    endrule

    rule connect_Node_1_4_to_Node_1_5_L2R;
        let data45_L2R <- node_1_4.get_value_to_right();
        node_1_5.put_value_from_left(data45_L2R);
    endrule

    // Now (below) all RIGHT TO LEFT connections are made
    rule connect_Node_1_1_to_Node_1_0_R2L;
        let data10_R2L <- node_1_1.get_value_to_left();
        node_1_0.put_value_from_right(data10_R2L);
    endrule

    rule connect_Node_1_2_to_Node_1_1_R2L;
        let data21_R2L <- node_1_2.get_value_to_left();
        node_1_1.put_value_from_right(data21_R2L);
    endrule

    rule connect_Node_1_3_to_Node_1_2_R2L;
        let data32_R2L <- node_1_3.get_value_to_left();
        node_1_2.put_value_from_right(data32_R2L);
    endrule

    rule connect_Node_1_4_to_Node_1_3_R2L;
        let data43_R2L <- node_1_4.get_value_to_left();
        node_1_3.put_value_from_right(data43_R2L);
    endrule

    rule connect_Node_1_5_to_Node_1_4_R2L;
        let data54_R2L <- node_1_5.get_value_to_left();
        node_1_4.put_value_from_right(data54_R2L);
    endrule



    //Setting up L2 network 2. A chain with 6 nodes.
    // In this example, 6 nodes are linked in a chain fashion.
    Address node_2_0_address;  node_2_0_address.netAddress=2;  node_2_0_address.nodeAddress=0;
    Address node_2_1_address;  node_2_1_address.netAddress=2;  node_2_1_address.nodeAddress=1;
    Address node_2_2_address;  node_2_2_address.netAddress=2;  node_2_2_address.nodeAddress=2;
    Address node_2_3_address;  node_2_3_address.netAddress=2;  node_2_3_address.nodeAddress=3;
    Address node_2_4_address;  node_2_4_address.netAddress=2;  node_2_4_address.nodeAddress=4;
    Address node_2_5_address;  node_2_5_address.netAddress=2;  node_2_5_address.nodeAddress=5;
    Address head_node_address_net_2=node_2_3_address;
    let node_2_0   <- mkChainNode(node_2_0_address, head_node_address_net_2,False);
    let node_2_1   <- mkChainNode(node_2_1_address, head_node_address_net_2,False);
    let node_2_2   <- mkChainNode(node_2_2_address, head_node_address_net_2,False);

    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    
    let node_2_3   <- mkChainHeadNode(node_2_3_address, head_node_address_net_2,True); // Head node
    let node_2_4   <- mkChainNode(node_2_4_address, head_node_address_net_2,False);
    let node_2_5   <- mkChainNode(node_2_5_address, head_node_address_net_2,False);
    
    // Connecting nodes - following are the interface of the nodes
    // First (below) all LEFT TO RIGHT connections are made
    // (ie) Flit goes from Node 0 to Node 1 (right direction travel, hence L2R(left 2 right)) 
    rule connect_Node_2_0_to_Node_2_1_L2R;
        let data01_L2R <- node_2_0.get_value_to_right();
        node_2_1.put_value_from_left(data01_L2R);
    endrule

    rule connect_Node_2_1_to_Node_2_2_L2R;
        let data12_L2R <- node_2_1.get_value_to_right();
        node_2_2.put_value_from_left(data12_L2R);
    endrule

    rule connect_Node_2_2_to_Node_2_3_L2R;
        let data23_L2R <- node_2_2.get_value_to_right();
        node_2_3.put_value_from_left(data23_L2R);
    endrule

    rule connect_Node_2_3_to_Node_2_4_L2R;
        let data34_L2R <- node_2_3.get_value_to_right();
        node_2_4.put_value_from_left(data34_L2R);
    endrule

    rule connect_Node_2_4_to_Node_2_5_L2R;
        let data45_L2R <- node_2_4.get_value_to_right();
        node_2_5.put_value_from_left(data45_L2R);
    endrule

    // Now (below) all RIGHT TO LEFT connections are made
    rule connect_Node_2_1_to_Node_2_0_R2L;
        let data10_R2L <- node_2_1.get_value_to_left();
        node_2_0.put_value_from_right(data10_R2L);
    endrule

    rule connect_Node_2_2_to_Node_2_1_R2L;
        let data21_R2L <- node_2_2.get_value_to_left();
        node_2_1.put_value_from_right(data21_R2L);
    endrule

    rule connect_Node_2_3_to_Node_2_2_R2L;
        let data32_R2L <- node_2_3.get_value_to_left();
        node_2_2.put_value_from_right(data32_R2L);
    endrule

    rule connect_Node_2_4_to_Node_2_3_R2L;
        let data43_R2L <- node_2_4.get_value_to_left();
        node_2_3.put_value_from_right(data43_R2L);
    endrule

    rule connect_Node_2_5_to_Node_2_4_R2L;
        let data54_R2L <- node_2_5.get_value_to_left();
        node_2_4.put_value_from_right(data54_R2L);
    endrule

    //Setting up L1 chain link between L2-0, L2-1, and L2-2 networks
    rule set_l1_linksx1;
        //Left to right connections
        let data1_L2R <- node_0_3.get_value_to_head_right();
        node_1_3.put_value_from_head_left(data1_L2R);
    endrule    

    rule set_l1_linksx2;
        let data2_L2R <- node_1_3.get_value_to_head_right();
        node_2_3.put_value_from_head_left(data2_L2R);
    endrule

        //Right to left connections
    rule set_l1_linksx3;    
        let data3_L2R <- node_2_3.get_value_to_head_left();
        node_1_3.put_value_from_head_right(data3_L2R);
    endrule

    rule set_l1_linksx4;
        let data4_L2R <- node_1_3.get_value_to_head_left();
        node_0_3.put_value_from_head_right(data4_L2R);
    endrule

endmodule: mkNoc

endpackage : Noc
