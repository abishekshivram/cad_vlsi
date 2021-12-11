package Noc_butterfly4x4L2;

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



module mkButterfly4x4L2Noc #(parameter NetAddressLen net_id) (IfcButterflyL2Noc);

    Address head_node_addr;  head_node_addr.netAddress=net_id;  head_node_addr.nodeAddress=1;

    /* 4x4 butterfly network is made */
    Address node0_address;  node0_address.netAddress=net_id;  node0_address.nodeAddress=0;
    let node000 <- mkButterflyL2Node(node0_address, head_node_addr);
    Address node1_address;  node1_address.netAddress=net_id;  node1_address.nodeAddress=1;
    let node001 <- mkButterflyL2HeadNode(node1_address, head_node_addr); // HEAD NODE
    Address node2_address;  node2_address.netAddress=net_id;  node2_address.nodeAddress=2;
    let node010 <- mkButterflyL2Node(node2_address, head_node_addr);
    Address node3_address;  node3_address.netAddress=net_id;  node3_address.nodeAddress=3;
    let node011 <- mkButterflyL2Node(node3_address, head_node_addr);

    Address node4_address;  node4_address.netAddress=net_id;  node4_address.nodeAddress=4;
    let node100 <- mkButterflyL2Node(node4_address, head_node_addr);
    Address node5_address;  node5_address.netAddress=net_id;  node5_address.nodeAddress=5;
    let node101 <- mkButterflyL2Node(node5_address, head_node_addr);
    Address node6_address;  node6_address.netAddress=net_id;  node6_address.nodeAddress=6;
    let node110 <- mkButterflyL2Node(node6_address, head_node_addr);
    Address node7_address;  node7_address.netAddress=net_id;  node7_address.nodeAddress=7;
    let node111 <- mkButterflyL2Node(node7_address, head_node_addr);
   

    // MAKING SWITCHES
    // mkButterflySwitch #(int my_addr, int layer, Bool left_ext, Bool right_ext)
    let switch_L0_0 <- mkButterflySwitchL2(0, 0, True, False, 2);
    let switch_L0_1 <- mkButterflySwitchL2(1, 0, True, False, 2);
    let switch_L1_0 <- mkButterflySwitchL2(0, 1, False, True, 2);
    let switch_L1_1 <- mkButterflySwitchL2(1, 1, False, True, 2);

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
        switch_L1_0.put_value_from_left_down(data);
    endrule
    rule connect_r2l_switchL1_0_switchL0_1;
        let data <- switch_L1_0.get_value_to_left_down();
        switch_L0_1.put_value_from_right_down(data);
    endrule

    method Action put_value_from_l1(Flit data_from_L1);
        node001.put_value_from_l1(data_from_L1);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        let data <- node001.get_value_to_l1();
        return data;
    endmethod


endmodule

endpackage : Noc_butterfly4x4L2
