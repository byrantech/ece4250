# Initialize power
h Vdd!
l GND!
s

echo "=== Add/Subtract Unit Test ==="

# Test case 1: a=0, b=0, cin=0 (expect s=0, cout=0)
echo "Test 1: a=0, b=0, cin=0, Expected s=0, cout=0"
l a
l b
l cin
s
assert s l
assert cout l

# Test case 2: a=0, b=0, cin=1 (expect s=1, cout=0)
echo "Test 2: a=0, b=0, cin=1, Expected s=1, cout=0"
l a
l b
h cin
s
assert s h
assert cout l

# Test case 3: a=0, b=1, cin=0 (expect s=1, cout=0)
echo "Test 3: a=0, b=1, cin=0, Expected s=1, cout=0"
l a
h b
l cin
s
assert s h
assert cout l

# Test case 4: a=0, b=1, cin=1 (expect s=0, cout=1)
echo "Test 4: a=0, b=1, cin=1, Expected s=0, cout=1"
l a
h b
h cin
s
assert s l
assert cout h

# Test case 5: a=1, b=0, cin=0 (expect s=1, cout=0)
echo "Test 5: a=1, b=0, cin=0, Expected s=1, cout=0"
h a
l b
l cin
s
assert s h
assert cout l

# Test case 6: a=1, b=0, cin=1 (expect s=0, cout=1)
echo "Test 6: a=1, b=0, cin=1, Expected s=0, cout=1"
h a
l b
h cin
s
assert s l
assert cout h

# Test case 7: a=1, b=1, cin=0 (expect s=0, cout=1)
echo "Test 7: a=1, b=1, cin=0, Expected s=0, cout=1"
h a
h b
l cin
s
assert s l
assert cout h

# Test case 8: a=1, b=1, cin=1 (expect s=1, cout=1)
echo "Test 8: a=1, b=1, cin=1, Expected s=1, cout=1"
h a
h b
h cin
s
assert s h
assert cout h

echo "=== All Add/Subtract Unit Tests Complete ==="

# Display waveforms for all signals
ana a b cin s cout
