# P2000T Cartridges

## Purpose
Set of homebrew multirom cartridges for the P2000T. These cartridges contain
multiple ROM files stored on a single parallel EEPROM chip. The user can select
the desired program using a DIP switch. More information on these cartridges can
be found [on the website](https://www.philips-p2000t.nl/).

## Overview

### Multirom cartridge

#### SST39SF040 / 512kb version

SLOT1 cartridge that allows the user to select one of 32 banks (assuming a 512kb
ROM chip is used). A specific bracket PCB is used to hold the DIP switch which
needs to be wired to the PCB. This cartridge also hosts a soft reset switch with
a debouncing 74HC123 multivibrator.

![P2000T Multicartridge ZIF](img/multicartridge-sst39sf040.jpg)

* [PCB - Multicartridge](multicartridge/pcb/p2000t-multicartridge)
* [PCB - DIP switch plate](multicartridge/pcb/dipswitch-plate)
* [Casing (3d-print files)](multicartridge/case)

#### W27C512 / 64kb version

There is also a Multirom cartridge using the venerable W27C512 chip, providing
4x16kb of space. In contrast to the 512kb version cartridge, this cartridge does
not contain the soft reset as a cost saving measure.

![P2000T Multicartridge ZIF](img/multicartridge-w27c512.jpg)

* [PCB - Multicartridge](multicartridge-w27c512/pcb)
* [Casing (3d-print files)](multicartridge-w27c512/case)

### Multirom cartridge - ZIF

SLOT1 cartridge that allows the user to select one of 32 banks (assuming a 512kb
ROM chip is used). Instead of a fixed ROM chip, this cartridge uses a ZIF socket
for easy exchange of the ROM chip. The cartridge also contains a soft reset
switch.

![P2000T Multicartridge ZIF](img/multicartridge-zif.jpg)

* [PCB](multicartridge-zif/pcb/p2000t-multicartridge-zif)
* [Casing (3d-print files)](multicartridge-zif/case)

### Multirom cartridge kit (smd)

Simplified version of the SST39SF040 / 512kb cartridge meant for easy soldering.
This cartridge assumes that the SMD components are already placed using an
assembly service of the PCB manufacturer.

![P2000T Multicartridge ZIF](img/multicartridge-smd.jpg)

* [PCB](multicartridge-smd/pcb/p2000t-multicartridge-smd)
* [Casing (3d-print files)](multicartridge-smd/case)

## Enclosures

All enclosures have so-called mouse ears which helps in the adhesion
of the enclosure to the print plate. This prevents warping.

Recommended print settings for the enclosures:
* 0.4mm nozzle
* 0.15mm layer height
* 10%-20% infill

All cases are labeled using the following notation: `ABBR-X-[T/B]`, where
`ABBR` corresponds to the cartridge type (see list below), `X` the revision
of the cartridge and `T/B` for the top or bottom parts.

* `MC`: Multirom SST39SF040 cartridge
* `MCW`: Multirom W27C512 cartridge
* `ZC`: Multirom cartridge - ZIF
* `MCS`: Multirom cartridge - KIT