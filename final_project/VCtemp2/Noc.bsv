package Noc;
// This package instantiates all the nodes and connects them

import Network1:: *;
import Network2:: *;
import Network3:: *;

(* synthesize *)
module mkNoc(Empty);

    Empty network1 <- mkNetwork1;
    Empty network2 <- mkNetwork2;
    Empty network3 <- mkNetwork3;

endmodule: mkNoc

endpackage : Noc
