import re
from network_layout import NetworkLayout 

from hypercube_router import *

name="L1_N22_H_1000"
name1="L1_N21_H_1000"
id1="11"
id2="1"

#l1_find_next
#l2_find_next
#find_next




nl=NetworkLayout("/home/lloyd/CAD-Assign/github-a1/cad_vlsi/assignment1/output.txt")

#nl=NetworkLayout("/home/lloyd/CAD-Assign/github-a1/cad_vlsi/assignment1/IP-Backup/op/L1H8L2H8.txt")

newnd=nl.name_node_dict["L2_N0_H_111"]
#newnd=is_node_in_neighbour_list(nd,"L1_N0_C_10")

i=10
while(i>=0):
        newnd=find_next(newnd,"L2_N7_H_111")
        if(newnd!=None):
                print("hi1->",newnd.name)
        else:
                print("no")
        i=i-1


#newnd1=find_next(newnd,"L2_N7_H_111")
#if(newnd1!=None):
#        print("hi2->",newnd1.name)
#else:
#        print("no")
#
#
#newnd1=find_next(newnd1,"L2_N7_H_111")
#if(newnd1!=None):
#        print("hi3->",newnd1.name)
#else:
#        print("no")
#
#newnd1=find_next(newnd1,"L2_N7_H_111")
#if(newnd1!=None):
#        print("hi4->",newnd1.name)
#else:
#        print("no")


#with open("/home/lloyd/CAD-Assign/github-a1/cad_vlsi/assignment1/IP-Backup/op/L1H8L2H8.txt.txt") as file:
#    mydic={}
#    for line in file:
#        match=re.findall('NodeID:.*_N(\d+)_C',line)
#        if(match):
#            if(int(match[0]) not in mydic):
#                mydic[int(match[0])]=1
#            else:
#                mydic[int(match[0])]=mydic[int(match[0])]+1
#
#for key, value in mydic.items():
#    print(str(key)+"->"+str(value))

        #with open(self.filename) as file:
        #    for line in file:
        #        nid=line.partition("NodeID:")[2]
        #        sid=line.partition("Switch ID:")[2]
        #        nid=str(nid).strip()
        #        sid=str(sid).strip()
        #        if(nid!="" or sid!=""): #Match for NodeID/SwitchID
        #            line1=file.readline()
        #            link_count=int(line1.partition("Links:")[2]) #Match Links: and extarct link count
        #            while(link_count):
        #                line1=file.readline()
        #                match=re.findall('L\d+:(.*)',line1)
        #                if match:
