#*************************************************************************************
#CS6230:CAD for VLSI Systems - Final Project
#Name: Implementation of a configuralble NoC using Python and bluespec
#Team Name: Kilbees
#Team Members: Abishekshivram AM (EE18B002)
#              Gayatri Ramanathan Ratnam (EE18B006)
#              Lloyd K L (CS21M001)
#Description: A very basic testbench for NoC
#Last updated on: 09-Dec-2021
#************************************************************************************** 

import cocotb
import random
import os

from cocotb.clock import Clock
from cocotb.decorators import coroutine
from cocotb.triggers import Timer, RisingEdge, ReadOnly, FallingEdge
from cocotb_bus.monitors import Monitor
from cocotb_bus.drivers import BitDriver
from cocotb.binary import BinaryValue
from cocotb.regression import TestFactory
from cocotb_bus.scoreboard import Scoreboard
from cocotb.result import TestFailure, TestSuccess

#------------------------------------Simple Test - Issues clock indefenitely------------------------------------------------------
#count = int(os.environ['COUNT'])
@cocotb.test()
def Simple_test(dut):  #14
    cocotb.fork(Clock(dut.CLK, 10,).start())
    dut.RST_N = 0
    clkedge = RisingEdge(dut.CLK)
    yield clkedge
    clkedge = RisingEdge(dut.CLK)
    dut.RST_N <= 1
    
    i = 1
    while i < 25:
        yield clkedge #Step 0,1,2...1000
        i += 1
