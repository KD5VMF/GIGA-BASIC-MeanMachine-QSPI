# BASIC Disk Commands

REV11 makes the GIGA onboard QSPI LittleFS user-data partition act like a tiny BASIC disk.

## Status

```basic
PRINT USR(16,0)
```

Expected `1`: filesystem driver compiled in.

```basic
PRINT USR(16,1)
```

Expected `1`: filesystem mounted.

## Save current BASIC program

```basic
SAVE "NAME.BAS"
```

Example:

```basic
SAVE "MANDEL.BAS"
```

## List files

```basic
CATALOG
```

Example output:

```text
MANDEL.BAS     986
HELLO.BAS      84
```

## Load a program

Use `NEW` first when loading a different program:

```basic
NEW
LOAD "MANDEL.BAS"
LIST
RUN
```

## Delete a file

```basic
DELETE "MANDEL.BAS"
CATALOG
```

## Important filename rule

LittleFS is case-sensitive. Use the exact filename shown by `CATALOG`:

```basic
LOAD "MANDEL.BAS"
```

not:

```basic
LOAD "mandel.bas"
```

## Good filename style

Use simple uppercase names:

```text
HELLO.BAS
MANDEL.BAS
PRIME.BAS
DISKTEST.BAS
AUTOEXEC.BAS
MENU.BAS
LEDTEST.BAS
```

## Clearing current BASIC memory

```basic
NEW
```

## Deleting a program line from memory

Type the line number by itself:

```basic
30
LIST
```
