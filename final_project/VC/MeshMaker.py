row = 3
col = 3
print("\n   // Connecting Left to Right nodes")
m = """    rule connect_Node{i}_to_Node{iplus1}_L2R;
        let data{i}{iplus1}_L2R <- node{i}.get_value_to_right();
        node{iplus1}.put_value_from_left(data{i}{iplus1}_L2R);
    endrule
"""
row_start = [0]
for i in range(1,row):
    ind = row_start[-1] + col
    row_start.append(ind)

for ind in row_start:
    for i in range(ind,ind+col-1):
        print(m.format(i=i,iplus1=i+1))

print("\n   // Connecting Right to Left nodes")
m = """    rule connect_Node{iplus1}_to_Node{i}_R2L;
        let data{iplus1}{i}_R2L <- node{iplus1}.get_value_to_left();
        node{i}.put_value_from_right(data{iplus1}{i}_R2L);
    endrule
"""
for ind in row_start:
    for i in range(ind,ind+col-1):
        print(m.format(i=i,iplus1=i+1))


print("\n   // Connecting Top to Bottom nodes")
m = """    rule connect_Node{i}_to_Node{ipluscol}_T2B;
        let data{i}{ipluscol}_T2B <- node{i}.get_value_to_bottom();
        node{ipluscol}.put_value_from_top(data{i}{ipluscol}_T2B);
    endrule
    """
for i in range(row-1):
    for j in range(col):
        print(m.format(i=row_start[i]+j,ipluscol=row_start[i+1]+j))


print("\n   // Connecting Bottom to Top nodes")
m = """    rule connect_Node{ipluscol}_to_Node{i}_B2T;
        let data{ipluscol}{i}_B2T <- node{ipluscol}.get_value_to_top();
        node{i}.put_value_from_bottom(data{ipluscol}{i}_B2T);
    endrule
    """
for i in range(row-1):
    for j in range(col):
        print(m.format(i=row_start[i]+j,ipluscol=row_start[i+1]+j))