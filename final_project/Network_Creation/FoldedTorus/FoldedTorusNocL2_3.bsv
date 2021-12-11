package FoldedTorusNocL2_3;
// This package instantiates all the nodes and connects them in FoldedTorus topology

import Shared::*;
import Parameters::*;

import FIFO :: * ;
import Core :: * ;

import FoldedTorusRouterVC :: *;
import FoldedTorusNodeVC :: *;

import FoldedTorusRouterL2HeadVC :: *;
import FoldedTorusNodeL2HeadVC :: *;

interface IfcFoldedTorusNoc;
    // Put value is used to insert data to the router
    // Get Value is used to read the value from the router

    method Action put_value_from_l1(Flit data_from_L1);
    method ActionValue#(Flit) get_value_to_l1();

endinterface


(* synthesize *)
module mkFoldedTorusL2Noc3 (IfcFoldedTorusNoc);


	Address head_node_addr;  head_node_addr.netAddress=16'h0100;  head_node_addr.nodeAddress=16'h0203;

	Address node00_address;  node00_address.netAddress=16'h0100;  node00_address.nodeAddress=16'h0000;
	let node00   <- mkFoldedTorusNode(node00_address, head_node_addr, 2,3);
	Address node01_address;  node01_address.netAddress=16'h0100;  node01_address.nodeAddress=16'h0001;
	let node01   <- mkFoldedTorusNode(node01_address, head_node_addr, 2,3);
	Address node02_address;  node02_address.netAddress=16'h0100;  node02_address.nodeAddress=16'h0002;
	let node02   <- mkFoldedTorusNode(node02_address, head_node_addr, 2,3);
	Address node10_address;  node10_address.netAddress=16'h0100;  node10_address.nodeAddress=16'h0100;
	let node10   <- mkFoldedTorusNode(node10_address, head_node_addr, 2,3);
	Address node11_address;  node11_address.netAddress=16'h0100;  node11_address.nodeAddress=16'h0101;
	let node11   <- mkFoldedTorusNode(node11_address, head_node_addr, 2,3);
	Address node12_address;  node12_address.netAddress=16'h0100;  node12_address.nodeAddress=16'h0102;
	let node12   <- mkFoldedTorusNode(node12_address, head_node_addr, 2,3);
	Address node20_address;  node20_address.netAddress=16'h0100;  node20_address.nodeAddress=16'h0200;
	let node20   <- mkFoldedTorusNode(node20_address, head_node_addr, 2,3);
	Address node21_address;  node21_address.netAddress=16'h0100;  node21_address.nodeAddress=16'h0201;
	let node21   <- mkFoldedTorusL2HeadNode(node21_address, head_node_addr, 2,3);
	Address node22_address;  node22_address.netAddress=16'h0100;  node22_address.nodeAddress=16'h0202;
	let node22   <- mkFoldedTorusNode(node22_address, head_node_addr, 2,3);
	Address node30_address;  node30_address.netAddress=16'h0100;  node30_address.nodeAddress=16'h0300;
	let node30   <- mkFoldedTorusNode(node30_address, head_node_addr, 2,3);
	Address node31_address;  node31_address.netAddress=16'h0100;  node31_address.nodeAddress=16'h0301;
	let node31   <- mkFoldedTorusNode(node31_address, head_node_addr, 2,3);
	Address node32_address;  node32_address.netAddress=16'h0100;  node32_address.nodeAddress=16'h0302;
	let node32   <- mkFoldedTorusNode(node32_address, head_node_addr, 2,3);


    
	rule connect_Node00_to_Node01_L2R;
        let data00_L2R <- node00.get_value_to_right();
        node01.put_value_from_left(data00_L2R);
    endrule

	rule connect_Node01_to_Node02_L2R;
        let data01_L2R <- node01.get_value_to_right();
        node02.put_value_from_left(data01_L2R);
    endrule

	rule connect_Node02_to_Node00_L2R;
        let data02_L2R <- node02.get_value_to_right();
        node00.put_value_from_left(data02_L2R);
    endrule

	rule connect_Node10_to_Node11_L2R;
        let data10_L2R <- node10.get_value_to_right();
        node11.put_value_from_left(data10_L2R);
    endrule

	rule connect_Node11_to_Node12_L2R;
        let data11_L2R <- node11.get_value_to_right();
        node12.put_value_from_left(data11_L2R);
    endrule

	rule connect_Node12_to_Node10_L2R;
        let data12_L2R <- node12.get_value_to_right();
        node10.put_value_from_left(data12_L2R);
    endrule

	rule connect_Node20_to_Node21_L2R;
        let data20_L2R <- node20.get_value_to_right();
        node21.put_value_from_left(data20_L2R);
    endrule

	rule connect_Node21_to_Node22_L2R;
        let data21_L2R <- node21.get_value_to_right();
        node22.put_value_from_left(data21_L2R);
    endrule

	rule connect_Node22_to_Node20_L2R;
        let data22_L2R <- node22.get_value_to_right();
        node20.put_value_from_left(data22_L2R);
    endrule

	rule connect_Node30_to_Node31_L2R;
        let data30_L2R <- node30.get_value_to_right();
        node31.put_value_from_left(data30_L2R);
    endrule

	rule connect_Node31_to_Node32_L2R;
        let data31_L2R <- node31.get_value_to_right();
        node32.put_value_from_left(data31_L2R);
    endrule

	rule connect_Node32_to_Node30_L2R;
        let data32_L2R <- node32.get_value_to_right();
        node30.put_value_from_left(data32_L2R);
    endrule

	rule connect_Node00_to_Node10_U2D;
        let data00_U2D <- node00.get_value_to_down();
        node10.put_value_from_up(data00_U2D);
    endrule

    rule connect_Node00_to_Node10_U2D_dateline;
        let data00_U2D_dateline <- node00.get_value_to_down_dateline();
        node10.put_value_from_up_dateline(data00_U2D_dateline);
    endrule

	rule connect_Node10_to_Node20_U2D;
        let data10_U2D <- node10.get_value_to_down();
        node20.put_value_from_up(data10_U2D);
    endrule

    rule connect_Node10_to_Node20_U2D_dateline;
        let data10_U2D_dateline <- node10.get_value_to_down_dateline();
        node20.put_value_from_up_dateline(data10_U2D_dateline);
    endrule

	rule connect_Node20_to_Node30_U2D;
        let data20_U2D <- node20.get_value_to_down();
        node30.put_value_from_up(data20_U2D);
    endrule

    rule connect_Node20_to_Node30_U2D_dateline;
        let data20_U2D_dateline <- node20.get_value_to_down_dateline();
        node30.put_value_from_up_dateline(data20_U2D_dateline);
    endrule

	rule connect_Node30_to_Node00_U2D;
        let data30_U2D <- node30.get_value_to_down();
        node00.put_value_from_up(data30_U2D);
    endrule

    rule connect_Node30_to_Node00_U2D_dateline;
        let data30_U2D_dateline <- node30.get_value_to_down_dateline();
        node00.put_value_from_up_dateline(data30_U2D_dateline);
    endrule

	rule connect_Node01_to_Node11_U2D;
        let data01_U2D <- node01.get_value_to_down();
        node11.put_value_from_up(data01_U2D);
    endrule

    rule connect_Node01_to_Node11_U2D_dateline;
        let data01_U2D_dateline <- node01.get_value_to_down_dateline();
        node11.put_value_from_up_dateline(data01_U2D_dateline);
    endrule

	rule connect_Node11_to_Node21_U2D;
        let data11_U2D <- node11.get_value_to_down();
        node21.put_value_from_up(data11_U2D);
    endrule

    rule connect_Node11_to_Node21_U2D_dateline;
        let data11_U2D_dateline <- node11.get_value_to_down_dateline();
        node21.put_value_from_up_dateline(data11_U2D_dateline);
    endrule

	rule connect_Node21_to_Node31_U2D;
        let data21_U2D <- node21.get_value_to_down();
        node31.put_value_from_up(data21_U2D);
    endrule

    rule connect_Node21_to_Node31_U2D_dateline;
        let data21_U2D_dateline <- node21.get_value_to_down_dateline();
        node31.put_value_from_up_dateline(data21_U2D_dateline);
    endrule

	rule connect_Node31_to_Node01_U2D;
        let data31_U2D <- node31.get_value_to_down();
        node01.put_value_from_up(data31_U2D);
    endrule

    rule connect_Node31_to_Node01_U2D_dateline;
        let data31_U2D_dateline <- node31.get_value_to_down_dateline();
        node01.put_value_from_up_dateline(data31_U2D_dateline);
    endrule

	rule connect_Node02_to_Node12_U2D;
        let data02_U2D <- node02.get_value_to_down();
        node12.put_value_from_up(data02_U2D);
    endrule

    rule connect_Node02_to_Node12_U2D_dateline;
        let data02_U2D_dateline <- node02.get_value_to_down_dateline();
        node12.put_value_from_up_dateline(data02_U2D_dateline);
    endrule

	rule connect_Node12_to_Node22_U2D;
        let data12_U2D <- node12.get_value_to_down();
        node22.put_value_from_up(data12_U2D);
    endrule

    rule connect_Node12_to_Node22_U2D_dateline;
        let data12_U2D_dateline <- node12.get_value_to_down_dateline();
        node22.put_value_from_up_dateline(data12_U2D_dateline);
    endrule

	rule connect_Node22_to_Node32_U2D;
        let data22_U2D <- node22.get_value_to_down();
        node32.put_value_from_up(data22_U2D);
    endrule

    rule connect_Node22_to_Node32_U2D_dateline;
        let data22_U2D_dateline <- node22.get_value_to_down_dateline();
        node32.put_value_from_up_dateline(data22_U2D_dateline);
    endrule

	rule connect_Node32_to_Node02_U2D;
        let data32_U2D <- node32.get_value_to_down();
        node02.put_value_from_up(data32_U2D);
    endrule

    rule connect_Node32_to_Node02_U2D_dateline;
        let data32_U2D_dateline <- node32.get_value_to_down_dateline();
        node02.put_value_from_up_dateline(data32_U2D_dateline);
    endrule




	rule connect_Node01_to_Node00_R2L;
        let data01_R2L <- node01.get_value_to_left();
        node00.put_value_from_right(data01_R2L);
    endrule

	rule connect_Node02_to_Node01_R2L;
        let data02_R2L <- node02.get_value_to_left();
        node01.put_value_from_right(data02_R2L);
    endrule

	rule connect_Node00_to_Node02_R2L;
        let data00_R2L <- node00.get_value_to_left();
        node02.put_value_from_right(data00_R2L);
    endrule

	rule connect_Node11_to_Node10_R2L;
        let data11_R2L <- node11.get_value_to_left();
        node10.put_value_from_right(data11_R2L);
    endrule

	rule connect_Node12_to_Node11_R2L;
        let data12_R2L <- node12.get_value_to_left();
        node11.put_value_from_right(data12_R2L);
    endrule

	rule connect_Node10_to_Node12_R2L;
        let data10_R2L <- node10.get_value_to_left();
        node12.put_value_from_right(data10_R2L);
    endrule

	rule connect_Node21_to_Node20_R2L;
        let data21_R2L <- node21.get_value_to_left();
        node20.put_value_from_right(data21_R2L);
    endrule

	rule connect_Node22_to_Node21_R2L;
        let data22_R2L <- node22.get_value_to_left();
        node21.put_value_from_right(data22_R2L);
    endrule

	rule connect_Node20_to_Node22_R2L;
        let data20_R2L <- node20.get_value_to_left();
        node22.put_value_from_right(data20_R2L);
    endrule

	rule connect_Node31_to_Node30_R2L;
        let data31_R2L <- node31.get_value_to_left();
        node30.put_value_from_right(data31_R2L);
    endrule

	rule connect_Node32_to_Node31_R2L;
        let data32_R2L <- node32.get_value_to_left();
        node31.put_value_from_right(data32_R2L);
    endrule

	rule connect_Node30_to_Node32_R2L;
        let data30_R2L <- node30.get_value_to_left();
        node32.put_value_from_right(data30_R2L);
    endrule

	rule connect_Node10_to_Node00_D2U;
        let data10_D2U <- node10.get_value_to_up();
        node00.put_value_from_down(data10_D2U);
    endrule

    rule connect_Node10_to_Node00_D2U_dateline;
        let data10_D2U_dateline <- node10.get_value_to_up_dateline();
        node00.put_value_from_down_dateline(data10_D2U_dateline);
    endrule

	rule connect_Node20_to_Node10_D2U;
        let data20_D2U <- node20.get_value_to_up();
        node10.put_value_from_down(data20_D2U);
    endrule

    rule connect_Node20_to_Node10_D2U_dateline;
        let data20_D2U_dateline <- node20.get_value_to_up_dateline();
        node10.put_value_from_down_dateline(data20_D2U_dateline);
    endrule

	rule connect_Node30_to_Node20_D2U;
        let data30_D2U <- node30.get_value_to_up();
        node20.put_value_from_down(data30_D2U);
    endrule

    rule connect_Node30_to_Node20_D2U_dateline;
        let data30_D2U_dateline <- node30.get_value_to_up_dateline();
        node20.put_value_from_down_dateline(data30_D2U_dateline);
    endrule

	rule connect_Node00_to_Node30_D2U;
        let data00_D2U <- node00.get_value_to_up();
        node30.put_value_from_down(data00_D2U);
    endrule

    rule connect_Node00_to_Node30_D2U_dateline;
        let data00_D2U_dateline <- node00.get_value_to_up_dateline();
        node30.put_value_from_down_dateline(data00_D2U_dateline);
    endrule

	rule connect_Node11_to_Node01_D2U;
        let data11_D2U <- node11.get_value_to_up();
        node01.put_value_from_down(data11_D2U);
    endrule

    rule connect_Node11_to_Node01_D2U_dateline;
        let data11_D2U_dateline <- node11.get_value_to_up_dateline();
        node01.put_value_from_down_dateline(data11_D2U_dateline);
    endrule

	rule connect_Node21_to_Node11_D2U;
        let data21_D2U <- node21.get_value_to_up();
        node11.put_value_from_down(data21_D2U);
    endrule

    rule connect_Node21_to_Node11_D2U_dateline;
        let data21_D2U_dateline <- node21.get_value_to_up_dateline();
        node11.put_value_from_down_dateline(data21_D2U_dateline);
    endrule

	rule connect_Node31_to_Node21_D2U;
        let data31_D2U <- node31.get_value_to_up();
        node21.put_value_from_down(data31_D2U);
    endrule

    rule connect_Node31_to_Node21_D2U_dateline;
        let data31_D2U_dateline <- node31.get_value_to_up_dateline();
        node21.put_value_from_down_dateline(data31_D2U_dateline);
    endrule

	rule connect_Node01_to_Node31_D2U;
        let data01_D2U <- node01.get_value_to_up();
        node31.put_value_from_down(data01_D2U);
    endrule

    rule connect_Node01_to_Node31_D2U_dateline;
        let data01_D2U_dateline <- node01.get_value_to_up_dateline();
        node31.put_value_from_down_dateline(data01_D2U_dateline);
    endrule

	rule connect_Node12_to_Node02_D2U;
        let data12_D2U <- node12.get_value_to_up();
        node02.put_value_from_down(data12_D2U);
    endrule

    rule connect_Node12_to_Node02_D2U_dateline;
        let data12_D2U_dateline <- node12.get_value_to_up_dateline();
        node02.put_value_from_down_dateline(data12_D2U_dateline);
    endrule

	rule connect_Node22_to_Node12_D2U;
        let data22_D2U <- node22.get_value_to_up();
        node12.put_value_from_down(data22_D2U);
    endrule

    rule connect_Node22_to_Node12_D2U_dateline;
        let data22_D2U_dateline <- node22.get_value_to_up_dateline();
        node12.put_value_from_down_dateline(data22_D2U_dateline);
    endrule

	rule connect_Node32_to_Node22_D2U;
        let data32_D2U <- node32.get_value_to_up();
        node22.put_value_from_down(data32_D2U);
    endrule

    rule connect_Node32_to_Node22_D2U_dateline;
        let data32_D2U_dateline <- node32.get_value_to_up_dateline();
        node22.put_value_from_down_dateline(data32_D2U_dateline);
    endrule

	rule connect_Node02_to_Node32_D2U;
        let data02_D2U <- node02.get_value_to_up();
        node32.put_value_from_down(data02_D2U);
    endrule

    rule connect_Node02_to_Node32_D2U_dateline;
        let data02_D2U_dateline <- node02.get_value_to_up_dateline();
        node32.put_value_from_down_dateline(data02_D2U_dateline);
    endrule










    method Action put_value_from_l1(Flit data_from_L1);
        node21.put_value_from_l1(data_from_L1);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        Flit data=defaultValue;
        data <- node21.get_value_to_l1();
        return data;
    endmethod

endmodule

endpackage : FoldedTorusNocL2_3
