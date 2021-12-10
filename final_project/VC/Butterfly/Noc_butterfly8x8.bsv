package Noc_butterfly8x8;

import ButterflyNodeVC::*;
import ButterflyRouterVC::*;
import ButterflySwitch::*;
import Shared::*;
import Parameters::*;

module mkButterfly8x8Noc(Empty);

    /* 8x8 butterfly network is made */
    Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;
    let node0000 <- mkButterflyNode(node0_address);
    Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=1;
    let node0001 <- mkButterflyNode(node1_address);
    Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=2;
    let node0010 <- mkButterflyNode(node2_address);
    Address node3_address;  node3_address.netAddress=0;  node3_address.nodeAddress=3;
    let node0011 <- mkButterflyNode(node3_address);
    Address node4_address;  node4_address.netAddress=0;  node4_address.nodeAddress=4;
    let node0100 <- mkButterflyNode(node4_address);
    Address node5_address;  node5_address.netAddress=0;  node5_address.nodeAddress=5;
    let node0101 <- mkButterflyNode(node5_address);
    Address node6_address;  node6_address.netAddress=0;  node6_address.nodeAddress=6;
    let node0110 <- mkButterflyNode(node6_address);
    Address node7_address;  node7_address.netAddress=0;  node7_address.nodeAddress=7;
    let node0111 <- mkButterflyNode(node7_address);
    Address node8_address;  node8_address.netAddress=0;  node8_address.nodeAddress=8;
    let node1000 <- mkButterflyNode(node8_address);
    Address node9_address;  node9_address.netAddress=0;  node9_address.nodeAddress=9;
    let node1001 <- mkButterflyNode(node9_address);
    Address node10_address;  node10_address.netAddress=0;  node10_address.nodeAddress=10;
    let node1010 <- mkButterflyNode(node10_address);
    Address node11_address;  node11_address.netAddress=0;  node11_address.nodeAddress=11;
    let node1011 <- mkButterflyNode(node11_address);
    Address node12_address;  node12_address.netAddress=0;  node12_address.nodeAddress=12;
    let node1100 <- mkButterflyNode(node12_address);
    Address node13_address;  node13_address.netAddress=0;  node13_address.nodeAddress=13;
    let node1101 <- mkButterflyNode(node13_address);
    Address node14_address;  node14_address.netAddress=0;  node14_address.nodeAddress=14;
    let node1110 <- mkButterflyNode(node14_address);
    Address node15_address;  node15_address.netAddress=0;  node15_address.nodeAddress=15;
    let node1111 <- mkButterflyNode(node15_address);

    // MAKING SWITCHES
    let switch_L0_0 <- mkButterflySwitch(0, 0, True, False);
    let switch_L0_1 <- mkButterflySwitch(1, 0, True, False);
    let switch_L0_2 <- mkButterflySwitch(2, 0, True, False);
    let switch_L0_3 <- mkButterflySwitch(3, 0, True, False);
    let switch_L1_0 <- mkButterflySwitch(0, 1, False, False);
    let switch_L1_1 <- mkButterflySwitch(1, 1, False, False);
    let switch_L1_2 <- mkButterflySwitch(2, 1, False, False);
    let switch_L1_3 <- mkButterflySwitch(3, 1, False, False);
    let switch_L2_0 <- mkButterflySwitch(0, 2, False, True);
    let switch_L2_1 <- mkButterflySwitch(1, 2, False, True);
    let switch_L2_2 <- mkButterflySwitch(2, 2, False, True);
    let switch_L2_3 <- mkButterflySwitch(3, 2, False, True);

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



endmodule

endpackage : Noc_butterfly8x8
