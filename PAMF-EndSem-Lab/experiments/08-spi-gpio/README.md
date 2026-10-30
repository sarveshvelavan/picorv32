# Q8 — 3-wire SPI GPIO firmware

**File:** `spi3wire.c`.

Host-side syntax check:

```bash
gcc -std=c11 -Wall -Wextra -Werror -fsyntax-only spi3wire.c
```

The example sends command `1011` MSB first using GPIO bit-banging. GPIO address, pin mapping, chip-select polarity and SPI sampling edge are assumptions. Confirm the actual sensor datasheet and board wiring before hardware use.