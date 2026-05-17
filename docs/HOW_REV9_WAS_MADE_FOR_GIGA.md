# How REV11 Was Made for the Arduino GIGA R1 WiFi

This package started from Stefan Lenz's `slviajero/tinybasic` Basic2/IoTBasic Arduino build.

## Design goal

Make the Arduino GIGA R1 WiFi act like a small standalone serial BASIC computer with an onboard flash disk.

The project first tried USB jump-drive storage. The GIGA could detect and mount the USB drive, but the USB path was not as reliable as desired for BASIC save/load work. The better GIGA-specific solution was the onboard QSPI flash user-data partition.

## GIGA-specific changes

### 1. Unique Arduino sketch name

The sketch was renamed to avoid Arduino IDE opening/uploading an older plain IoTBasic build:

```text
GigaBasic_MeanMachine_QSPI_REV11/GigaBasic_MeanMachine_QSPI_REV11.ino
```

### 2. Force-enabled GIGA QSPI filesystem

In `hardware.h`, REV11 force-enables the GIGA-specific storage backend:

```cpp
#define GIGA_BASIC_MEANMACHINE_REV11
#define GIGAQSPIFS
#define GIGAQSPIFS_VERBOSE
```

This avoids unreliable board macro auto-detection.

### 3. Onboard QSPI user partition mounted as LittleFS

In `runtime.cpp`, REV11 mounts the GIGA/Portenta-style default block device partition 4 through Mbed:

```text
BlockDevice::get_default_instance()
MBRBlockDevice(..., 4)
LittleFileSystem("fs")
mount as /fs
```

Partition 4 is the user-data partition created by Arduino's `QSPIFormat` flow.

### 4. `SAVE`, `LOAD`, `DELETE`, and `CATALOG`

The interpreter's existing file API was connected to the mounted `/fs` filesystem so normal BASIC disk commands work:

```basic
SAVE "HELLO.BAS"
LOAD "HELLO.BAS"
CATALOG
DELETE "HELLO.BAS"
```

### 5. Avoided unsupported `dirent.h`

The GIGA Arduino arm-none-eabi toolchain rejected:

```cpp
#include <dirent.h>
```

with:

```text
#error "<dirent.h> not supported"
```

So REV8/REV11 avoids `opendir/readdir` and keeps a tiny internal file index:

```text
/fs/_CATALOG.TXT
```

When a BASIC program is saved, its filename is added to that index. `CATALOG` uses the index and verifies that each listed file still exists before displaying it.

### 6. Storage status through USR

The existing filesystem status function maps to:

```basic
PRINT USR(16,0)   '1 = filesystem support compiled in
PRINT USR(16,1)   '1 = filesystem mounted
```

## Why QSPI instead of USB stick?

USB drive path:

```text
Pros: removable storage
Cons: drive compatibility, power spikes, FAT details, mount/write uncertainty
```

Onboard QSPI path:

```text
Pros: always present, no external drive, fast enough for BASIC programs, clean self-contained retro computer feel
Cons: must be formatted correctly first; flash write endurance matters
```

For this project, QSPI is the better default disk.
