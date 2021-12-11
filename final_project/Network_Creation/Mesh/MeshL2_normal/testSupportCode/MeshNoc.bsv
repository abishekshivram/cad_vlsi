package MeshNoc;
// This package instantiates all the nodes and connects them

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import MeshRouterVC :: *;
import MeshNodeVC :: *;

(* synthesize *)

module mkMeshNoc(Empty);

    // MAKING MESH TOPOLOGY WITH ROWS: 3 AND COLUMNS: 3
    // MAKING NODES
    Address node00_address;  node00_address.netAddress=0;  node00_address.nodeAddress=16'h0000;
    Address node01_address;  node01_address.netAddress=0;  node01_address.nodeAddress=16'h0001;
    Address node02_address;  node02_address.netAddress=0;  node02_address.nodeAddress=16'h0002;
    Address node10_address;  node10_address.netAddress=0;  node10_address.nodeAddress=16'h0100;
    Address node11_address;  node11_address.netAddress=0;  node11_address.nodeAddress=16'h0101;
    Address node12_address;  node12_address.netAddress=0;  node12_address.nodeAddress=16'h0102;
    Address node20_address;  node20_address.netAddress=0;  node20_address.nodeAddress=16'h0200;
    Address node21_address;  node21_address.netAddress=0;  node21_address.nodeAddress=16'h0201;
    Address node22_address;  node22_address.netAddress=0;  node22_address.nodeAddress=16'h0202;
    
    let node00   <- mkMeshNode(node00_address, node11_address);
    let node01   <- mkMeshNode(node01_address, node11_address);
    let node02   <- mkMeshNode(node02_address, node11_address);
    let node10   <- mkMeshNode(node10_address, node11_address);
    let node11   <- mkMeshNode(node11_address, node11_address);
    let node12   <- mkMeshNode(node12_address, node11_address);
    let node20   <- mkMeshNode(node20_address, node11_address);
    let node21   <- mkMeshNode(node21_address, node11_address);
    let node22   <- mkMeshNode(node22_address, node11_address);


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




endmodule

endpackage: MeshNoc
