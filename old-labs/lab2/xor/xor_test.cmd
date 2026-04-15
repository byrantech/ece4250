# Initialize power
h Vdd!
l GND!
s

echo "=== XOR Gate Test ==="

# Test case 1: A=0, B=0 (expect out=0)
echo "Test 1: A=0, B=0, Expected out=0"
l A
l B
s
assert out l

# Test case 2: A=0, B=1 (expect out=1)
echo "Test 2: A=0, B=1, Expected out=1"
l A
h B
s
assert out h

# Test case 3: A=1, B=0 (expect out=1)
echo "Test 3: A=1, B=0, Expected out=1"
h A
l B
s
assert out h

# Test case 4: A=1, B=1 (expect out=0)
echo "Test 4: A=1, B=1, Expected out=0"
h A
h B
s
assert out l

echo "=== All XOR Tests Complete ==="

# Display waveforms for all signals
ana A B out