package Noc_butterfly4x4;

import ButterflyNodeVC::*;
import ButterflyRouterVC::*;
import ButterflySwitch::*;
import Shared::*;
import Parameters::*;

module mkButterfly4x4Noc(Empty);

    /* 4x4 butterfly network is made */
    Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;
    let node000 <- mkButterflyNode(node0_address);
    Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=1;
    let node001 <- mkButterflyNode(node1_address);
    Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=2;
    let node010 <- mkButterflyNode(node2_address);
    Address node3_address;  node3_address.netAddress=0;  node3_address.nodeAddress=3;
    let node011 <- mkButterflyNode(node3_address);

    Address node4_address;  node4_address.netAddress=0;  node4_address.nodeAddress=4;
    let node100 <- mkButterflyNode(node4_address);
    Address node5_address;  node5_address.netAddress=0;  node5_address.nodeAddress=5;
    let node101 <- mkButterflyNode(node5_address);
    Address node6_address;  node6_address.netAddress=0;  node6_address.nodeAddress=6;
    let node110 <- mkButterflyNode(node6_address);
    Address node7_address;  node7_address.netAddress=0;  node7_address.nodeAddress=7;
    let node111 <- mkButterflyNode(node7_address);
   

    // MAKING SWITCHES
    // mkButterflySwitch #(int my_addr, int layer, Bool left_ext, Bool right_ext)
    let switch_L0_0 <- mkButterflySwitch(0, 0, True, False);
    let switch_L0_1 <- mkButterflySwitch(1, 0, True, False);
    let switch_L1_0 <- mkButterflySwitch(0, 1, False, True);
    let switch_L1_1 <- mkButterflySwitch(1, 1, False, True);

    // CONNECTING NODES TO ITS SWITCHES
    // LEFT NODES
    rule node0_to_switch_L0_0;
        let data <- node000.get_value();
        switch_L0_0.put_value_from_left_up(data);
    endrule

    rule node1_to_switch_L0_0;
        let data <- node001.get_value();
        switch_L0_0.put_value_from_left_down(data);
    endrule

    rule node2_to_switch_L0_1;
        let data <- node010.get_value();
        switch_L0_1.put_value_from_left_up(data);
    endrule

    rule node3_to_switch_L0_1;
        let data <- node011.get_value();
        switch_L0_1.put_value_from_left_down(data);
    endrule

    //SWITCHES TO NODES
    rule to_switch_L0_0_node0;
        let data <- switch_L0_0.get_value_to_left_up();
        node000.put_value(data);
    endrule

   rule to_switch_L0_0_node1;
        let data <- switch_L0_0.get_value_to_left_down();
        node001.put_value(data);
    endrule

   rule to_switch_L0_1_node2;
        let data <- switch_L0_1.get_value_to_left_up();
        node010.put_value(data);
    endrule

   rule to_switch_L0_1_node3;
        let data <- switch_L0_1.get_value_to_left_down();
        node011.put_value(data);
    endrule



    //RIGHT NODES
    rule node4_to_switch_L1_0;
        let data <- node100.get_value();
        switch_L1_0.put_value_from_right_up(data);
    endrule

    rule node5_to_switch_L1_0;
        let data <- node101.get_value();
        switch_L1_0.put_value_from_right_down(data);
    endrule

    rule node6_to_switch_L1_1;
        let data <- node110.get_value();
        switch_L1_1.put_value_from_right_up(data);
    endrule

    rule node7_to_switch_L1_1;
        let data <- node111.get_value();
        switch_L1_1.put_value_from_right_down(data);
    endrule

    // SWITCHES TO NODES
    rule to_switch_L1_0_node4;
        let data <- switch_L1_0.get_value_to_right_up();
        node100.put_value(data);
    endrule

    rule to_switch_L1_0_node5;
        let data <- switch_L1_0.get_value_to_right_down();
        node101.put_value(data);
    endrule

    rule to_switch_L1_1_node6;
        let data <- switch_L1_1.get_value_to_right_up();
        node110.put_value(data);
    endrule

    rule to_switch_L1_1_node7;
        let data <- switch_L1_1.get_value_to_right_down();
        node111.put_value(data);
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


    //CONNECTING SWITCHES (CROSS CONNECTIONS)
    // LAYER 0 1
    rule connect_l2r_switchL0_0_switchL1_1;
        let data <- switch_L0_0.get_value_to_right_down();
        switch_L1_1.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_1_switchL0_0;
        let data <- switch_L1_1.get_value_to_left_down();
        switch_L0_0.put_value_from_right_down(data);
    endrule


    rule connect_l2r_switchL0_1_switchL1_0;
        let data <- switch_L0_1.get_value_to_right_down();
        switch_L1_3.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_0_switchL0_1;
        let data <- switch_L1_0.get_value_to_left_down();
        switch_L0_1.put_value_from_right_down(data);
    endrule



endmodule

endpackage : Noc_butterfly4x4
