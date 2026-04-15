# FSM Example Walkthrough

## Scenario: Reset → Load 0xAA → Iter → Iter

This traces the FSM through a complete sequence of operations.

---

## Initial: Power-On / Reset

### Cycle -1 (before reset): State = IDLE (busy=0, cycle_bit=X)
```
Inputs: reset=1, load=0, iter=0
Status: ready=1

phi0: Nothing happens (idle)
phi1: next_busy = reset | ... = 1
      → busy latch captures: busy ← 1
      cycle_bit_next = busy & ~cycle_bit & ~reset = 0 (reset prevents)
      → cycle_bit latch captures: cycle_bit ← 0
```

**Next state: CYC0 (busy=1, cycle_bit=0)**

---

### Cycle 0 (RESET operation): State = CYC0 (busy=1, cycle_bit=0)
```
Inputs: reset=1, load=0, iter=0
Status: ready=0 (busy=1)
Decodes: doing_reset=1, doing_load=0, doing_iter=0
         cycle_0=1, cycle_1=0

phi0: g3=g2=g1=g0=0 (fblock configured for zeros)
      fblock output = 0x00

phi1: rfb=1 (need_zeros = doing_reset & cycle_0 = 1)
      → rfb latch captures fblock output → wz ← 0x00
      w1=1 (reg0_write)
      → register_0 writes wz → x ← 0x00

      next_busy = reset | ... = 1 (still in reset)
      → busy ← 1
      cycle_bit_next = busy & ~cycle_bit & ~reset = 1 & 1 & 0 = 0
      → cycle_bit ← 0

      Wait, reset=1 so cycle_bit_next=0
```

Actually, let me reconsider. If reset stays high, we stay in cycle 0. Let me assume reset is pulsed for just the initial entry.

Let me restart with clearer reset behavior:

---

## Better Example: Clean Reset Pulse

### Initial State: Unknown → Assert Reset

**Before any clocks, set inputs:**
```
reset=1, load=0, iter=0
Status: Assume busy=0 initially (or X)
```

### Cycle 0 (RESET): State = CYC0 (busy=1, cycle_bit=0)

```
State: busy=1, cycle_bit=0 (entered because reset=1)
Decodes: doing_reset=1, cycle_0=1

phi0:
  - g3=g2=g1=g0 = 0 (fblock outputs all zeros)
  - fblock computes: 0x00

phi1:
  - rfb=1 → rfb latch captures → wz = 0x00
  - w1=1 → reg0 writes wz → x ← 0x00
  - next_busy = 1 (continue_op = busy & ~cycle_bit = 1)
  - cycle_bit_next = 0 (because reset=1 inhibits)

State latches update:
  - busy ← 1 (stays busy)
  - cycle_bit ← 0 (stays at 0 while reset=1)
```

**Hmm, this is confusing. Let me clarify the reset behavior properly.**

Actually, looking at the logic again:
- `cycle_bit_next = busy & ~cycle_bit & ~reset`

If reset=1, then cycle_bit_next=0, so we stay in cycle_0 forever. That's wrong.

Let me re-examine the reference:
- The cycle_bit should advance when `busy & ~cycle_bit & ~reset`
- This means during reset operation, if reset stays high, cycle_bit won't advance
- So reset should only be pulsed to start the operation, then released

Let me trace it correctly:

---

## Corrected Example

### Cycle -1: Power-on (reset pulse)
```
Before: busy=0 (IDLE), ready=1
Input: reset=1 (pulse high)

phi0: Sample reset=1
phi1: next_busy = 1 (reset is high)
      → busy ← 1
      cycle_bit_next = 1 & 1 & 0 = 0 (reset blocks)
      → cycle_bit ← 0

After: busy=1, cycle_bit=0 (CYC0)
Now release reset (reset←0)
```

### Cycle 0: RESET operation, CYC0
```
State: busy=1, cycle_bit=0
Input: reset=0, load=0, iter=0
Decodes: doing_reset=0 (reset=0 now!), cycle_0=1

phi0:
  - g3=g2=g1=g0 = 0
  - fblock → 0x00

phi1:
  - rfb=0 (need_zeros = 0 because doing_reset=0)
  - w1=0
  - next_busy = continue_op = busy & ~cycle_bit = 1 & 1 = 1
  - cycle_bit_next = busy & ~cycle_bit & ~reset = 1 & 1 & 1 = 1

After: busy=1, cycle_bit=1 (CYC1)
```

Wait, this is still confusing because reset being 0 means doing_reset=0.

Let me look at the reference document more carefully. The issue is: should reset be held high for the entire 2 cycles, or pulsed?

Looking at `doing_reset = reset & busy`, if reset is pulsed and then goes low, doing_reset becomes 0, which breaks the operation.

I think the correct interpretation is:
- Reset should be held high for the entire operation duration
- Or the FSM should latch which operation to perform

Actually, the simpler interpretation from the reference is that the command (reset/load/iter) should be held stable for the entire 2-cycle operation. Let me trace it that way:

</thinking>

<function_calls>
<invoke name="search_replace">
<parameter name="file_path">/Users/byran/OrbStack/docker/containers/vlsi-desktop/root/Downloads/vlsi-files/lab4/fsm_simple.md
