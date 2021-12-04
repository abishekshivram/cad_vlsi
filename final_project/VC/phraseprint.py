count = 1

a = """    method ActionValue#(int) GetValueVC{element}();
        let temp{element} = VC{element}.first;
        VC{element}.deq;
        return temp{element}
    endmethod"""

for i in range(1, 1+6):
    print(a.format(element=i))
    print()
    
