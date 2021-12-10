package ChainNocL2_1;
// This package instantiates all the nodes and connects them in chain topology

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;

import ChainRouterVC :: *;
import ChainNodeVC :: *;

import ChainRouterL2HeadVC :: *;
import ChainNodeL2HeadVC :: *;

interface IfcChainNoc;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router

    method Action put_value_from_l1(Flit data_from_L1);
    method ActionValue#(Flit) get_value_to_l1();

endinterface


(* synthesize *)
module mkChainL2Noc1 (IfcChainNoc);

    Address head_node_addr;
    head_node_addr.netAddress=1;  head_node_addr.nodeAddress=2;

	Address node0_address;  node0_address.netAddress=1;  node0_address.nodeAddress=0;
	let node0   <- mkChainNode(node0_address, head_node_addr);
	Address node1_address;  node1_address.netAddress=1;  node1_address.nodeAddress=1;
	let node1   <- mkChainNode(node1_address, head_node_addr);
	Address node2_address;  node2_address.netAddress=1;  node2_address.nodeAddress=2;
	let node2   <- mkChainL2HeadNode(node2_address, head_node_addr);
	Address node3_address;  node3_address.netAddress=1;  node3_address.nodeAddress=3;
	let node3   <- mkChainNode(node3_address, head_node_addr);


    
	rule connect_Node0_to_Node1_L2R;
        let data01_L2R <- node0.get_value_to_right();
        node1.put_value_from_left(data01_L2R);
    endrule

	rule connect_Node1_to_Node2_L2R;
        let data12_L2R <- node1.get_value_to_right();
        node2.put_value_from_left(data12_L2R);
    endrule

	rule connect_Node2_to_Node3_L2R;
        let data23_L2R <- node2.get_value_to_right();
        node3.put_value_from_left(data23_L2R);
    endrule





	rule connect_Node1_to_Node0_R2L;
        let data10_R2L <- node1.get_value_to_left();
        node0.put_value_from_right(data10_R2L);
    endrule

	rule connect_Node2_to_Node1_R2L;
        let data21_R2L <- node2.get_value_to_left();
        node1.put_value_from_right(data21_R2L);
    endrule

	rule connect_Node3_to_Node2_R2L;
        let data32_R2L <- node3.get_value_to_left();
        node2.put_value_from_right(data32_R2L);
    endrule



    method Action put_value_from_l1(Flit data_from_L1);
        node2.put_value_from_l1(data_from_L1);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        Flit data=defaultValue;
        data <- node2.get_value_to_l1();
        return data;
    endmethod

endmodule

endpackage : ChainNocL2_1
