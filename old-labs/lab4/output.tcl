loading history file ... 48 events added
Running IRSIM Console Functions
Warning: irsim command 'time' use fully-qualified name '::irsim::time'
Warning: irsim command 'clear' use fully-qualified name '::irsim::clear'
Warning: irsim command 'exit' use fully-qualified name '::irsim::exit'
Starting irsim under Tcl interpreter
IRSIM 9.7.104 compiled on Sat, 19 Oct 2019 20:07:42 +0200
Unexpected first line: lambda 0.09

fsm.sim: Ignoring lumped-resistance ('R' construct)
Warning: Aliasing nodes 'GND' and 'Gnd'

Read fsm.sim lambda:0.09u format:MIT

Read fsm.al lambda:0.09u format:MIT
154 nodes, 233 aliases; transistors: n-channel=133 p-channel=133
parallel txtors:none
Main console display active (Tcl8.6.14 / Tk8.6.14)
(lab4) 49 % @ fsm_test.irsim
time = 10.000ns
{=== FSM Comprehensive Test ===}
{}
{=== Test 1: Initial Reset ===}
time = 50.000ns
time = 60.000ns
{After first clock}
H=X00X0X N=X00000
time = 60.000ns
time = 100.000ns
{Reset asserted, should enter h2}
H=010000 N=010000
time = 100.000ns
time = 140.000ns
{Reset deasserted, should transition to h1}
H=100000 N=100000
time = 140.000ns
rd=0
time = 140.000ns
{rd should be high in h1 (ready state)}
{}
{=== Test 2: Load Sequence (h1 -> h2 -> h3 -> h4 -> h1) ===}
{From h1, assert load}
time = 180.000ns
{Should be in h3 (load0)}
H=001000 N=000100
time = 180.000ns
ld=0 reg1w=0
time = 180.000ns
{ld and reg1w should be high}
{Stay in h3, should go to h4}
time = 220.000ns
{Should be in h4 (load1)}
H=000100 N=100000
time = 220.000ns
(command line,1): reg2w: No such node or vector
ld=0 reg1w=0
time = 220.000ns
{ld and reg2w should be high, reg1w should be low}
{Stay in h4, should return to h1}
time = 260.000ns
{Should be back in h1}
H=100000 N=100000
time = 260.000ns
(command line,1): reg2w: No such node or vector
rd=0
time = 260.000ns
{rd should be high, reg2w should be low}
{}
{=== Test 3: Iter Sequence (h1 -> h5 -> h6 -> h1) ===}
{From h1, assert iter}
time = 300.000ns
{Should be in h5 (iter0)}
H=000010 N=000001
time = 300.000ns
ros=0 reg0r0=0
time = 300.000ns
{ros and reg0r0 should be high}
{Stay in h5 with iter, should go to h6}
time = 340.000ns
{Should be in h6 (iter1)}
H=000001 N=100000
time = 340.000ns
rfb=0 rd=1 ros=0
time = 340.000ns
{rfb and rd should be high, ros should be low}
{Deassert iter, should return to h1}
time = 380.000ns
{Should be back in h1}
H=100000 N=100000
time = 380.000ns
{}
{=== Test 4: Reset from different states ===}
{Reset from h3}
time = 420.000ns
H=001000 N=000100
time = 420.000ns
{In h3}
time = 460.000ns
H=010000 N=010000
time = 460.000ns
{Reset successful to h2}
time = 500.000ns
H=100000 N=001000
time = 500.000ns
{Back to h1}
{Reset from h5}
time = 540.000ns
H=001010 N=000101
time = 540.000ns
{In h5}
time = 580.000ns
H=010000 N=010000
time = 580.000ns
{Reset successful to h2}
time = 620.000ns
H=100000 N=001010
time = 620.000ns
{}
{=== Test 5: Full natural progression from h2 ===}
{Enter reset state}
time = 660.000ns
H=010000 N=010000
time = 660.000ns
{In h2, now let it naturally progress}
time = 700.000ns
{h2 -> h3}
H=100000 N=100000
time = 700.000ns
(command line, 1): assertion failed on 'H' 100000 (001000)
time = 740.000ns
{h3 -> h4}
H=100000 N=100000
time = 740.000ns
(command line, 1): assertion failed on 'H' 100000 (000100)
time = 780.000ns
{h4 -> h1}
H=100000 N=100000
time = 780.000ns
{}
{=== Test 6: Load from non-h1 state ===}
{Get to h5, then assert load}
time = 820.000ns
H=000010 N=000001
time = 820.000ns
{In h5}
time = 860.000ns
{Load asserted from h5, should go to h3}
H=000001 N=100000
time = 860.000ns
(command line, 1): assertion failed on 'H' 000001 (001000)
time = 900.000ns
time = 940.000ns
H=100000 N=100000
time = 940.000ns
{}
{=== Test 7: Iter from h1 -> h5, stay -> h6 -> h1 cycle ===}
time = 980.000ns
H=000010 N=000001
time = 980.000ns
{In h5}
time = 1020.000ns
H=000001 N=100000
time = 1020.000ns
{In h6}
time = 1060.000ns
H=100000 N=000010
time = 1060.000ns
{Back to h1}
{}
{=== Test 8: Multiple consecutive resets ===}
time = 1100.000ns
H=010000 N=010000
time = 1100.000ns
time = 1140.000ns
H=010000 N=010000
time = 1140.000ns
{Still in h2}
time = 1180.000ns
H=010000 N=010000
time = 1180.000ns
{Still in h2}
time = 1220.000ns
H=100000 N=000010
time = 1220.000ns
{}
{=== Test 9: Verify one-hot encoding throughout ===}
{Check that exactly one H bit is always high}
time = 1260.000ns
H=100000
time = 1260.000ns
time = 1300.000ns
H=100000
time = 1300.000ns
time = 1340.000ns
H=100000
time = 1340.000ns
{}
{=== Test 10: Output signals verification ===}
{h1: rd=1}
H=100000 N=100000 rd=0
time = 1340.000ns
{h2: rd=0}
time = 1380.000ns
H=010000 N=010000 rd=1
time = 1380.000ns
{h3: ld=1, reg1w=1}
time = 1420.000ns
H=100000 N=001000 (command line,1): reg2w: No such node or vector
ld=0 reg1w=0
time = 1420.000ns
{h4: ld=1, reg2w=1}
time = 1460.000ns
H=001000 N=000100 (command line,1): reg2w: No such node or vector
ld=0 reg1w=0
time = 1460.000ns
{h5: ros=1, reg0r0=1}
time = 1500.000ns
time = 1540.000ns
H=100000 N=000010 ros=0 reg0r0=0
time = 1540.000ns
{h6: rfb=1, rd=1}
time = 1580.000ns
H=000010 N=000001 rfb=0 rd=0
time = 1580.000ns
{}
{=== All Tests Complete ===}
{FSM verified for:}
{  - Basic state transitions}
{  - Load and iter sequences}
{  - Reset from all states}
{  - Load/iter from non-h1 states}
{  - Output signal correctness}
{  - One-hot encoding integrity}
{  - Multiple consecutive operations}
time = 1620.000ns
H=000001 N=100000
time = 1620.000ns
{Final state: back to h1 (ready)}
(command line, 1): assertion failed on 'H' 000001 (100000)
(lab4) 50 %