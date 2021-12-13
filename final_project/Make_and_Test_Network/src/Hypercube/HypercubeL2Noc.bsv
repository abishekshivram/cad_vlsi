package HypercubeL2Noc;
// This package instantiates all the nodes and connects them

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;


import HypercubeL2NodesVC :: *; // Nodes 0 to 7 where Node0=HEAD
import HypercubeRouterL2VC :: *; // Router for rest nodes
import HypercubeRouterL2HeadVC :: *; // Router for HEAD NODE

// import HypercubeRouterVC :: *;
// import HypercubeNode0VC :: *;
// import HypercubeNode1VC :: *;
// import HypercubeNode2VC :: *;
// import HypercubeNode3VC :: *;
// import HypercubeNode4VC :: *;
// import HypercubeNode5VC :: *;
// import HypercubeNode6VC :: *;
// import HypercubeNode7VC :: *;



interface IfcHypercubeL2Noc;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router

    method Action put_value_from_l1(Flit data_from_L1);
    method ActionValue#(Flit) get_value_to_l1();

endinterface 

(* synthesize *)
module mkHypercubeL2Noc #(parameter NetAddress net_id) (IfcHypercubeL2Noc);

    // When its a head node, it should has more than two set of 3 links,
    // one set to L2 network, another set for L1 network
    
    Address node0_address;  node0_address.netAddress=net_id;  node0_address.nodeAddress=0;
    let node0   <- mkHypercubeNode0VC(node0_address); // HEAD
    
    Address node1_address;  node1_address.netAddress=net_id;  node1_address.nodeAddress=1;
    let node1   <- mkHypercubeNode1VC(node1_address);
    
    Address node2_address;  node2_address.netAddress=net_id;  node2_address.nodeAddress=2;
    let node2   <- mkHypercubeNode2VC(node2_address);

    Address node3_address;  node3_address.netAddress=net_id;  node3_address.nodeAddress=3;
    let node3   <- mkHypercubeNode3VC(node3_address);

    Address node4_address;  node4_address.netAddress=net_id;  node4_address.nodeAddress=4;
    let node4   <- mkHypercubeNode4VC(node4_address);

    Address node5_address;  node5_address.netAddress=net_id;  node5_address.nodeAddress=5;
    let node5   <- mkHypercubeNode5VC(node5_address);

    Address node6_address;  node6_address.netAddress=net_id;  node6_address.nodeAddress=6;
    let node6   <- mkHypercubeNode6VC(node6_address);

    Address node7_address;  node7_address.netAddress=net_id;  node7_address.nodeAddress=7;
    let node7   <- mkHypercubeNode7VC(node7_address);
    


    



    // Connecting nodes - following are the interface of the nodes
    rule connect_Node0_to_Node1_lsb;
        let data0_1_lsb <- node0.get_value_to_lsb();
        node1.put_value_from_lsb(data0_1_lsb);
    endrule

    rule connect_Node0_to_Node2_mid;
        let data0_2_mid <- node0.get_value_to_mid();
        node2.put_value_from_mid(data0_2_mid);
    endrule

    rule connect_Node0_to_Node4_msb;
        let data0_4_msb <- node0.get_value_to_msb();
        node4.put_value_from_msb(data0_4_msb);
    endrule

    rule connect_Node1_to_Node0_lsb;
        let data1_0_lsb <- node1.get_value_to_lsb();
        node0.put_value_from_lsb(data1_0_lsb);
    endrule

    rule connect_Node1_to_Node3_mid;
        let data1_3_mid <- node1.get_value_to_mid();
        node3.put_value_from_mid(data1_3_mid);
    endrule

    rule connect_Node1_to_Node5_msb;
        let data1_5_msb <- node1.get_value_to_msb();
        node5.put_value_from_msb(data1_5_msb);
    endrule

    rule connect_Node2_to_Node3_lsb;
        let data2_3_lsb <- node2.get_value_to_lsb();
        node3.put_value_from_lsb(data2_3_lsb);
    endrule

    rule connect_Node2_to_Node0_mid;
        let data2_0_mid <- node2.get_value_to_mid();
        node0.put_value_from_mid(data2_0_mid);
    endrule

    rule connect_Node2_to_Node6_msb;
        let data2_6_msb <- node2.get_value_to_msb();
        node6.put_value_from_msb(data2_6_msb);
    endrule

    rule connect_Node3_to_Node2_lsb;
        let data3_2_lsb <- node3.get_value_to_lsb();
        node2.put_value_from_lsb(data3_2_lsb);
    endrule

    rule connect_Node3_to_Node1_mid;
        let data3_1_mid <- node3.get_value_to_mid();
        node1.put_value_from_mid(data3_1_mid);
    endrule

    rule connect_Node3_to_Node7_msb;
        let data3_7_msb <- node3.get_value_to_msb();
        node7.put_value_from_msb(data3_7_msb);
    endrule

    rule connect_Node4_to_Node5_lsb;
        let data4_5_lsb <- node4.get_value_to_lsb();
        node5.put_value_from_lsb(data4_5_lsb);
    endrule

    rule connect_Node4_to_Node6_mid;
        let data4_6_mid <- node4.get_value_to_mid();
        node6.put_value_from_mid(data4_6_mid);
    endrule

    rule connect_Node4_to_Node0_msb;
        let data4_0_msb <- node4.get_value_to_msb();
        node0.put_value_from_msb(data4_0_msb);
    endrule

    rule connect_Node5_to_Node4_lsb;
        let data5_4_lsb <- node5.get_value_to_lsb();
        node4.put_value_from_lsb(data5_4_lsb);
    endrule

    rule connect_Node5_to_Node7_mid;
        let data5_7_mid <- node5.get_value_to_mid();
        node7.put_value_from_mid(data5_7_mid);
    endrule

    rule connect_Node5_to_Node1_msb;
        let data5_1_msb <- node5.get_value_to_msb();
        node1.put_value_from_msb(data5_1_msb);
    endrule

    rule connect_Node6_to_Node7_lsb;
        let data6_7_lsb <- node6.get_value_to_lsb();
        node7.put_value_from_lsb(data6_7_lsb);
    endrule

    rule connect_Node6_to_Node4_mid;
        let data6_4_mid <- node6.get_value_to_mid();
        node4.put_value_from_mid(data6_4_mid);
    endrule

    rule connect_Node6_to_Node2_msb;
        let data6_2_msb <- node6.get_value_to_msb();
        node2.put_value_from_msb(data6_2_msb);
    endrule

    rule connect_Node7_to_Node6_lsb;
        let data7_6_lsb <- node7.get_value_to_lsb();
        node6.put_value_from_lsb(data7_6_lsb);
    endrule

    rule connect_Node7_to_Node5_mid;
        let data7_5_mid <- node7.get_value_to_mid();
        node5.put_value_from_mid(data7_5_mid);
    endrule

    rule connect_Node7_to_Node3_msb;
        let data7_3_msb <- node7.get_value_to_msb();
        node3.put_value_from_msb(data7_3_msb);
    endrule
    
    

    method Action put_value_from_l1(Flit data_from_L1);
        node0.put_value_from_l1(data_from_L1);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        Flit data=defaultValue;
        $display("Calling get_value_to_l1 from L2 N0");
        data <- node0.get_value_to_l1();
        return data;
    endmethod

endmodule
endpackage : HypercubeL2Noc
