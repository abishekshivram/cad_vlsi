from ctypes import string_at


count = 1

a = """    method ActionValue#(int) GetValueVC{element}();
        let temp{element} = VC{element}.first;
        VC{element}.deq;
        return temp{element}
    endmethod"""

b = "let node{element}   <- mkChainNode(3'b{element1:0>3b});"

c = """    rule connect_Node{element}_to_Node{element1}_L2R;
        let data{element}{element1}_L2R <- node{element}.get_value_to_right();
        node{element1}.put_value_from_left(data{element}{element1}_L2R);
    endrule"""

c1 = """    rule connect_Node{element}_to_Node{element1}_L2R_dateline;
        let data{element}{element1}_L2R <- node{element}.get_value_to_right_dateline();
        node{element1}.put_value_from_left_dateline(data{element}{element1}_L2R);
    endrule"""

d = """    rule connect_Node{element1}_to_Node{element}_R2L;
        let data{element1}{element}_R2L <- node{element1}.get_value_to_left();
        node{element}.put_value_from_right(data{element1}{element}_R2L);
    endrule"""

d1 = """    rule connect_Node{element1}_to_Node{element}_R2L_dateline;
        let data{element1}{element}_R2L <- node{element1}.get_value_to_left_dateline();
        node{element}.put_value_from_right_dateline(data{element1}{element}_R2L);
    endrule"""

# for element in range(6):
#     print(c1.format(element = element, element1 = element+1))

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

hypercube_il_to_vc = """    else if (flit.currentDstAddress.nodeAddress == {count}) begin
        vir_chnl_{count2}.enq(flit);
    end"""

hypercube_vc_to_core = """    rule outputLinkCore{count2}0(my_addr.nodeAddress == {count2} && counter_router==3'b000);
        $display("here flit is put into core from router left vc{count2plus1}; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC{count2plus1}();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore{count2}1(my_addr.nodeAddress == {count2} && counter_router==3'b001);
        $display("here flit is put into core from router left vc{count2plus1}; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC{count2plus1}();
        core.put_flit(data_core);
    endrule
    rule outputLinkCore{count2}2(my_addr.nodeAddress == {count2} && counter_router==3'b010);
        $display("here flit is put into core from router left vc{count2plus1}; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC{count2plus1}();
        core.put_flit(data_core);
    endrule
"""

for addr in range(8):
    print(hypercube_vc_to_core.format(count2=addr,count2plus1 = addr+1))

hyper = """    rule send_from_vc{vc}_ie_to_{which}{router}{addr} (my_addr.nodeAddress == {addr} && counter_router == 3'b{binary_route} {sentence});
        Flit data=defaultValue;
        data <- router_{router}.get_valueVC{vc}();
        output_link_{which}.enq(data);
    endrule
"""
# which (lsb, msb, mid)  

zero_one = 0

address_wise = [[]]*8

# ways = ["lsb", "mid", "msb"]
# router = ["core", "lsb", "mid", "msb"]
# print_count = 0
# which_way = None
# for addr in range(8):
#     for rout in range(4):
    
#         count_of_ways = [0,0,0]
#         for vc in range(1, 1+8):
#             if (addr != (vc-1)):
#                 binary_addr = f"{addr:0>3b}"
#                 binary_vc = f"{vc-1:0>3b}"
#                 binary_route = f"{rout:0>3b}"
#                 for bit in range(3):
#                     if(binary_addr[-1-bit] != binary_vc[-1-bit]):
#                         which_way = ways[bit]
#                         count_of_ways[bit] += 1
#                         break
#                 if(bit == 0):
#                     count2val = (count_of_ways[bit] - 1) % 4
#                     sentenceval = "&& counter_{which}==2'b{count2:0>2b}".format(which=which_way, count2=count2val)
#                 elif(bit == 1):
#                     count2val = (count_of_ways[bit] - 1) % 2
#                     sentenceval = "&& counter_{which}==1'b{count2:0>1b}".format(which=which_way, count2=count2val)
#                 else:
#                     sentenceval = ""
#                 # print_count +=1
#                 # print(print_count)
#                 # address_wise[addr].append(addr)
#                 print(hyper.format(vc=vc, which=which_way, addr=addr,router=router[rout],binary_route=binary_route, sentence=sentenceval))

# for  i in (address_wise)    :
#     print(i)
# for i in address_wise:
#     for j in i:
#         print(j)


# for i in range(8):
#     print(hypercube_vc_to_core.format(count2=i, count2plus1=i+1))


#for i in range(8):
    # print(d.format(element=i, element1=i+1))
    # print(g.format(count=i))
    # one_two = [ "left", "right", "up", "down"]
    # print(method_mesh.format(string=one_two[i%4]))
    # print("method Action put_value_from_{string}(Flit data_{string});".format(string=one_two[i%5]))
    # print("method ActionValue#(Flit) get_value_to_{string}();".format(string=one_two[i%5]))
    # one_two, VC_list = ["right", "up", "down", "core"], [3, 4]
    # one_two, VC_list = ["up", "down", "core", "left"], [5,6]
    # one_two, VC_list = ["down", "core", "left", "right"], [7,8]
    # print(j.format(count=i, string=one_two[i%4], count2=VC_list[i//4]))
    #zero_one = 1 if zero_one==0 else 0
    # print()
    
g ="""     method ActionValue#(Flit) get_value_to_{which}();
        let data_to_{which} = output_link_{which}.first();
        output_link_{which}.deq();
        return data_to_{which};
    endmethod"""
gg = """    method Action put_value_from_{which}(Flit data_{which});
        router_{which}.put_value(data_{which});
    endmethod
"""
# which = ["lsb","mid","msb"]
# for i in range(3):
#     print(gg.format(which=which[i]))