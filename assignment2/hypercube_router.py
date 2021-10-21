from router import Router
from flit import Flit

class HypercubeRouter(Router):
    def __init__(self,name):
        super(HypercubeRouter, self).__init__(name)
        return

    def find_next(destination_node): #current_node we know from this router
        return
    
    def receive_flit(flit,destination_node): #May be it can store name of nodes it traversed as meta data
        pass
