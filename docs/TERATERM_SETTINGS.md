# Tera Term Settings

The interpreter works best with a real serial terminal.

## Serial port

```text
Baud: 115200
Data: 8 bit
Parity: none
Stop: 1 bit
Flow control: none
```

## Newline settings

```text
Setup -> Terminal...
Receive new-line: LF
Transmit new-line: CR
Local echo: OFF
```

If the boot text appears stair-stepped, the receive newline setting is wrong. Use `LF` receive.

If pasted BASIC lines get scrambled, the transmit newline or paste delay is wrong. Use `CR` transmit and paste delay.

## Paste settings

```text
Setup -> Additional settings... -> Copy and Paste
Paste delay per line: 100 ms
Paste delay per character: 0 or 1 ms
```

Then save settings:

```text
Setup -> Save setup...
```

## Basic paste workflow

1. Type `NEW`.
2. Paste the BASIC program.
3. Type `LIST` to verify.
4. Type `RUN`.
5. Type `SAVE "NAME.BAS"` when it works.
