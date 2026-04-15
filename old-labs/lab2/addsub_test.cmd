# Initialize power
h Vdd!
l GND!
s

echo "=== Add/Subtract Unit Test ==="
echo ""
echo "--- ADDITION TESTS (cin=0) ---"

# Test case 1: a=0, b=0, cin=0 (0+0=0, expect s=0, cout=0)
echo "Test 1: ADD: 0+0, Expected s=0, cout=0"
l a
l b
l cin
s
assert s l
assert cout l

# Test case 2: a=0, b=1, cin=0 (0+1=1, expect s=1, cout=0)
echo "Test 2: ADD: 0+1, Expected s=1, cout=0"
l a
h b
l cin
s
assert s h
assert cout l

# Test case 3: a=1, b=0, cin=0 (1+0=1, expect s=1, cout=0)
echo "Test 3: ADD: 1+0, Expected s=1, cout=0"
h a
l b
l cin
s
assert s h
assert cout l

# Test case 4: a=1, b=1, cin=0 (1+1=2, expect s=0, cout=1)
echo "Test 4: ADD: 1+1, Expected s=0, cout=1"
h a
h b
l cin
s
assert s l
assert cout h

echo ""
echo "--- SUBTRACTION TESTS (cin=1) ---"

# Test case 5: a=0, b=0, cin=1 (0-0=0, expect s=0, cout=1)
echo "Test 5: SUB: 0-0, Expected s=0, cout=1 (no borrow)"
l a
l b
h cin
s
assert s l
assert cout h

# Test case 6: a=0, b=1, cin=1 (0-1=-1, expect s=1, cout=0)
echo "Test 6: SUB: 0-1, Expected s=1, cout=0 (borrow)"
l a
h b
h cin
s
assert s h
assert cout l

# Test case 7: a=1, b=0, cin=1 (1-0=1, expect s=1, cout=1)
echo "Test 7: SUB: 1-0, Expected s=1, cout=1 (no borrow)"
h a
l b
h cin
s
assert s h
assert cout h

# Test case 8: a=1, b=1, cin=1 (1-1=0, expect s=0, cout=1)
echo "Test 8: SUB: 1-1, Expected s=0, cout=1 (no borrow)"
h a
h b
h cin
s
assert s l
assert cout h

echo ""
echo "=== All Add/Subtract Unit Tests Complete ==="

# Display waveforms for all signals
ana a b cin s cout
