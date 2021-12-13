package Noc_butterfly8x8L2;

import ButterflyL2NodeVC::*;
import ButterflyL2RouterVC::*;

import ButterflyL2HeadNodeVC::*;
import ButterflyL2HeadRouterVC::*;

import ButterflySwitchL2::*;
import Shared::*;
import Parameters::*;


interface IfcButterflyL2Noc;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router

    method Action put_value_from_l1(Flit data_from_L1);
    method ActionValue#(Flit) get_value_to_l1();

endinterface



module mkButterfly8x8L2Noc #(parameter NetAddress net_id) (IfcButterflyL2Noc);

    Address head_node_addr;  head_node_addr.netAddress=net_id;  head_node_addr.nodeAddress=3;
    
    /* 8x8 butterfly network is made */
    Address node0_address;  node0_address.netAddress=net_id;  node0_address.nodeAddress=0;
    let node0000 <- mkButterflyL2Node(node0_address, head_node_addr);
    Address node1_address;  node1_address.netAddress=net_id;  node1_address.nodeAddress=1;
    let node0001 <- mkButterflyL2Node(node1_address, head_node_addr);
    Address node2_address;  node2_address.netAddress=net_id;  node2_address.nodeAddress=2;
    let node0010 <- mkButterflyL2Node(node2_address, head_node_addr);
    Address node3_address;  node3_address.netAddress=net_id;  node3_address.nodeAddress=3;
    let node0011 <- mkButterflyL2HeadNode(node3_address, head_node_addr); //HEAD NODE
    Address node4_address;  node4_address.netAddress=net_id;  node4_address.nodeAddress=4;
    let node0100 <- mkButterflyL2Node(node4_address, head_node_addr);
    Address node5_address;  node5_address.netAddress=net_id;  node5_address.nodeAddress=5;
    let node0101 <- mkButterflyL2Node(node5_address, head_node_addr);
    Address node6_address;  node6_address.netAddress=net_id;  node6_address.nodeAddress=6;
    let node0110 <- mkButterflyL2Node(node6_address, head_node_addr);
    Address node7_address;  node7_address.netAddress=net_id;  node7_address.nodeAddress=7;
    let node0111 <- mkButterflyL2Node(node7_address, head_node_addr);

    Address node8_address;  node8_address.netAddress=net_id;  node8_address.nodeAddress=8;
    let node1000 <- mkButterflyL2Node(node8_address, head_node_addr);
    Address node9_address;  node9_address.netAddress=net_id;  node9_address.nodeAddress=9;
    let node1001 <- mkButterflyL2Node(node9_address, head_node_addr);
    Address node10_address;  node10_address.netAddress=net_id;  node10_address.nodeAddress=10;
    let node1010 <- mkButterflyL2Node(node10_address, head_node_addr);
    Address node11_address;  node11_address.netAddress=net_id;  node11_address.nodeAddress=11;
    let node1011 <- mkButterflyL2Node(node11_address, head_node_addr);
    Address node12_address;  node12_address.netAddress=net_id;  node12_address.nodeAddress=12;
    let node1100 <- mkButterflyL2Node(node12_address, head_node_addr);
    Address node13_address;  node13_address.netAddress=net_id;  node13_address.nodeAddress=13;
    let node1101 <- mkButterflyL2Node(node13_address, head_node_addr);
    Address node14_address;  node14_address.netAddress=net_id;  node14_address.nodeAddress=14;
    let node1110 <- mkButterflyL2Node(node14_address, head_node_addr);
    Address node15_address;  node15_address.netAddress=net_id;  node15_address.nodeAddress=15;
    let node1111 <- mkButterflyL2Node(node15_address, head_node_addr);

    // MAKING SWITCHES
    let switch_L0_0 <- mkButterflySwitchL2(0, 0, True, False, 3);
    let switch_L0_1 <- mkButterflySwitchL2(1, 0, True, False, 3);
    let switch_L0_2 <- mkButterflySwitchL2(2, 0, True, False, 3);
    let switch_L0_3 <- mkButterflySwitchL2(3, 0, True, False, 3);
    let switch_L1_0 <- mkButterflySwitchL2(0, 1, False, False, 3);
    let switch_L1_1 <- mkButterflySwitchL2(1, 1, False, False, 3);
    let switch_L1_2 <- mkButterflySwitchL2(2, 1, False, False, 3);
    let switch_L1_3 <- mkButterflySwitchL2(3, 1, False, False, 3);
    let switch_L2_0 <- mkButterflySwitchL2(0, 2, False, True, 3);
    let switch_L2_1 <- mkButterflySwitchL2(1, 2, False, True, 3);
    let switch_L2_2 <- mkButterflySwitchL2(2, 2, False, True, 3);
    let switch_L2_3 <- mkButterflySwitchL2(3, 2, False, True, 3);

    // CONNECTING NODES TO ITS SWITCHES
    // LEFT NODES
    rule node0_to_switch_L0_0;
        let data <- node0000.get_value();
        switch_L0_0.put_value_from_left_up(data);
    endrule

    rule node1_to_switch_L0_0;
        let data <- node0001.get_value();
        switch_L0_0.put_value_from_left_down(data);
    endrule

    rule node2_to_switch_L0_1;
        let data <- node0010.get_value();
        switch_L0_1.put_value_from_left_up(data);
    endrule

    rule node3_to_switch_L0_1;
        let data <- node0011.get_value();
        switch_L0_1.put_value_from_left_down(data);
    endrule

    rule node4_to_switch_L0_2;
        let data <- node0100.get_value();
        switch_L0_2.put_value_from_left_up(data);
    endrule

    rule node5_to_switch_L0_2;
        let data <- node0101.get_value();
        switch_L0_2.put_value_from_left_down(data);
    endrule

    rule node6_to_switch_L0_3;
        let data <- node0110.get_value();
        switch_L0_3.put_value_from_left_up(data);
    endrule

    rule node7_to_switch_L0_3;
        let data <- node0111.get_value();
        switch_L0_3.put_value_from_left_down(data);
    endrule
    //SWITCHES TO NODES
    rule to_switch_L0_0_node0;
        let data <- switch_L0_0.get_value_to_left_up();
        node0000.put_value(data);
    endrule

   rule to_switch_L0_0_node1;
        let data <- switch_L0_0.get_value_to_left_down();
        node0001.put_value(data);
    endrule

   rule to_switch_L0_1_node2;
        let data <- switch_L0_1.get_value_to_left_up();
        node0010.put_value(data);
    endrule

   rule to_switch_L0_1_node3;
        let data <- switch_L0_1.get_value_to_left_down();
        node0011.put_value(data);
    endrule

   rule to_switch_L0_2_node4;
        let data <- switch_L0_2.get_value_to_left_up();
        node0100.put_value(data);
    endrule

   rule to_switch_L0_2_node5;
        let data <- switch_L0_2.get_value_to_left_down();
        node0101.put_value(data);
    endrule

   rule to_switch_L0_3_node6;
        let data <- switch_L0_3.get_value_to_left_up();
        node0110.put_value(data);
    endrule

   rule to_switch_L0_3_node7;
        let data <- switch_L0_3.get_value_to_left_down();
        node0111.put_value(data);
    endrule


    //RIGHT NODES
    rule node8_to_switch_L2_0;
        let data <- node1000.get_value();
        switch_L2_0.put_value_from_right_up(data);
    endrule

    rule node9_to_switch_L2_0;
        let data <- node1001.get_value();
        switch_L2_0.put_value_from_right_down(data);
    endrule

    rule node10_to_switch_L2_1;
        let data <- node1010.get_value();
        switch_L2_1.put_value_from_right_up(data);
    endrule

    rule node11_to_switch_L2_1;
        let data <- node1011.get_value();
        switch_L2_1.put_value_from_right_down(data);
    endrule

    rule node12_to_switch_L2_2;
        let data <- node1100.get_value();
        switch_L2_2.put_value_from_right_up(data);
    endrule

    rule node13_to_switch_L2_2;
        let data <- node1101.get_value();
        switch_L2_2.put_value_from_right_down(data);
    endrule

    rule node14_to_switch_L2_3;
        let data <- node1110.get_value();
        switch_L2_3.put_value_from_right_up(data);
    endrule

    rule node15_to_switch_L2_3;
        let data <- node1111.get_value();
        switch_L2_3.put_value_from_right_down(data);
    endrule
    // SWITCHES TO NODES
    rule to_switch_L2_0_node8;
        let data <- switch_L2_0.get_value_to_right_up();
        node1000.put_value(data);
    endrule

    rule to_switch_L2_0_node9;
        let data <- switch_L2_0.get_value_to_right_down();
        node1001.put_value(data);
    endrule

    rule to_switch_L2_1_node10;
        let data <- switch_L2_1.get_value_to_right_up();
        node1010.put_value(data);
    endrule

    rule to_switch_L2_1_node11;
        let data <- switch_L2_1.get_value_to_right_down();
        node1011.put_value(data);
    endrule

    rule to_switch_L2_2_node12;
        let data <- switch_L2_2.get_value_to_right_up();
        node1100.put_value(data);
    endrule

    rule to_switch_L2_2_node13;
        let data <- switch_L2_2.get_value_to_right_down();
        node1101.put_value(data);
    endrule

    rule to_switch_L2_3_node14;
        let data <- switch_L2_3.get_value_to_right_up();
        node1110.put_value(data);
    endrule

    rule to_switch_L2_3_node15;
        let data <- switch_L2_3.get_value_to_right_down();
        node1111.put_value(data);
    endrule







    //CONNECTING SWITCHES (STRAIGHT CONNECTIONS)
    rule connect_l2r_switchL0_0_switchL1_0;
        let data <- switch_L0_0.get_value_to_right_up();
        switch_L1_0.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_0_switchL0_0;
        let data <- switch_L1_0.get_value_to_left_up();
        switch_L0_0.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL0_1_switchL1_1;
        let data <- switch_L0_1.get_value_to_right_up();
        switch_L1_1.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_1_switchL0_1;
        let data <- switch_L1_1.get_value_to_left_up();
        switch_L0_1.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL0_2_switchL1_2;
        let data <- switch_L0_2.get_value_to_right_up();
        switch_L1_2.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_2_switchL0_2;
        let data <- switch_L1_2.get_value_to_left_up();
        switch_L0_2.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL0_3_switchL1_3;
        let data <- switch_L0_3.get_value_to_right_up();
        switch_L1_3.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_3_switchL0_3;
        let data <- switch_L1_3.get_value_to_left_up();
        switch_L0_3.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL1_0_switchL2_0;
        let data <- switch_L1_0.get_value_to_right_up();
        switch_L2_0.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_0_switchL1_0;
        let data <- switch_L2_0.get_value_to_left_up();
        switch_L1_0.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL1_1_switchL2_1;
        let data <- switch_L1_1.get_value_to_right_up();
        switch_L2_1.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_1_switchL1_1;
        let data <- switch_L2_1.get_value_to_left_up();
        switch_L1_1.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL1_2_switchL2_2;
        let data <- switch_L1_2.get_value_to_right_up();
        switch_L2_2.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_2_switchL1_2;
        let data <- switch_L2_2.get_value_to_left_up();
        switch_L1_2.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL1_3_switchL2_3;
        let data <- switch_L1_3.get_value_to_right_up();
        switch_L2_3.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_3_switchL1_3;
        let data <- switch_L2_3.get_value_to_left_up();
        switch_L1_3.put_value_from_right_up(data);
    endrule

    //CONNECTING SWITCHES (CROSS CONNECTIONS)
    // LAYER 0 1
    rule connect_l2r_switchL0_0_switchL1_2;
        let data <- switch_L0_0.get_value_to_right_down();
        switch_L1_2.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_2_switchL0_0;
        let data <- switch_L1_2.get_value_to_left_down();
        switch_L0_0.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_1_switchL1_3;
        let data <- switch_L0_1.get_value_to_right_down();
        switch_L1_3.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_3_switchL0_1;
        let data <- switch_L1_3.get_value_to_left_down();
        switch_L0_1.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_2_switchL1_0;
        let data <- switch_L0_2.get_value_to_right_down();
        switch_L1_0.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_0_switchL0_2;
        let data <- switch_L1_0.get_value_to_left_down();
        switch_L0_2.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_3_switchL1_1;
        let data <- switch_L0_3.get_value_to_right_down();
        switch_L1_1.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_1_switchL0_3;
        let data <- switch_L1_1.get_value_to_left_down();
        switch_L0_3.put_value_from_right_down(data);
    endrule


    // LAYER 1 2
    rule connect_l2r_switchL1_0_switchL2_1;
        let data <- switch_L1_0.get_value_to_right_down();
        switch_L2_1.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_1_switchL1_0;
        let data <- switch_L2_1.get_value_to_left_down();
        switch_L1_0.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_1_switchL2_0;
        let data <- switch_L1_1.get_value_to_right_down();
        switch_L2_0.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_0_switchL1_1;
        let data <- switch_L2_0.get_value_to_left_down();
        switch_L1_1.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_2_switchL2_3;
        let data <- switch_L1_2.get_value_to_right_down();
        switch_L2_3.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_3_switchL1_2;
        let data <- switch_L2_3.get_value_to_left_down();
        switch_L1_2.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_3_switchL2_2;
        let data <- switch_L1_3.get_value_to_right_down();
        switch_L2_2.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_2_switchL1_3;
        let data <- switch_L2_2.get_value_to_left_down();
        switch_L1_3.put_value_from_right_down(data);
    endrule

    method Action put_value_from_l1(Flit data_from_L1);
        node0011.put_value_from_l1(data_from_L1);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        let data <- node0011.get_value_to_l1();
        return data;
    endmethod

endmodule

endpackage : Noc_butterfly8x8L2
