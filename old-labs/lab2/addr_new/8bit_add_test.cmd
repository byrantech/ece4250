h Vdd!
l GND!
s

vector a_inputs a7 a6 a5 a4 a3 a2 a1 a0
vector b_inputs b7 b6 b5 b4 b3 b2 b1 b0
vector sum_outputs s7 s6 s5 s4 s3 s2 s1 s0

echo "=== Addition Tests (cin=0) ==="
l cin
s

echo "A=00000000, B=00000000, S=00000000"
setvector a_inputs 00000000
setvector b_inputs 00000000
s
assert sum_outputs 00000000
assert cout l

echo "A=00000001, B=00000001, S=00000010"
setvector a_inputs 00000001
setvector b_inputs 00000001
s
assert sum_outputs 00000010
assert cout l

echo "A=11111111, B=00000001, S=00000000"
setvector a_inputs 11111111
setvector b_inputs 00000001
s
assert sum_outputs 00000000
assert cout h

echo "A=00001111, B=00001111, S=00011110"
setvector a_inputs 00001111
setvector b_inputs 00001111
s
assert sum_outputs 00011110
assert cout l

echo "A=10000000, B=10000000, S=00000000"
setvector a_inputs 10000000
setvector b_inputs 10000000
s
assert sum_outputs 00000000
assert cout h

echo "A=01111111, B=00000001, S=10000000"
setvector a_inputs 01111111
setvector b_inputs 00000001
s
assert sum_outputs 10000000
assert cout l

echo "A=11111111, B=11111111, S=11111110"
setvector a_inputs 11111111
setvector b_inputs 11111111
s
assert sum_outputs 11111110
assert cout h

echo "A=10101010, B=01010101, S=11111111"
setvector a_inputs 10101010
setvector b_inputs 01010101
s
assert sum_outputs 11111111
assert cout l

echo "A=11110000, B=00001111, S=11111111"
setvector a_inputs 11110000
setvector b_inputs 00001111
s
assert sum_outputs 11111111
assert cout l

echo "=== Subtraction Tests (cin=1) ==="
h cin
s

echo "A=00000000, B=00000000, S=00000000"
setvector a_inputs 00000000
setvector b_inputs 00000000
s
assert sum_outputs 00000000
assert cout h

echo "A=00000101, B=00000011, S=00000010"
setvector a_inputs 00000101
setvector b_inputs 00000011
s
assert sum_outputs 00000010
assert cout h

echo "A=00000000, B=00000001, S=11111111"
setvector a_inputs 00000000
setvector b_inputs 00000001
s
assert sum_outputs 11111111
assert cout l

echo "A=00001010, B=00001010, S=00000000"
setvector a_inputs 00001010
setvector b_inputs 00001010
s
assert sum_outputs 00000000
assert cout h

echo "A=11111111, B=00000001, S=11111110"
setvector a_inputs 11111111
setvector b_inputs 00000001
s
assert sum_outputs 11111110
assert cout h

echo "A=10000000, B=01111111, S=00000001"
setvector a_inputs 10000000
setvector b_inputs 01111111
s
assert sum_outputs 00000001
assert cout h

echo "A=01010101, B=10101010, S=10101011"
setvector a_inputs 01010101
setvector b_inputs 10101010
s
assert sum_outputs 10101011
assert cout l

echo "A=11110000, B=00001111, S=11100001"
setvector a_inputs 11110000
setvector b_inputs 00001111
s
assert sum_outputs 11100001
assert cout h

echo "=== Random Pattern Tests (Addition) ==="
l cin
s

echo "A=11010011, B=10110101, S=10001000"
setvector a_inputs 11010011
setvector b_inputs 10110101
s
assert sum_outputs 10001000
assert cout h

echo "A=01101100, B=11001001, S=00110101"
setvector a_inputs 01101100
setvector b_inputs 11001001
s
assert sum_outputs 00110101
assert cout h

echo "A=00110011, B=01010101, S=10001000"
setvector a_inputs 00110011
setvector b_inputs 01010101
s
assert sum_outputs 10001000
assert cout l

echo "=== Random Pattern Tests (Subtraction) ==="
h cin
s

echo "A=11010011, B=10110101, S=00011110"
setvector a_inputs 11010011
setvector b_inputs 10110101
s
assert sum_outputs 00011110
assert cout h

echo "A=10101100, B=01010011, S=01011001"
setvector a_inputs 10101100
setvector b_inputs 01010011
s
assert sum_outputs 01011001
assert cout h

echo "A=00110011, B=01010101, S=11011110"
setvector a_inputs 00110011
setvector b_inputs 01010101
s
assert sum_outputs 11011110
assert cout l

echo "=== Delay Analysis ==="
l cin
setvector a_inputs 10101010
setvector b_inputs 01010101
s
setvector a_inputs 11111111
setvector b_inputs 11111111
s
path s0
path s7
path cout

h cin
setvector a_inputs 11111111
setvector b_inputs 00000001
s
setvector a_inputs 00000000
setvector b_inputs 11111111
s
path s0
path s7
path cout

echo "=== All Tests Complete ==="
ana a0 a1 a2 a3 a4 a5 a6 a7 b0 b1 b2 b3 b4 b5 b6 b7 cin s0 s1 s2 s3 s4 s5 s6 s7 cout