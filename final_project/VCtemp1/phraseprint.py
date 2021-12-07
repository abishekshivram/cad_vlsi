count = 1

a = """    method ActionValue#(int) GetValueVC{element}();
        let temp{element} = VC{element}.first;
        VC{element}.deq;
        return temp{element}
    endmethod"""

b = "let node{element}   <- mkChainNode(3'b{element1:0>3b});"

c = """    rule connect_Node{element}_to_Node{element1}_L2R;
        let data{element}{element1}_L2R <- node{element}.GetValuetoRight();
        node{element1}.PutValuefromLeft(data{element}{element1}_L2R);
    endrule"""

d = """    rule connect_Node{element1}_to_Node{element}_R2L;
        let data{element1}{element}_R2L <- node{element1}.GetValuetoLeft();
        node{element}.PutValuefromRight(data{element1}{element}_R2L);
    endrule"""

e = """ rule add_to_link_left;
        $display("add_to_link_left");
        Flit data_left=defaultValue;

        $display("Arbiter count-%d",counter);
        case(counter) matches
            2'b00:  data_left <- router_right.get_valueVC3();
            2'b01:  data_left <- router_core.get_valueVC3();
            2'b10:  data_left <- router_right.get_valueVC4();
            2'b11:  data_left <- router_core.get_valueVC4();
        endcase
        output_link_left.enq(data_left);
    endrule
"""

f = """    rule add_to_link_right{count}(counter == 2'b{count:>2b});
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_{string}.get_valueVC{count2}();
        output_link_right.enq(data_right);
    endrule
"""

e = """    rule add_to_link_left{count}(counter == 2'b{count:0>2b});
        $display("add_to_link_left{count} -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_{string}.get_valueVC{count2}();
        output_link_left.enq(data_left);
    endrule
"""
for i in range(4):
    #print(d.format(element=i, element1=i+1))
    #core_left = "core" if i%2==0 else "left"
    right_core = "right" if i%2==0 else "core"
    print(e.format(count=i, string=right_core, count2=i//2+3))
    print()
    
