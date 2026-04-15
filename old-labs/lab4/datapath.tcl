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
(lab3) 49 % @ datapath.irsim
time = 10.000ns
{=== Initializing all control signals ===}
time = 20.000ns
{=== Datapath Functional Tests ===}
{}
{=== Test 1: Initialize reg1 with 0x2A (00101010) ===}
{Set inputs to 00101010}
time = 30.000ns
{Enable input latch to pass data to wz bus}
time = 40.000ns
{Write to reg1}
time = 50.000ns
time = 60.000ns
{Disable input latch}
time = 70.000ns
{}
{=== Test 2: Initialize reg2 with 0x15 (00010101) ===}
{Set inputs to 00010101}
time = 80.000ns
{Enable input latch}
time = 90.000ns
{Write to reg2}
time = 100.000ns
time = 110.000ns
{Disable input latch}
time = 120.000ns
{}
{=== Test 3: Verify reg1 contents ===}
{Read reg1 port 1 to rx bus, then through rd latch to output}
time = 130.000ns
time = 140.000ns
{Output should be 00101010}
critical path for last transition of out0:
  rd -> 1 @ 130.000ns , node was an input
  out0 -> 0 @ 130.042ns   (0.042ns)
critical path for last transition of out7:
  rd -> 1 @ 130.000ns , node was an input
  out7 -> 0 @ 130.042ns   (0.042ns)
{Disable read}
time = 150.000ns
{}
{=== Test 4: Verify reg2 contents ===}
{Read reg2 port 1 to rx bus, then through rd latch to output}
time = 160.000ns
time = 170.000ns
{Output should be 00010101}
{Disable read}
time = 180.000ns
{}
{=== Test 5: Addition (reg1 + reg2 = 0x2A + 0x15 = 0x3F) ===}
{Step 1: Read reg1 to rx bus (port 1), reg2 to ry bus (port 2)}
time = 190.000ns
{Step 2: Set cin=0 for addition}
time = 200.000ns
{Step 3: Enable addsub output latch to capture result on wz}
time = 210.000ns
{Step 4: Disable all reads BEFORE writing}
time = 220.000ns
{Step 5: Write result to reg1}
time = 230.000ns
time = 240.000ns
{Step 6: Disable addsub latch}
time = 250.000ns
{Step 7: Verify result in reg1}
time = 260.000ns
time = 270.000ns
{Output should be 00111111 (0x3F = 63)}
critical path for last transition of out0:
  transition of latch_4/latch_one_0[0]/new_latch_0/a_82_52#, which has since changed again
  out0 -> 1 @ 160.059ns   (?)
critical path for last transition of out7:
  transition of rd, which has since changed again
  out7 -> 0 @ 130.042ns   (?)
time = 280.000ns
{}
{=== Test 6: Addition 0x3F + 0x2A = 0x54 ===}
{Load 0x2A into reg2}
time = 290.000ns
time = 300.000ns
time = 310.000ns
time = 320.000ns
time = 330.000ns
{Read both registers}
time = 340.000ns
{Addition (cin=0)}
time = 350.000ns
{Enable addsub latch}
time = 360.000ns
{Disable reads}
time = 370.000ns
{Write to reg1}
time = 380.000ns
time = 390.000ns
{Disable latch}
time = 400.000ns
{Verify result}
time = 410.000ns
time = 420.000ns
{Output should be 01101001 (0x68 = 104)}
time = 430.000ns
{}
{=== Test 7: Addition 0x80 + 0x80 = 0x00 (with carry) ===}
{Load 0x80 into reg1}
time = 440.000ns
time = 450.000ns
time = 460.000ns
time = 470.000ns
time = 480.000ns
{Load 0x80 into reg2}
time = 490.000ns
time = 500.000ns
time = 510.000ns
time = 520.000ns
time = 530.000ns
{Read both registers}
time = 540.000ns
Addition
time = 550.000ns
{Enable addsub latch}
time = 560.000ns
{Disable reads}
time = 570.000ns
{Write to reg1}
time = 580.000ns
time = 590.000ns
{Disable latch}
time = 600.000ns
{Verify result}
time = 610.000ns
time = 620.000ns
{Output should be 00000000 (0x00, carry out ignored)}
time = 630.000ns
{}
{=== Test 8: Subtraction (0x00 - 0x80 = 0x80 with wrap) ===}
{reg1 already has 0x00, reg2 has 0x80}
{Read both registers}
time = 640.000ns
{Subtraction (cin=1)}
time = 650.000ns
{Enable addsub latch}
time = 660.000ns
{Disable reads}
time = 670.000ns
{Write to reg1}
time = 680.000ns
time = 690.000ns
{Disable latch and cin}
time = 700.000ns
{Verify result}
time = 710.000ns
time = 720.000ns
{Output should be 10000000 (0x80 = 128)}
time = 730.000ns
{}
{=== Test 9: Subtraction 0xFF - 0x01 = 0xFE ===}
{Load 0xFF into reg1}
time = 740.000ns
time = 750.000ns
time = 760.000ns
time = 770.000ns
time = 780.000ns
{Load 0x01 into reg2}
time = 790.000ns
time = 800.000ns
time = 810.000ns
time = 820.000ns
time = 830.000ns
{Read both registers}
time = 840.000ns
Subtraction
time = 850.000ns
{Enable addsub latch}
time = 860.000ns
{Disable reads}
time = 870.000ns
{Write to reg1}
time = 880.000ns
time = 890.000ns
{Disable latch and cin}
time = 900.000ns
{Verify result}
time = 910.000ns
time = 920.000ns
{Output should be 11111110 (0xFE = 254)}
time = 930.000ns
{}
{=== Test 10: Subtraction 0x00 - 0x01 = 0xFF (underflow) ===}
{Load 0x00 into reg1}
time = 940.000ns
time = 950.000ns
time = 960.000ns
time = 970.000ns
time = 980.000ns
{Load 0x01 into reg2}
time = 990.000ns
time = 1000.000ns
time = 1010.000ns
time = 1020.000ns
time = 1030.000ns
{Read both registers}
time = 1040.000ns
Subtraction
time = 1050.000ns
{Enable addsub latch}
time = 1060.000ns
{Disable reads}
time = 1070.000ns
{Write to reg1}
time = 1080.000ns
time = 1090.000ns
{Disable latch and cin}
time = 1100.000ns
{Verify result}
time = 1110.000ns
time = 1120.000ns
{Output should be 11111111 (0xFF = 255)}
time = 1130.000ns
{}
{=== Test 11: Function Block AND ===}
{Load 0xF0 into reg1}
time = 1140.000ns
time = 1150.000ns
time = 1160.000ns
time = 1170.000ns
time = 1180.000ns
{Load 0x55 into reg2}
time = 1190.000ns
time = 1200.000ns
time = 1210.000ns
time = 1220.000ns
time = 1230.000ns
{Configure fblock for AND: g0=0, g1=0, g2=0, g3=1}
time = 1240.000ns
{Read both registers}
time = 1250.000ns
{Enable function block latch}
time = 1260.000ns
{Disable reads}
time = 1270.000ns
{Write result to reg1}
time = 1280.000ns
time = 1290.000ns
{Disable fblock latch}
time = 1300.000ns
{Verify: 0xF0 & 0x55 = 0x50}
time = 1310.000ns
time = 1320.000ns
time = 1330.000ns
{}
{=== Test 12: Function Block OR ===}
{Configure fblock for OR: g0=0, g1=1, g2=1, g3=1}
time = 1340.000ns
{Read reg1 (0x50) and reg2 (0x55)}
time = 1350.000ns
{Enable fblock latch}
time = 1360.000ns
{Disable reads}
time = 1370.000ns
{Write result to reg2}
time = 1380.000ns
time = 1390.000ns
{Disable fblock latch}
time = 1400.000ns
{Verify: 0x50 | 0x55 = 0x55}
time = 1410.000ns
time = 1420.000ns
time = 1430.000ns
{}
{=== Test 13: Function Block XOR ===}
{Configure fblock for XOR: g0=0, g1=1, g2=1, g3=0}
time = 1440.000ns
{Read reg1 (0x50) and reg2 (0x55)}
time = 1450.000ns
{Enable fblock latch}
time = 1460.000ns
{Disable reads}
time = 1470.000ns
{Write result to reg1}
time = 1480.000ns
time = 1490.000ns
{Disable fblock latch}
time = 1500.000ns
{Verify: 0x50 ^ 0x55 = 0x05}
time = 1510.000ns
time = 1520.000ns
time = 1530.000ns
{}
{=== Test 14: Left Shift ===}
{Load 0x15 (00010101) into reg1}
time = 1540.000ns
time = 1550.000ns
time = 1560.000ns
time = 1570.000ns
time = 1580.000ns
{Configure shift: s=1 (enable), u=1 (left shift)}
time = 1590.000ns
{Read reg1}
time = 1600.000ns
{Enable shift output latch}
time = 1610.000ns
{Disable read}
time = 1620.000ns
{Write result to reg1}
time = 1630.000ns
time = 1640.000ns
{Disable shift latch and controls}
time = 1650.000ns
{Verify: 0x15 << 1 = 0x2A}
time = 1660.000ns
time = 1670.000ns
critical path for last transition of out0:
  rd -> 1 @ 1660.000ns , node was an input
  out0 -> 0 @ 1660.042ns   (0.042ns)
critical path for last transition of out7:
  transition of rd, which has since changed again
  out7 -> 0 @ 1310.042ns   (?)
time = 1680.000ns
{}
{=== Test 15: Right Shift ===}
{Configure shift: s=1 (enable), u=0 (right shift)}
time = 1690.000ns
{Read reg1 (0x2A)}
time = 1700.000ns
{Enable shift latch}
time = 1710.000ns
{Disable read}
time = 1720.000ns
{Write result to reg1}
time = 1730.000ns
time = 1740.000ns
{Disable shift latch and control}
time = 1750.000ns
{Verify: 0x2A >> 1 = 0x15}
time = 1760.000ns
time = 1770.000ns
time = 1780.000ns
{}
{=== Test 16: No Shift (pass through) ===}
{Load 0xAA (10101010) into reg1}
time = 1790.000ns
time = 1800.000ns
time = 1810.000ns
time = 1820.000ns
time = 1830.000ns
{Configure shift: s=0 (disable)}
time = 1840.000ns
{Read reg1}
time = 1850.000ns
{Enable shift latch (should pass through)}
time = 1860.000ns
{Disable read}
time = 1870.000ns
{Write to reg2}
time = 1880.000ns
time = 1890.000ns
{Disable shift latch}
time = 1900.000ns
{Verify: output = input = 0xAA}
time = 1910.000ns
time = 1920.000ns
time = 1930.000ns
{}
{=== Test 17: Complex Operation Chain ===}
{Load 0x0F into reg1}
time = 1940.000ns
time = 1950.000ns
time = 1960.000ns
time = 1970.000ns
time = 1980.000ns
{Load 0x03 into reg2}
time = 1990.000ns
time = 2000.000ns
time = 2010.000ns
time = 2020.000ns
time = 2030.000ns
{Step 1: Add reg1 + reg2 (0x0F + 0x03 = 0x12)}
time = 2040.000ns
time = 2050.000ns
time = 2060.000ns
time = 2070.000ns
time = 2080.000ns
time = 2090.000ns
time = 2100.000ns
{Step 2: Left shift result (0x12 << 1 = 0x24)}
time = 2110.000ns
time = 2120.000ns
time = 2130.000ns
time = 2140.000ns
time = 2150.000ns
time = 2160.000ns
time = 2170.000ns
{Verify final result: 0x24 (00100100)}
time = 2180.000ns
time = 2190.000ns
time = 2200.000ns
{}
{=== Test 18: Dual Port Read Simultaneous ===}
{Load 0x12 into reg1}
time = 2210.000ns
time = 2220.000ns
time = 2230.000ns
time = 2240.000ns
time = 2250.000ns
{Load 0x34 into reg2}
time = 2260.000ns
time = 2270.000ns
time = 2280.000ns
time = 2290.000ns
time = 2300.000ns
{Read both registers on different ports simultaneously}
time = 2310.000ns
{Add them (cin=0)}
time = 2320.000ns
time = 2330.000ns
{Disable reads}
time = 2340.000ns
{Write result to reg1}
time = 2350.000ns
time = 2360.000ns
{Disable latch}
time = 2370.000ns
{Verify: 0x12 + 0x34 = 0x46}
time = 2380.000ns
time = 2390.000ns
time = 2400.000ns
{}
{=== Test 19: All Zeros ===}
time = 2410.000ns
time = 2420.000ns
time = 2430.000ns
time = 2440.000ns
time = 2450.000ns
time = 2460.000ns
time = 2470.000ns
time = 2480.000ns
{}
{=== Test 20: All Ones ===}
time = 2490.000ns
time = 2500.000ns
time = 2510.000ns
time = 2520.000ns
time = 2530.000ns
time = 2540.000ns
time = 2550.000ns
time = 2560.000ns
{}
{=== All Datapath Tests Complete ===}
{Running timing analysis...}
(lab3) 50 % 