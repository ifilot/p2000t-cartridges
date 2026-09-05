# P2000T cartridge firmware

ATmega32U4 native USB serial firmware for the SST39SF020 cartridge. Build in
WSL, upload and communicate from Windows. The application now supports USB
bootloader entry, flash identification, chip erase, 256-byte programming and
read-back. Flash operations are for the cartridge **outside the P2000T**, with
USB supplying the PCB (ST=0). ST is not connected to an MCU input.

## Build

WSL dependencies: gcc-avr, avr-libc, binutils-avr, make, git, python3, host gcc.

```sh
cd /mnt/d/PROGRAMMING/P2000T/p2000t-cartridges/multicartridge-smd-32u4-top-dipswitch/firmware
sh fetch-lufa.sh
make -j4 combined test
```

Outputs in ignored `build/`: `cartridge.hex` (application), `bootloader.hex`,
and `combined.hex` (one-time ISP installation). `backups/` and `.deps/` are also
ignored. The combined-image tool validates checksums and rejects region overlap.
The app occupies 6026 bytes of flash, with 399 bytes static RAM plus stack;
the bootloader occupies 3756 bytes, with 178 bytes static RAM plus stack.
The last two SRAM bytes (0xAFE/0xAFF) hold a watchdog boot key, and both images
set their initial stack to 0xAFD to reserve those bytes.

[LUFA](https://github.com/abcminiuser/lufa) is pinned to
`90d65ba059d91078a34b9c26c8772ee14b556a13`. USB descriptors and bootloader sources
retain their upstream licenses. The bootloader is adapted from LUFA's CDC
AVR109 bootloader: no board LEDs, safe cartridge GPIO, boot window, explicit
watchdog entry, and no USB lock-bit writes. LUFA's page routines reject writes
to boot flash; incoming block writes additionally validate bounds/alignment.

## One-time bootloader installation (Windows + USBasp)

Disconnect cartridge USB and connect USBasp ISP to J3. Its pins are MISO,
USB_5V_RAW, SCK, MOSI, RESET, GND. Do not connect two power sources to the
shared USB_5V_RAW rail. From WSL in this directory:

```sh
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w "$PWD/install-bootloader-windows.ps1")"
```

This installs **both** images, replacing the MCU flash and erasing its internal
EEPROM. It captures the previous MCU contents under ignored `backups/`, verifies
flash/fuses, and leaves all lock bits unset. It never accesses SST ROM contents.

| Setting | Before bootloader | With bootloader |
| --- | --- | --- |
| Low fuse | 5E | 5E (16 MHz crystal; CKDIV8 overridden in software) |
| High fuse | 99 | 98 (BOOTRST enabled; ISP still enabled) |
| Extended fuse | FB | FB (unconnected HWB disabled) |
| Lock byte | FF | FF (unlocked) |
| Application region | starts at 0000 | 0000–6FFF (28 KiB) |
| Bootloader region | unused | 7000–7FFF (4 KiB) |

The USBasp's existing SCK warning does not replace verification: require a
successful verified upload and final fuse/lock checks. ISP remains a recovery
option. Do not upload an application-only HEX using a chip-erasing ISP command
once the bootloader is installed; use the combined installer for ISP recovery.

## Subsequent firmware updates: USB only

After installation, disconnect USBasp and connect the cartridge's USB data
cable. It can remain connected for all normal firmware updates and ROM work.

```sh
make -j4
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$(wslpath -w "$PWD/flash-windows.ps1")"
```

`flash-windows.ps1` validates that the image stays below 0x7000, sends BOOTLOAD,
finds the bootloader COM port, uses Windows AVRDUDE with `-c avr109`, verifies
flash, and waits for the application to reappear. It does not write fuses or
locks. Override `-Port`, `-BootPort`, `-Image`, `-Avrdude` or `-Config` if needed.
Do not supply combined.hex to this script: it intentionally rejects boot code.

Application USB ID: `03EB:2044`, product `P2000T Cartridge Serial`.
Bootloader USB ID: `03EB:204A`, product `P2000T USB Boot`.
These are LUFA demo IDs for this bench prototype, not project-owned IDs for
distribution. Both use Windows' built-in usbser driver; do not apply the
USBasp's WinUSB driver to either serial device. COM numbers can differ.

On power-up/reset, the bootloader offers approximately 5.2 seconds for a host
to connect, then starts a nonblank application. BOOTLOAD explicitly requests
bootloader mode with no timeout. Receiving a bootloader command also cancels
the timeout. A blank application keeps the bootloader active. AVRDUDE exits it
through a watchdog reset after programming. If an application crashes and
cannot accept BOOTLOAD, reset/power-cycle the board and connect during the boot
window, or use ISP. USB alone cannot remotely reset an entirely unresponsive
application; the boot window is the recovery path. A partially uploaded app is
not considered valid by a checksum, so use this recovery path after interrupted
uploads rather than relying on automatic startup.

## Program and verify SST39SF020

From Windows PowerShell in this directory:

```powershell
.\flash-sst-windows.ps1 -Image D:\path\cartridge.bin
.\flash-sst-windows.ps1 -Image D:\path\cartridge.bin -VerifyOnly
.\flash-sst-windows.ps1 -TestPattern
```

Or launch the same script from WSL with `powershell.exe -NoProfile
-ExecutionPolicy Bypass -File "$(wslpath -w "$PWD/flash-sst-windows.ps1")"` and the
same arguments (image paths must be Windows paths). All tools auto-detect a
single cartridge; pass `-Port COM32` if needed.

**Programming erases the entire SST39SF020.** Inputs of 1–262144 bytes are
padded with FF to 256 KiB. TestPattern writes a deterministic xorshift32 pattern
(seed 0x20003204) covering the whole chip. No old ROM contents are backed up.
This is intentional for the owner's factory-fresh test chip. VerifyOnly never
erases or programs. Optional `-Readback` saves the actual read-back image.

The host identifies BF B6, erases, transmits 256-byte blocks with CRC16-XMODEM,
checks every operation's status, then independently reads all 262144 bytes,
validates each read CRC and compares every byte with the padded input. It
reports the first mismatching address or a successful full-image SHA256.
Firmware checks CRC before writing, rejects zero-to-one transitions before
modifying a block, polls program completion with a finite bound, and checks the
programmed bytes. Chip erase is bounded to roughly one second; USB is serviced
while operations run. A failure/disconnect can leave a partially programmed
ROM; rerun the complete erase/write/verify operation.

## Serial protocol (V003)

Eight-byte ASCII commands followed by the exact eight-byte echo. No unsolicited
text, NUL terminators or newlines. Assert DTR. Commands may span USB packets;
CR/LF is ignored only at frame boundaries. One request at a time is recommended.
READINFO and DEVIDSST preserve the earlier response layout.

| Command | After echo |
| --- | --- |
| READINFO | 16 ASCII bytes: `P2000T-32U4 V003` |
| DEVIDSST | 2 raw bytes: manufacturer BF, device B6 |
| BOOTLOAD | status byte, then USB disconnect/re-enumeration |
| ERASEALL | status after completion |
| RDBKhhhh | status, then on success 256 data bytes and 2 CRC bytes |
| WRBKhhhh | ready status; host then sends 256 data bytes + 2 CRC bytes; device returns final status (no second echo) |
| Unknown command | 8 ASCII bytes: ERRORCMD |

`hhhh` is uppercase hexadecimal block index 0000–03FF, address = index * 256.
CRC16-XMODEM: polynomial 0x1021, initial 0, no reflection/final xor; high byte
first. Status: 0 success, 1 CRC mismatch, 2 invalid address, 3 wrong chip,
4 operation timeout, 5 verification failure, 6 needs erase, 7 payload timeout.
Errors on reads contain only status, no data or CRC. Each write is buffered
fully before programming. After a two-second gap in a binary write payload,
status 7 is returned and further bytes are ignored until DTR drops or USB
reconnects; this prevents late payload bytes being treated as commands. Partial
ASCII commands expire after one second. Transport errors should be recovered
by closing/reopening the port before retrying. No sector erase yet.

BF B6 is a manufacturer/model ID, not a unique serial number per chip.

## Wiring and protocol review

The [PICO protocol](https://github.com/ifilot/pico-sst39sf0x0-programmer/tree/8032ec93e67729c8ebcb56f8ca86b993c33f13a5/firmware)
is a good basis: fixed commands, command echo, known-length binary payloads.
This implementation adds stricter framing, explicit status, bounds, timeouts
and a consistent CRC. New read/write responses are not byte-for-byte compatible
with the PICO programmer; hosts must use the V003 layouts above.

Checked the current schematic/PCB, not the stale exported XML netlist:
PORTD is D0–D7 and feeds both SST data and all three 74HC573 latch inputs.
PF0=LE1/U7/A0–A7, PF1=LE2/U8/A8–A15, PF4=LE3/U6/A16–A17.
PB7=OE_ADDR#, PB4=PROG#/WE#, PB5=CS_PROG#, PB6=OE_PROG#.
ST=0 routes these through U4/U5/U10. Firmware disables JTAG because PF4 is LE3.
All control lines are set inactive before enabling output drivers. Each address
load disables SST outputs, drives the shared data bus into the three latches,
then enables addresses. Reads release the bus before enabling flash outputs.
Idle disables CE/OE/WE/address outputs and releases PORTD without pull-ups.

Sources: [SST datasheet](https://ww1.microchip.com/downloads/aemDocuments/documents/MPD/ProductDocuments/DataSheets/SST39SF010A-SST39SF020A-SST39SF040-Data-Sheet-DS20005022.pdf),
[ATmega32U4 datasheet](https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7766-8-bit-AVR-ATmega16U4-32U4_Datasheet.pdf).

## Validation

Native parser tests cover fragmented/consecutive commands, invalid frames,
reconnects/timeouts, the CRC golden vector, address bounds, complete write
buffering, CRC rejection and binary timeout isolation. Host CRC and HEX checks
also pass, including rejection of application images overlapping the bootloader.
Earlier V002 hardware tests read BF B6 repeatedly and tested serial framing.
V003 hardware validation passed on 2026-09-05:

- Combined bootloader installation verified; fuses 5E/98/FB, lock FF.
- USB-only firmware upload through COM33 verified all 6026 bytes, followed by
  successful application enumeration/READINFO on COM32.
- Deterministic SST test pattern programmed and all 262144 bytes read back and
  compared successfully. SHA256:
  `d09f79573a77cd8491450b7478947212e9cad885ceda6151e9ffd31cccf4d26f`.
- Hardware CRC rejection, address bounds, binary payload timeout/isolation and
  erase-precondition tests passed with the checked block unchanged.

The [16-bank P2000T display test](bank-test/README.md) generates a 256 KiB image
with bank numbers 00–15. All bank entry/display and bank-switch/NMI CPU execution
tests passed. It is intended for physical P2000T verification of DIP bank
selection and all four 4 KiB ROM quarters.

The 16-bank display image was subsequently flashed and verified over all
262144 bytes, SHA256
`226a2515b29281fc3d420a0a6f67fe9844da39a94c040c5396ff9799a895a80c`.
It is the image currently installed in the SST39SF020, ready for the user's
physical P2000T test.
