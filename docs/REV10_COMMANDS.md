# REV11 Commands

## Normal BASIC disk commands

```basic
SAVE "NAME.BAS"
LOAD "NAME.BAS"
CATALOG
DELETE "NAME.BAS"
NEW
LIST
RUN
```

## REV11 helper commands

```basic
CALL 40    QSPI mount/status
CALL 41    raw write/read test
CALL 42    raw catalog test
CALL 43    write SAMPLE.BAS
CALL 44    disk-space report
CALL 45    print disk command cheat sheet
CALL 46    write AUTOEXEC.BAS menu
CALL 47    write starter library: HELLO.BAS, DISKTEST.BAS, PRIME.BAS
CALL 48    about/version/credit information
```

## USR disk-space values

```basic
PRINT USR(40,4)   cataloged used KB
PRINT USR(40,5)   estimated free KB
PRINT USR(40,6)   total QSPI partition KB
```

The free-space report is estimated from files that are tracked in the BASIC catalog index. It is intended for BASIC program storage, where files are small and the estimate is useful.
