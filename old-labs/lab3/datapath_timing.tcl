loading history file ... 48 events added
Running IRSIM Console Functions
Warning: irsim command 'time' use fully-qualified name '::irsim::time'
Warning: irsim command 'clear' use fully-qualified name '::irsim::clear'
Warning: irsim command 'exit' use fully-qualified name '::irsim::exit'
Starting irsim under Tcl interpreter
IRSIM 9.7.104 compiled on Sat, 19 Oct 2019 20:07:42 +0200
Unexpected first line: lambda 0.09

datapath.sim: Ignoring lumped-resistance ('R' construct)
Warning: Aliasing nodes 'GND' and 'Gnd'

Read datapath.sim lambda:0.09u format:MIT

Read datapath.al lambda:0.09u format:MIT
1132 nodes, 2882 aliases; transistors: n-channel=1054 p-channel=1054
parallel txtors:none
Main console display active (Tcl8.6.14 / Tk8.6.14)
(lab3) 49 % @ datapath_timing.irsim
time = 10.000ns
time = 20.000ns
{=== DATAPATH TIMING ANALYSIS ===}
{}
{Setup: Loading test patterns...}
time = 30.000ns
time = 40.000ns
time = 50.000ns
time = 60.000ns
time = 70.000ns
time = 80.000ns
{}
{=== Path 1: Register Read to Output (through rd latch) ===}
{Measures: Register -> rx bus -> rd latch -> output staticizers}
time = 90.000ns
time = 100.000ns
time = 110.000ns
{Waiting for output to settle...}
time = 120.000ns
time = 130.000ns
time = 140.000ns
{Final output:}
outputs=10101010 
time = 140.000ns
{Critical path analysis:}
critical path for last transition of out0:
  rd -> 1 @ 100.000ns , node was an input
  out0 -> 0 @ 100.042ns   (0.042ns)
critical path for last transition of out7:
  rd -> 1 @ 100.000ns , node was an input
  latch_4/latch_one_0[7]/new_latch_0/a_82_52# -> 0 @ 100.006ns   (0.006ns)
  out7 -> 1 @ 100.059ns   (0.053ns)
time = 240.000ns
{}
{=== Path 2: Addition through ALU ===}
{Measures: Register read -> rx/ry buses -> adder -> ras latch -> wz bus -> register write}
time = 250.000ns
time = 260.000ns
{Waiting for addition to complete...}
time = 270.000ns
time = 280.000ns
time = 290.000ns
{Result on wz bus:}
wz_bus=11111111 
time = 290.000ns
{Critical path through adder:}
critical path for last transition of wz0:
  in0 -> 1 @ 50.000ns , node was an input
  latch_0/latch_one_0[0]/new_latch_0/a_79_32# -> 0 @ 50.010ns   (0.010ns)
  wz0 -> 1 @ 50.213ns   (0.203ns)
critical path for last transition of wz7:
  ras -> 1 @ 250.000ns , node was an input
  latch_2/latch_one_0[7]/new_latch_0/a_82_52# -> 0 @ 250.006ns   (0.006ns)
  wz7 -> 1 @ 250.203ns   (0.197ns)
time = 390.000ns
{}
{=== Path 3: Function Block (XOR) ===}
{Measures: Register read -> rx/ry buses -> function block -> rfb latch -> wz bus}
(command line,1): fblock_ctrl: No such vector
time = 400.000ns
time = 410.000ns
{Waiting for function block to complete...}
time = 420.000ns
time = 430.000ns
time = 440.000ns
{Result on wz bus:}
wz_bus=00000000 
time = 440.000ns
{Critical path through function block:}
critical path for last transition of wz0:
  rfb -> 1 @ 400.000ns , node was an input
  wz0 -> 0 @ 400.163ns   (0.163ns)
critical path for last transition of wz7:
  rfb -> 1 @ 400.000ns , node was an input
  wz7 -> 0 @ 400.159ns   (0.159ns)
time = 540.000ns
{}
{=== Path 4: Left Shift ===}
{Measures: Register read -> rx bus -> shifter -> ros latch -> wz bus}
time = 550.000ns
time = 560.000ns
{Waiting for shift to complete...}
time = 570.000ns
time = 580.000ns
time = 590.000ns
{Result on wz bus:}
wz_bus=01010100 
time = 590.000ns
{Critical path through shifter:}
critical path for last transition of wz0:
  transition of rfb, which has since changed again
  wz0 -> 0 @ 400.163ns   (?)
critical path for last transition of wz7:
  transition of rfb, which has since changed again
  wz7 -> 0 @ 400.159ns   (?)
time = 690.000ns
{}
{=== Path 5: Right Shift ===}
time = 700.000ns
time = 710.000ns
{Waiting for shift to complete...}
time = 720.000ns
time = 730.000ns
time = 740.000ns
{Result on wz bus:}
wz_bus=01010101 
time = 740.000ns
{Critical path through shifter:}
critical path for last transition of wz0:
  ros -> 1 @ 700.000ns , node was an input
  latch_3/latch_one_0[0]/new_latch_0/a_82_52# -> 0 @ 700.006ns   (0.006ns)
  wz0 -> 1 @ 700.208ns   (0.202ns)
critical path for last transition of wz7:
  transition of rfb, which has since changed again
  wz7 -> 0 @ 400.159ns   (?)
time = 840.000ns
{}
{=== Path 6: Complete Read-Modify-Write Cycle ===}
{Measures: Full datapath loop (register -> ALU -> register)}
{Starting at t=0 with registers stable...}
time = 940.000ns
{Read registers (transition starts)}
time = 950.000ns
time = 960.000ns
{Wait for ALU output...}
time = 970.000ns
time = 980.000ns
time = 990.000ns
time = 1000.000ns
{Write back to register}
time = 1010.000ns
time = 1020.000ns
time = 1030.000ns
time = 1040.000ns
{Read back result}
time = 1050.000ns
time = 1060.000ns
time = 1070.000ns
time = 1080.000ns
{Final output:}
outputs=11111111 
time = 1080.000ns
{End-to-end critical path:}
critical path for last transition of out0:
  rd -> 1 @ 1050.000ns , node was an input
  latch_4/latch_one_0[0]/new_latch_0/a_82_52# -> 0 @ 1050.006ns   (0.006ns)
  out0 -> 1 @ 1050.059ns   (0.053ns)
critical path for last transition of out7:
  transition of latch_4/latch_one_0[7]/new_latch_0/a_82_52#, which has since changed again
  out7 -> 1 @ 100.059ns   (?)
time = 1180.000ns
{}
{=== Path 7: Input to Register Write ===}
{Measures: Input pins -> ld latch -> wz bus -> register}
time = 1190.000ns
time = 1200.000ns
{Wait for input latch...}
time = 1210.000ns
time = 1220.000ns
time = 1230.000ns
{Wait for register write...}
time = 1240.000ns
time = 1250.000ns
time = 1260.000ns
{Verify write:}
time = 1270.000ns
time = 1280.000ns
outputs=11110000 
time = 1280.000ns
{Input to output path:}
critical path for last transition of out0:
  rd -> 1 @ 1270.000ns , node was an input
  out0 -> 0 @ 1270.042ns   (0.042ns)
critical path for last transition of out7:
  transition of latch_4/latch_one_0[7]/new_latch_0/a_82_52#, which has since changed again
  out7 -> 1 @ 100.059ns   (?)
time = 1380.000ns
{}
{=== SUMMARY: Maximum Delays ===}
{Run 'path' command on critical nodes to see detailed timing}
{Key paths measured:}
{  1. Register Read -> Output Display}
{  2. Addition (rx/ry -> adder -> wz)}
{  3. Function Block (rx/ry -> fblock -> wz)}
{  4. Left Shift (rx -> shifter -> wz)}
{  5. Right Shift (rx -> shifter -> wz)}
{  6. Complete Read-Modify-Write cycle}
{  7. Input -> Register Write -> Output}
{}
{=== Timing Analysis Complete ===}
(lab3) 50 % 