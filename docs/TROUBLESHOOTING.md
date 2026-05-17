# Troubleshooting

## Boot only shows `IO: 0 1`

Problem:

```text
IO: 0 1
```

This means the filesystem backend was not compiled into the sketch you uploaded.

Fix:

1. Close Arduino IDE.
2. Run `tools/install_to_arduino_sketchbook_REV11.ps1`.
3. Open this exact file:

```text
Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11\GigaBasic_MeanMachine_QSPI_REV11.ino
```

4. Upload again.

Good boot should show:

```text
IO: 0 1 16
GIGA BASIC MEAN MACHINE REV11 - onboard flash build
```

## Mount failed with status -3102

Problem:

```text
GIGA onboard QSPI: mount failed on partition 4 with status -3102.
```

Fix:

Run Arduino `QSPIFormat` and answer `Y` when asked to format user data partition with LittleFS.

## SAVE gives Memory Error / Syntax Error

Usually means no filesystem channel is mounted.

Check:

```basic
PRINT USR(16,0)
PRINT USR(16,1)
```

Expected:

```text
1
1
```

If not, recheck boot messages and QSPIFormat.

## LOAD gives File Error but CATALOG shows the file

LittleFS is case-sensitive. Use the exact name shown by `CATALOG`.

Correct:

```basic
LOAD "MANDEL.BAS"
```

Wrong if file is uppercase:

```basic
LOAD "mandel.bas"
```

## Text looks stair-stepped in Tera Term

Set:

```text
Receive new-line: LF
```

## Pasted BASIC gets garbled

Set:

```text
Transmit new-line: CR
Paste delay per line: 100 ms
Local echo: OFF
```

## Arduino IDE will not upload because COM port is busy

Close Tera Term, PuTTY, Serial Monitor, or any other serial program using the port.

## CATALOG is empty after files were copied manually

REV11's `CATALOG` uses `_CATALOG.TXT`, which is updated when BASIC saves files. If you manually place files into `/fs` through another tool, they may not appear in `CATALOG` until added to the index. Normal BASIC `SAVE` files will appear.
