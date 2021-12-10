row = 3
col = 3
print("\n   // Connecting Left to Right nodes")
m = """\trule connect_Node{i}_to_Node{iplus1}_L2R;
        let data{i}{iplus1}_L2R <- node{i}.get_value_to_right();
        node{iplus1}.put_value_from_left(data{i}{iplus1}_L2R);
    endrule
"""
row_start = [0]
for i in range(1,row):
    ind = row_start[-1] + col
    row_start.append(ind)

for i in range(len(row_start)):
    for j in range(col):
        print(m.format(i=row_start[i]+j,iplus1=row_start[i]+(j+1)%col))

print("\n   // Connecting Right to Left nodes")
m = """    rule connect_Node{iplus1}_to_Node{i}_R2L;
        let data{iplus1}{i}_R2L <- node{iplus1}.get_value_to_left();
        node{i}.put_value_from_right(data{iplus1}{i}_R2L);
    endrule
"""
for i in range(len(row_start)):
    for j in range(col):
        print(m.format(i=row_start[i]+j,iplus1=row_start[i]+(j+1)%col))


print("\n   // Connecting Top to Bottom nodes")
m = """    rule connect_Node{i}_to_Node{ipluscol}_T2B;
        let data{i}{ipluscol}_T2B <- node{i}.get_value_to_down();
        node{ipluscol}.put_value_from_up(data{i}{ipluscol}_T2B);
    endrule
    """
for i in range(row):
    for j in range(col):
        print(m.format(i=(row_start[i]+j),ipluscol=(row_start[(i+1)%row]+j)))

print("\n   // Connecting Top to Bottom nodes following dateline")
m = """    rule connect_Node{i}_to_Node{ipluscol}_T2B_dateline;
        let data{i}{ipluscol}_T2B_dateline <- node{i}.get_value_to_down_dateline();
        node{ipluscol}.put_value_from_up_dateline(data{i}{ipluscol}_T2B_dateline);
    endrule
    """
for i in range(row):
    for j in range(col):
        print(m.format(i=(row_start[i]+j),ipluscol=(row_start[(i+1)%row]+j)))


print("\n   // Connecting Bottom to Top nodes")
m = """    rule connect_Node{ipluscol}_to_Node{i}_B2T;
        let data{ipluscol}{i}_B2T <- node{ipluscol}.get_value_to_up();
        node{i}.put_value_from_down(data{ipluscol}{i}_B2T);
    endrule
    """
for i in range(row):
    for j in range(col):
        print(m.format(i=(row_start[i]+j),ipluscol=(row_start[(i+1)%row]+j)))

print("\n   // Connecting Bottom to Top nodes following dateline")
m = """    rule connect_Node{ipluscol}_to_Node{i}_B2T_dateline;
        let data{ipluscol}{i}_B2T_dateline <- node{ipluscol}.get_value_to_up_dateline();
        node{i}.put_value_from_down_dateline(data{ipluscol}{i}_B2T_dateline);
    endrule
    """
for i in range(row):
    for j in range(col):
        print(m.format(i=(row_start[i]+j),ipluscol=(row_start[(i+1)%row]+j)))