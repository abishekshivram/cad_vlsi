### TOP_DIR: The Ddirectory containing the .bsv file
### TOP_FILE: The Name of the file that contains the topmost module
### TOP_MODULE: The Name of the topmost module which will be defined inside the TOP_FILE
### MODULE: This is the name of the python test bench WITHOUT the (.py) extension


#TOP_MODULE:=mkNoc
#TOP_FILE:=Noc.bsv
#TOP_DIR:=.
#MODULE:=testRunner
#BLUESPEC_TOOL:=/home/lloyd/tools/bsc


#TOP_MODULE:=mkNoc
#TOP_FILE:=Noc_ring.bsv
#TOP_DIR:=.
#MODULE:=testRunner
#BLUESPEC_TOOL:=/home/lloyd/tools/bsc



TOP_MODULE:=mkMeshNocL1
TOP_FILE:=MeshNocL1.bsv
TOP_DIR:=.
MODULE:=testRunner
BLUESPEC_TOOL:=/home/lloyd/tools/bsc

