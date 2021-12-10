package Noc_mesh;
// This package instantiates all the nodes and connects them

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import MeshRouterVC :: *;
import MeshNodeVC :: *;

(* synthesize *)

module mkNoc(Empty);

    // In this example, 6 nodes are linked in a Mesh fashion
    
    Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=16'h0000;
    let node0   <- mkMeshNode(node0_address, 0);
    Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=16'h0001;
    let node1   <- mkMeshNode(node1_address, 0);
    Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=16'h0002;
    let node2   <- mkMeshNode(node2_address, 0);

    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    Address node3_address;  node3_address.netAddress=0;  node3_address.nodeAddress=16'h0100;
    let node3   <- mkMeshNode(node3_address, 1); // Head node

    Address node4_address;  node4_address.netAddress=0;  node4_address.nodeAddress=16'h0101;
    let node4   <- mkMeshNode(node4_address, 1);
    Address node5_address;  node5_address.netAddress=0;  node5_address.nodeAddress=16'h0102;
    let node5   <- mkMeshNode(node5_address, 0);

    // Last row in folded torus
    Address node6_address;  node6_address.netAddress=0;  node6_address.nodeAddress=16'h0200;
    let node6   <- mkMeshNode(node6_address, 0); // Head node

    Address node7_address;  node7_address.netAddress=0;  node7_address.nodeAddress=16'h0201;
    let node7   <- mkMeshNode(node7_address, 0);
    Address node8_address;  node8_address.netAddress=0;  node8_address.nodeAddress=16'h0202;
    let node8   <- mkMeshNode(node8_address, 0);
    
    // Connecting nodes - following are the interface of the nodes
    // First (below) all LEFT TO RIGHT connections are made
    // (ie) Flit goes from Node 0 to Node 1 (right direction travel, hence L2R(left 2 right)) 

   // Connecting Left to Right nodes
    rule connect_Node0_to_Node1_L2R;
        let data01_L2R <- node0.get_value_to_right();
        node1.put_value_from_left(data01_L2R);
    endrule

    rule connect_Node1_to_Node2_L2R;
        let data12_L2R <- node1.get_value_to_right();
        node2.put_value_from_left(data12_L2R);
    endrule

    rule connect_Node3_to_Node4_L2R;
        let data34_L2R <- node3.get_value_to_right();
        node4.put_value_from_left(data34_L2R);
    endrule

    rule connect_Node4_to_Node5_L2R;
        let data45_L2R <- node4.get_value_to_right();
        node5.put_value_from_left(data45_L2R);
    endrule

    rule connect_Node6_to_Node7_L2R;
        let data67_L2R <- node6.get_value_to_right();
        node7.put_value_from_left(data67_L2R);
    endrule

    rule connect_Node7_to_Node8_L2R;
        let data78_L2R <- node7.get_value_to_right();
        node8.put_value_from_left(data78_L2R);
    endrule


    // Connecting Right to Left nodes
    rule connect_Node1_to_Node0_R2L;
        let data10_R2L <- node1.get_value_to_left();
        node0.put_value_from_right(data10_R2L);
    endrule

    rule connect_Node2_to_Node1_R2L;
        let data21_R2L <- node2.get_value_to_left();
        node1.put_value_from_right(data21_R2L);
    endrule

    rule connect_Node4_to_Node3_R2L;
        let data43_R2L <- node4.get_value_to_left();
        node3.put_value_from_right(data43_R2L);
    endrule

    rule connect_Node5_to_Node4_R2L;
        let data54_R2L <- node5.get_value_to_left();
        node4.put_value_from_right(data54_R2L);
    endrule

    rule connect_Node7_to_Node6_R2L;
        let data76_R2L <- node7.get_value_to_left();
        node6.put_value_from_right(data76_R2L);
    endrule

    rule connect_Node8_to_Node7_R2L;
        let data87_R2L <- node8.get_value_to_left();
        node7.put_value_from_right(data87_R2L);
    endrule


    // Connecting Top to Bottom nodes
    rule connect_Node0_to_Node3_T2B;
        let data03_T2B <- node0.get_value_to_bottom();
        node3.put_value_from_top(data03_T2B);
    endrule

    rule connect_Node1_to_Node4_T2B;
        let data14_T2B <- node1.get_value_to_bottom();
        node4.put_value_from_top(data14_T2B);
    endrule

    rule connect_Node2_to_Node5_T2B;
        let data25_T2B <- node2.get_value_to_bottom();
        node5.put_value_from_top(data25_T2B);
    endrule

    rule connect_Node3_to_Node6_T2B;
        let data36_T2B <- node3.get_value_to_bottom();
        node6.put_value_from_top(data36_T2B);
    endrule

    rule connect_Node4_to_Node7_T2B;
        let data47_T2B <- node4.get_value_to_bottom();
        node7.put_value_from_top(data47_T2B);
    endrule

    rule connect_Node5_to_Node8_T2B;
        let data58_T2B <- node5.get_value_to_bottom();
        node8.put_value_from_top(data58_T2B);
    endrule


    // Connecting Bottom to Top nodes
    rule connect_Node3_to_Node0_B2T;
        let data30_B2T <- node3.get_value_to_top();
        node0.put_value_from_bottom(data30_B2T);
    endrule

    rule connect_Node4_to_Node1_B2T;
        let data41_B2T <- node4.get_value_to_top();
        node1.put_value_from_bottom(data41_B2T);
    endrule

    rule connect_Node5_to_Node2_B2T;
        let data52_B2T <- node5.get_value_to_top();
        node2.put_value_from_bottom(data52_B2T);
    endrule

    rule connect_Node6_to_Node3_B2T;
        let data63_B2T <- node6.get_value_to_top();
        node3.put_value_from_bottom(data63_B2T);
    endrule

    rule connect_Node7_to_Node4_B2T;
        let data74_B2T <- node7.get_value_to_top();
        node4.put_value_from_bottom(data74_B2T);
    endrule

    rule connect_Node8_to_Node5_B2T;
        let data85_B2T <- node8.get_value_to_top();
        node5.put_value_from_bottom(data85_B2T);
    endrule



endmodule
endpackage : Noc_mesh