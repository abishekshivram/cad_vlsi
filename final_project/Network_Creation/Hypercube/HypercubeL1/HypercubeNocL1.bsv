package HypercubeNocL1;
// This package instantiates all the nodeL1_s and connects them in chain topology

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;

import HypercubeL1Node0VC :: *;
import HypercubeL1Node1VC :: *;
import HypercubeL1Node2VC :: *;
import HypercubeL1Node3VC :: *;
import HypercubeL1Node4VC :: *;
import HypercubeL1Node5VC :: *;
import HypercubeL1Node6VC :: *;
import HypercubeL1Node7VC :: *;




(* synthesize *)
module mkHypercubeL1Noc (Empty);

    // INSTANTIATION OF L1 NODES
	Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;
    let nodeL1_0   <- mkHypercubeL1Node0VC(node0_address); 
	Address node1_address;  node1_address.netAddress=1;  node1_address.nodeAddress=1;
    let nodeL1_1   <- mkHypercubeL1Node1VC(node1_address); 
	Address node2_address;  node2_address.netAddress=2;  node2_address.nodeAddress=2;
    let nodeL1_2   <- mkHypercubeL1Node2VC(node2_address); 
	Address node3_address;  node3_address.netAddress=3;  node3_address.nodeAddress=3;
    let nodeL1_3   <- mkHypercubeL1Node3VC(node3_address); 
	Address node4_address;  node4_address.netAddress=4;  node4_address.nodeAddress=4;
    let nodeL1_4   <- mkHypercubeL1Node4VC(node4_address); 
	Address node5_address;  node5_address.netAddress=5;  node5_address.nodeAddress=5;
    let nodeL1_5   <- mkHypercubeL1Node5VC(node5_address); 
	Address node6_address;  node6_address.netAddress=6;  node6_address.nodeAddress=6;
    let nodeL1_6   <- mkHypercubeL1Node6VC(node6_address); 
	Address node7_address;  node7_address.netAddress=7;  node7_address.nodeAddress=7;
    let nodeL1_7   <- mkHypercubeL1Node7VC(node7_address); 


    // INSTANTIATION OF L2 NODES
    // IMPLEMENTING EIGHT HYPERCUBES HERE
	let noc_N0 <- mkHypercubeL2Noc(0);
	let noc_N1 <- mkHypercubeL2Noc(1);
	let noc_N2 <- mkHypercubeL2Noc(2);
	let noc_N3 <- mkHypercubeL2Noc(3);
	let noc_N4 <- mkHypercubeL2Noc(4);
	let noc_N5 <- mkHypercubeL2Noc(5);
	let noc_N6 <- mkHypercubeL2Noc(6);
	let noc_N7 <- mkHypercubeL2Noc(7);
    

    // CONNECTING L1 NODES TO L2 NOCs
	rule connect_N0_to_node0_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_0.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N0.put_value_from_l1(data);
    endrule
    rule connect_node0_to_N0_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N0.get_value_to_l1();
        nodeL1_0.put_value_from_l2(data);
    endrule
	rule connect_N1_to_node1_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_1.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N1.put_value_from_l1(data);
    endrule
    rule connect_node1_to_N1_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N1.get_value_to_l1();
        nodeL1_1.put_value_from_l2(data);
    endrule
	rule connect_N2_to_node2_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_2.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N2.put_value_from_l1(data);
    endrule
    rule connect_node2_to_N2_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N2.get_value_to_l1();
        nodeL1_2.put_value_from_l2(data);
    endrule
	rule connect_N3_to_node3_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_3.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N3.put_value_from_l1(data);
    endrule
    rule connect_node3_to_N3_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N3.get_value_to_l1();
        nodeL1_3.put_value_from_l2(data);
    endrule
	rule connect_N4_to_node4_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_4.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N4.put_value_from_l1(data);
    endrule
    rule connect_node4_to_N4_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N4.get_value_to_l1();
        nodeL1_4.put_value_from_l2(data);
    endrule
	rule connect_N5_to_node5_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_5.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N5.put_value_from_l1(data);
    endrule
    rule connect_node5_to_N5_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N5.get_value_to_l1();
        nodeL1_5.put_value_from_l2(data);
    endrule
	rule connect_N6_to_node6_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_6.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N6.put_value_from_l1(data);
    endrule
    rule connect_node6_to_N6_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N6.get_value_to_l1();
        nodeL1_6.put_value_from_l2(data);
    endrule
	rule connect_N7_to_node7_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_7.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N7.put_value_from_l1(data);
    endrule
    rule connect_node7_to_N7_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N7.get_value_to_l1();
        nodeL1_7.put_value_from_l2(data);
    endrule
 


    // CONNECTION OF L1 NODES START
    rule connect_Node0_to_Node1_lsb;
        let data0_1_lsb <- nodeL1_0.get_value_to_lsb();
        nodeL1_1.put_value_from_lsb(data0_1_lsb);
    endrule

    rule connect_Node0_to_Node2_mid;
        let data0_2_mid <- nodeL1_0.get_value_to_mid();
        nodeL1_2.put_value_from_mid(data0_2_mid);
    endrule

    rule connect_Node0_to_Node4_msb;
        let data0_4_msb <- nodeL1_0.get_value_to_msb();
        nodeL1_4.put_value_from_msb(data0_4_msb);
    endrule

    rule connect_Node1_to_Node0_lsb;
        let data1_0_lsb <- nodeL1_1.get_value_to_lsb();
        nodeL1_0.put_value_from_lsb(data1_0_lsb);
    endrule

    rule connect_Node1_to_Node3_mid;
        let data1_3_mid <- nodeL1_1.get_value_to_mid();
        nodeL1_3.put_value_from_mid(data1_3_mid);
    endrule

    rule connect_Node1_to_Node5_msb;
        let data1_5_msb <- nodeL1_1.get_value_to_msb();
        nodeL1_5.put_value_from_msb(data1_5_msb);
    endrule

    rule connect_Node2_to_Node3_lsb;
        let data2_3_lsb <- nodeL1_2.get_value_to_lsb();
        nodeL1_3.put_value_from_lsb(data2_3_lsb);
    endrule

    rule connect_Node2_to_Node0_mid;
        let data2_0_mid <- nodeL1_2.get_value_to_mid();
        nodeL1_0.put_value_from_mid(data2_0_mid);
    endrule

    rule connect_Node2_to_Node6_msb;
        let data2_6_msb <- nodeL1_2.get_value_to_msb();
        nodeL1_6.put_value_from_msb(data2_6_msb);
    endrule

    rule connect_Node3_to_Node2_lsb;
        let data3_2_lsb <- nodeL1_3.get_value_to_lsb();
        nodeL1_2.put_value_from_lsb(data3_2_lsb);
    endrule

    rule connect_Node3_to_Node1_mid;
        let data3_1_mid <- nodeL1_3.get_value_to_mid();
        nodeL1_1.put_value_from_mid(data3_1_mid);
    endrule

    rule connect_Node3_to_Node7_msb;
        let data3_7_msb <- nodeL1_3.get_value_to_msb();
        nodeL1_7.put_value_from_msb(data3_7_msb);
    endrule

    rule connect_Node4_to_Node5_lsb;
        let data4_5_lsb <- nodeL1_4.get_value_to_lsb();
        nodeL1_5.put_value_from_lsb(data4_5_lsb);
    endrule

    rule connect_Node4_to_Node6_mid;
        let data4_6_mid <- nodeL1_4.get_value_to_mid();
        nodeL1_6.put_value_from_mid(data4_6_mid);
    endrule

    rule connect_Node4_to_Node0_msb;
        let data4_0_msb <- nodeL1_4.get_value_to_msb();
        nodeL1_0.put_value_from_msb(data4_0_msb);
    endrule

    rule connect_Node5_to_Node4_lsb;
        let data5_4_lsb <- nodeL1_5.get_value_to_lsb();
        nodeL1_4.put_value_from_lsb(data5_4_lsb);
    endrule

    rule connect_Node5_to_Node7_mid;
        let data5_7_mid <- nodeL1_5.get_value_to_mid();
        nodeL1_7.put_value_from_mid(data5_7_mid);
    endrule

    rule connect_Node5_to_Node1_msb;
        let data5_1_msb <- nodeL1_5.get_value_to_msb();
        nodeL1_1.put_value_from_msb(data5_1_msb);
    endrule

    rule connect_Node6_to_Node7_lsb;
        let data6_7_lsb <- nodeL1_6.get_value_to_lsb();
        nodeL1_7.put_value_from_lsb(data6_7_lsb);
    endrule

    rule connect_Node6_to_Node4_mid;
        let data6_4_mid <- nodeL1_6.get_value_to_mid();
        nodeL1_4.put_value_from_mid(data6_4_mid);
    endrule

    rule connect_Node6_to_Node2_msb;
        let data6_2_msb <- nodeL1_6.get_value_to_msb();
        nodeL1_2.put_value_from_msb(data6_2_msb);
    endrule

    rule connect_Node7_to_Node6_lsb;
        let data7_6_lsb <- nodeL1_7.get_value_to_lsb();
        nodeL1_6.put_value_from_lsb(data7_6_lsb);
    endrule

    rule connect_Node7_to_Node5_mid;
        let data7_5_mid <- nodeL1_7.get_value_to_mid();
        nodeL1_5.put_value_from_mid(data7_5_mid);
    endrule

    rule connect_Node7_to_Node3_msb;
        let data7_3_msb <- nodeL1_7.get_value_to_msb();
        nodeL1_3.put_value_from_msb(data7_3_msb);
    endrule

    // CONNECTION OF L1 NODES END


endmodule
endpackage : HypercubeNocL1
