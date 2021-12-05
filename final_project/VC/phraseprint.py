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
for i in range(6):
    print(d.format(element=i, element1=i+1))
    print()
    
