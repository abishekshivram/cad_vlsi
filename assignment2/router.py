import sys
sys.path.insert(1, './../assignment1')
from node import Node


class Router(Node):
    def __init__(self,name):
        super(Router, self).__init__(name)
        return

    def clock(): #Click signal, What to do on clock, may be this can be moved to a base class to avoid repetition
        pass

    def clock(destination_node): #In this case asks the router to generate a flit dor the dest node specified
        pass
