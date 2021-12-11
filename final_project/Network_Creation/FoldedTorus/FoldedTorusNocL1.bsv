package FoldedTorusNocL1;
// This package instantiates all the nodes and connects them in FoldedTorus topology

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;

import FoldedTorusRouterL1VC :: *;
import FoldedTorusNodeL1VC :: *;

import FoldedTorusNocL2_0 :: * ;
import FoldedTorusNocL2_1 :: * ;
import FoldedTorusNocL2_2 :: * ;
import FoldedTorusNocL2_3 :: * ;
import FoldedTorusNocL2_4 :: * ;
import FoldedTorusNocL2_5 :: * ;



(* synthesize *)
module mkFoldedTorusL1Noc (Empty);


	Address nodeL1_00_address;  nodeL1_00_address.netAddress=16'h0000;  nodeL1_00_address.nodeAddress=0;
	let nodeL1_00   <- mkFoldedTorusL1Node(nodeL1_00_address, 2, 1);
	Address nodeL1_01_address;  nodeL1_01_address.netAddress=16'h0001;  nodeL1_01_address.nodeAddress=0;
	let nodeL1_01   <- mkFoldedTorusL1Node(nodeL1_01_address, 2, 1);
	Address nodeL1_02_address;  nodeL1_02_address.netAddress=16'h0002;  nodeL1_02_address.nodeAddress=0;
	let nodeL1_02   <- mkFoldedTorusL1Node(nodeL1_02_address, 2, 1);
	Address nodeL1_10_address;  nodeL1_10_address.netAddress=16'h0100;  nodeL1_10_address.nodeAddress=0;
	let nodeL1_10   <- mkFoldedTorusL1Node(nodeL1_10_address, 2, 1);
	Address nodeL1_11_address;  nodeL1_11_address.netAddress=16'h0101;  nodeL1_11_address.nodeAddress=0;
	let nodeL1_11   <- mkFoldedTorusL1Node(nodeL1_11_address, 2, 1);
	Address nodeL1_12_address;  nodeL1_12_address.netAddress=16'h0102;  nodeL1_12_address.nodeAddress=0;
	let nodeL1_12   <- mkFoldedTorusL1Node(nodeL1_12_address, 2, 1);


	let noc_N0 <- mkFoldedTorusL2Noc0();
	let noc_N1 <- mkFoldedTorusL2Noc1();
	let noc_N2 <- mkFoldedTorusL2Noc2();
	let noc_N3 <- mkFoldedTorusL2Noc3();
	let noc_N4 <- mkFoldedTorusL2Noc4();
	let noc_N5 <- mkFoldedTorusL2Noc5();




	rule connect_Node00_to_Node01_L2R;
        let data00_L2R <- nodeL1_00.get_value_to_right();
        nodeL1_01.put_value_from_left(data00_L2R);
    endrule

	rule connect_Node01_to_Node02_L2R;
        let data01_L2R <- nodeL1_01.get_value_to_right();
        nodeL1_02.put_value_from_left(data01_L2R);
    endrule

	rule connect_Node02_to_Node00_L2R;
        let data02_L2R <- nodeL1_02.get_value_to_right();
        nodeL1_00.put_value_from_left(data02_L2R);
    endrule

	rule connect_Node10_to_Node11_L2R;
        let data10_L2R <- nodeL1_10.get_value_to_right();
        nodeL1_11.put_value_from_left(data10_L2R);
    endrule

	rule connect_Node11_to_Node12_L2R;
        let data11_L2R <- nodeL1_11.get_value_to_right();
        nodeL1_12.put_value_from_left(data11_L2R);
    endrule

	rule connect_Node12_to_Node10_L2R;
        let data12_L2R <- nodeL1_12.get_value_to_right();
        nodeL1_10.put_value_from_left(data12_L2R);
    endrule





	rule connect_Node01_to_Node00_R2L;
        let data01_R2L <- nodeL1_01.get_value_to_left();
        nodeL1_00.put_value_from_right(data01_R2L);
    endrule

	rule connect_Node02_to_Node01_R2L;
        let data02_R2L <- nodeL1_02.get_value_to_left();
        nodeL1_01.put_value_from_right(data02_R2L);
    endrule

	rule connect_Node00_to_Node02_R2L;
        let data00_R2L <- nodeL1_00.get_value_to_left();
        nodeL1_02.put_value_from_right(data00_R2L);
    endrule

	rule connect_Node11_to_Node10_R2L;
        let data11_R2L <- nodeL1_11.get_value_to_left();
        nodeL1_10.put_value_from_right(data11_R2L);
    endrule

	rule connect_Node12_to_Node11_R2L;
        let data12_R2L <- nodeL1_12.get_value_to_left();
        nodeL1_11.put_value_from_right(data12_R2L);
    endrule

	rule connect_Node10_to_Node12_R2L;
        let data10_R2L <- nodeL1_10.get_value_to_left();
        nodeL1_12.put_value_from_right(data10_R2L);
    endrule





	rule connect_N0_to_node00_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_00.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N0.put_value_from_l1(data);
    endrule
    rule connect_node00_to_N0_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N0.get_value_to_l1();
        nodeL1_00.put_value_from_l2(data);
    endrule

	rule connect_N1_to_node01_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_01.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N1.put_value_from_l1(data);
    endrule
    rule connect_node01_to_N1_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N1.get_value_to_l1();
        nodeL1_01.put_value_from_l2(data);
    endrule

	rule connect_N2_to_node02_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_02.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N2.put_value_from_l1(data);
    endrule
    rule connect_node02_to_N2_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N2.get_value_to_l1();
        nodeL1_02.put_value_from_l2(data);
    endrule

	rule connect_N3_to_node10_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_10.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N3.put_value_from_l1(data);
    endrule
    rule connect_node10_to_N3_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N3.get_value_to_l1();
        nodeL1_10.put_value_from_l2(data);
    endrule

	rule connect_N4_to_node11_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_11.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N4.put_value_from_l1(data);
    endrule
    rule connect_node11_to_N4_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N4.get_value_to_l1();
        nodeL1_11.put_value_from_l2(data);
    endrule

	rule connect_N5_to_node12_L1_to_L2;
        Flit data=defaultValue;
        data <- nodeL1_12.get_value_to_l2();
        data.currentDstAddress.netAddress   = data.finalDstAddress.netAddress;
        data.currentDstAddress.nodeAddress  = data.finalDstAddress.nodeAddress;
        noc_N5.put_value_from_l1(data);
    endrule
    rule connect_node12_to_N5_L2_to_L1;
        Flit data=defaultValue;
        data <- noc_N5.get_value_to_l1();
        nodeL1_12.put_value_from_l2(data);
    endrule


endmodule

endpackage : FoldedTorusNocL1
