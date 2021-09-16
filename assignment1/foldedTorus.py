from node import Node

class FoldedTorus:
    def __init__(self,name,rowCount,colCount):
        self.name=name
        self.rowCount=rowCount
        self.colCount=colCount
        self.rowVertices=[]
        self.create()

    def get_node_name(self,i,j):
        return self.name+str(i)+str(j)
    
    def next_index(self,index,dim):
        assert (index < dim and index >= 0),"Invalid index for Mesh"
        if (index == dim-1):
            return 0
        return index + 1
        
    def prev_index(self,index,dim):
        assert (index < dim and index >= 0),"Invalid index for Mesh"
        if (index == 0):
            return dim-1
        return index - 1

    def create(self):
        #init
        for i in range(self.rowCount):
            row=[]
            for j in range(self.colCount):
                row.append(Node(self.get_node_name(i,j)))
            self.rowVertices.append(row)

        #Nodes in the folded torus
        for i in range(len(self.rowVertices)):
            for j in range(len(self.rowVertices[i])):
                self.rowVertices[i][j].add_neighbour(self.rowVertices[self.prev_index(i,self.rowCount)][j])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[self.next_index(i,self.rowCount)][j])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i][self.prev_index(j,self.colCount)])
                self.rowVertices[i][j].add_neighbour(self.rowVertices[i][self.next_index(j,self.colCount)])


    def print(self):
        for i in range(0,self.rowCount):
            for j in range(0,self.colCount):
                self.rowVertices[i][j].print_neighbour()


    def get_head_node(self):
        midrow=self.rowCount//2
        midcol=self.colCount//2

        if(len(self.rowVertices)>0 and len(self.rowVertices)>=midrow):
            if(len(self.rowVertices[midrow])>0 and len(self.rowVertices[midrow])>=midcol):
                return self.rowVertices[midrow][midcol]
        print("Folded Torus not created yet")
        n=Node("NIL")
        return n
