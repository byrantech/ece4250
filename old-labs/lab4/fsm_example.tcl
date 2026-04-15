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
(lab4) 49 % @ fsm_init.irsim
time = 10.000ns
{=== Initialized clock ===}
time = 50.000ns
time = 60.000ns
{=== Resetting ===}
time = 100.000ns
time = 140.000ns
(lab4) 50 % d H N
H=100000 N=100000 
time = 140.000ns
(lab4) 51 % h load
(lab4) 52 % p
time = 150.000ns
(lab4) 53 % d H N clock
H=100000 N=001000 CLOCK=10 
time = 150.000ns
(lab4) 54 % p
time = 160.000ns
(lab4) 55 % d H N clock
H=100000 N=001000 CLOCK=00 
time = 160.000ns
(lab4) 56 % p
time = 170.000ns
(lab4) 57 % d H N clock
H=001000 N=000100 CLOCK=01 
time = 170.000ns
(lab4) 58 % d ld
ld=1 
time = 170.000ns
(lab4) 59 % p
time = 180.000ns
(lab4) 60 % d H N clock
H=001000 N=000100 CLOCK=00 
time = 180.000ns
(lab4) 61 % p
time = 190.000ns
(lab4) 62 % d H N clock
H=001000 N=000100 CLOCK=10 
time = 190.000ns
(lab4) 63 % d reg1w
reg1w=1 
time = 190.000ns
(lab4) 64 % d ld
ld=0 
time = 190.000ns
(lab4) 65 % 