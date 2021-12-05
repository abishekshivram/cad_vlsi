package Noc;
// This package instantiates all the nodes and connects them


module mkNoc(Empty);
    // In this example, 6 nodes are linked in a chain fashion
    let node0   <- mkChainNode(3'b000, False);
    let node1   <- mkChainNode(3'b001, False);
    let node2   <- mkChainNode(3'b010, False);
    let node3   <- mkChainNode(3'b011, True); // Head node
    // When its a head node, it has more than two links,
    // one set to L2 network, another set for L1 network
    let node4   <- mkChainNode(3'b100, False);
    let node5   <- mkChainNode(3'b101, False);
    
    // Connecting nodes - following are the interface of the nodes
    // First (below) all LEFT TO RIGHT connections are made
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

    // Now (below) all RIGHT TO LEFT connections are made
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


endmodule
endpackage : Noc