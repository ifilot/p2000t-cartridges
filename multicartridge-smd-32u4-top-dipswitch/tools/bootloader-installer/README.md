# P2000T bootloader installer

Windows command-line utility for installing the cartridge's combined ATmega32U4
application and bootloader image through USBasp. It checks the ISP connection
several times before allowing a write and verifies the result afterwards.

## Build with MSYS2/MinGW

From an MSYS2 UCRT64 terminal with CMake, Ninja and GCC installed:

```sh
cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

The resulting program is `build/p2000t-bootloader-installer.exe`.

To create a ready-to-use ZIP containing the installer, `combined.hex`, AVRDUDE
and its corresponding GPL source and licence:

```sh
cmake --build build --target package_bundle
```

The package is written to `dist/P2000T-Bootloader-Installer.zip`.

## Use

Keep the cartridge out of the P2000T and do not connect its USB port while the
USBasp powers the ISP header contacts.

```text
p2000t-bootloader-installer.exe
p2000t-bootloader-installer.exe check
p2000t-bootloader-installer.exe flash D:\path\to\combined.hex
```

Launching without arguments displays an interactive menu. In the packaged
version, preparing a cartridge requires no paths or command-line options.

`flash` always runs the connection check first. By default, the utility performs
five independent reads and requires an ATmega32U4 signature plus identical fuse
and lock values each time. It then flashes and verifies the image, sets the high
fuse to `98` and extended fuse to `FB`, and checks the device three more times.
It never writes the low fuse or lock byte.

The packaged version includes AVRDUDE beside the installer. A standalone build
also searches `PATH` and an Arduino installation under
`%LOCALAPPDATA%\Arduino15`. Override discovery when needed:

```text
p2000t-bootloader-installer.exe --avrdude C:\path\avrdude.exe --config C:\path\avrdude.conf check
```

Run `p2000t-bootloader-installer.exe --help` for all options.
