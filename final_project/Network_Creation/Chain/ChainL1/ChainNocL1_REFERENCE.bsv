package ChainNocL1;
// This package instantiates all the nodes and connects them in chain topology

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;

import ChainRouterL1VC :: *;
import ChainNodeL1VC :: *;

import ChainNocL2_0 :: * ;
import ChainNocL2_1 :: * ;
import ChainNocL2_2 :: * ;



(* synthesize *)
module mkChainL1Noc (Empty);


	Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;
	let nodeL1_0   <- mkChainNodeL1(node0_address);
	Address node1_address;  node1_address.netAddress=1;  node1_address.nodeAddress=1;
	let nodeL1_1   <- mkChainNodeL1(node1_address);
	Address node2_address;  node2_address.netAddress=2;  node2_address.nodeAddress=2;
	let nodeL1_2   <- mkChainNodeL1(node2_address);


	let noc_N0 <- mkChainL2Noc0();
	let noc_N1 <- mkChainL2Noc1();
	let noc_N2 <- mkChainL2Noc2();




	rule connect_Node0_to_Node1_L2R;
        let data01_L2R <- nodeL1_0.get_value_to_right();
        nodeL1_1.put_value_from_left(data01_L2R);
    endrule

	rule connect_Node1_to_Node2_L2R;
        let data12_L2R <- nodeL1_1.get_value_to_right();
        nodeL1_2.put_value_from_left(data12_L2R);
    endrule





	rule connect_Node1_to_Node0_R2L;
        let data10_R2L <- nodeL1_1.get_value_to_left();
        nodeL1_0.put_value_from_right(data10_R2L);
    endrule

	rule connect_Node2_to_Node1_R2L;
        let data21_R2L <- nodeL1_2.get_value_to_left();
        nodeL1_1.put_value_from_right(data21_R2L);
    endrule





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


endmodule

endpackage : ChainNocL1
