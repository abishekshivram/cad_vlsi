from ctypes import string_at


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

g = """    method ActionValue#(Flit) get_valueVC{count}();
        $display("get_valueVC{count} method called at Router(Addr: %h)", my_addr);
         let temp{count} = vir_chnl_{count}.first();
         vir_chnl_{count}.deq();
        return temp{count};
    endmethod
"""


f = """    rule add_to_link_right{count}(counter == 3'b{count:0>3b});
        $display("add_to_link_right-> my_addr %d",my_addr.netAddress);    
        Flit data_right=defaultValue;
        data_right <- router_{string}.get_valueVC{count2}();
        output_link_right.enq(data_right);
    endrule
"""

e = """    rule add_to_link_left{count}(counter == 3'b{count:0>3b});
        $display("add_to_link_left{count} -> my_addr %d",my_addr.netAddress);    
        Flit data_left=defaultValue;
        data_left <- router_{string}.get_valueVC{count2}();
        output_link_left.enq(data_left);
    endrule
"""
h ="""    rule outputLinkCore{count}(counter == 3'b{count:0>3b});
        $display("here flit is put into core from router left vc{count2}; Arbiter count-%d", counter);      
        Flit data_core=defaultValue;
        data_core <- router_{string}.get_valueVC{count2}();
        core.put_flit(data_core);
    endrule
"""


j = """    rule add_to_link_down{count}(counter == 3'b{count:0>3b});
        $display("add_to_link_down-> my_addr %d",my_addr.netAddress);    
        Flit data_down = defaultValue;
        data_down <- router_{string}.get_valueVC{count2}();
        output_link_down.enq(data_down);
    endrule
"""

k = """    rule add_to_link_up{count}(counter == 3'b{count:0>3b});
        $display("add_to_link_up-> my_addr %d",my_addr.netAddress);    
        Flit data_up = defaultValue;
        data_up <- router_{string}.get_valueVC{count2}();
        output_link_up.enq(data_up);
    endrule
"""

method_mesh_return = """    method ActionValue#(Flit) get_value_to_{string}();
        let data_to_{string} = output_link_{string}.first();
        output_link_{string}.deq();
        return data_to_{string};
    endmethod
"""
method_mesh = """    method Action put_value_from_{string}(Flit data_{string});
        router_{string}.put_value(data_{string});
    endmethod
"""

zero_one = 0

for i in range(8):
    # print(d.format(element=i, element1=i+1))
    # print(g.format(count=i))
    one_two = [ "left", "right", "up", "down"]
    print(method_mesh.format(string=one_two[i%4]))
    # print("method Action put_value_from_{string}(Flit data_{string});".format(string=one_two[i%5]))
    # print("method ActionValue#(Flit) get_value_to_{string}();".format(string=one_two[i%5]))
    # one_two, VC_list = ["right", "up", "down", "core"], [3, 4]
    # one_two, VC_list = ["up", "down", "core", "left"], [5,6]
    # one_two, VC_list = ["down", "core", "left", "right"], [7,8]
    # print(j.format(count=i, string=one_two[i%4], count2=VC_list[i//4]))
    #zero_one = 1 if zero_one==0 else 0
    # print()
    
