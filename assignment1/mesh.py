from node import Node
from butterfly import dec_to_bin,log

class Mesh:
    def __init__(self,name,rowCount,colCount,create=True):
        self.name=name
        self.rowCount=rowCount
        self.colCount=colCount
        self.rowVertices=[]
        if (create):
            self.create_nodes()

    def get_node_name(self,i,j):
        return self.name+str(i)+"_"+str(j)

    def create_nodes(self):
        #init
        row_bits = log(self.rowCount)
        col_bits = log(self.colCount)
        for i in range(0,self.rowCount):
            self.colVertices=[]
            for j in range(0,self.colCount):
                self.colVertices.append(Node(self.get_node_name(dec_to_bin(i,row_bits),dec_to_bin(j,col_bits))))
            self.rowVertices.append(self.colVertices)
        self.create_network()
        
    def insert_nodes(self,node):
        max_row = len(self.rowVertices)
        
        if max_row > 0:
            max_column = len(self.rowVertices[-1])
        else:
            max_column = 0
        
        assert (max_row < self.rowCount or (max_row == self.rowCount and max_column < self.colCount)),\
            "More than expected rows for Mesh network"
        
        if (max_row == 0 or len(self.rowVertices[-1]) == self.colCount):
            self.rowVertices.append([]) 
        self.rowVertices[-1].append(node)
        
    def create_network(self):
        #Nodes in the center
        for i in range(1,len(self.rowVertices)-1):
            for j in range(1,len(self.rowVertices[i])-1):
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i-1][j])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i+1][j])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i][j-1])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i][j+1])

        #Top row and bottom row of the mesh
        lastRow=self.rowCount-1
        for i in range(1, self.colCount-1):
            self.rowVertices[0][i].add_neighbour(self.rowVertices[0][i+1])
            self.rowVertices[0][i].add_neighbour(self.rowVertices[0][i-1])
            self.rowVertices[0][i].add_neighbour(self.rowVertices[1][i])
            
            self.rowVertices[lastRow][i].add_neighbour(self.rowVertices[lastRow][i+1])
            self.rowVertices[lastRow][i].add_neighbour(self.rowVertices[lastRow][i-1])
            self.rowVertices[lastRow][i].add_neighbour(self.rowVertices[lastRow-1][i])

        #Corners of the mesh
        if self.colCount >1:
            self.rowVertices[0][0].add_neighbour(self.rowVertices[0][1])#TopLeft
            self.rowVertices[0][self.colCount-1].add_neighbour(self.rowVertices[0][self.colCount-2]) #TopRight
            self.rowVertices[lastRow][0].add_neighbour(self.rowVertices[lastRow][1]) #BottmLeft
            self.rowVertices[lastRow][self.colCount-1].add_neighbour(self.rowVertices[lastRow][self.colCount-2])#BottmRight

        if self.rowCount >1:
            self.rowVertices[0][0].add_neighbour(self.rowVertices[1][0])#TopLeft
            self.rowVertices[0][self.colCount-1].add_neighbour(self.rowVertices[1][self.colCount-1]) #TopRight
            self.rowVertices[lastRow][0].add_neighbour(self.rowVertices[lastRow-1][0]) #BottmLeft
            self.rowVertices[lastRow][self.colCount-1].add_neighbour(self.rowVertices[lastRow-1][self.colCount-1])#BottmRight

        #Left col and right col
        for i in range(1, self.rowCount-1):
            self.rowVertices[i][0].add_neighbour(self.rowVertices[i+1][0])
            self.rowVertices[i][0].add_neighbour(self.rowVertices[i-1][0])
            self.rowVertices[i][0].add_neighbour(self.rowVertices[i][1])
            
            self.rowVertices[i][self.colCount-1].add_neighbour(self.rowVertices[i+1][self.colCount-1])
            self.rowVertices[i][self.colCount-1].add_neighbour(self.rowVertices[i-1][self.colCount-1])
            self.rowVertices[i][self.colCount-1].add_neighbour(self.rowVertices[i][self.colCount-2])
            
            
    def print_nodes(self):
        for i in range(0,self.rowCount):
            for j in range(0,self.colCount):
                self.rowVertices[i][j].print_neighbour()


    def get_head_node(self):
        midrow=self.rowCount//2
        midcol=self.colCount//2

        if(len(self.rowVertices)>0 and len(self.rowVertices)>=midrow):
            if(len(self.rowVertices[midrow])>0 and len(self.rowVertices[midrow])>=midcol):
                self.rowVertices[midrow][midcol].name = 'L1'+self.rowVertices[midrow][midcol].name[2:]
                return self.rowVertices[midrow][midcol]
        print("Mesh not created yet")
        n=Node("NIL")
        return n
