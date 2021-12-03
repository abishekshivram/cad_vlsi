package Noc

import Core     :: * ;
import Router   :: * ;



module mkNOC(Empty);

    // Since 3 bits are used for ID
    let router_core_1 <- mkChainRouter(3'b000, 0);
    let router_core_2 <- mkChainRouter(3'b001, 0);
    let router_core_3 <- mkChainRouter(3'b010, 0);
    let router_core_4 <- mkChainRouter(3'b011, 0);
    let router_core_5 <- mkChainRouter(3'b100, 0);
    let router_core_6 <- mkChainRouter(3'b101, 0);

    // We have six routers along with its associated cores (random no generators)
    // Each router has 4 IO (get, put on left, right)
    rule connect_12_L2R;
        let data1   <- router_core_1.GetValueRight();
        router_core_2.PutValuefromLeft(data1);
    endrule

    rule connect_12_R2L;
        let data2   <- router_core_2.GetValueLeft();
        router_core_1.PutValuefromRight(data2);
    endrule


    rule connect_23_L2R;
        let data3   <- router_core_2.GetValueRight();
        router_core_3.PutValuefromLeft(data3);
    endrule

    rule connect_23_R2L;
        let data4   <- router_core_3.GetValueLeft();
        router_core_2.PutValuefromRight(data4);
    endrule


    rule connect_34_L2R;
        let data5   <- router_core_3.GetValueRight();
        router_core_4.PutValuefromLeft(data5);
    endrule

    rule connect_34_R2L;
        let data6   <- router_core_4.GetValueLeft();
        router_core_3.PutValuefromRight(data6);
    endrule


    rule connect_45_L2R;
        let data7   <- router_core_4.GetValueRight();
        router_core_5.PutValuefromLeft(data7);
    endrule

    rule connect_45_R2L;
        let data8   <- router_core_5.GetValueLeft();
        router_core_4.PutValuefromRight(data8);
    endrule


    rule connect_56_L2R;
        let data9   <- router_core_5.GetValueRight();
        router_core_6.PutValuefromLeft(data9);
    endrule

    rule connect_56_R2L;
        let data10   <- router_core_6.GetValueLeft();
        router_core_5.PutValuefromRight(data10);
    endrule


    rule connect_67_L2R;
        let data11   <- router_core_6.GetValueRight();
        router_core_7.PutValuefromLeft(data11);
    endrule

    rule connect_67_R2L;
        let data12   <- router_core_7.GetValueLeft();
        router_core_6.PutValuefromRight(data12);
    endrule


endmodule


endpackage : Noc
