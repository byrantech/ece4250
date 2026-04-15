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
154 nodes, 225 aliases; transistors: n-channel=133 p-channel=133
parallel txtors:none
Main console display active (Tcl8.6.14 / Tk8.6.14)
(lab4) 49 % h Vdd!
(lab4) 50 % l GND!
(lab4) 51 % s
time = 10.000ns
(lab4) 52 % vector CLOCK phi0 phi1
(lab4) 53 % vector H h1 h2 h3 h4 h5 h6
(lab4) 54 % vector N nh1 nh2 nh3 nh4 nh5 nh6
(lab4) 55 % vector INPUT reset load iter
(lab4) 56 % setvector INPUT 000
(lab4) 57 % s
time = 20.000ns
(lab4) 58 % clock CLOCK 00 10 00 01
(lab4) 59 % c
time = 60.000ns
(lab4) 60 % d clock H N
CLOCK=01 H=X00X0X N=X00000 
time = 60.000ns
(lab4) 61 % p
time = 70.000ns
(lab4) 62 % d clock H N
CLOCK=00 H=X00X0X N=X00000 
time = 70.000ns
(lab4) 63 % h reset
(lab4) 64 % c
time = 110.000ns
(lab4) 65 % d H N
H=010000 N=010000 
time = 110.000ns
(lab4) 66 % c
time = 150.000ns
(lab4) 67 % d H N
H=010000 N=010000 
time = 150.000ns
(lab4) 68 % d H N clock
H=010000 N=010000 CLOCK=00 
time = 150.000ns
(lab4) 69 % l reset
(lab4) 70 % c
time = 190.000ns
(lab4) 71 % d H N
H=100000 N=100000 
time = 190.000ns
(lab4) 72 % setvector INPUT 010
(lab4) 73 % c
time = 230.000ns
(lab4) 74 % d H N clock
H=001000 N=000100 CLOCK=00 
time = 230.000ns
(lab4) 75 % c
time = 270.000ns
(lab4) 76 % d H N clock
H=000100 N=100000 CLOCK=00 
time = 270.000ns
(lab4) 77 % c
time = 310.000ns
(lab4) 78 % d H N clock
H=100000 N=001000 CLOCK=00 
time = 310.000ns
(lab4) 79 % l load
(lab4) 80 % c
time = 350.000ns
(lab4) 81 % l load
(lab4) 82 % d H N clock
H=100000 N=100000 CLOCK=00 
time = 350.000ns
(lab4) 83 % h iter
(lab4) 84 % c
time = 390.000ns
(lab4) 85 % d H N clock
H=000010 N=000001 CLOCK=00 
time = 390.000ns
(lab4) 86 % c
time = 430.000ns
(lab4) 87 % d H N clock
H=000001 N=100000 CLOCK=00 
time = 430.000ns
(lab4) 88 % c
time = 470.000ns
(lab4) 89 % d H N clock
H=100000 N=000010 CLOCK=00 
time = 470.000ns
(lab4) 90 % c
time = 510.000ns
(lab4) 91 % d H N clock
H=000010 N=000001 CLOCK=00 
time = 510.000ns
(lab4) 92 % l iter
(lab4) 93 % d H N clock
H=000010 N=000001 CLOCK=00 
time = 510.000ns
(lab4) 94 % c
time = 550.000ns
(lab4) 95 % d H N clock
H=000001 N=100000 CLOCK=00 
time = 550.000ns
(lab4) 96 % c
time = 590.000ns
(lab4) 97 % d H N clock
H=100000 N=100000 CLOCK=00 
time = 590.000ns
(lab4) 98 % 