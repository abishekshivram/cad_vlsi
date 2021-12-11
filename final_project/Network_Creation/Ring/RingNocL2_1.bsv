package RingNocL2_1;
// This package instantiates all the nodes and connects them in ring topology

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;

import RingRouterVC :: *;
import RingNodeVC :: *;

import RingRouterL2HeadVC :: *;
import RingNodeL2HeadVC :: *;

interface IfcRingNoc;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router

    method Action put_value_from_l1(Flit data_from_L1);
    method ActionValue#(Flit) get_value_to_l1();

endinterface


(* synthesize *)
module mkRingL2Noc1 (IfcRingNoc);


	Address head_node_addr;  head_node_addr.netAddress=1;  head_node_addr.nodeAddress=0;

	Address node0_address;  node0_address.netAddress=1;  node0_address.nodeAddress=0;
	let node0   <- mkRingL2HeadNode(node0_address, 3, head_node_addr);
	Address node1_address;  node1_address.netAddress=1;  node1_address.nodeAddress=1;
	let node1   <- mkRingNode(node1_address, 3, head_node_addr);
	Address node2_address;  node2_address.netAddress=1;  node2_address.nodeAddress=2;
	let node2   <- mkRingNode(node2_address, 3, head_node_addr);
	Address node3_address;  node3_address.netAddress=1;  node3_address.nodeAddress=3;
	let node3   <- mkRingNode(node3_address, 3, head_node_addr);


    
	rule connect_Node0_to_Node1_L2R;
        let data01_L2R <- node0.get_value_to_right();
        node1.put_value_from_left(data01_L2R);
    endrule

    rule connect_Node0_to_Node1_L2R_dateline;
        let data01_L2R_dateline <- node0.get_value_to_right_dateline();
        node1.put_value_from_left_dateline(data01_L2R_dateline);
    endrule

	rule connect_Node1_to_Node2_L2R;
        let data12_L2R <- node1.get_value_to_right();
        node2.put_value_from_left(data12_L2R);
    endrule

    rule connect_Node1_to_Node2_L2R_dateline;
        let data12_L2R_dateline <- node1.get_value_to_right_dateline();
        node2.put_value_from_left_dateline(data12_L2R_dateline);
    endrule

	rule connect_Node2_to_Node3_L2R;
        let data23_L2R <- node2.get_value_to_right();
        node3.put_value_from_left(data23_L2R);
    endrule

    rule connect_Node2_to_Node3_L2R_dateline;
        let data23_L2R_dateline <- node2.get_value_to_right_dateline();
        node3.put_value_from_left_dateline(data23_L2R_dateline);
    endrule

	rule connect_Node3_to_Node0_L2R;
        let data30_L2R <- node3.get_value_to_right();
        node0.put_value_from_left(data30_L2R);
    endrule

    rule connect_Node3_to_Node0_L2R_dateline;
        let data30_L2R_dateline <- node3.get_value_to_right_dateline();
        node0.put_value_from_left_dateline(data30_L2R_dateline);
    endrule




	rule connect_Node1_to_Node0_R2L;
        let data10_R2L <- node1.get_value_to_left();
        node0.put_value_from_right(data10_R2L);
    endrule

    rule connect_Node1_to_Node0_R2L_dateline;
        let data10_R2L_dateline <- node1.get_value_to_left_dateline();
        node0.put_value_from_right_dateline(data10_R2L_dateline);
    endrule

	rule connect_Node2_to_Node1_R2L;
        let data21_R2L <- node2.get_value_to_left();
        node1.put_value_from_right(data21_R2L);
    endrule

    rule connect_Node2_to_Node1_R2L_dateline;
        let data21_R2L_dateline <- node2.get_value_to_left_dateline();
        node1.put_value_from_right_dateline(data21_R2L_dateline);
    endrule

	rule connect_Node3_to_Node2_R2L;
        let data32_R2L <- node3.get_value_to_left();
        node2.put_value_from_right(data32_R2L);
    endrule

    rule connect_Node3_to_Node2_R2L_dateline;
        let data32_R2L_dateline <- node3.get_value_to_left_dateline();
        node2.put_value_from_right_dateline(data32_R2L_dateline);
    endrule

	rule connect_Node0_to_Node3_R2L;
        let data03_R2L <- node0.get_value_to_left();
        node3.put_value_from_right(data03_R2L);
    endrule

    rule connect_Node0_to_Node3_R2L_dateline;
        let data03_R2L_dateline <- node0.get_value_to_left_dateline();
        node3.put_value_from_right_dateline(data03_R2L_dateline);
    endrule



    method Action put_value_from_l1(Flit data_from_L1);
        node0.put_value_from_l1(data_from_L1);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        Flit data=defaultValue;
        data <- node0.get_value_to_l1();
        return data;
    endmethod

endmodule

endpackage : RingNocL2_1
