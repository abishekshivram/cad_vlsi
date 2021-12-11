package MeshNocL1;
// This package instantiates all the nodes and connects them in chain topology

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;
import MeshRouterL1VC :: *;
import MeshNodeL1VC :: *;





(* synthesize *)
module mkMeshNocL1 (Empty);


    // MAKING MESH TOPOLOGY WITH ROWS: $NO_OF_ROWS AND COLUMNS: $NO_OF_COLUMNS
    // MAKING NODES
    
Address head_node_address; head_node_address.netAddress=16'h0101; head_node_address.nodeAddress=16'h0101;    
    Address node00_address;  node00_address.netAddress=16'h0000;  node00_address.nodeAddress=16'h0000;
    let node00   <- mkMeshNodeL1(node00_address, head_node_address); 
    Address node01_address;  node01_address.netAddress=16'h0001;  node01_address.nodeAddress=16'h0001;
    let node01   <- mkMeshNodeL1(node01_address, head_node_address); 
    Address node02_address;  node02_address.netAddress=16'h0002;  node02_address.nodeAddress=16'h0002;
    let node02   <- mkMeshNodeL1(node02_address, head_node_address); 
    Address node10_address;  node10_address.netAddress=16'h0100;  node10_address.nodeAddress=16'h0100;
    let node10   <- mkMeshNodeL1(node10_address, head_node_address); 
    Address node11_address;  node11_address.netAddress=16'h0101;  node11_address.nodeAddress=16'h0101;
    let node11   <- mkMeshNodeL1(node11_address, head_node_address); 
    Address node12_address;  node12_address.netAddress=16'h0102;  node12_address.nodeAddress=16'h0102;
    let node12   <- mkMeshNodeL1(node12_address, head_node_address); 
    Address node20_address;  node20_address.netAddress=16'h0200;  node20_address.nodeAddress=16'h0200;
    let node20   <- mkMeshNodeL1(node20_address, head_node_address); 
    Address node21_address;  node21_address.netAddress=16'h0201;  node21_address.nodeAddress=16'h0201;
    let node21   <- mkMeshNodeL1(node21_address, head_node_address); 
    Address node22_address;  node22_address.netAddress=16'h0202;  node22_address.nodeAddress=16'h0202;
    let node22   <- mkMeshNodeL1(node22_address, head_node_address); 


	let noc_N0 <- mkMeshL2Noc0();
	let noc_N1 <- mkMeshL2Noc1();
	let noc_N2 <- mkMeshL2Noc2();




// LEFT RIGHT
    rule connect_Node00_to_Node01_L2R;
        let data01_L2R <- node00.get_value_to_right();
        node01.put_value_from_left(data01_L2R);
    endrule
    rule connect_Node01_to_Node00_R2L;
        let data00_R2L <- node01.get_value_to_left();
        node00.put_value_from_right(data00_R2L);
    endrule
    rule connect_Node01_to_Node02_L2R;
        let data02_L2R <- node01.get_value_to_right();
        node02.put_value_from_left(data02_L2R);
    endrule
    rule connect_Node02_to_Node01_R2L;
        let data01_R2L <- node02.get_value_to_left();
        node01.put_value_from_right(data01_R2L);
    endrule
    rule connect_Node10_to_Node11_L2R;
        let data11_L2R <- node10.get_value_to_right();
        node11.put_value_from_left(data11_L2R);
    endrule
    rule connect_Node11_to_Node10_R2L;
        let data10_R2L <- node11.get_value_to_left();
        node10.put_value_from_right(data10_R2L);
    endrule
    rule connect_Node11_to_Node12_L2R;
        let data12_L2R <- node11.get_value_to_right();
        node12.put_value_from_left(data12_L2R);
    endrule
    rule connect_Node12_to_Node11_R2L;
        let data11_R2L <- node12.get_value_to_left();
        node11.put_value_from_right(data11_R2L);
    endrule
    rule connect_Node20_to_Node21_L2R;
        let data21_L2R <- node20.get_value_to_right();
        node21.put_value_from_left(data21_L2R);
    endrule
    rule connect_Node21_to_Node20_R2L;
        let data20_R2L <- node21.get_value_to_left();
        node20.put_value_from_right(data20_R2L);
    endrule
    rule connect_Node21_to_Node22_L2R;
        let data22_L2R <- node21.get_value_to_right();
        node22.put_value_from_left(data22_L2R);
    endrule
    rule connect_Node22_to_Node21_R2L;
        let data21_R2L <- node22.get_value_to_left();
        node21.put_value_from_right(data21_R2L);
    endrule



// UP DOWN
    rule connect_Node00_to_Node10_T2B;
        let data10_T2B <- node00.get_value_to_down();
        node10.put_value_from_up(data10_T2B);
    endrule
    rule connect_Node10_to_Node00_B2T;
        let data00_B2T <- node10.get_value_to_up();
        node00.put_value_from_down(data00_B2T);
    endrule
    rule connect_Node01_to_Node11_T2B;
        let data11_T2B <- node01.get_value_to_down();
        node11.put_value_from_up(data11_T2B);
    endrule
    rule connect_Node11_to_Node01_B2T;
        let data01_B2T <- node11.get_value_to_up();
        node01.put_value_from_down(data01_B2T);
    endrule
    rule connect_Node02_to_Node12_T2B;
        let data12_T2B <- node02.get_value_to_down();
        node12.put_value_from_up(data12_T2B);
    endrule
    rule connect_Node12_to_Node02_B2T;
        let data02_B2T <- node12.get_value_to_up();
        node02.put_value_from_down(data02_B2T);
    endrule
    rule connect_Node10_to_Node20_T2B;
        let data20_T2B <- node10.get_value_to_down();
        node20.put_value_from_up(data20_T2B);
    endrule
    rule connect_Node20_to_Node10_B2T;
        let data10_B2T <- node20.get_value_to_up();
        node10.put_value_from_down(data10_B2T);
    endrule
    rule connect_Node11_to_Node21_T2B;
        let data21_T2B <- node11.get_value_to_down();
        node21.put_value_from_up(data21_T2B);
    endrule
    rule connect_Node21_to_Node11_B2T;
        let data11_B2T <- node21.get_value_to_up();
        node11.put_value_from_down(data11_B2T);
    endrule
    rule connect_Node12_to_Node22_T2B;
        let data22_T2B <- node12.get_value_to_down();
        node22.put_value_from_up(data22_T2B);
    endrule
    rule connect_Node22_to_Node12_B2T;
        let data12_B2T <- node22.get_value_to_up();
        node12.put_value_from_down(data12_B2T);
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

endpackage : MeshNocL1
