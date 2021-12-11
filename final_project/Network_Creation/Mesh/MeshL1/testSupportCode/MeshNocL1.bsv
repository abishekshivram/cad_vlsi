package MeshNocL1;
// This package instantiates all the nodes and connects them

import Shared::*;

import FIFO :: * ;
import Core :: * ;
import MeshNodeL1VC :: *;
import MeshRouterL1VC :: *;

(* synthesize *)

module mkMeshNocL1(Empty);
    //Asimple compilation test
    Address node00_address;  node00_address.netAddress=0;  node00_address.nodeAddress=16'h0000;
    let node00   <- mkMeshNodeL1(node00_address, node00_address);

endmodule

endpackage: MeshNocL1
