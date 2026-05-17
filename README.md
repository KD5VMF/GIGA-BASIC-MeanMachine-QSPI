# GIGA BASIC Mean Machine QSPI REV11

A GIGA R1 WiFi-focused retro BASIC computer build based on **Stefan's Basic / slviajero tinybasic**.

This package keeps credit to the upstream BASIC project and adds the working Arduino GIGA R1 changes we developed and tested:

- Serial BASIC over USB-C terminal.
- Onboard GIGA QSPI flash as a LittleFS BASIC disk mounted at `/fs`.
- Working `SAVE`, `LOAD`, `CATALOG`, and `DELETE` for BASIC programs.
- A catalog index so the GIGA toolchain does not need unsupported `dirent.h` directory walking.
- GIGA-specific diagnostics and helper commands.
- Disk-space report using `CALL 44` and `USR(40,4..6)`.
- Starter library writer using `CALL 47`.
- Autoexec/menu writer using `CALL 46`.

## Repository name suggestion

`GIGA-BASIC-MeanMachine-QSPI`

## Main sketch

Open this in Arduino IDE:

```text
Arduino/GigaBasic_MeanMachine_QSPI_REV11/GigaBasic_MeanMachine_QSPI_REV11.ino
```

## Required Arduino setup

Install/select:

```text
Arduino IDE 2.x
Arduino Mbed OS Giga Boards
Board: Arduino GIGA R1 WiFi
```

No USB-stick library is required for this QSPI build.

## One-time QSPI prep

Run Arduino's QSPI formatter before using SAVE/LOAD:

```text
File -> Examples -> STM32H747_System -> QSPIFormat
```

When asked, choose LittleFS for the user-data partition. Then upload this REV11 BASIC sketch again.

The good boot message is:

```text
GIGA onboard QSPI: mounted OK at /fs. SAVE/LOAD/CATALOG enabled.
Stefan's Basic 2.0 Memory 65535 EEPROM 0
Language set: full
IO: 0 1 16
GIGA BASIC MEAN MACHINE REV11 - onboard QSPI flash build
```

## Disk commands

```basic
SAVE "NAME.BAS"
LOAD "NAME.BAS"
CATALOG
DELETE "NAME.BAS"
NEW
LIST
RUN
```

Use uppercase filenames exactly as shown by `CATALOG`.

## New REV11 helper commands

```basic
CALL 40    ' mount/status
CALL 41    ' raw QSPI write/read diagnostic
CALL 42    ' raw catalog diagnostic
CALL 43    ' write SAMPLE.BAS
CALL 44    ' disk-space report
CALL 45    ' disk command cheat sheet
CALL 46    ' write AUTOEXEC.BAS menu
CALL 47    ' write HELLO/DISKTEST/PRIME library
CALL 48    ' about/revision/credit info
```

Disk-space values:

```basic
PRINT USR(40,4)   ' cataloged used KB
PRINT USR(40,5)   ' estimated free KB
PRINT USR(40,6)   ' total QSPI partition KB
```

`CALL 44` is the easiest way to see disk usage.

## Upstream credit

This is a GIGA R1 focused package/fork of Stefan's Basic / slviajero tinybasic. The original interpreter, BASIC language implementation, and broad hardware support come from the upstream project. REV11 adds the Arduino GIGA R1 onboard QSPI LittleFS storage workflow, command helpers, docs, and test/demo programs.

## REV11 compile fix

REV11 fixes the REV10 C++ compile errors caused by unescaped quote marks inside generated help text and generated BASIC sample files. The working QSPI/LittleFS storage design from REV8/REV9 is preserved, with the added Mean Machine commands from REV10.

