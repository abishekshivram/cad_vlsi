package MeshNocL2Head;
// This package instantiates all the nodes and connects them

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import MeshRouterVCL2Head :: *;
import MeshNodeL2HeadVC :: *;

(* synthesize *)

module mkMeshNocL2Head(Empty);
    //Asimple compilation test
    Address node00_address;  node00_address.netAddress=0;  node00_address.nodeAddress=16'h0000;
    let node00   <- mkMeshL2HeadNode(node00_address, node00_address);

endmodule

endpackage: MeshNocL2Head
