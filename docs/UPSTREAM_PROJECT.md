# Upstream Project

This project is based on Stefan Lenz's `slviajero/tinybasic`, also known as Stefan's BASIC.

Upstream repository:

```text
https://github.com/slviajero/tinybasic
```

Upstream manual:

```text
https://github.com/slviajero/tinybasic/blob/main/MANUAL.md
```

Upstream wiki:

```text
https://github.com/slviajero/tinybasic/wiki
```

The original project is a BASIC interpreter for Arduino, ESP, RP2040, STM32, Infineon XMC, POSIX, and other platforms. This repository packages a GIGA R1 WiFi-specific variant focused on USB-C serial BASIC and onboard QSPI LittleFS program storage.

## License

The upstream project is BSD-3-Clause licensed. The included source remains under the upstream license. See the root `LICENSE` file.

## Local changes in this package

The main local changes are:

```text
Unique Arduino sketch folder/name for GIGA REV11
Forced GIGA QSPI compile flags in hardware.h
Mbed BlockDevice + MBRBlockDevice + LittleFileSystem mount for GIGA QSPI partition 4
SAVE/LOAD/CATALOG/DELETE support through onboard /fs storage
_CATALOG.TXT catalog index to avoid unsupported dirent.h on the GIGA toolchain
GitHub-ready docs and install script
```
