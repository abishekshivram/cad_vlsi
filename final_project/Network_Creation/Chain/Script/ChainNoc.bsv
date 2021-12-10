package ChainNocL2;
// This package instantiates all the nodes and connects them in chain topology

import Shared::*;
import Parameters::*;
import FIFO :: * ;
import Core :: * ;
import ChainRouterVC :: *;
import ChainNodeVC :: *;

(* synthesize *)
module mkChainNoc(Empty);


	Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;
	let node0   <- mkChainNode(node0_address, False);
	Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=1;
	let node1   <- mkChainNode(node1_address, False);
	Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=2;
	let node2   <- mkChainNode(node2_address, False);
	Address node3_address;  node3_address.netAddress=0;  node3_address.nodeAddress=3;
	let node3   <- mkChainNode(node3_address, True);
	Address node4_address;  node4_address.netAddress=0;  node4_address.nodeAddress=4;
	let node4   <- mkChainNode(node4_address, False);
	Address node5_address;  node5_address.netAddress=0;  node5_address.nodeAddress=5;
	let node5   <- mkChainNode(node5_address, False);


    
	rule connect_Node0_to_Node1_L2R;
        let data01_L2R <- node0.GetValuetoRight();
        node1.PutValuefromLeft(data01_L2R);
    endrule

	rule connect_Node1_to_Node2_L2R;
        let data12_L2R <- node1.GetValuetoRight();
        node2.PutValuefromLeft(data12_L2R);
    endrule

	rule connect_Node2_to_Node3_L2R;
        let data23_L2R <- node2.GetValuetoRight();
        node3.PutValuefromLeft(data23_L2R);
    endrule

	rule connect_Node3_to_Node4_L2R;
        let data34_L2R <- node3.GetValuetoRight();
        node4.PutValuefromLeft(data34_L2R);
    endrule

	rule connect_Node4_to_Node5_L2R;
        let data45_L2R <- node4.GetValuetoRight();
        node5.PutValuefromLeft(data45_L2R);
    endrule

	rule connect_Node5_to_Node6_L2R;
        let data56_L2R <- node5.GetValuetoRight();
        node6.PutValuefromLeft(data56_L2R);
    endrule




	rule connect_Node1_to_Node0_R2L;
        let data10_R2L <- node1.GetValuetoLeft();
        node0.PutValuefromRight(data10_R2L);
    endrule

	rule connect_Node2_to_Node1_R2L;
        let data21_R2L <- node2.GetValuetoLeft();
        node1.PutValuefromRight(data21_R2L);
    endrule

	rule connect_Node3_to_Node2_R2L;
        let data32_R2L <- node3.GetValuetoLeft();
        node2.PutValuefromRight(data32_R2L);
    endrule

	rule connect_Node4_to_Node3_R2L;
        let data43_R2L <- node4.GetValuetoLeft();
        node3.PutValuefromRight(data43_R2L);
    endrule

	rule connect_Node5_to_Node4_R2L;
        let data54_R2L <- node5.GetValuetoLeft();
        node4.PutValuefromRight(data54_R2L);
    endrule

	rule connect_Node6_to_Node5_R2L;
        let data65_R2L <- node6.GetValuetoLeft();
        node5.PutValuefromRight(data65_R2L);
    endrule




endmodule : mkChainNoc

endpackage : ChainNocL2
