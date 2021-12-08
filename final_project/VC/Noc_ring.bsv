package Noc_ring;
// This package instantiates all the nodes and connects them

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import RingRouterVC :: *;
import RingNodeVC :: *;

(* synthesize *)

module mkNoc(Empty);

    // In this example, 3 nodes are linked in a ring fashion
    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    Address node0_address;  node0_address.netAddress=0;  node0_address.nodeAddress=0;   node0_address.maxNodeAddress=2;
    let node0   <- mkRingNode(node0_address, 0); // Head node
    Address node1_address;  node1_address.netAddress=0;  node1_address.nodeAddress=1;   node1_address.maxNodeAddress=2;
    let node1   <- mkRingNode(node1_address, 0);
    Address node2_address;  node2_address.netAddress=0;  node2_address.nodeAddress=2;   node2_address.maxNodeAddress=2;
    let node2   <- mkRingNode(node2_address, 0);


    // Connecting nodes - following are the interface of the nodes
    // First (below) all LEFT TO RIGHT connections are made
    // (ie) Flit goes from Node 0 to Node 1 (right direction travel, hence L2R(left 2 right)) 
    rule connect_Node0_to_Node1_L2R;
        let data01_L2R <- node0.get_value_to_right();
        node1.put_value_from_left(data01_L2R);
    endrule

    rule connect_Node1_to_Node2_L2R;
        let data12_L2R <- node1.get_value_to_right();
        node2.put_value_from_left(data12_L2R);
    endrule

    rule connect_Node2_to_Node0_L2R;
        let data20_L2R <- node2.get_value_to_right();
        node0.put_value_from_left(data20_L2R);
    endrule


    // Now (below) all RIGHT TO LEFT connections are made
    rule connect_Node1_to_Node0_R2L;
        let data10_R2L <- node1.get_value_to_left();
        node0.put_value_from_right(data10_R2L);
    endrule

    rule connect_Node2_to_Node1_R2L;
        let data21_R2L <- node2.get_value_to_left();
        node1.put_value_from_right(data21_R2L);
    endrule

    rule connect_Node0_to_Node2_R2L;
        let data02_R2L <- node0.get_value_to_left();
        node2.put_value_from_right(data02_R2L);
    endrule

endmodule
endpackage : Noc_ring