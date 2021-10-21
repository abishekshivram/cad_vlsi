import re
from network_layout import NetworkLayout 

NetworkLayout("/home/lloyd/CAD-Assign/github-a1/cad_vlsi/assignment1/output.txt")

#with open("/home/lloyd/CAD-Assign/github-a1/cad_vlsi/assignment1/IP-Backup/op/L1C4L2C4.txt") as file:
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
