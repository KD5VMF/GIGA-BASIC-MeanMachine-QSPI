# QSPI Prep and Recovery

REV11 uses the Arduino GIGA R1 WiFi onboard QSPI flash user-data partition as a LittleFS BASIC disk.

## Normal first-time prep

Use Arduino's built-in QSPI formatting sketch:

```text
File -> Examples -> STM32H747_System -> QSPIFormat
```

Answer the prompts like this:

```text
Proceed: Y
Full erase: Y
Restore WiFi firmware and certificates: Y
Use LittleFS to format user data partition: Y
```

The LittleFS answer is required because REV11 mounts the user-data partition as LittleFS.

## Expected REV11 boot after QSPI is ready

```text
GIGA onboard QSPI: mounted OK at /fs. SAVE/LOAD/CATALOG enabled.
IO: 0 1 16
GIGA BASIC MEAN MACHINE REV11 - onboard flash build
```

## If you see mount failed -3102

Example:

```text
GIGA onboard QSPI: mount failed on partition 4 with status -3102.
```

Most likely causes:

```text
QSPI user-data partition was never formatted
User-data partition was formatted as FatFS instead of LittleFS
QSPI layout is stale or corrupted
```

Fix:

1. Re-run `QSPIFormat`.
2. Answer `Y` for LittleFS user-data partition.
3. Upload REV11 again.

## Advanced recovery with FDISK

After QSPIFormat has already created the correct partition layout, this BASIC build includes the interpreter's `FDISK` command path for the mounted filesystem backend.

Use this only if you already have the correct QSPI partition layout and want to reformat the BASIC storage area:

```basic
FDISK 0
```

Safer normal recovery remains the Arduino `QSPIFormat` example.

## What not to do

Do not power off/reset during:

```basic
SAVE
DELETE
FDISK
```

Do not use this as high-frequency logging storage without buffering. Flash has finite write endurance.
