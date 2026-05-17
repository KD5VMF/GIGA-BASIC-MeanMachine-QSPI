# Revision Names and Descriptions

These are the clean names to use if you redo, publish, or tag the project on GitHub.

## Recommended repository name

```text
GIGA-BASIC-RetroStation-QSPI
```

Description:

```text
Arduino GIGA R1 WiFi serial BASIC computer using Stefan's BASIC with onboard QSPI LittleFS SAVE/LOAD/CATALOG disk support.
```

## Release/tag naming

### REV1 - Serial BASIC Bring-Up

```text
GIGA_BASIC_SERIAL_REV1
```

Description:

```text
First working Stefan's BASIC prompt over USB-C serial on the Arduino GIGA R1 WiFi.
```

### REV2 - USB Stick Experiment

```text
GIGA_BASIC_USB_SAVE_LOAD_REV2
```

Description:

```text
Experimental USB-A host FAT/FAT32 jump-drive storage support for SAVE/LOAD/CATALOG.
```

### REV3 - USB Diagnostics

```text
GIGA_BASIC_USB_DIAG_REV3
```

Description:

```text
USB drive detection, mount, and raw write/read diagnostics.
```

### REV4 - First QSPI Attempt

```text
GIGA_BASIC_QSPI_SAVE_LOAD_REV4
```

Description:

```text
First attempt to move BASIC disk storage to the GIGA onboard QSPI flash user-data partition.
```

### REV5 / REV6 - Force Enable QSPI

```text
GIGA_BASIC_QSPI_FORCE_ENABLE_REV6
```

Description:

```text
Force-enabled QSPI storage compile flags so the boot IO list should include channel 16.
```

### REV7 - Unique Sketch Name

```text
GIGA_BASIC_QSPI_UNIQUE_SKETCH_REV7
```

Description:

```text
Renamed the Arduino sketch so Arduino IDE would not accidentally upload the older plain IoTBasic build.
```

### REV8 - Confirmed Working QSPI BASIC Disk

```text
GIGA_BASIC_QSPI_SAVE_LOAD_REV8
```

Description:

```text
Confirmed working onboard QSPI LittleFS storage: SAVE, CATALOG, NEW, LOAD, LIST, and RUN verified with MANDEL.BAS.
```

### REV11 - GitHub Ready Release

```text
GIGA_BASIC_MEANMACHINE_QSPI_REV11
```

Description:

```text
Clean GitHub-ready package with the working GIGA QSPI BASIC build, install script, QSPI prep docs, terminal setup docs, disk command docs, examples, and revision notes.
```
