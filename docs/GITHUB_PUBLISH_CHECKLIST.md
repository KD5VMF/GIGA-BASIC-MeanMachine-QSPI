# GitHub Publish Checklist

## Repository settings

Recommended name:

```text
GIGA-BASIC-RetroStation-QSPI
```

Short description:

```text
Arduino GIGA R1 WiFi serial BASIC computer with onboard QSPI LittleFS SAVE/LOAD/CATALOG disk support.
```

Topics:

```text
arduino
arduino-giga
basic
retrocomputing
littlefs
qspi
stm32h747
embedded
serial-terminal
```

## First commit files

Commit the whole folder:

```text
Arduino/
BASIC_EXAMPLES/
docs/
tools/
README.md
LICENSE
NOTICE.md
.gitignore
```

## Suggested first release

Tag:

```text
v0.9.0-rev11
```

Release title:

```text
REV11 - GitHub-ready GIGA QSPI BASIC RetroStation
```

Release notes:

```text
- Based on Stefan's BASIC Basic2/IoTBasic.
- Arduino GIGA R1 WiFi-specific sketch name and compile flags.
- Mounts onboard QSPI user-data partition as LittleFS at /fs.
- Supports SAVE, LOAD, CATALOG, and DELETE from BASIC.
- Avoids dirent.h by using _CATALOG.TXT index.
- Includes QSPIFormat setup docs, terminal settings, troubleshooting, and BASIC examples.
- Confirmed workflow: SAVE "MANDEL.BAS", CATALOG, NEW, LOAD "MANDEL.BAS", LIST, RUN.
```
