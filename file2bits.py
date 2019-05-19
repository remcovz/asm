#!/usr/bin/env python
# usage example: file2bits.py < cbm_348.64c

import sys

# optionally strip leading bytes first (headers, etc)
strip = 2

f = sys.stdin

if strip > 0:
  byte = f.read(strip)

byte = f.read(1)

charcount = 0
while byte != '':
  print '; -- char #%d --' % (charcount)
  for count in range(0,8):
    dec = int(ord(byte))
    binary = '{0:08b}'.format(dec)
    # 'XX.XX.XX' instead of '11011011' (for readability)
    #binary = binary.replace('1', 'X')
    #binary = binary.replace('0', '.')
    # byte count (for debugging)
    #print '#%d: %s' % (count,binary)
    print '!byte %%%s' % binary

    byte = f.read(1)
    count += 1
  charcount += 1

f.close()
