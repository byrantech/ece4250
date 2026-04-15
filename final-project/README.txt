Universal Random Number Generator

By: Byran Huang, Peter Bowman-Davis, Steven Zhou, and Yiannis Scotiniadis


Top-level design file: ring.mag

This chip generates four different random distributions from a single design.

---
I/O SIGNALS
---

Outputs (active high):
  right_0 to right_7 - 8-bit result (selected distribution output)

  In IRSIM: vector result right_0 right_1 right_2 right_3 right_4 right_5 right_6 right_7

Inputs:
  phi0, phi1    - Two-phase non-overlapping clock
  reset         - System reset (active high)

  left_4        - Config bit 0 (distribution select)
  left_5        - Config bit 1 (distribution select)
  left_3        - Seed enable (set high to load seeds into LFSRs)

  top_3         - Uniform LFSR seed input
  top_4         - Sqrt LFSR seed input
  top_5         - Log LFSR seed input
  bottom_0..4   - CLT LFSR seed inputs (5 total)

Power:
  Vdd!, GND!

Distribution select (config = left_5, left_4):
  00 - Uniform      (raw LFSR, 8-bit)
  01 - Sqrt         (Rayleigh-like, Q4.4 format)
  10 - CLT          (Gaussian-like, sum of 5 uniforms)
  11 - Log          (Exponential-like, Q3.5 format)

---
HOW TO TEST
---

Load in IRSIM:
  irsim ring.sim full_test.irsim

Basic steps:
  1. Set up power and clock
     h Vdd!
     l GND!
     vector CLOCK phi0 phi1
     clock CLOCK 00 10 00 01
     l reset
     s

  2. Define vectors
     vector result right_0 right_1 right_2 right_3 right_4 right_5 right_6 right_7
     vector config left_5 left_4

  3. Seed the LFSRs (required before use)
     h left_3
     h top_3 top_4 top_5 bottom_4 bottom_3 bottom_2 bottom_1 bottom_0
     c
     ... (clock in your 8 bit seed pattern. Note: CLT must have different seeds)
     l left_3

  4. Select distribution and sample
     setvector config 00    (or 01, 10, 11)
     c
     d result

You can then use analyze_full_test.py with the log file of the irsim results to generate histograms.

analyze_full_test.py full_distr_sample.tcl

---
DESIGN ARCHITECTURE
---

  Seed Inputs & Clock
         |
         v
  +------------+   +------------+   +-------------------+   +------------+
  |   LFSR     |   |   LFSR     |   | LFSR x5 (5 indep) |   |   LFSR     |
  | (uniform)  |   |  (sqrt)    |   |      (clt)        |   |   (log)    |
  +-----+------+   +-----+------+   +--------+----------+   +-----+------+
        |                |                   |                    |
        |                v                   v                    v
        |          +-----------+       +-----------+        +-----------+
        |          |   Sqrt    |       |    CLT    |        |    Log    |
        |          |   Linear  |       |   Adder   |        |    LUT    |
        |          |  Approx   |       | (5 -> 1)  |        |   Approx  |
        |          +-----------+       +-----------+        +-----------+
        |                |                   |                    |
        v                v                   v                    v
  +---------------------------------------------------------------+
  |               4-to-1 8-bit Multiplexer                        |
  |                    (config select)                            |
  |     00=Uniform      01=Sqrt      10=CLT      11=Log           |
  +---------------------------------------------------------------+
                                |
                                v
                        Output Pads (right_0..7)

  Total LFSRs: 8 (1 uniform + 1 sqrt + 5 clt + 1 log)

Blocks:
  - LFSR: 8-bit maximal-length, XOR feedback, period 255
  - Sqrt: Piecewise linear approx of sqrt(-2*ln(x/256))
  - Log: LUT approx of -ln(x/256)
  - CLT: Sums 5 independent uniform values for Gaussian
  - MUX: 4-to-1 8-bit output selector


---
EXPECTED OUTPUTS
---

Uniform (config=00):
  Range 0-255, flat histogram

Sqrt/Rayleigh (config=01):
  Range 0 to ~3.5 (Q4.4, divide raw output by 16)
  Rayleigh-shaped, peaks around 1.0

CLT/Gaussian (config=10):
  Range ~80 to ~175, centered around 127
  Bell curve shape

Log/Exponential (config=11):
  Range 0 to ~5.5 (Q3.5, divide raw output by 32)
  Exponential decay shape
