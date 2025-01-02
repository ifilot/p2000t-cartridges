#
# Bundles the three ROM files into a single BIN file that can be flashed
# to a W27C512 chip.
#

import os
import numpy as np

roms = [
    'Brick-wall.bin',
    'Ghosthunt.bin',
    'Lazy Bug.bin',
    'Space Fight.bin'
]

ROOT = os.path.dirname(__file__)
data = bytearray([])

for rom in roms:
    with open(os.path.join(ROOT, '..', 'roms', rom), 'rb') as f:
        print('Appending: %s' % rom)
        romdata = bytearray(f.read())
        romdata += bytearray(np.zeros(16*1024 - len(romdata), dtype=np.uint8))
        data += romdata
        
with open(os.path.join(ROOT, '..', 'gamecart1.bin'), 'wb') as f:
    f.write(data)