package Noc_butterfly16x16;

import ButterflyNodeVC::*;
import ButterflyRouterVC::*;
import ButterflySwitch::*;
import Shared::*;
import Parameters::*;

module mkButterfly16x16Noc(Empty);

    /* 16x16 butterfly network is made */
    Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;
    let node00000 <- mkButterflyNode(node0_address);
    Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=1;
    let node00001 <- mkButterflyNode(node1_address);
    Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=2;
    let node00010 <- mkButterflyNode(node2_address);
    Address node3_address;  node3_address.netAddress=0;  node3_address.nodeAddress=3;
    let node00011 <- mkButterflyNode(node3_address);
    Address node4_address;  node4_address.netAddress=0;  node4_address.nodeAddress=4;
    let node00100 <- mkButterflyNode(node4_address);
    Address node5_address;  node5_address.netAddress=0;  node5_address.nodeAddress=5;
    let node00101 <- mkButterflyNode(node5_address);
    Address node6_address;  node6_address.netAddress=0;  node6_address.nodeAddress=6;
    let node00110 <- mkButterflyNode(node6_address);
    Address node7_address;  node7_address.netAddress=0;  node7_address.nodeAddress=7;
    let node00111 <- mkButterflyNode(node7_address);
    Address node8_address;  node8_address.netAddress=0;  node8_address.nodeAddress=8;
    let node01000 <- mkButterflyNode(node8_address);
    Address node9_address;  node9_address.netAddress=0;  node9_address.nodeAddress=9;
    let node01001 <- mkButterflyNode(node9_address);
    Address node10_address;  node10_address.netAddress=0;  node10_address.nodeAddress=10;
    let node01010 <- mkButterflyNode(node10_address);
    Address node11_address;  node11_address.netAddress=0;  node11_address.nodeAddress=11;
    let node01011 <- mkButterflyNode(node11_address);
    Address node12_address;  node12_address.netAddress=0;  node12_address.nodeAddress=12;
    let node01100 <- mkButterflyNode(node12_address);
    Address node13_address;  node13_address.netAddress=0;  node13_address.nodeAddress=13;
    let node01101 <- mkButterflyNode(node13_address);
    Address node14_address;  node14_address.netAddress=0;  node14_address.nodeAddress=14;
    let node01110 <- mkButterflyNode(node14_address);
    Address node15_address;  node15_address.netAddress=0;  node15_address.nodeAddress=15;
    let node01111 <- mkButterflyNode(node15_address);

    Address node16_address;  node16_address.netAddress=0;  node16_address.nodeAddress=16;
    let node10000 <- mkButterflyNode(node16_address);
    Address node17_address;  node17_address.netAddress=0;  node17_address.nodeAddress=17;
    let node10001 <- mkButterflyNode(node17_address);
    Address node18_address;  node18_address.netAddress=0;  node18_address.nodeAddress=18;
    let node10010 <- mkButterflyNode(node18_address);
    Address node19_address;  node19_address.netAddress=0;  node19_address.nodeAddress=19;
    let node10011 <- mkButterflyNode(node19_address);
    Address node20_address;  node20_address.netAddress=0;  node20_address.nodeAddress=20;
    let node10100 <- mkButterflyNode(node20_address);
    Address node21_address;  node21_address.netAddress=0;  node21_address.nodeAddress=21;
    let node10101 <- mkButterflyNode(node21_address);
    Address node22_address;  node22_address.netAddress=0;  node22_address.nodeAddress=22;
    let node10110 <- mkButterflyNode(node22_address);
    Address node23_address;  node23_address.netAddress=0;  node23_address.nodeAddress=23;
    let node10111 <- mkButterflyNode(node23_address);
    Address node24_address;  node24_address.netAddress=0;  node24_address.nodeAddress=24;
    let node11000 <- mkButterflyNode(node24_address);
    Address node25_address;  node25_address.netAddress=0;  node25_address.nodeAddress=25;
    let node11001 <- mkButterflyNode(node25_address);
    Address node26_address;  node26_address.netAddress=0;  node26_address.nodeAddress=26;
    let node11010 <- mkButterflyNode(node26_address);
    Address node27_address;  node27_address.netAddress=0;  node27_address.nodeAddress=27;
    let node11011 <- mkButterflyNode(node27_address);
    Address node28_address;  node28_address.netAddress=0;  node28_address.nodeAddress=28;
    let node11100 <- mkButterflyNode(node28_address);
    Address node29_address;  node29_address.netAddress=0;  node29_address.nodeAddress=29;
    let node11101 <- mkButterflyNode(node29_address);
    Address node30_address;  node30_address.netAddress=0;  node30_address.nodeAddress=30;
    let node11110 <- mkButterflyNode(node30_address);
    Address node31_address;  node31_address.netAddress=0;  node31_address.nodeAddress=31;
    let node11111 <- mkButterflyNode(node31_address);

    // MAKING SWITCHES
    let switch_L0_0 <- mkButterflySwitch(node0_address, 0, True, False);
    let switch_L0_1 <- mkButterflySwitch(node1_address, 0, True, False);
    let switch_L0_2 <- mkButterflySwitch(node2_address, 0, True, False);
    let switch_L0_3 <- mkButterflySwitch(node3_address, 0, True, False);
    let switch_L0_4 <- mkButterflySwitch(node4_address, 0, True, False);
    let switch_L0_5 <- mkButterflySwitch(node5_address, 0, True, False);
    let switch_L0_6 <- mkButterflySwitch(node6_address, 0, True, False);
    let switch_L0_7 <- mkButterflySwitch(node7_address, 0, True, False);
    let switch_L1_0 <- mkButterflySwitch(node0_address, 1, False, False);
    let switch_L1_1 <- mkButterflySwitch(node1_address, 1, False, False);
    let switch_L1_2 <- mkButterflySwitch(node2_address, 1, False, False);
    let switch_L1_3 <- mkButterflySwitch(node3_address, 1, False, False);
    let switch_L1_4 <- mkButterflySwitch(node4_address, 1, False, False);
    let switch_L1_5 <- mkButterflySwitch(node5_address, 1, False, False);
    let switch_L1_6 <- mkButterflySwitch(node6_address, 1, False, False);
    let switch_L1_7 <- mkButterflySwitch(node7_address, 1, False, False);
    let switch_L2_0 <- mkButterflySwitch(node0_address, 2, False, False);
    let switch_L2_1 <- mkButterflySwitch(node1_address, 2, False, False);
    let switch_L2_2 <- mkButterflySwitch(node2_address, 2, False, False);
    let switch_L2_3 <- mkButterflySwitch(node3_address, 2, False, False);
    let switch_L2_4 <- mkButterflySwitch(node4_address, 2, False, False);
    let switch_L2_5 <- mkButterflySwitch(node5_address, 2, False, False);
    let switch_L2_6 <- mkButterflySwitch(node6_address, 2, False, False);
    let switch_L2_7 <- mkButterflySwitch(node7_address, 2, False, False);
    let switch_L3_0 <- mkButterflySwitch(node0_address, 3, False, True);
    let switch_L3_1 <- mkButterflySwitch(node1_address, 3, False, True);
    let switch_L3_2 <- mkButterflySwitch(node2_address, 3, False, True);
    let switch_L3_3 <- mkButterflySwitch(node3_address, 3, False, True);
    let switch_L3_4 <- mkButterflySwitch(node4_address, 3, False, True);
    let switch_L3_5 <- mkButterflySwitch(node5_address, 3, False, True);
    let switch_L3_6 <- mkButterflySwitch(node6_address, 3, False, True);
    let switch_L3_7 <- mkButterflySwitch(node7_address, 3, False, True);

    // CONNECTING NODES TO ITS SWITCHES
    // LEFT NODES
    rule node0_to_switch_L0_0;
        let data <- node00000.get_value();
        switch_L0_0.put_value_from_left_up(data);
    endrule

    rule node1_to_switch_L0_0;
        let data <- node00001.get_value();
        switch_L0_0.put_value_from_left_down(data);
    endrule

    rule node2_to_switch_L0_1;
        let data <- node00010.get_value();
        switch_L0_1.put_value_from_left_up(data);
    endrule

    rule node3_to_switch_L0_1;
        let data <- node00011.get_value();
        switch_L0_1.put_value_from_left_down(data);
    endrule

    rule node4_to_switch_L0_2;
        let data <- node00100.get_value();
        switch_L0_2.put_value_from_left_up(data);
    endrule

    rule node5_to_switch_L0_2;
        let data <- node00101.get_value();
        switch_L0_2.put_value_from_left_down(data);
    endrule

    rule node6_to_switch_L0_3;
        let data <- node00110.get_value();
        switch_L0_3.put_value_from_left_up(data);
    endrule

    rule node7_to_switch_L0_3;
        let data <- node00111.get_value();
        switch_L0_3.put_value_from_left_down(data);
    endrule

    rule node8_to_switch_L0_4;
        let data <- node01000.get_value();
        switch_L0_4.put_value_from_left_up(data);
    endrule

    rule node9_to_switch_L0_4;
        let data <- node01001.get_value();
        switch_L0_4.put_value_from_left_down(data);
    endrule

    rule node10_to_switch_L0_5;
        let data <- node01010.get_value();
        switch_L0_5.put_value_from_left_up(data);
    endrule

    rule node11_to_switch_L0_5;
        let data <- node01011.get_value();
        switch_L0_5.put_value_from_left_down(data);
    endrule

    rule node12_to_switch_L0_6;
        let data <- node01100.get_value();
        switch_L0_6.put_value_from_left_up(data);
    endrule

    rule node13_to_switch_L0_6;
        let data <- node01101.get_value();
        switch_L0_6.put_value_from_left_down(data);
    endrule

    rule node14_to_switch_L0_7;
        let data <- node01110.get_value();
        switch_L0_7.put_value_from_left_up(data);
    endrule

    rule node15_to_switch_L0_7;
        let data <- node01111.get_value();
        switch_L0_7.put_value_from_left_down(data);
    endrule
    //SWITCHES TO NODES
    rule to_switch_L0_0_node0;
        let data <- switch_L0_0.get_value_to_left_up();
        node00000.put_value(data);;
    endrule

   rule to_switch_L0_0_node1;
        let data <- switch_L0_0.get_value_to_left_down();
        node00001.put_value(data);
    endrule

   rule to_switch_L0_1_node2;
        let data <- switch_L0_1.get_value_to_left_up();
        node00010.put_value(data);
    endrule

   rule to_switch_L0_1_node3;
        let data <- switch_L0_1.get_value_to_left_down();
        node00011.put_value(data);
    endrule

   rule to_switch_L0_2_node4;
        let data <- switch_L0_2.get_value_to_left_up();
        node00100.put_value(data);
    endrule

   rule to_switch_L0_2_node5;
        let data <- switch_L0_2.get_value_to_left_down();
        node00101.put_value(data);
    endrule

   rule to_switch_L0_3_node6;
        let data <- switch_L0_3.get_value_to_left_up();
        node00110.put_value(data);
    endrule

   rule to_switch_L0_3_node7;
        let data <- switch_L0_3.get_value_to_left_down();
        node00111.put_value(data);
    endrule

   rule to_switch_L0_4_node8;
        let data <- switch_L0_4.get_value_to_left_up();
        node01000.put_value(data);
    endrule

   rule to_switch_L0_4_node9;
        let data <- switch_L0_4.get_value_to_left_down();
        node01001.put_value(data);
    endrule

   rule to_switch_L0_5_node10;
        let data <- switch_L0_5.get_value_to_left_up();
        node01010.put_value(data);
    endrule

   rule to_switch_L0_5_node11;
        let data <- switch_L0_5.get_value_to_left_down();
        node01011.put_value(data);
    endrule

   rule to_switch_L0_6_node12;
        let data <- switch_L0_6.get_value_to_left_up();
        node01100.put_value(data);
    endrule

   rule to_switch_L0_6_node13;
        let data <- switch_L0_6.get_value_to_left_down();
        node01101.put_value(data);
    endrule

   rule to_switch_L0_7_node14;
        let data <- switch_L0_7.get_value_to_left_up();
        node01110.put_value(data);
    endrule

   rule to_switch_L0_7_node15;
        let data <- switch_L0_7.get_value_to_left_down();
        node01111.put_value(data);
    endrule



    //RIGHT NODES
    rule node16_to_switch_L3_0;
        let data <- node10000.get_value();
        switch_L3_0.put_value_from_right_up(data);
    endrule

    rule node17_to_switch_L3_0;
        let data <- node10001.get_value();
        switch_L3_0.put_value_from_right_down(data);
    endrule

    rule node18_to_switch_L3_1;
        let data <- node10010.get_value();
        switch_L3_1.put_value_from_right_up(data);
    endrule

    rule node19_to_switch_L3_1;
        let data <- node10011.get_value();
        switch_L3_1.put_value_from_right_down(data);
    endrule

    rule node20_to_switch_L3_2;
        let data <- node10100.get_value();
        switch_L3_2.put_value_from_right_up(data);
    endrule

    rule node21_to_switch_L3_2;
        let data <- node10101.get_value();
        switch_L3_2.put_value_from_right_down(data);
    endrule

    rule node22_to_switch_L3_3;
        let data <- node10110.get_value();
        switch_L3_3.put_value_from_right_up(data);
    endrule

    rule node23_to_switch_L3_3;
        let data <- node10111.get_value();
        switch_L3_3.put_value_from_right_down(data);
    endrule

    rule node24_to_switch_L3_4;
        let data <- node11000.get_value();
        switch_L3_4.put_value_from_right_up(data);
    endrule

    rule node25_to_switch_L3_4;
        let data <- node11001.get_value();
        switch_L3_4.put_value_from_right_down(data);
    endrule

    rule node26_to_switch_L3_5;
        let data <- node11010.get_value();
        switch_L3_5.put_value_from_right_up(data);
    endrule

    rule node27_to_switch_L3_5;
        let data <- node11011.get_value();
        switch_L3_5.put_value_from_right_down(data);
    endrule

    rule node28_to_switch_L3_6;
        let data <- node11100.get_value();
        switch_L3_6.put_value_from_right_up(data);
    endrule

    rule node29_to_switch_L3_6;
        let data <- node11101.get_value();
        switch_L3_6.put_value_from_right_down(data);
    endrule

    rule node30_to_switch_L3_7;
        let data <- node11110.get_value();
        switch_L3_7.put_value_from_right_up(data);
    endrule

    rule node31_to_switch_L3_7;
        let data <- node11111.get_value();
        switch_L3_7.put_value_from_right_down(data);
    endrule
    // SWITCHES TO NODES
    rule to_switch_L3_0_node16;
        let data <- switch_L3_0.get_value_to_right_up();
        node10000.put_value(data);
    endrule

    rule to_switch_L3_0_node17;
        let data <- switch_L3_0.get_value_to_right_down();
        node10001.put_value(data);
    endrule

    rule to_switch_L3_1_node18;
        let data <- switch_L3_1.get_value_to_right_up();
        node10010.put_value(data);
    endrule

    rule to_switch_L3_1_node19;
        let data <- switch_L3_1.get_value_to_right_down();
        node10011.put_value(data);
    endrule

    rule to_switch_L3_2_node20;
        let data <- switch_L3_2.get_value_to_right_up();
        node10100.put_value(data);
    endrule

    rule to_switch_L3_2_node21;
        let data <- switch_L3_2.get_value_to_right_down();
        node10101.put_value(data);
    endrule

    rule to_switch_L3_3_node22;
        let data <- switch_L3_3.get_value_to_right_up();
        node10110.put_value(data);
    endrule

    rule to_switch_L3_3_node23;
        let data <- switch_L3_3.get_value_to_right_down();
        node10111.put_value(data);
    endrule

    rule to_switch_L3_4_node24;
        let data <- switch_L3_4.get_value_to_right_up();
        node11000.put_value(data);
    endrule

    rule to_switch_L3_4_node25;
        let data <- switch_L3_4.get_value_to_right_down();
        node11001.put_value(data);
    endrule

    rule to_switch_L3_5_node26;
        let data <- switch_L3_5.get_value_to_right_up();
        node11010.put_value(data);
    endrule

    rule to_switch_L3_5_node27;
        let data <- switch_L3_5.get_value_to_right_down();
        node11011.put_value(data);
    endrule

    rule to_switch_L3_6_node28;
        let data <- switch_L3_6.get_value_to_right_up();
        node11100.put_value(data);
    endrule

    rule to_switch_L3_6_node29;
        let data <- switch_L3_6.get_value_to_right_down();
        node11101.put_value(data);
    endrule

    rule to_switch_L3_7_node30;
        let data <- switch_L3_7.get_value_to_right_up();
        node11110.put_value(data);
    endrule

    rule to_switch_L3_7_node31;
        let data <- switch_L3_7.get_value_to_right_down();
        node11111.put_value(data);
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


    rule connect_l2r_switchL0_4_switchL1_4;
        let data <- switch_L0_4.get_value_to_right_up();
        switch_L1_4.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_4_switchL0_4;
        let data <- switch_L1_4.get_value_to_left_up();
        switch_L0_4.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL0_5_switchL1_5;
        let data <- switch_L0_5.get_value_to_right_up();
        switch_L1_5.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_5_switchL0_5;
        let data <- switch_L1_5.get_value_to_left_up();
        switch_L0_5.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL0_6_switchL1_6;
        let data <- switch_L0_6.get_value_to_right_up();
        switch_L1_6.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_6_switchL0_6;
        let data <- switch_L1_6.get_value_to_left_up();
        switch_L0_6.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL0_7_switchL1_7;
        let data <- switch_L0_7.get_value_to_right_up();
        switch_L1_7.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL1_7_switchL0_7;
        let data <- switch_L1_7.get_value_to_left_up();
        switch_L0_7.put_value_from_right_up(data);
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


    rule connect_l2r_switchL1_4_switchL2_4;
        let data <- switch_L1_4.get_value_to_right_up();
        switch_L2_4.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_4_switchL1_4;
        let data <- switch_L2_4.get_value_to_left_up();
        switch_L1_4.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL1_5_switchL2_5;
        let data <- switch_L1_5.get_value_to_right_up();
        switch_L2_5.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_5_switchL1_5;
        let data <- switch_L2_5.get_value_to_left_up();
        switch_L1_5.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL1_6_switchL2_6;
        let data <- switch_L1_6.get_value_to_right_up();
        switch_L2_6.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_6_switchL1_6;
        let data <- switch_L2_6.get_value_to_left_up();
        switch_L1_6.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL1_7_switchL2_7;
        let data <- switch_L1_7.get_value_to_right_up();
        switch_L2_7.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL2_7_switchL1_7;
        let data <- switch_L2_7.get_value_to_left_up();
        switch_L1_7.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_0_switchL3_0;
        let data <- switch_L2_0.get_value_to_right_up();
        switch_L3_0.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_0_switchL2_0;
        let data <- switch_L3_0.get_value_to_left_up();
        switch_L2_0.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_1_switchL3_1;
        let data <- switch_L2_1.get_value_to_right_up();
        switch_L3_1.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_1_switchL2_1;
        let data <- switch_L3_1.get_value_to_left_up();
        switch_L2_1.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_2_switchL3_2;
        let data <- switch_L2_2.get_value_to_right_up();
        switch_L3_2.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_2_switchL2_2;
        let data <- switch_L3_2.get_value_to_left_up();
        switch_L2_2.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_3_switchL3_3;
        let data <- switch_L2_3.get_value_to_right_up();
        switch_L3_3.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_3_switchL2_3;
        let data <- switch_L3_3.get_value_to_left_up();
        switch_L2_3.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_4_switchL3_4;
        let data <- switch_L2_4.get_value_to_right_up();
        switch_L3_4.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_4_switchL2_4;
        let data <- switch_L3_4.get_value_to_left_up();
        switch_L2_4.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_5_switchL3_5;
        let data <- switch_L2_5.get_value_to_right_up();
        switch_L3_5.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_5_switchL2_5;
        let data <- switch_L3_5.get_value_to_left_up();
        switch_L2_5.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_6_switchL3_6;
        let data <- switch_L2_6.get_value_to_right_up();
        switch_L3_6.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_6_switchL2_6;
        let data <- switch_L3_6.get_value_to_left_up();
        switch_L2_6.put_value_from_right_up(data);
    endrule


    rule connect_l2r_switchL2_7_switchL3_7;
        let data <- switch_L2_7.get_value_to_right_up();
        switch_L3_7.put_value_from_left_up(data);
    endrule
    rule connect_r2l_switchL3_7_switchL2_7;
        let data <- switch_L3_7.get_value_to_left_up();
        switch_L2_7.put_value_from_right_up(data);
    endrule

//CONNECTING SWITCHES (CROSS CONNECTIONS)
// LAYER 0 1 
    rule connect_l2r_switchL0_0_switchL1_4;
        let data <- switch_L0_0.get_value_to_right_down();
        switch_L1_4.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_4_switchL0_0;
        let data <- switch_L1_4.get_value_to_left_down();
        switch_L0_0.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_1_switchL1_5;
        let data <- switch_L0_1.get_value_to_right_down();
        switch_L1_5.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_5_switchL0_1;
        let data <- switch_L1_5.get_value_to_left_down();
        switch_L0_1.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_2_switchL1_6;
        let data <- switch_L0_2.get_value_to_right_down();
        switch_L1_6.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_6_switchL0_2;
        let data <- switch_L1_6.get_value_to_left_down();
        switch_L0_2.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_3_switchL1_7;
        let data <- switch_L0_3.get_value_to_right_down();
        switch_L1_7.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_7_switchL0_3;
        let data <- switch_L1_7.get_value_to_left_down();
        switch_L0_3.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_4_switchL1_0;
        let data <- switch_L0_4.get_value_to_right_down();
        switch_L1_0.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_0_switchL0_4;
        let data <- switch_L1_0.get_value_to_left_down();
        switch_L0_4.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_5_switchL1_1;
        let data <- switch_L0_5.get_value_to_right_down();
        switch_L1_1.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_1_switchL0_5;
        let data <- switch_L1_1.get_value_to_left_down();
        switch_L0_5.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_6_switchL1_2;
        let data <- switch_L0_6.get_value_to_right_down();
        switch_L1_2.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_2_switchL0_6;
        let data <- switch_L1_2.get_value_to_left_down();
        switch_L0_6.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_7_switchL1_3;
        let data <- switch_L0_7.get_value_to_right_down();
        switch_L1_3.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_3_switchL0_7;
        let data <- switch_L1_3.get_value_to_left_down();
        switch_L0_7.put_value_from_right_down(data);
    endrule


// LAYER 1 2
    rule connect_l2r_switchL1_0_switchL2_2;
        let data <- switch_L1_0.get_value_to_right_down();
        switch_L2_2.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_2_switchL1_0;
        let data <- switch_L2_2.get_value_to_left_down();
        switch_L1_0.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_1_switchL2_3;
        let data <- switch_L1_1.get_value_to_right_down();
        switch_L2_3.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_3_switchL1_1;
        let data <- switch_L2_3.get_value_to_left_down();
        switch_L1_1.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_2_switchL2_0;
        let data <- switch_L1_2.get_value_to_right_down();
        switch_L2_0.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_0_switchL1_2;
        let data <- switch_L2_0.get_value_to_left_down();
        switch_L1_2.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_3_switchL2_1;
        let data <- switch_L1_3.get_value_to_right_down();
        switch_L2_1.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_1_switchL1_3;
        let data <- switch_L2_1.get_value_to_left_down();
        switch_L1_3.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_4_switchL2_6;
        let data <- switch_L1_4.get_value_to_right_down();
        switch_L2_6.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_6_switchL1_4;
        let data <- switch_L2_6.get_value_to_left_down();
        switch_L1_4.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_5_switchL2_7;
        let data <- switch_L1_5.get_value_to_right_down();
        switch_L2_7.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_7_switchL1_5;
        let data <- switch_L2_7.get_value_to_left_down();
        switch_L1_5.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_6_switchL2_4;
        let data <- switch_L1_6.get_value_to_right_down();
        switch_L2_4.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_4_switchL1_6;
        let data <- switch_L2_4.get_value_to_left_down();
        switch_L1_6.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL1_7_switchL2_5;
        let data <- switch_L1_7.get_value_to_right_down();
        switch_L2_5.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL2_5_switchL1_7;
        let data <- switch_L2_5.get_value_to_left_down();
        switch_L1_7.put_value_from_right_down(data);
    endrule

 
// LAYER 2 3
    rule connect_l2r_switchL2_0_switchL3_1;
        let data <- switch_L2_0.get_value_to_right_down();
        switch_L3_1.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_1_switchL2_0;
        let data <- switch_L3_1.get_value_to_left_down();
        switch_L2_0.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL2_1_switchL3_0;
        let data <- switch_L2_1.get_value_to_right_down();
        switch_L3_0.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_0_switchL2_1;
        let data <- switch_L3_0.get_value_to_left_down();
        switch_L2_1.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL2_2_switchL3_3;
        let data <- switch_L2_2.get_value_to_right_down();
        switch_L3_3.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_3_switchL2_2;
        let data <- switch_L3_3.get_value_to_left_down();
        switch_L2_2.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL2_3_switchL3_2;
        let data <- switch_L2_3.get_value_to_right_down();
        switch_L3_2.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_2_switchL2_3;
        let data <- switch_L3_2.get_value_to_left_down();
        switch_L2_3.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL2_4_switchL3_5;
        let data <- switch_L2_4.get_value_to_right_down();
        switch_L3_5.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_5_switchL2_4;
        let data <- switch_L3_5.get_value_to_left_down();
        switch_L2_4.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL2_5_switchL3_4;
        let data <- switch_L2_5.get_value_to_right_down();
        switch_L3_4.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_4_switchL2_5;
        let data <- switch_L3_4.get_value_to_left_down();
        switch_L2_5.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL2_6_switchL3_7;
        let data <- switch_L2_6.get_value_to_right_down();
        switch_L3_7.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_7_switchL2_6;
        let data <- switch_L3_7.get_value_to_left_down();
        switch_L2_6.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL2_7_switchL3_6;
        let data <- switch_L2_7.get_value_to_right_down();
        switch_L3_6.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL3_6_switchL2_7;
        let data <- switch_L3_6.get_value_to_left_down();
        switch_L2_7.put_value_from_right_down(data);
    endrule





endmodule

endpackage : Noc_butterfly16x16
