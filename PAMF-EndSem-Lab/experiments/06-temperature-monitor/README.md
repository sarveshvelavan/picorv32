# Q6 — Temperature monitor firmware

**File:** `temperature_monitor.c`.

Host-side syntax check:

```bash
gcc -std=c11 -Wall -Wextra -Werror -fsyntax-only temperature_monitor.c
```

This is firmware for an assumed memory-mapped temperature input and LED output. The addresses and Q8.8 temperature scaling are examples; confirm the actual board register map and sensor format before hardware execution.