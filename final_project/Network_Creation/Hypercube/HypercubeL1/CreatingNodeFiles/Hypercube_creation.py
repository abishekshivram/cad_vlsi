from string import Template
from math import log2


### START - ONETIME

hypercube_il_to_vc = """    else if (flit.currentDstAddress.nodeAddress == {count}) begin
        vir_chnl_{count2}.enq(flit);
    end"""


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

### END - ONETIME


### START - NOC

hi = """    rule connect_Node{id1}_to_Node{id2}_{which};
        let data{id1}_{id2}_{which} <- node{id1}.get_value_to_{which}();
        node{id2}.put_value_from_{which}(data{id1}_{id2}_{which});
    endrule
"""


# ways = ["lsb","mid","msb"]
# aes = [1,2,4]
# for i in range(8):
#     # id1 = f"{i:0>3b}"
#     for j in range(3):
#         id2 = i ^ aes[j]
#         # id2 = f"{id2:0>3b}"
#         #id2[-1-j] = "0" if id2[-i-1]=="1" else "1"
#         print(hi.format(id1=i,id2=id2,which=ways[j]))

### END - NOC






hypercube_vc_to_core = """    rule outputLinkl2_{count2}0(counter_router==2'b00);
        $display("here flit is put into core from router left vc{count2plus1}; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_lsb.get_valueVC{count2plus1}();
        output_link_l2.enq(data_core);
    endrule
    rule outputLinkl2_{count2}1(counter_router==2'b01);
        $display("here flit is put into core from router left vc{count2plus1}; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_mid.get_valueVC{count2plus1}();
        output_link_l2.enq(data_core);
    endrule
    rule outputLinkl2_{count2}2(counter_router==2'b10);
        $display("here flit is put into core from router left vc{count2plus1}; Arbiter count-%d", counter_router);      
        Flit data_core=defaultValue;
        data_core <- router_msb.get_valueVC{count2plus1}();
        output_link_l2.enq(data_core);
    endrule
"""

hyper = """    rule send_from_vc{vc}_ie_to_{which}{router}{addr} (counter_router == 2'b{binary_route} {sentence});
        Flit data=defaultValue;
        data <- router_{router}.get_valueVC{vc}();
        output_link_{which}.enq(data);
    endrule
"""

for address in range(8):
    #NODE ID
    d ={}
    # address = 0


    # DESTINATION REACHED
    dest_reached = []
    # for addr in range(8):
    dest_reached.append((hypercube_vc_to_core.format(count2=address,count2plus1 = address+1)))

    # RULES
    zero_one = 0

    address_wise = [[]]*8
    rules = []

    ways = ["lsb", "mid", "msb"]
    router = ["l2", "lsb", "mid", "msb"]
    print_count = 0
    which_way = None
    # for addr in range(8):
    for rout in range(4):

        count_of_ways = [0,0,0]
        for vc in range(1, 1+8):
            if (address != (vc-1)):
                binary_addr = f"{address:0>3b}"
                binary_vc = f"{vc-1:0>3b}"
                binary_route = f"{rout:0>2b}"
                for bit in range(3):
                    if(binary_addr[-1-bit] != binary_vc[-1-bit]):
                        which_way = ways[bit]
                        count_of_ways[bit] += 1
                        break
                if(bit == 0):
                    count2val = (count_of_ways[bit] - 1) % 4
                    sentenceval = "&& counter_{which}==2'b{count2:0>2b}".format(which=which_way, count2=count2val)
                elif(bit == 1):
                    count2val = (count_of_ways[bit] - 1) % 2
                    sentenceval = "&& counter_{which}==1'b{count2:0>1b}".format(which=which_way, count2=count2val)
                else:
                    sentenceval = ""
                # print_count +=1
                # print(print_count)
                # address_wise[addr].append(addr)
                rules.append((hyper.format(vc=vc, which=which_way, addr=address,router=router[rout],binary_route=binary_route, sentence=sentenceval)))

    d['NODE_ID'] = f"{address}VC"
    d['RULES_CONNECTING_OTHER_VC_TO_OUTPUT_LINK'] = ''.join(rules)
    d['DESTINATION_REACHED'] = ''.join(dest_reached)
    d['display'] = "$display"

    with open('Hypercube_template.txt', 'r') as f:
        src = Template(f.read())
        result = src.substitute(d)

        output_file_name = f"HypercubeL1Node{address}VC.bsv"
        with open(output_file_name, 'w') as op:
            op.write(result)
