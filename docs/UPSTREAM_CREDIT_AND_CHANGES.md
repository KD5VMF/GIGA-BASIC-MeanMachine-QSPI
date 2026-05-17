# Upstream Credit and GIGA Changes

This project is based on Stefan's Basic / slviajero tinybasic.

The upstream project provides the BASIC interpreter, language runtime, Arduino support structure, and most of the core features.

REV11 customizes it for the Arduino GIGA R1 WiFi as a self-contained retro serial BASIC computer.

## GIGA-specific additions

- Force-enabled onboard QSPI LittleFS storage path for GIGA.
- Mounts the official QSPI user-data partition as `/fs`.
- Avoids the unsupported `<dirent.h>` path on the GIGA compiler by using `_CATALOG.TXT` as a BASIC disk index.
- Adds confirmed SAVE/LOAD/CATALOG/DELETE workflow for onboard flash.
- Adds GIGA helper calls: CALL 40 through CALL 48.
- Adds disk space reporting and `USR(40,4..6)` values.
- Adds starter BASIC library and autoexec/menu generator.
- Adds Arduino IDE and QSPIFormat documentation specific to the GIGA R1.

## Why this exists

The Arduino GIGA R1 WiFi is powerful enough to be a small old-computer style serial BASIC machine. The onboard QSPI flash makes it self-contained: no USB stick is required to save and load BASIC programs.
