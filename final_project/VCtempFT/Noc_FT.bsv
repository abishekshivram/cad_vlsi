package Noc_FT;
// This package instantiates all the nodes and connects them

import Shared::*;
import Parameters::*;

import FoldedTorusRouterVC :: *;
import FoldedTorusNodeVC :: *;

(* synthesize *)

module mkNoc(Empty);

    // In this example, 6 nodes are linked in a FoldedTorus fashion
    NodeAddressX maxXAddress = fromInteger(2);
    NodeAddressY maxYAddress = fromInteger(2);

    Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=16'h0000;
    Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=16'h0001;
    Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=16'h0002;
    Address node3_address;  node3_address.netAddress=0;  node3_address.nodeAddress=16'h0100;
    Address node4_address;  node4_address.netAddress=0;  node4_address.nodeAddress=16'h0101;
    Address node5_address;  node5_address.netAddress=0;  node5_address.nodeAddress=16'h0102;
    Address node6_address;  node6_address.netAddress=0;  node6_address.nodeAddress=16'h0200;
    Address node7_address;  node7_address.netAddress=0;  node7_address.nodeAddress=16'h0201;
    Address node8_address;  node8_address.netAddress=0;  node8_address.nodeAddress=16'h0202;

    let node0   <- mkFoldedTorusNode(node0_address, node4_address,False, maxXAddress, maxYAddress);
    let node1   <- mkFoldedTorusNode(node1_address, node4_address,False, maxXAddress, maxYAddress);
    let node2   <- mkFoldedTorusNode(node2_address, node4_address,False, maxXAddress, maxYAddress);

    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    let node3   <- mkFoldedTorusNode(node3_address, node4_address,False, maxXAddress, maxYAddress); // Head node

    let node4   <- mkFoldedTorusNode(node4_address, node4_address, True, maxXAddress, maxYAddress);
    let node5   <- mkFoldedTorusNode(node5_address, node4_address,False, maxXAddress, maxYAddress);

    // Last row in folded torus
    let node6   <- mkFoldedTorusNode(node6_address, node4_address,False, maxXAddress, maxYAddress);

    let node7   <- mkFoldedTorusNode(node7_address, node4_address,False, maxXAddress, maxYAddress);
    let node8   <- mkFoldedTorusNode(node8_address, node4_address,False, maxXAddress, maxYAddress);
    
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

    rule connect_Node2_to_Node0_L2R;
        let data20_L2R <- node2.get_value_to_right();
        node0.put_value_from_left(data20_L2R);
    endrule

    rule connect_Node3_to_Node4_L2R;
        let data34_L2R <- node3.get_value_to_right();
        node4.put_value_from_left(data34_L2R);
    endrule

    rule connect_Node4_to_Node5_L2R;
        let data45_L2R <- node4.get_value_to_right();
        node5.put_value_from_left(data45_L2R);
    endrule

    rule connect_Node5_to_Node3_L2R;
        let data53_L2R <- node5.get_value_to_right();
        node3.put_value_from_left(data53_L2R);
    endrule

    rule connect_Node6_to_Node7_L2R;
        let data67_L2R <- node6.get_value_to_right();
        node7.put_value_from_left(data67_L2R);
    endrule

    rule connect_Node7_to_Node8_L2R;
        let data78_L2R <- node7.get_value_to_right();
        node8.put_value_from_left(data78_L2R);
    endrule

    rule connect_Node8_to_Node6_L2R;
        let data86_L2R <- node8.get_value_to_right();
        node6.put_value_from_left(data86_L2R);
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

    rule connect_Node0_to_Node2_R2L;
        let data02_R2L <- node0.get_value_to_left();
        node2.put_value_from_right(data02_R2L);
    endrule

    rule connect_Node4_to_Node3_R2L;
        let data43_R2L <- node4.get_value_to_left();
        node3.put_value_from_right(data43_R2L);
    endrule

    rule connect_Node5_to_Node4_R2L;
        let data54_R2L <- node5.get_value_to_left();
        node4.put_value_from_right(data54_R2L);
    endrule

    rule connect_Node3_to_Node5_R2L;
        let data35_R2L <- node3.get_value_to_left();
        node5.put_value_from_right(data35_R2L);
    endrule

    rule connect_Node7_to_Node6_R2L;
        let data76_R2L <- node7.get_value_to_left();
        node6.put_value_from_right(data76_R2L);
    endrule

    rule connect_Node8_to_Node7_R2L;
        let data87_R2L <- node8.get_value_to_left();
        node7.put_value_from_right(data87_R2L);
    endrule

    rule connect_Node6_to_Node8_R2L;
        let data68_R2L <- node6.get_value_to_left();
        node8.put_value_from_right(data68_R2L);
    endrule


    // Connecting Top to Bottom nodes
    rule connect_Node0_to_Node3_T2B;
        let data03_T2B <- node0.get_value_to_down();
        node3.put_value_from_up(data03_T2B);
    endrule

    rule connect_Node1_to_Node4_T2B;
        let data14_T2B <- node1.get_value_to_down();
        node4.put_value_from_up(data14_T2B);
    endrule

    rule connect_Node2_to_Node5_T2B;
        let data25_T2B <- node2.get_value_to_down();
        node5.put_value_from_up(data25_T2B);
    endrule

    rule connect_Node3_to_Node6_T2B;
        let data36_T2B <- node3.get_value_to_down();
        node6.put_value_from_up(data36_T2B);
    endrule

    rule connect_Node4_to_Node7_T2B;
        let data47_T2B <- node4.get_value_to_down();
        node7.put_value_from_up(data47_T2B);
    endrule

    rule connect_Node5_to_Node8_T2B;
        let data58_T2B <- node5.get_value_to_down();
        node8.put_value_from_up(data58_T2B);
    endrule

    rule connect_Node6_to_Node0_T2B;
        let data60_T2B <- node6.get_value_to_down();
        node0.put_value_from_up(data60_T2B);
    endrule

    rule connect_Node7_to_Node1_T2B;
        let data71_T2B <- node7.get_value_to_down();
        node1.put_value_from_up(data71_T2B);
    endrule

    rule connect_Node8_to_Node2_T2B;
        let data82_T2B <- node8.get_value_to_down();
        node2.put_value_from_up(data82_T2B);
    endrule


    // Connecting Top to Bottom nodes following dateline
    rule connect_Node0_to_Node3_T2B_dateline;
        let data03_T2B_dateline <- node0.get_value_to_down_dateline();
        node3.put_value_from_up_dateline(data03_T2B_dateline);
    endrule

    rule connect_Node1_to_Node4_T2B_dateline;
        let data14_T2B_dateline <- node1.get_value_to_down_dateline();
        node4.put_value_from_up_dateline(data14_T2B_dateline);
    endrule

    rule connect_Node2_to_Node5_T2B_dateline;
        let data25_T2B_dateline <- node2.get_value_to_down_dateline();
        node5.put_value_from_up_dateline(data25_T2B_dateline);
    endrule

    rule connect_Node3_to_Node6_T2B_dateline;
        let data36_T2B_dateline <- node3.get_value_to_down_dateline();
        node6.put_value_from_up_dateline(data36_T2B_dateline);
    endrule

    rule connect_Node4_to_Node7_T2B_dateline;
        let data47_T2B_dateline <- node4.get_value_to_down_dateline();
        node7.put_value_from_up_dateline(data47_T2B_dateline);
    endrule

    rule connect_Node5_to_Node8_T2B_dateline;
        let data58_T2B_dateline <- node5.get_value_to_down_dateline();
        node8.put_value_from_up_dateline(data58_T2B_dateline);
    endrule

    rule connect_Node6_to_Node0_T2B_dateline;
        let data60_T2B_dateline <- node6.get_value_to_down_dateline();
        node0.put_value_from_up_dateline(data60_T2B_dateline);
    endrule

    rule connect_Node7_to_Node1_T2B_dateline;
        let data71_T2B_dateline <- node7.get_value_to_down_dateline();
        node1.put_value_from_up_dateline(data71_T2B_dateline);
    endrule

    rule connect_Node8_to_Node2_T2B_dateline;
        let data82_T2B_dateline <- node8.get_value_to_down_dateline();
        node2.put_value_from_up_dateline(data82_T2B_dateline);
    endrule


    // Connecting Bottom to Top nodes
    rule connect_Node3_to_Node0_B2T;
        let data30_B2T <- node3.get_value_to_up();
        node0.put_value_from_down(data30_B2T);
    endrule

    rule connect_Node4_to_Node1_B2T;
        let data41_B2T <- node4.get_value_to_up();
        node1.put_value_from_down(data41_B2T);
    endrule

    rule connect_Node5_to_Node2_B2T;
        let data52_B2T <- node5.get_value_to_up();
        node2.put_value_from_down(data52_B2T);
    endrule

    rule connect_Node6_to_Node3_B2T;
        let data63_B2T <- node6.get_value_to_up();
        node3.put_value_from_down(data63_B2T);
    endrule

    rule connect_Node7_to_Node4_B2T;
        let data74_B2T <- node7.get_value_to_up();
        node4.put_value_from_down(data74_B2T);
    endrule

    rule connect_Node8_to_Node5_B2T;
        let data85_B2T <- node8.get_value_to_up();
        node5.put_value_from_down(data85_B2T);
    endrule

    rule connect_Node0_to_Node6_B2T;
        let data06_B2T <- node0.get_value_to_up();
        node6.put_value_from_down(data06_B2T);
    endrule

    rule connect_Node1_to_Node7_B2T;
        let data17_B2T <- node1.get_value_to_up();
        node7.put_value_from_down(data17_B2T);
    endrule

    rule connect_Node2_to_Node8_B2T;
        let data28_B2T <- node2.get_value_to_up();
        node8.put_value_from_down(data28_B2T);
    endrule


    // Connecting Bottom to Top nodes following dateline
    rule connect_Node3_to_Node0_B2T_dateline;
        let data30_B2T_dateline <- node3.get_value_to_up_dateline();
        node0.put_value_from_down_dateline(data30_B2T_dateline);
    endrule

    rule connect_Node4_to_Node1_B2T_dateline;
        let data41_B2T_dateline <- node4.get_value_to_up_dateline();
        node1.put_value_from_down_dateline(data41_B2T_dateline);
    endrule

    rule connect_Node5_to_Node2_B2T_dateline;
        let data52_B2T_dateline <- node5.get_value_to_up_dateline();
        node2.put_value_from_down_dateline(data52_B2T_dateline);
    endrule

    rule connect_Node6_to_Node3_B2T_dateline;
        let data63_B2T_dateline <- node6.get_value_to_up_dateline();
        node3.put_value_from_down_dateline(data63_B2T_dateline);
    endrule

    rule connect_Node7_to_Node4_B2T_dateline;
        let data74_B2T_dateline <- node7.get_value_to_up_dateline();
        node4.put_value_from_down_dateline(data74_B2T_dateline);
    endrule

    rule connect_Node8_to_Node5_B2T_dateline;
        let data85_B2T_dateline <- node8.get_value_to_up_dateline();
        node5.put_value_from_down_dateline(data85_B2T_dateline);
    endrule

    rule connect_Node0_to_Node6_B2T_dateline;
        let data06_B2T_dateline <- node0.get_value_to_up_dateline();
        node6.put_value_from_down_dateline(data06_B2T_dateline);
    endrule

    rule connect_Node1_to_Node7_B2T_dateline;
        let data17_B2T_dateline <- node1.get_value_to_up_dateline();
        node7.put_value_from_down_dateline(data17_B2T_dateline);
    endrule

    rule connect_Node2_to_Node8_B2T_dateline;
        let data28_B2T_dateline <- node2.get_value_to_up_dateline();
        node8.put_value_from_down_dateline(data28_B2T_dateline);
    endrule


endmodule
endpackage : Noc_FT