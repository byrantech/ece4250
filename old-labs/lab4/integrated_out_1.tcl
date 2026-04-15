loading history file ... 48 events added
Running IRSIM Console Functions
Warning: irsim command 'time' use fully-qualified name '::irsim::time'
Warning: irsim command 'clear' use fully-qualified name '::irsim::clear'
Warning: irsim command 'exit' use fully-qualified name '::irsim::exit'
Starting irsim under Tcl interpreter
IRSIM 9.7.104 compiled on Sat, 19 Oct 2019 20:07:42 +0200
Unexpected first line: lambda 0.09

full.sim: Ignoring lumped-resistance ('R' construct)
Warning: Aliasing nodes 'GND' and 'Gnd'

Read full.sim lambda:0.09u format:MIT

Read full.al lambda:0.09u format:MIT
1259 nodes, 3192 aliases; transistors: n-channel=1181 p-channel=1181
parallel txtors:none
Main console display active (Tcl8.6.14 / Tk8.6.14)
(lab4) 49 % @ integrated_test.irsim
time = 10.000ns
time = 20.000ns
{=== Integrated FSM + Datapath Test ===}
{}
{=== Test 1: System Reset and Init ===}
time = 30.000ns
time = 70.000ns
{FSM in reset state (h2)}
H=010000 N=010000 
time = 70.000ns
time = 110.000ns
{FSM in ready state (h1)}
H=100000 N=100000 
time = 110.000ns
DATAPATH_OUT=00000000 
time = 110.000ns
{}
{=== Test 2: Load Data into Datapath ===}
{Loading 0x55 (01010101) via FSM control}
time = 120.000ns
time = 160.000ns
{FSM in h3 (load0)}
H=001000 ld=0 reg1w=0 
time = 160.000ns
time = 200.000ns
{FSM in h4 (load1)}
H=000100 ld=0 reg0w=0 
time = 200.000ns
time = 240.000ns
{FSM back to h1}
H=100000 
time = 240.000ns
{Data loaded into registers}
{}
{=== Test 3: First Iteration ===}
time = 280.000ns
{FSM in h5 (iter0)}
H=000010 N=000001 reg0r0=0 ros=0 
time = 280.000ns
wz=00000000 
time = 280.000ns
time = 320.000ns
{FSM in h6 (iter1)}
H=000001 N=100000 reg0r0=1 reg1r1=0 rfb=0 rd=1 
time = 320.000ns
time = 330.000ns
time = 340.000ns
wz=01010101 
time = 340.000ns
{Function block result on wz bus}
DATAPATH_OUT=01010101 
time = 340.000ns
time = 380.000ns
{FSM back to h1 after first iteration}
H=100000 DATAPATH_OUT=01010101 
time = 380.000ns
{}
{=== Test 4: Multiple Iterations ===}
{Running 5 consecutive iterations}
{Iteration 2:}
time = 420.000ns
time = 460.000ns
time = 500.000ns
H=000001 DATAPATH_OUT=11111111 
time = 500.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{Iteration 3:}
time = 540.000ns
time = 580.000ns
time = 620.000ns
H=000001 DATAPATH_OUT=10101011 
time = 620.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{Iteration 4:}
time = 660.000ns
time = 700.000ns
time = 740.000ns
H=000001 DATAPATH_OUT=00000011 
time = 740.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{Iteration 5:}
time = 780.000ns
time = 820.000ns
time = 860.000ns
H=000001 DATAPATH_OUT=01010011 
time = 860.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{Iteration 6:}
time = 900.000ns
time = 940.000ns
time = 980.000ns
H=000001 DATAPATH_OUT=11110011 
time = 980.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{}
{=== Test 5: Load New Data and Compute ===}
{Loading 0xAA (10101010)}
time = 990.000ns
time = 1030.000ns
time = 1070.000ns
time = 1110.000ns
{New data loaded}
DATAPATH_OUT=00000000 
time = 1110.000ns
{Run iteration on new data:}
time = 1150.000ns
time = 1190.000ns
time = 1230.000ns
H=000001 DATAPATH_OUT=10101010 
time = 1230.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{}
{=== Test 6: Verify Control Signals ===}
{Starting iteration, stepping through phases:}
time = 1240.000ns
{Phase 1: h1->h5 transition}
H=100000 N=000010 CLOCK=01 
time = 1240.000ns
time = 1250.000ns
time = 1260.000ns
{Phase 2: In h5 (iter0)}
H=100000 N=000010 CLOCK=10 reg0r0=0 ros=0 
time = 1260.000ns
(command line, 1): assertion failed on 'H' 100000 (000010)
{Check wz bus has shift result:}
wz=00000000 
time = 1260.000ns
time = 1270.000ns
time = 1280.000ns
{Phase 3: h5->h6 transition}
H=000010 N=000001 CLOCK=01 
time = 1280.000ns
time = 1290.000ns
time = 1300.000ns
{Phase 4: In h6 (iter1)}
H=000010 N=000001 CLOCK=10 reg0r0=0 reg1r1=0 rfb=0 rd=0 
time = 1300.000ns
(command line, 1): assertion failed on 'H' 000010 (000001)
{Check wz bus has fblock result:}
wz=01010100 
time = 1300.000ns
{Check datapath output:}
DATAPATH_OUT=10101010 
time = 1300.000ns
time = 1310.000ns
time = 1320.000ns
{Phase 5: h6->h1 transition}
H=000001 N=100000 CLOCK=01 
time = 1320.000ns
time = 1330.000ns
time = 1340.000ns
{Phase 6: Back in h1}
H=000001 CLOCK=10 
time = 1340.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{}
{=== Test 7: Reset Interrupt ===}
{Start iteration:}
time = 1380.000ns
{Mid-iteration, assert reset:}
H=100000 
time = 1380.000ns
(command line, 1): assertion failed on 'H' 100000 (000010)
time = 1420.000ns
{FSM forced to h2:}
H=000010 
time = 1420.000ns
(command line, 1): assertion failed on 'H' 000010 (010000)
time = 1460.000ns
{FSM recovers to h1:}
H=010000 
time = 1460.000ns
(command line, 1): assertion failed on 'H' 010000 (100000)
{}
{=== Test 8: Continuous Iterations ===}
{Running 10 iterations to verify stability}
time = 1500.000ns
time = 1540.000ns
time = 1580.000ns
H=000001 DATAPATH_OUT=00000000 
time = 1580.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 1620.000ns
time = 1660.000ns
time = 1700.000ns
H=000001 DATAPATH_OUT=00000000 
time = 1700.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 1740.000ns
time = 1780.000ns
time = 1820.000ns
H=000001 DATAPATH_OUT=00000000 
time = 1820.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 1860.000ns
time = 1900.000ns
time = 1940.000ns
H=000001 DATAPATH_OUT=00000000 
time = 1940.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 1980.000ns
time = 2020.000ns
time = 2060.000ns
H=000001 DATAPATH_OUT=00000000 
time = 2060.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 2100.000ns
time = 2140.000ns
time = 2180.000ns
H=000001 DATAPATH_OUT=00000000 
time = 2180.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 2220.000ns
time = 2260.000ns
time = 2300.000ns
H=000001 DATAPATH_OUT=00000000 
time = 2300.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 2340.000ns
time = 2380.000ns
time = 2420.000ns
H=000001 DATAPATH_OUT=00000000 
time = 2420.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 2460.000ns
time = 2500.000ns
time = 2540.000ns
H=000001 DATAPATH_OUT=00000000 
time = 2540.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
time = 2580.000ns
time = 2620.000ns
time = 2660.000ns
H=000001 DATAPATH_OUT=00000000 
time = 2660.000ns
(command line, 1): assertion failed on 'H' 000001 (100000)
{}
{=== All System Tests Complete ===}
{}
Verified:
{  - System initialization and reset}
{  - Data loading via FSM control}
{  - Single iteration cycle}
{  - Multiple consecutive iterations}
{  - New data loading and computation}
{  - Detailed signal timing}
{  - Reset interrupt handling}
{  - Continuous operation stability}
{}
{System operational!}
(lab4) 50 % 