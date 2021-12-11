package FoldedTorusNocL2_4;
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
module mkFoldedTorusL2Noc4 (IfcFoldedTorusNoc);


	Address head_node_addr;  head_node_addr.netAddress=16'h0101;  head_node_addr.nodeAddress=16'h0104;

	Address node00_address;  node00_address.netAddress=16'h0101;  node00_address.nodeAddress=16'h0000;
	let node00   <- mkFoldedTorusNode(node00_address, head_node_addr, 3,2);
	Address node01_address;  node01_address.netAddress=16'h0101;  node01_address.nodeAddress=16'h0001;
	let node01   <- mkFoldedTorusNode(node01_address, head_node_addr, 3,2);
	Address node02_address;  node02_address.netAddress=16'h0101;  node02_address.nodeAddress=16'h0002;
	let node02   <- mkFoldedTorusNode(node02_address, head_node_addr, 3,2);
	Address node03_address;  node03_address.netAddress=16'h0101;  node03_address.nodeAddress=16'h0003;
	let node03   <- mkFoldedTorusNode(node03_address, head_node_addr, 3,2);
	Address node10_address;  node10_address.netAddress=16'h0101;  node10_address.nodeAddress=16'h0100;
	let node10   <- mkFoldedTorusNode(node10_address, head_node_addr, 3,2);
	Address node11_address;  node11_address.netAddress=16'h0101;  node11_address.nodeAddress=16'h0101;
	let node11   <- mkFoldedTorusNode(node11_address, head_node_addr, 3,2);
	Address node12_address;  node12_address.netAddress=16'h0101;  node12_address.nodeAddress=16'h0102;
	let node12   <- mkFoldedTorusL2HeadNode(node12_address, head_node_addr, 3,2);
	Address node13_address;  node13_address.netAddress=16'h0101;  node13_address.nodeAddress=16'h0103;
	let node13   <- mkFoldedTorusNode(node13_address, head_node_addr, 3,2);
	Address node20_address;  node20_address.netAddress=16'h0101;  node20_address.nodeAddress=16'h0200;
	let node20   <- mkFoldedTorusNode(node20_address, head_node_addr, 3,2);
	Address node21_address;  node21_address.netAddress=16'h0101;  node21_address.nodeAddress=16'h0201;
	let node21   <- mkFoldedTorusNode(node21_address, head_node_addr, 3,2);
	Address node22_address;  node22_address.netAddress=16'h0101;  node22_address.nodeAddress=16'h0202;
	let node22   <- mkFoldedTorusNode(node22_address, head_node_addr, 3,2);
	Address node23_address;  node23_address.netAddress=16'h0101;  node23_address.nodeAddress=16'h0203;
	let node23   <- mkFoldedTorusNode(node23_address, head_node_addr, 3,2);


    
	rule connect_Node00_to_Node01_L2R;
        let data00_L2R <- node00.get_value_to_right();
        node01.put_value_from_left(data00_L2R);
    endrule

	rule connect_Node01_to_Node02_L2R;
        let data01_L2R <- node01.get_value_to_right();
        node02.put_value_from_left(data01_L2R);
    endrule

	rule connect_Node02_to_Node03_L2R;
        let data02_L2R <- node02.get_value_to_right();
        node03.put_value_from_left(data02_L2R);
    endrule

	rule connect_Node03_to_Node00_L2R;
        let data03_L2R <- node03.get_value_to_right();
        node00.put_value_from_left(data03_L2R);
    endrule

	rule connect_Node10_to_Node11_L2R;
        let data10_L2R <- node10.get_value_to_right();
        node11.put_value_from_left(data10_L2R);
    endrule

	rule connect_Node11_to_Node12_L2R;
        let data11_L2R <- node11.get_value_to_right();
        node12.put_value_from_left(data11_L2R);
    endrule

	rule connect_Node12_to_Node13_L2R;
        let data12_L2R <- node12.get_value_to_right();
        node13.put_value_from_left(data12_L2R);
    endrule

	rule connect_Node13_to_Node10_L2R;
        let data13_L2R <- node13.get_value_to_right();
        node10.put_value_from_left(data13_L2R);
    endrule

	rule connect_Node20_to_Node21_L2R;
        let data20_L2R <- node20.get_value_to_right();
        node21.put_value_from_left(data20_L2R);
    endrule

	rule connect_Node21_to_Node22_L2R;
        let data21_L2R <- node21.get_value_to_right();
        node22.put_value_from_left(data21_L2R);
    endrule

	rule connect_Node22_to_Node23_L2R;
        let data22_L2R <- node22.get_value_to_right();
        node23.put_value_from_left(data22_L2R);
    endrule

	rule connect_Node23_to_Node20_L2R;
        let data23_L2R <- node23.get_value_to_right();
        node20.put_value_from_left(data23_L2R);
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

	rule connect_Node20_to_Node00_U2D;
        let data20_U2D <- node20.get_value_to_down();
        node00.put_value_from_up(data20_U2D);
    endrule

    rule connect_Node20_to_Node00_U2D_dateline;
        let data20_U2D_dateline <- node20.get_value_to_down_dateline();
        node00.put_value_from_up_dateline(data20_U2D_dateline);
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

	rule connect_Node21_to_Node01_U2D;
        let data21_U2D <- node21.get_value_to_down();
        node01.put_value_from_up(data21_U2D);
    endrule

    rule connect_Node21_to_Node01_U2D_dateline;
        let data21_U2D_dateline <- node21.get_value_to_down_dateline();
        node01.put_value_from_up_dateline(data21_U2D_dateline);
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

	rule connect_Node22_to_Node02_U2D;
        let data22_U2D <- node22.get_value_to_down();
        node02.put_value_from_up(data22_U2D);
    endrule

    rule connect_Node22_to_Node02_U2D_dateline;
        let data22_U2D_dateline <- node22.get_value_to_down_dateline();
        node02.put_value_from_up_dateline(data22_U2D_dateline);
    endrule

	rule connect_Node03_to_Node13_U2D;
        let data03_U2D <- node03.get_value_to_down();
        node13.put_value_from_up(data03_U2D);
    endrule

    rule connect_Node03_to_Node13_U2D_dateline;
        let data03_U2D_dateline <- node03.get_value_to_down_dateline();
        node13.put_value_from_up_dateline(data03_U2D_dateline);
    endrule

	rule connect_Node13_to_Node23_U2D;
        let data13_U2D <- node13.get_value_to_down();
        node23.put_value_from_up(data13_U2D);
    endrule

    rule connect_Node13_to_Node23_U2D_dateline;
        let data13_U2D_dateline <- node13.get_value_to_down_dateline();
        node23.put_value_from_up_dateline(data13_U2D_dateline);
    endrule

	rule connect_Node23_to_Node03_U2D;
        let data23_U2D <- node23.get_value_to_down();
        node03.put_value_from_up(data23_U2D);
    endrule

    rule connect_Node23_to_Node03_U2D_dateline;
        let data23_U2D_dateline <- node23.get_value_to_down_dateline();
        node03.put_value_from_up_dateline(data23_U2D_dateline);
    endrule




	rule connect_Node01_to_Node00_R2L;
        let data01_R2L <- node01.get_value_to_left();
        node00.put_value_from_right(data01_R2L);
    endrule

	rule connect_Node02_to_Node01_R2L;
        let data02_R2L <- node02.get_value_to_left();
        node01.put_value_from_right(data02_R2L);
    endrule

	rule connect_Node03_to_Node02_R2L;
        let data03_R2L <- node03.get_value_to_left();
        node02.put_value_from_right(data03_R2L);
    endrule

	rule connect_Node00_to_Node03_R2L;
        let data00_R2L <- node00.get_value_to_left();
        node03.put_value_from_right(data00_R2L);
    endrule

	rule connect_Node11_to_Node10_R2L;
        let data11_R2L <- node11.get_value_to_left();
        node10.put_value_from_right(data11_R2L);
    endrule

	rule connect_Node12_to_Node11_R2L;
        let data12_R2L <- node12.get_value_to_left();
        node11.put_value_from_right(data12_R2L);
    endrule

	rule connect_Node13_to_Node12_R2L;
        let data13_R2L <- node13.get_value_to_left();
        node12.put_value_from_right(data13_R2L);
    endrule

	rule connect_Node10_to_Node13_R2L;
        let data10_R2L <- node10.get_value_to_left();
        node13.put_value_from_right(data10_R2L);
    endrule

	rule connect_Node21_to_Node20_R2L;
        let data21_R2L <- node21.get_value_to_left();
        node20.put_value_from_right(data21_R2L);
    endrule

	rule connect_Node22_to_Node21_R2L;
        let data22_R2L <- node22.get_value_to_left();
        node21.put_value_from_right(data22_R2L);
    endrule

	rule connect_Node23_to_Node22_R2L;
        let data23_R2L <- node23.get_value_to_left();
        node22.put_value_from_right(data23_R2L);
    endrule

	rule connect_Node20_to_Node23_R2L;
        let data20_R2L <- node20.get_value_to_left();
        node23.put_value_from_right(data20_R2L);
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

	rule connect_Node00_to_Node20_D2U;
        let data00_D2U <- node00.get_value_to_up();
        node20.put_value_from_down(data00_D2U);
    endrule

    rule connect_Node00_to_Node20_D2U_dateline;
        let data00_D2U_dateline <- node00.get_value_to_up_dateline();
        node20.put_value_from_down_dateline(data00_D2U_dateline);
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

	rule connect_Node01_to_Node21_D2U;
        let data01_D2U <- node01.get_value_to_up();
        node21.put_value_from_down(data01_D2U);
    endrule

    rule connect_Node01_to_Node21_D2U_dateline;
        let data01_D2U_dateline <- node01.get_value_to_up_dateline();
        node21.put_value_from_down_dateline(data01_D2U_dateline);
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

	rule connect_Node02_to_Node22_D2U;
        let data02_D2U <- node02.get_value_to_up();
        node22.put_value_from_down(data02_D2U);
    endrule

    rule connect_Node02_to_Node22_D2U_dateline;
        let data02_D2U_dateline <- node02.get_value_to_up_dateline();
        node22.put_value_from_down_dateline(data02_D2U_dateline);
    endrule

	rule connect_Node13_to_Node03_D2U;
        let data13_D2U <- node13.get_value_to_up();
        node03.put_value_from_down(data13_D2U);
    endrule

    rule connect_Node13_to_Node03_D2U_dateline;
        let data13_D2U_dateline <- node13.get_value_to_up_dateline();
        node03.put_value_from_down_dateline(data13_D2U_dateline);
    endrule

	rule connect_Node23_to_Node13_D2U;
        let data23_D2U <- node23.get_value_to_up();
        node13.put_value_from_down(data23_D2U);
    endrule

    rule connect_Node23_to_Node13_D2U_dateline;
        let data23_D2U_dateline <- node23.get_value_to_up_dateline();
        node13.put_value_from_down_dateline(data23_D2U_dateline);
    endrule

	rule connect_Node03_to_Node23_D2U;
        let data03_D2U <- node03.get_value_to_up();
        node23.put_value_from_down(data03_D2U);
    endrule

    rule connect_Node03_to_Node23_D2U_dateline;
        let data03_D2U_dateline <- node03.get_value_to_up_dateline();
        node23.put_value_from_down_dateline(data03_D2U_dateline);
    endrule










    method Action put_value_from_l1(Flit data_from_L1);
        node12.put_value_from_l1(data_from_L1);
    endmethod

    method ActionValue#(Flit) get_value_to_l1();
        Flit data=defaultValue;
        data <- node12.get_value_to_l1();
        return data;
    endmethod

endmodule

endpackage : FoldedTorusNocL2_4
