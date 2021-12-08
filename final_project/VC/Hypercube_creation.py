




hi = """    rule connect_Node{id1}_to_Node{id2}_{which};
        let data{id1}_{id2}_{which} <- node{id1}.get_value_to_{which}();
        node{id2}.put_value_from_{which}(data{id1}_{id2}_{which});
    endrule
"""


ways = ["lsb","mid","msb"]
aes = [1,2,4]
for i in range(8):
    # id1 = f"{i:0>3b}"
    for j in range(3):
        id2 = i ^ aes[j]
        # id2 = f"{id2:0>3b}"
        #id2[-1-j] = "0" if id2[-i-1]=="1" else "1"
        print(hi.format(id1=i,id2=id2,which=ways[j]))