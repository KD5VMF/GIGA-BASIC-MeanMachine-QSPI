# GIGA BASIC Mean Machine QSPI REV11 User Manual

**Project:** `KD5VMF/GIGA-BASIC-MeanMachine-QSPI`  
**Board:** Arduino GIGA R1 WiFi  
**Build:** GIGA BASIC MEAN MACHINE REV11 - onboard QSPI flash build  
**Primary interface:** USB-C serial terminal  
**Primary storage:** Onboard GIGA QSPI flash, mounted as LittleFS at `/fs`

---

## 1. What this is

GIGA BASIC Mean Machine QSPI REV11 turns the Arduino GIGA R1 WiFi into a small, self-contained, retro-style serial BASIC computer.

It is based on Stefan's BASIC 2.0 / slviajero TinyBasic, with GIGA-specific changes added for the Arduino GIGA R1 WiFi:

- BASIC prompt over the USB-C serial port.
- Onboard QSPI flash used as a tiny BASIC disk.
- `SAVE`, `LOAD`, `CATALOG`, and `DELETE` for BASIC programs.
- A catalog index file so the GIGA build does not depend on unsupported directory-walking APIs.
- Helper `CALL` commands for status, diagnostics, disk space, sample files, and starter programs.
- Disk-space reporting through both `CALL 44` and `USR(40,4..6)`.

This build is meant to feel like a small vintage computer: power it up, open a terminal, type BASIC, save programs, load them back, and run them again later.

---

## 2. Required hardware and software

### Hardware

- Arduino GIGA R1 WiFi.
- USB-C cable connected to the programming/serial USB-C port.
- Windows PC, Linux PC, or Mac with Arduino IDE and a serial terminal.

### Software

- Arduino IDE 2.x.
- Arduino Mbed OS Giga Boards package.
- Tera Term, PuTTY, Arduino Serial Monitor, or another serial terminal.

Recommended terminal for Windows: **Tera Term**.

---

## 3. Arduino IDE setup

1. Open Arduino IDE.
2. Go to:

```text
Tools -> Board -> Boards Manager
```

3. Install:

```text
Arduino Mbed OS Giga Boards
```

4. Select the board:

```text
Tools -> Board -> Arduino Mbed OS Giga Boards -> Arduino GIGA R1 WiFi
```

5. Select the correct COM port:

```text
Tools -> Port -> your Arduino GIGA COM port
```

---

## 4. One-time QSPI flash preparation

REV11 uses the GIGA onboard QSPI user-data partition as a LittleFS BASIC disk. The QSPI user partition must be formatted correctly before `SAVE` and `LOAD` will work.

### Important

Close Tera Term, PuTTY, Arduino Serial Monitor, or anything else using the GIGA COM port before uploading sketches.

### Run Arduino's QSPI formatter

In Arduino IDE, open:

```text
File -> Examples -> STM32H747_System -> QSPIFormat
```

Upload it to the GIGA.

Open Arduino Serial Monitor. If nothing appears, press the GIGA reset button once.

Answer the prompts like this:

```text
Do you want to proceed? Y/[n]
Y

Do you want to perform a full erase of the QSPI flash before proceeding? Y/[n]
Y

Do you want to restore the WiFi firmware and certificates? Y/[n]
Y

Do you want to use LittleFS to format user data partition? Y/[n]
Y
```

The last answer is critical. REV11 expects the user-data partition to be **LittleFS**.

Wait until the formatter says it is finished and safe to reboot or disconnect.

Then upload the REV11 BASIC sketch again.

---

## 5. Installing REV11 into the Arduino sketchbook

From the repository ZIP or clone, run this PowerShell command from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\install_to_arduino_sketchbook_REV11.ps1
```

That copies the sketch to the normal Arduino sketchbook location:

```text
C:\Users\YOURNAME\Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11
```

Then open this exact file in Arduino IDE:

```text
C:\Users\YOURNAME\Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11\GigaBasic_MeanMachine_QSPI_REV11.ino
```

Upload it to the Arduino GIGA R1 WiFi.

---

## 6. Serial terminal setup

### Tera Term serial settings

Use these settings:

```text
Baud:           115200
Data:           8 bit
Parity:         none
Stop:           1 bit
Flow control:   none
```

### Tera Term terminal settings

Use:

```text
Receive new-line:   LF
Transmit new-line:  CR
Local echo:         OFF
```

### Tera Term paste settings

Use:

```text
Paste delay per line:       100 ms
Paste delay per character:  0 or 1 ms
```

Then save the setup:

```text
Setup -> Save setup...
```

### Why these settings matter

If the boot text looks stair-stepped, the receive newline setting is wrong. Use `LF`.

If pasted BASIC programs get scrambled, the paste delay or transmit newline setting is wrong. Use `CR` transmit and a 100 ms line paste delay.

---

## 7. Good boot message

After uploading REV11 and opening the serial terminal, a good boot looks like this:

```text
GIGA onboard QSPI: mounting LittleFS user partition /fs...
GIGA onboard QSPI: mounted OK at /fs. SAVE/LOAD/CATALOG enabled.
Stefan's Basic 2.0 Memory 65535 EEPROM 0
Language set: full
IO: 0 1 16
GIGA BASIC MEAN MACHINE REV11 - onboard flash build
>
```

The prompt is:

```text
>
```

The `IO: 0 1 16` line is important:

- `0` = internal/null/buffer channel.
- `1` = serial console channel.
- `16` = filesystem channel.

If you only see `IO: 0 1`, the filesystem backend is not active in the sketch that was uploaded.

---

## 8. First test

At the BASIC prompt, type:

```basic
PRINT USR(16,0)
PRINT USR(16,1)
```

Expected result:

```text
1
1
```

Meaning:

- `USR(16,0)` = filesystem support is compiled in.
- `USR(16,1)` = filesystem is mounted.

Now test a small program:

```basic
NEW
10 PRINT "HELLO WORLD!!"
20 FOR I=1 TO 5
30 PRINT I,I*I
40 NEXT I
SAVE "HELLO.BAS"
CATALOG
NEW
LOAD "HELLO.BAS"
LIST
RUN
```

If that works, the GIGA is ready as a self-contained BASIC computer.

---

## 9. Direct mode vs program mode

### Direct mode

A command without a line number runs immediately:

```basic
PRINT 2+2
```

Output:

```text
4
```

### Program mode

A command with a line number is stored in memory:

```basic
10 PRINT "GIGA BASIC"
20 PRINT "MEAN MACHINE"
30 END
```

Then run it:

```basic
RUN
```

### Listing the current program

```basic
LIST
```

### Replacing a line

Type the same line number again:

```basic
20 PRINT "REV11"
```

### Deleting a line

Type the line number by itself:

```basic
20
```

### Clearing memory

```basic
NEW
```

`NEW` clears the current BASIC program in RAM. It does not delete saved files from QSPI storage.

---

## 10. Normal BASIC program workflow

The safest workflow is:

```basic
NEW
```

Paste or type the program.

```basic
LIST
RUN
```

When it works:

```basic
SAVE "NAME.BAS"
```

To reload later:

```basic
NEW
LOAD "NAME.BAS"
LIST
RUN
```

---

## 11. Filename rules

The GIGA QSPI LittleFS filesystem is case-sensitive.

Use simple uppercase filenames:

```text
HELLO.BAS
PRIME.BAS
DISKTEST.BAS
MENU.BAS
LEDTEST.BAS
MANDEL.BAS
```

Correct:

```basic
LOAD "HELLO.BAS"
```

Possibly wrong if the file was saved uppercase:

```basic
LOAD "hello.bas"
```

Always use the exact spelling shown by:

```basic
CATALOG
```

---

## 12. Disk commands

### SAVE

Saves the current BASIC program from RAM to the onboard QSPI BASIC disk.

```basic
SAVE "NAME.BAS"
```

Example:

```basic
SAVE "HELLO.BAS"
```

### LOAD

Loads a BASIC program from QSPI storage into memory.

Recommended workflow:

```basic
NEW
LOAD "NAME.BAS"
LIST
RUN
```

Example:

```basic
NEW
LOAD "HELLO.BAS"
RUN
```

### CATALOG

Lists saved BASIC files known to the REV11 catalog index.

```basic
CATALOG
```

Example output:

```text
HELLO.BAS 84
PRIME.BAS 512
DISKTEST.BAS 260
```

### DELETE

Deletes a saved BASIC file.

```basic
DELETE "NAME.BAS"
```

Example:

```basic
DELETE "HELLO.BAS"
CATALOG
```

### FDISK

Advanced filesystem format command path.

Normal users should usually use Arduino's `QSPIFormat` example instead.

If the QSPI partition layout is already correct and you only need to reformat the BASIC storage area, the documented advanced command is:

```basic
FDISK 0
```

Do not power off or reset during `FDISK`.

---

## 13. REV11 CALL command reference

The REV11 GIGA-specific helper calls are `CALL 40` through `CALL 48`.

These are direct-mode or program-mode commands. In normal use, type them at the prompt.

### Quick table

| Command | Purpose |
|---|---|
| `CALL 40` | QSPI mount/status report. |
| `CALL 41` | Raw QSPI write/read diagnostic. |
| `CALL 42` | Raw catalog diagnostic. |
| `CALL 43` | Write `SAMPLE.BAS`. |
| `CALL 44` | Disk-space report. |
| `CALL 45` | Print disk command cheat sheet. |
| `CALL 46` | Write autoexec/menu program. |
| `CALL 47` | Write starter library: `HELLO.BAS`, `DISKTEST.BAS`, `PRIME.BAS`. |
| `CALL 48` | About, version, and credit information. |

### CALL 40 - QSPI mount/status

Use this to check whether the onboard flash disk is alive.

```basic
CALL 40
```

Use it after boot, after formatting, or when `SAVE`/`LOAD` do not behave correctly.

Related checks:

```basic
PRINT USR(16,0)
PRINT USR(16,1)
```

Expected:

```text
1
1
```

### CALL 41 - Raw QSPI write/read diagnostic

Use this as a low-level flash test.

```basic
CALL 41
```

This is not needed for normal programming. It is useful when proving that QSPI writes and reads are actually working.

### CALL 42 - Raw catalog diagnostic

Use this to inspect or test the REV11 catalog mechanism.

```basic
CALL 42
```

REV11 uses a catalog index file instead of unsupported directory walking. If `CATALOG` seems wrong, this diagnostic is the first helper to try.

### CALL 43 - Write SAMPLE.BAS

Creates a sample BASIC program on the QSPI disk.

```basic
CALL 43
CATALOG
LOAD "SAMPLE.BAS"
LIST
RUN
```

### CALL 44 - Disk-space report

Prints a disk-space report.

```basic
CALL 44
```

This is the easiest way to see QSPI BASIC disk usage.

Disk-space values are also available through `USR(40,n)`:

```basic
PRINT USR(40,4)
PRINT USR(40,5)
PRINT USR(40,6)
```

Meaning:

| Function | Meaning |
|---|---|
| `USR(40,4)` | Cataloged used KB. |
| `USR(40,5)` | Estimated free KB. |
| `USR(40,6)` | Total QSPI partition KB. |

The free-space report is estimated from files tracked in the BASIC catalog index. It is intended for BASIC program storage, where files are small.

### CALL 45 - Disk command cheat sheet

Prints a quick reference for the disk commands.

```basic
CALL 45
```

Useful commands shown by this helper include:

```basic
SAVE "NAME.BAS"
LOAD "NAME.BAS"
CATALOG
DELETE "NAME.BAS"
NEW
LIST
RUN
```

### CALL 46 - Write autoexec/menu program

Writes the autoexec/menu program.

```basic
CALL 46
CATALOG
```

Use this when you want the board to have a ready-made menu program stored on the QSPI BASIC disk.

If the file does not auto-run on boot, load and run it manually with the exact filename shown by `CATALOG`.

Example:

```basic
CATALOG
NEW
LOAD "AUTOEXEC.BAS"
RUN
```

Because the filesystem is case-sensitive, exact spelling matters.

### CALL 47 - Write starter library

Writes a starter program library to the QSPI disk.

```basic
CALL 47
CATALOG
```

The documented starter files are:

```text
HELLO.BAS
DISKTEST.BAS
PRIME.BAS
```

Suggested use:

```basic
CALL 47
CATALOG
NEW
LOAD "HELLO.BAS"
LIST
RUN
```

Then try:

```basic
NEW
LOAD "DISKTEST.BAS"
RUN
```

And:

```basic
NEW
LOAD "PRIME.BAS"
RUN
```

### CALL 48 - About/version/credit information

Prints build information, version information, and upstream credit.

```basic
CALL 48
```

Use this to confirm you are running the intended REV11 build.

---

## 14. USR function reference for this build

`USR()` returns numeric status values from low-level runtime helpers.

### Filesystem status

```basic
PRINT USR(16,0)
```

Returns:

```text
1
```

Meaning: filesystem support is compiled in.

```basic
PRINT USR(16,1)
```

Returns:

```text
1
```

Meaning: filesystem is mounted.

### Disk-space values

```basic
PRINT USR(40,4)
```

Cataloged used KB.

```basic
PRINT USR(40,5)
```

Estimated free KB.

```basic
PRINT USR(40,6)
```

Total QSPI partition KB.

For normal use, `CALL 44` is easier.

---

## 15. HELP command and active keywords

At the prompt, type:

```basic
HELP
```

The REV11 full language set reports keywords similar to:

```text
=> <= <> PRINT LET INPUT GOTO GOSUB
RETURN IF FOR TO STEP NEXT STOP LIST
NEW RUN ABS RND SIZE REM NOT AND
OR LEN SGN PEEK DIM CLR HIMEM TAB
THEN END POKE CONT SQR POW MAP DUMP
BREAK SAVE LOAD GET PUT SET CLS LOCATE
ELSE PINM DWRITE DREAD AWRITE AREAD DELAY MILLIS
AZERO LED PLAY PULSE CATALOG DELETE OPEN CLOSE
FDISK USR CALL SIN COS TAN ATAN LOG
EXP
```

This means REV11 includes the core BASIC language, file commands, Arduino I/O commands, math functions, and the GIGA helper `CALL` commands.

---

## 16. Core command reference

### PRINT

Prints text, numbers, or expressions.

```basic
PRINT "HELLO"
PRINT 2+2
PRINT A
PRINT A,B
```

Example:

```basic
10 PRINT "COUNT",I
```

### LET

Assigns a value to a variable.

```basic
LET A=10
```

In many cases, `LET` is optional:

```basic
A=10
```

### INPUT

Asks the user for a value.

```basic
10 INPUT A
20 PRINT A
```

Prompted input example:

```basic
10 PRINT "ENTER A NUMBER"
20 INPUT N
30 PRINT N*N
```

### GOTO

Jumps to a line number.

```basic
10 PRINT "AGAIN"
20 GOTO 10
```

### GOSUB and RETURN

Calls a subroutine and returns.

```basic
10 GOSUB 100
20 PRINT "BACK"
30 END
100 PRINT "SUBROUTINE"
110 RETURN
```

### IF / THEN / ELSE

Conditional execution.

```basic
10 INPUT A
20 IF A>10 THEN 50
30 PRINT "10 OR LESS"
40 END
50 PRINT "GREATER THAN 10"
```

With `ELSE`:

```basic
10 INPUT A
20 IF A>10 THEN PRINT "HIGH" ELSE PRINT "LOW"
```

### FOR / TO / STEP / NEXT

Looping.

```basic
10 FOR I=1 TO 10
20 PRINT I
30 NEXT I
```

With step:

```basic
10 FOR I=0 TO 100 STEP 10
20 PRINT I
30 NEXT I
```

### BREAK and CONT

`BREAK` exits a loop.

`CONT` continues loop processing, depending on context.

Example:

```basic
10 FOR I=1 TO 100
20 PRINT I
30 IF I=10 THEN BREAK
40 NEXT I
```

### STOP and END

`END` ends the program and returns to the prompt.

```basic
10 PRINT "DONE"
20 END
```

`STOP` is also present, but for clean program endings, prefer `END`.

### REM

Comment line.

```basic
10 REM THIS IS A COMMENT
20 PRINT "HELLO"
```

### LIST

Lists the current program.

```basic
LIST
```

### NEW

Clears the current program from RAM.

```basic
NEW
```

### RUN

Runs the current program.

```basic
RUN
```

### SIZE

Reports memory information.

```basic
SIZE
```

### HELP

Prints available keywords.

```basic
HELP
```

---

## 17. Math and expression reference

### Operators

Common operators include:

```text
+   addition
-   subtraction
*   multiplication
/   division
=   equal
<>  not equal
<   less than
>   greater than
<=  less than or equal
>=  greater than or equal
```

### Boolean operators

```basic
NOT
AND
OR
```

Example:

```basic
10 IF A>0 AND A<10 THEN PRINT "OK"
```

### Bitwise-style operators and helpers

The active keyword list includes:

```text
<<
>>
BIT
```

These are useful for bit shifting and bit tests when working with binary values, LEDs, masks, and low-level I/O experiments.

### Common numeric functions

| Function | Purpose |
|---|---|
| `ABS(X)` | Absolute value. |
| `RND(X)` | Random number helper. |
| `SGN(X)` | Sign of value. |
| `SQR(X)` | Square root. |
| `POW(A,B)` | Power function. |
| `INT(X)` | Integer part. |
| `SIN(X)` | Sine. |
| `COS(X)` | Cosine. |
| `TAN(X)` | Tangent. |
| `ATAN(X)` | Arctangent. |
| `LOG(X)` | Natural logarithm. |
| `EXP(X)` | Exponential. |

Examples:

```basic
PRINT ABS(-5)
PRINT SQR(81)
PRINT POW(2,8)
PRINT SIN(1)
```

### Timing function

```basic
PRINT MILLIS(1)
```

`MILLIS()` reports elapsed time based on the Arduino millisecond timer. The argument acts as a divisor in the runtime.

Examples:

```basic
PRINT MILLIS(1)
PRINT MILLIS(1000)
```

---

## 18. Memory and low-level commands

### PEEK

Reads a byte/value from memory.

```basic
PRINT PEEK(ADDRESS)
```

### POKE

Writes a byte/value to memory.

```basic
POKE ADDRESS,VALUE
```

Use `POKE` carefully. It is a low-level command.

### HIMEM

Memory boundary/control command from the upstream BASIC.

For normal GIGA BASIC programming, you usually do not need to change `HIMEM`.

### DUMP

Dumps memory information.

```basic
DUMP
```

Useful for diagnostics and advanced exploration.

---

## 19. Screen and terminal commands

### CLS

Clears the terminal/display.

```basic
CLS
```

### LOCATE

Moves the cursor using terminal escape positioning.

```basic
LOCATE X,Y
```

Example:

```basic
10 CLS
20 LOCATE 5,5
30 PRINT "HELLO"
```

Terminal behavior depends on the terminal program and escape-sequence support.

### TAB

Print spacing.

```basic
PRINT TAB(10);"HELLO"
```

---

## 20. Arduino I/O command reference

The active keyword list includes Arduino-style I/O commands.

### PINM

Configures a pin mode.

Typical use:

```basic
PINM PIN,MODE
```

Modes depend on the runtime build. Common Arduino ideas are input/output/pullup-style modes.

### DWRITE

Digital write.

```basic
DWRITE PIN,VALUE
```

Typical values:

```text
0 = low
1 = high
```

### DREAD

Digital read.

```basic
PRINT DREAD(PIN)
```

### AWRITE

Analog/PWM-style write.

```basic
AWRITE PIN,VALUE
```

### AREAD

Analog read.

```basic
PRINT AREAD(PIN)
```

### DELAY

Delay in milliseconds.

```basic
DELAY 1000
```

### AZERO

Analog-zero helper from the upstream Arduino I/O support.

### LED

Board LED helper from the upstream Arduino I/O support.

### PLAY

Tone/play helper.

### PULSE

Pulse helper.

For the GIGA R1, always verify pin names/numbers and electrical limits before wiring external hardware.

---

## 21. Example: blink-style digital output

This example shows the style. Adjust the pin number for your wiring.

```basic
NEW
10 PINM 13,1
20 DWRITE 13,1
30 DELAY 500
40 DWRITE 13,0
50 DELAY 500
60 GOTO 20
RUN
```

To interrupt a running program, try sending the break character used by the runtime, often `#`, or press the GIGA reset button if the terminal does not catch it.

---

## 22. Example: counter program

```basic
NEW
10 CLS
20 FOR I=0 TO 10
30 PRINT "COUNT = ";I
40 DELAY 500
50 NEXT I
60 PRINT "DONE"
70 END
RUN
```

Save it:

```basic
SAVE "COUNT.BAS"
```

Load it later:

```basic
NEW
LOAD "COUNT.BAS"
RUN
```

---

## 23. Example: prime number demo

You can generate the built-in starter library first:

```basic
CALL 47
CATALOG
```

Then load the starter prime program:

```basic
NEW
LOAD "PRIME.BAS"
LIST
RUN
```

---

## 24. Example: making a menu

Generate the autoexec/menu starter:

```basic
CALL 46
CATALOG
```

Then inspect it:

```basic
NEW
LOAD "AUTOEXEC.BAS"
LIST
```

Run it:

```basic
RUN
```

If the generated filename differs in case, use the exact filename shown by `CATALOG`.

---

## 25. Program storage safety

The onboard QSPI flash is good for BASIC programs, but it is still flash memory.

Avoid:

- Saving in a tight loop.
- High-frequency logging directly to QSPI.
- Resetting or powering off while `SAVE`, `DELETE`, or `FDISK` is running.

Good use:

- Write/edit/test a program.
- Save it when it works.
- Load and run it later.
- Keep small BASIC utilities and demos on the onboard disk.

---

## 26. Troubleshooting

### Problem: boot only shows `IO: 0 1`

Bad sign:

```text
IO: 0 1
```

Good sign:

```text
IO: 0 1 16
```

If `16` is missing, the filesystem backend was not active in the sketch that was uploaded.

Fix:

1. Close Arduino IDE.
2. Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\install_to_arduino_sketchbook_REV11.ps1
```

3. Open this exact sketch:

```text
Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11\GigaBasic_MeanMachine_QSPI_REV11.ino
```

4. Upload again.

### Problem: mount failed with status `-3102`

Example:

```text
GIGA onboard QSPI: mount failed on partition 4 with status -3102.
```

Most likely causes:

- QSPI user-data partition was never formatted.
- User-data partition was formatted as FatFS instead of LittleFS.
- QSPI layout is stale or corrupted.

Fix:

1. Re-run Arduino's `QSPIFormat` example.
2. Answer `Y` to LittleFS user-data partition.
3. Upload REV11 again.

### Problem: `SAVE` gives Memory Error or Syntax Error

Usually means the filesystem channel is not mounted.

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

If not, recheck QSPI formatting and the boot messages.

### Problem: `LOAD` gives File Error but `CATALOG` shows the file

Use the exact case shown by `CATALOG`.

Correct:

```basic
LOAD "MANDEL.BAS"
```

Wrong if the file is uppercase:

```basic
LOAD "mandel.bas"
```

### Problem: terminal text is stair-stepped

Set Tera Term receive newline to:

```text
LF
```

### Problem: pasted BASIC gets garbled

Use:

```text
Transmit new-line: CR
Paste delay per line: 100 ms
Local echo: OFF
```

### Problem: Arduino IDE will not upload

The COM port is probably busy.

Close:

- Tera Term.
- PuTTY.
- Arduino Serial Monitor.
- Any other serial program using the GIGA COM port.

### Problem: `CATALOG` is empty after manually copying files

REV11's `CATALOG` uses an internal index file:

```text
/fs/_CATALOG.TXT
```

Normal BASIC `SAVE` updates the index.

Files manually placed into `/fs` by another tool may not appear until they are added to that index.

---

## 27. Recommended first saved programs

After setup, create or generate these:

```basic
CALL 47
CATALOG
```

Then add your own:

```text
HELLO.BAS
COUNT.BAS
PINTEST.BAS
MATH.BAS
MENU.BAS
```

Use simple uppercase filenames so loading is easy.

---

## 28. Quick command cheat sheet

### Startup checks

```basic
HELP
PRINT USR(16,0)
PRINT USR(16,1)
CALL 40
CALL 44
```

### Program editing

```basic
NEW
LIST
RUN
10 PRINT "HELLO"
20 END
```

### Disk

```basic
SAVE "NAME.BAS"
LOAD "NAME.BAS"
CATALOG
DELETE "NAME.BAS"
```

### Helpers

```basic
CALL 43
CALL 45
CALL 46
CALL 47
CALL 48
```

### Disk space

```basic
CALL 44
PRINT USR(40,4)
PRINT USR(40,5)
PRINT USR(40,6)
```

---

## 29. Best practices

- Use uppercase filenames.
- Use `NEW` before loading a different program.
- Use `LIST` after pasting a program to verify it arrived correctly.
- Use `SAVE` only after the program works.
- Do not reset or unplug during `SAVE`, `DELETE`, or `FDISK`.
- Use `CALL 44` to check storage.
- Use `CALL 48` to confirm the build/version.
- Keep backup copies of important BASIC programs on your PC.

---

## 30. Minimal “known good” test session

This is a good complete test after flashing REV11:

```basic
HELP
PRINT USR(16,0)
PRINT USR(16,1)
CALL 40
CALL 44
NEW
10 PRINT "GIGA BASIC REV11 WORKS"
20 FOR I=1 TO 5
30 PRINT I,I*I
40 NEXT I
50 END
LIST
RUN
SAVE "TEST.BAS"
CATALOG
NEW
LOAD "TEST.BAS"
RUN
```

If this session works, the terminal, interpreter, QSPI mount, save/load path, and catalog are all working.

---

## 31. Credits

GIGA BASIC Mean Machine QSPI REV11 is based on Stefan's BASIC 2.0 / slviajero TinyBasic. The upstream interpreter provides the BASIC language core and runtime. This REV11 package adds the Arduino GIGA R1 WiFi onboard QSPI LittleFS workflow, helper commands, documentation, and starter program support.

---

## 32. One-page CALL and USR card

```text
CALL 40  QSPI mount/status
CALL 41  Raw QSPI write/read diagnostic
CALL 42  Raw catalog diagnostic
CALL 43  Write SAMPLE.BAS
CALL 44  Disk-space report
CALL 45  Disk command cheat sheet
CALL 46  Write AUTOEXEC/menu program
CALL 47  Write HELLO/DISKTEST/PRIME starter library
CALL 48  About/version/credit info

USR(16,0)  1 = filesystem support compiled in
USR(16,1)  1 = filesystem mounted
USR(40,4)  Cataloged used KB
USR(40,5)  Estimated free KB
USR(40,6)  Total QSPI partition KB
```

