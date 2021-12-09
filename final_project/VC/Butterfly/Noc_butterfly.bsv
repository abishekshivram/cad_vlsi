package Noc_butterfly;

import ButterflyNodeVC::*;
import ButterflyRouterVC::*;
import ButterflySwitch::*;


module mkButterflyNoc(Empty);

    /* 8x8 butterfly network is made */
    let node0000 <- mkButterflyNode(0);
    let node0001 <- mkButterflyNode(1);
    let node0010 <- mkButterflyNode(2);
    let node0011 <- mkButterflyNode(3);
    let node0100 <- mkButterflyNode(4);
    let node0101 <- mkButterflyNode(5);
    let node0110 <- mkButterflyNode(6);
    let node0111 <- mkButterflyNode(7);
    let node1000 <- mkButterflyNode(8);
    let node1001 <- mkButterflyNode(9);
    let node1010 <- mkButterflyNode(10);
    let node1011 <- mkButterflyNode(11);
    let node1100 <- mkButterflyNode(12);
    let node1101 <- mkButterflyNode(13);
    let node1110 <- mkButterflyNode(14);
    let node1111 <- mkButterflyNode(15);

    // MAKING SWITCHES
    let switch_L0_0 <- mkButterflySwitch(0, 0);
    let switch_L0_1 <- mkButterflySwitch(1, 0);
    let switch_L0_2 <- mkButterflySwitch(2, 0);
    let switch_L0_3 <- mkButterflySwitch(3, 0);
    let switch_L1_0 <- mkButterflySwitch(0, 1);
    let switch_L1_1 <- mkButterflySwitch(1, 1);
    let switch_L1_2 <- mkButterflySwitch(2, 1);
    let switch_L1_3 <- mkButterflySwitch(3, 1);
    let switch_L2_0 <- mkButterflySwitch(0, 2);
    let switch_L2_1 <- mkButterflySwitch(1, 2);
    let switch_L2_2 <- mkButterflySwitch(2, 2);
    let switch_L2_3 <- mkButterflySwitch(3, 2);

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

endpackage : Noc_butterfly

/* SWITCH METHODS
   method Action put_value_from_left_up(Flit data_left);
    method Action put_value_from_left_down(Flit data_left);
    method Action put_value_from_right_up(Flit data_right);
    method Action put_value_from_right_down(Flit data_right);

    method ActionValue#(Flit) get_value_to_left_up();
    method ActionValue#(Flit) get_value_to_left_down();
    method ActionValue#(Flit) get_value_to_right_up();
    method ActionValue#(Flit) get_value_to_right_down();
*/