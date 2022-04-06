"""
    This Python scripts loads the bitstrings from a text file and converts them to mouse events.
    It also checks for parity bits and reports incorrect values.
"""

import json


def parse_mouse_event(b):
    d = {
        'left': b[1] == '1',
        'right': b[2] == '1',
        'x_overflow': b[7] == '1',
        'y_overflow': b[8] == '1',
        'x': (-1 if b[5] == 1 else 1) * int(b[13:21], 2),
        'y': (-1 if b[6] == 1 else 1) * int(b[24:32], 2),
        'checks': b[0] == '0' and b[3] == '0' and b[4] == '1' and b[10] == '1' and 
            b[11] == '0' and b[21] == '1' and b[22] == '0'
    }

    p1, p2, p3 = 0, 0, 0
    for i in range(1, 9):
        p1 ^= int(b[i])
    for i in range(12, 20):
        p2 ^= int(b[i])
    for i in range(24, 31):
        p3 ^= int(b[i])
    d['parity'] = p1 == int(b[9]) and p2 == int(b[20]) and p3 == int(b[31])

    return d

f = open("input.txt")
o = open("output.txt", "w")
i = 0
for line in f:
    bits = line.rstrip().replace(' ', '')
    if len(bits) == 0 or bits[0] == '#':
        continue
    i += 1
    o.write("-" * 20 + " [" + str(i) + "] " + "-" * 20 + "\n")
    if len(bits) != 32:
        o.write("Malformed input (length = " + str(len(bits)) + ")\n")
        continue
    dump = parse_mouse_event(bits)
    # write the dump to the output file as JSON
    o.write(json.dumps(dump, indent=4))
o.close()
f.close()