package Noc;
// This package instantiates all the nodes and connects them

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import ChainRouterVC :: *;
import ChainNodeVC :: *;

(* synthesize *)

module mkNoc(Empty);

    // In this example, 6 nodes are linked in a chain fashion
    
    Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;
    let node0   <- mkChainNode(node0_address, 0);
    Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=1;
    let node1   <- mkChainNode(node1_address, 0);
    Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=2;
    let node2   <- mkChainNode(node2_address, 0);

    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    //Address node3_address;  node3_address.netAddress=0;  node3_address.nodeAddress=3;
    //let node3   <- mkChainNode(node3_address, 1); // Head node

    //Address node4_address;  node4_address.netAddress=0;  node4_address.nodeAddress=4;
    //let node4   <- mkChainNode(node4_address, 0);
    //Address node5_address;  node5_address.netAddress=0;  node5_address.nodeAddress=5;
    //let node5   <- mkChainNode(node5_address, 0);
    
    // Connecting nodes - following are the interface of the nodes
    // First (below) all LEFT TO RIGHT connections are made
    // (ie) Flit goes from Node 0 to Node 1 (right direction travel, hence L2R(left 2 right)) 
    rule connect_Node0_to_Node1_L2R;
        $display("connect_Node0_to_Node1_L2R");
        let data01_L2R <- node0.get_value_to_right();
        node1.put_value_from_left(data01_L2R);
    endrule

    rule connect_Node1_to_Node2_L2R;
        $display("connect_Node1_to_Node2_L2R");
        let data12_L2R <- node1.get_value_to_right();
        node2.put_value_from_left(data12_L2R);
    endrule

    /*rule connect_Node2_to_Node3_L2R;
        let data23_L2R <- node2.get_value_to_right();
        node3.put_value_from_left(data23_L2R);
        $display("going from node 2 to node 3");
    endrule

    rule connect_Node3_to_Node4_L2R;
        let data34_L2R <- node3.get_value_to_right();
        node4.put_value_from_left(data34_L2R);
        $display("going from node 3 to node 4");
    endrule*/

    /*rule connect_Node4_to_Node5_L2R;
        let data45_L2R <- node4.get_value_to_right();
        node5.put_value_from_left(data45_L2R);
    endrule*/

    // Now (below) all RIGHT TO LEFT connections are made
    rule connect_Node1_to_Node0_R2L;
        $display("connect_Node2_to_Node1_R2L");
        let data10_R2L <- node1.get_value_to_left();
        node0.put_value_from_right(data10_R2L);
    endrule

    rule connect_Node2_to_Node1_R2L;
        $display("connect_Node2_to_Node1_R2L");
        let data21_R2L <- node2.get_value_to_left();
        node1.put_value_from_right(data21_R2L);
    endrule

    /*rule connect_Node3_to_Node2_R2L;
        let data32_R2L <- node3.get_value_to_left();
        node2.put_value_from_right(data32_R2L);
    endrule

    rule connect_Node4_to_Node3_R2L;
        let data43_R2L <- node4.get_value_to_left();
        node3.put_value_from_right(data43_R2L);
    endrule*/

    /*rule connect_Node5_to_Node4_R2L;
        let data54_R2L <- node5.get_value_to_left();
        node4.put_value_from_right(data54_R2L);
    endrule*/



endmodule
endpackage : Noc