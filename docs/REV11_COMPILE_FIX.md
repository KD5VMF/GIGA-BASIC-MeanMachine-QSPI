# REV11 Compile Fix

REV10 added Mean Machine commands but had C++ quote escaping errors in generated help text and generated BASIC files.

REV11 fixes those C++ string literals by escaping embedded BASIC quotation marks.

Fixed areas:

- CALL 45 disk command cheat sheet
- CALL 46 AUTOEXEC.BAS generator
- CALL 47 starter BASIC library generator
- About/banner text updated to REV11

Expected boot after upload:

```text
GIGA onboard QSPI: mounted OK at /fs. SAVE/LOAD/CATALOG enabled.
Stefan's Basic 2.0 Memory 65535 EEPROM 0
Language set: full
IO: 0 1 16
GIGA BASIC MEAN MACHINE REV11 - onboard flash build
```

Test commands:

```basic
CALL 44
CALL 45
CALL 46
CALL 47
CATALOG
NEW
LOAD "HELLO.BAS"
RUN
```
