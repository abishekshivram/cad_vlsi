from node import Node
from butterfly import dec_to_bin,log

class FoldedTorus:
	def __init__(self,name,rowCount,colCount,create=True):
		self.name=name
		self.rowCount=rowCount
		self.colCount=colCount
		self.rowVertices=[]
		if (create):        
			self.create_nodes()

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

	def create_nodes(self):
		#init
		row_bits = log(self.rowCount)
		col_bits = log(self.colCount)
		for i in range(self.rowCount):
			row=[]
			for j in range(self.colCount):
				row.append(Node(self.get_node_name(dec_to_bin(i,row_bits),dec_to_bin(j,col_bits))))
			
			self.rowVertices.append(row)
			
		self.create_network()

	def insert_nodes(self, node):
		max_row = len(self.rowVertices)
		
		if max_row > 0:
			max_column = len(self.rowVertices[-1])
		else:
			max_column = 0
		
		assert (max_row < self.rowCount or (max_row == self.rowCount and max_column < self.colCount)),"More than expected rows for Folded Torus network"
		
		if (max_row == 0 or len(self.rowVertices[-1]) == self.colCount):
			self.rowVertices.append([])	
		self.rowVertices[-1].append(node)
			
	def create_network(self):
		#Nodes in the folded torus
		for i in range(len(self.rowVertices)):
			for j in range(len(self.rowVertices[i])):
				self.rowVertices[i][j].add_neighbour(self.rowVertices[self.prev_index(i,self.rowCount)][j])
				self.rowVertices[i][j].add_neighbour(self.rowVertices[self.next_index(i,self.rowCount)][j])
				self.rowVertices[i][j].add_neighbour(self.rowVertices[i][self.prev_index(j,self.colCount)])
				self.rowVertices[i][j].add_neighbour(self.rowVertices[i][self.next_index(j,self.colCount)])

	def print_nodes(self):
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
