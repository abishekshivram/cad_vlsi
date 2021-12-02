count = 1
for i in range(1, 1+6):

    print(f"    rule connect_{i}{i+1}_L2R;")
    print(f"        let data{count}   <- router_core_{i}.GetValueRight();")
    print(f"        router_core_{i+1}.PutValuefromLeft(data{count});")
    print(f"    endrule")
    print()
    count += 1
    print(f"    rule connect_{i}{i+1}_R2L;")
    print(f"        let data{count}   <- router_core_{i+1}.GetValueLeft();")
    print(f"        router_core_{i}.PutValuefromRight(data{count});")
    print(f"    endrule")
    print("\n")
    count += 1
