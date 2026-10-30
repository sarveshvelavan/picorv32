# Q10 — Linker memory layout

`sections.lds` defines 16 KiB RAM at `0x00000000` and 2 KiB ROM at `0x20000000`. The `.crt0` section is retained at the beginning of ROM. Q11 supplies `startup.S` in section `.crt0`; it initializes the stack, copies `.data` to RAM, clears `.bss`, then calls `main`.
