# CAD for VLSI - Project 3 - Configurable NoC using bluespec and Python

## Project Working: How to run the project?
### Input File
L1Topology.txt: L1 network needs to be specified in the format specified in Project 1. \
L2Topology.txt: L2 networks need to be specified in the format specified in Project 1.

### File that needs to be run for the project
- Run the file *run.sh* for building the network on bluespec.
- First, *run.sh* removes the *.bsv* files which instantiate nodes based on the previous input configuration.
- Then it runs the python script *create_noc_of_nocs.py* which creates makes .bsv files(will refer to them as NoC files) for instantiating nodes based on L1 and L2 configuration. These files will be avilable in directory src_nocs/.
- Once the NoC files are created, it runs *runbsvcode* to build the network and routing.

##### The user just needs to change configuration in the input files and run *run.sh*.

## Description of the Organisation of the Project
### Files in the Current Directory
1. **run.sh:** Used to run the project.
2. **create_noc_of_nocs.py:** Reads L1Topology.txt and L2Topology.txt, checks if the input configuration specified is valid, and creates the NoC .bsv files (stored in src_nodes/) for each network where nodes are instantiated as per configuration in the input files. Additionally, Parameters.bsv (inside the src/) is also created.
3. **make_params.py:** Called from *create_noc_of_nocs.py* to make Parameters.bsv.
4. **organise.sh:** Used in *run.sh*. Moves the NoC files to src_nocs/.
5. **clean.sh:** Removes folders and files created while running *run.sh*.
6. **testRunner.py:** Python File used to run the Design Under Test.

### Files and folders inside src/
1. 

### Files inside src_nocs/

### Files inside Templates/


## Theory behind the Project
### Link
Each link works in full duplex mode - Can send and receive the data at the same time. So if the flit size (length) is ‘x’ we would need ‘2x’ wires between each pair of nodes. Here the communication happens in parallel. The Flit size and Phit size are the same. This means a flit is transferred completely in a single clock cycle.

Each input link is associated with a router and each output link is associated with multiple virtual channels.

### Flit
Basic unit of communication. Has four fields
- Source Id
- Final dest id
- Current dest id
- Payload

The payload size of the flit should be parameterisable (At compile time)

### Address
The address is made up of <network number> and <node number>. The size of these two fields are to be decided based on the network size.

### Router
Each node is composed of Routers, core and the arbiters. Routers implement the routing algorithm. The number of routers is equal to the number of input links connected to the node. All the L2 nodes will be implementing the L2 routing algorithm. All the nodes which are part of L1 (headnodes) have to implement the L1 routing algorithm. So Head nodes will have two different routing algorithms implemented.

The routing algorithm decides to which output link and to which VC the current flit should go. Then the flit is stored in the respective buffer (FIFO) of the VC.

The implementation of the routing algorithm should minimise the latency, otherwise routing cannot be completed in a single clock. If the routing cannot be completed in a clock, either we will have to decrease the clock frequency (to the slowest router) or to implement the router in a pipelined fashion. Otherwise, the incoming Flits will quickly fill up the input buffer (FIFO).

If there are ‘v’ VCs and ‘r’ routers, there will be ‘v X r’ VCs. So each router will represent a portion of each of the VCs in the node.

### Virtual Channels
Each link has an associated Virtual Channel (VC). The number of VC is equal to the number of Links+1(self). The additional VC is for the host node, because level 2 nodes generate and accept traffic in the form of Flits. 

If there are 4 VCs, each router represents a part of it. So VC1 will be present in router 1 to n. VC2 will also be present in router 1 to n. The same applies for VC3 and VC4.

### Arbiter
Each (output)link has an associated arbiter. It is meant for avoiding starvation. Our arbiter needs to implement only the round robin algorithm. It checks the VCs of its output link (in all routers) and selects the next flit to be transmitted. If the selected VC does not have a ready flit, the next VC in-line will be checked and selected.

### Core
Core represents the host module in a NoC. Its role is to generate and consume traffic in the form of flits. When a flit is consumed, the core has to compute the ‘Delay’ (Transmission delay). Core generates the flits at random. When a flit is generated at random, the destination node address should be a valid one (the address which is present in the current network configuration).

### Buffer (FIFO)
All the synchronisation buffers are to be implemented using the FIFO. The size of this FIFO is to be determined.

> Deliverables - Performance measure
Measure link utilisation - in descending order: Each router should be able to calculate the link utilisation (Based on the data in its input link)
> Delay - Max delay from source to destination: Each core should be able to calculate the delay. The sending core can store the timestamp (How to get timestamp? - current clock?) while flit generation as a payload in the flit. The receiving core can find the difference between the sending time stamps and receiving timestamps to measure the delay.


### Node
A node is composed of core, multiple routers (routing algorithm), arbiters (arbitration algorithm - Round Robin), flit store buffer (input FIFOs), virtual channels (output FIFOs) and associated input & output links.

## Constructing NoC

Should the node be composed dynamically or to be selected from a set of statically constructed nodes?. (Initially may be thought of as static nodes, later can be moved to dynamic node construction using python). Dynamic construction would be needed otherwise a large number of static node configurations would be needed (Consider the construction of head nodes). 

Once the nodes are ready, the links are to be established between them as per the network configuration.

The python code reads the input of Project1 (L2 topologies and L1 topology) and payload length. Based on the input, the script generates BSV project files which combine different nodes together to form the NoC. It also parametrises payload size of the flit.

## Implementation Steps

As a quick proof of the total system, a simple chain based NoC with only L2 (1 level) can be implemented. Then it can be expanded to L1&L2 based complete NoC supporting different routing algorithms and network topologies.

1. A- In each clock pulse the core randomly generates a valid flit and stores it in the input FIFO (Input link FIFO). It is not necessary to generate the flit in every clock cycle. 
B- In each clock cycle, the core checks its output FIFO (VC) and if flits are present, one flit is consumed. If a flit is consumed, the core computes the transmission delay. The transmission delay is printed on the screen.
2. In each clock, the routers read its input FIFO and decide to which VC (+output link) the flit should be placed. The flit is removed from input FIFO and placed in the VC’s FIFO associated with the router. (A VC will have an associated FIFO in all routers). The router also updates the link utilisation parameter for its input link.
	
	> How and when the link utilisation to be conveyed to the external world?

3. In each clock, The arbiters scans all the VC FIFOs (Output FIFO) associated with it in a round robin fashion and selects the flit to be transferred. The selected flit is transmitted in the respective output link.

> NOTE: There are two types of FIFOs in a node. Input FIFO and VC FIFO (Output FIFO).


Once a basic system is ready, the whole system can be quickly (relatively) evolved to a fully functional 2 layer NoC with six routing algorithms.


