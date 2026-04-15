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
(lab4) 49 % @ sys.irsim
time = 10.000ns
time = 20.000ns
(lab4) 50 % setvector datapath_in 01010101
(lab4) 51 % h reset
(lab4) 52 % c
time = 60.000ns
(lab4) 53 % l reset
(lab4) 54 % c
time = 100.000ns
(lab4) 55 % p
time = 110.000ns
(lab4) 56 % h reset
(lab4) 57 % c
time = 150.000ns
(lab4) 58 % l reset
(lab4) 59 % c
time = 190.000ns
(lab4) 60 % h load
(lab4) 61 % c
time = 230.000ns
(lab4) 62 % l load
(lab4) 63 % c
time = 270.000ns
(lab4) 64 % d datapath_out
DATAPATH_OUT=00000000
time = 270.000ns
(lab4) 65 % d reg1d0
reg1d0=1
time = 270.000ns
(lab4) 66 % d h n clock
H=000100 N=100000 CLOCK=00
time = 270.000ns
(lab4) 67 % h iter
(lab4) 68 % c
time = 310.000ns
(lab4) 69 % l iter
(lab4) 70 % c
time = 350.000ns
(lab4) 71 % d datapath_out
DATAPATH_OUT=00000000
time = 350.000ns
(lab4) 72 % d h n clock
H=100000 N=100000 CLOCK=00
time = 350.000ns
(lab4) 73 % h iter
(lab4) 74 % p
time = 360.000ns
(lab4) 75 % d h n clock
H=100000 N=000010 CLOCK=10
time = 360.000ns
(lab4) 76 % p
time = 370.000ns
(lab4) 77 % p
time = 380.000ns
(lab4) 78 % d h n clock
H=000010 N=000001 CLOCK=01
time = 380.000ns
(lab4) 79 % d reg0r0
reg0r0=1
time = 380.000ns
(lab4) 80 % d ros
ros=1
time = 380.000ns
(lab4) 81 % d wz
wz=00000000
time = 380.000ns
(lab4) 82 % p
time = 390.000ns
(lab4) 83 % p
time = 400.000ns
(lab4) 84 % d reg0w
reg0w=1
time = 400.000ns
(lab4) 85 % p
time = 410.000ns
(lab4) 86 % p
time = 420.000ns
(lab4) 87 % d reg0r0
reg0r0=1
time = 420.000ns
(lab4) 88 % d reg1r1
reg1r1=1
time = 420.000ns
(lab4) 89 % d datapath_0/g1
datapath_0/g1=1
time = 420.000ns
(lab4) 90 % d rfb
rfb=1
time = 420.000ns
(lab4) 91 % p
time = 430.000ns
(lab4) 92 % d wz
wz=10101010
time = 430.000ns
(lab4) 93 % p
time = 440.000ns
(lab4) 94 % d wz
wz=10101010
time = 440.000ns
(lab4) 95 % d h n clock
H=000001 N=100000 CLOCK=10
time = 440.000ns
(lab4) 96 % d reg0w
reg0w=1
time = 440.000ns
(lab4) 97 % d reg0r0
reg0r0=1
time = 440.000ns
(lab4) 98 % d rd
rd=1
time = 440.000ns
(lab4) 99 % p
time = 450.000ns
(lab4) 100 % d wz
wz=10101010
time = 450.000ns
(lab4) 101 % d datapath_0/rx0
datapath_0/rx0=1
time = 450.000ns
(lab4) 102 % d datapath_out
DATAPATH_OUT=01010101
time = 450.000ns
(lab4) 103 % d h n clock
H=000001 N=100000 CLOCK=00
time = 450.000ns
(lab4) 104 % p
time = 460.000ns
(lab4) 105 % d h n clock
H=100000 N=000010 CLOCK=01
time = 460.000ns
(lab4) 106 % p
time = 470.000ns
(lab4) 107 % p
time = 480.000ns
(lab4) 108 % p
time = 490.000ns
(lab4) 109 % p
time = 500.000ns
(lab4) 110 % d h n clock
H=000010 N=000001 CLOCK=01
time = 500.000ns
(lab4) 111 % p
time = 510.000ns
(lab4) 112 % d h n clock
H=000010 N=000001 CLOCK=00
time = 510.000ns
(lab4) 113 % d datapath_out
DATAPATH_OUT=01010101
time = 510.000ns
(lab4) 114 % c
time = 550.000ns
(lab4) 115 % d datapath_out
DATAPATH_OUT=10101010
time = 550.000ns
(lab4) 116 % c
time = 590.000ns
(lab4) 117 % d datapath_out
DATAPATH_OUT=11111111
time = 590.000ns
(lab4) 118 % c
time = 630.000ns
(lab4) 119 % c
time = 670.000ns
(lab4) 120 % d datapath_out
DATAPATH_OUT=11111110
time = 670.000ns
(lab4) 121 % c
time = 710.000ns
(lab4) 122 % d datapath_out
DATAPATH_OUT=10101011
time = 710.000ns
(lab4) 123 % c
time = 750.000ns
(lab4) 124 % c
time = 790.000ns
(lab4) 125 % d datapath_out
DATAPATH_OUT=01010110
time = 790.000ns
(lab4) 126 % c
time = 830.000ns
(lab4) 127 % d datapath_out
DATAPATH_OUT=00000011
time = 830.000ns
(lab4) 128 % d h1
h1=1
time = 830.000ns
(lab4) 129 % c
time = 870.000ns
(lab4) 130 % d h1
h1=0
time = 870.000ns
(lab4) 131 % c
time = 910.000ns
(lab4) 132 % d h1
h1=0
time = 910.000ns
(lab4) 133 % c
time = 950.000ns
(lab4) 134 % d h1
h1=1
time = 950.000ns
(lab4) 135 % d datapath_out
DATAPATH_OUT=01010011
time = 950.000ns
(lab4) 136 %