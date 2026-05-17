# Quick Start: Arduino GIGA R1 BASIC with onboard QSPI disk

## 1. Install Arduino support

In Arduino IDE:

```text
Tools -> Board -> Boards Manager
```

Install:

```text
Arduino Mbed OS Giga Boards
```

Select:

```text
Tools -> Board -> Arduino Mbed OS Giga Boards -> Arduino GIGA R1 WiFi
```

## 2. Prepare the GIGA onboard QSPI flash

Close Tera Term or any other serial program first.

In Arduino IDE:

```text
File -> Examples -> STM32H747_System -> QSPIFormat
```

Upload it to the GIGA.

Open Arduino Serial Monitor. If the prompt does not appear, press the GIGA reset button once.

Recommended answers:

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

The last `Y` is critical. REV11 expects the user-data partition to be LittleFS.

Wait until QSPIFormat says it is finished and safe to reboot/disconnect.

## 3. Install REV11 into your Arduino sketchbook

Extract this repository ZIP.

Open PowerShell in the repository root and run:

```powershell
powershell -ExecutionPolicy Bypass -File .\tools\install_to_arduino_sketchbook_REV11.ps1
```

This copies the sketch to:

```text
C:\Users\<you>\Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11
```

## 4. Open and upload REV11

In Arduino IDE, open this exact file:

```text
C:\Users\<you>\Documents\Arduino\GigaBasic_MeanMachine_QSPI_REV11\GigaBasic_MeanMachine_QSPI_REV11.ino
```

Upload it to the GIGA.

## 5. Open serial terminal

Tera Term settings:

```text
Baud: 115200
Data: 8 bit
Parity: none
Stop: 1 bit
Flow control: none
Receive new-line: LF
Transmit new-line: CR
Local echo: OFF
Paste delay per line: 100 ms
```

## 6. Confirm good boot

You want to see:

```text
GIGA onboard QSPI: mounting LittleFS user partition /fs...
GIGA onboard QSPI: mounted OK at /fs. SAVE/LOAD/CATALOG enabled.
Stefan's Basic 2.0 Memory 65535 EEPROM 0
Language set: full
IO: 0 1 16
GIGA BASIC MEAN MACHINE REV11 - onboard flash build
>
```

## 7. Test save and load

Type:

```basic
PRINT USR(16,0)
PRINT USR(16,1)
```

Expected:

```text
1
1
```

Then:

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

If that works, your GIGA is now a self-contained serial BASIC computer with onboard disk storage.
