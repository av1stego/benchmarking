import sys

SKIPPING_IDENTIFIER = "[Skipping]"

def string_from_bits(bits):
    chars = []
    bytes_count = int(len(bits) / 8)
    for b in range(0, bytes_count):
        byte = bits[b*8:(b+1)*8]
        byte.reverse()
        char = chr(int(''.join([str(bit) for bit in byte]), 2))
        chars.append(char)
        if char == '\0':
            break

    return ''.join(chars)

def retrieve_bits_from_lines(lines, padding, offset):
    bits = []

    lines = lines[offset:]

    i = 0

    while i < len(lines):
        line = lines[i]
        if not (SKIPPING_IDENTIFIER in line):
            bit = int(line.split(" ")[7])
            bits.append(bit)

        i += 1 + padding

    return bits

def main():
    lines = open(sys.argv[1]).readlines()
    padding = int(sys.argv[2])
    offset = int(sys.argv[3])

    bits = retrieve_bits_from_lines(lines, padding, offset)

    if "stats" in sys.argv:
        print(f"Injected bits: {len(bits)} ({len(bits)/8} bytes)")

    if "message" in sys.argv:
        print(string_from_bits(bits))

if __name__ == "__main__":
    main()