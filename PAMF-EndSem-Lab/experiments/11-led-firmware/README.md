# Q11 — Bare-metal LED firmware

Build `main.c` with `startup.S` and Q10's linker script `../10-linker-script/sections.lds`. The GPIO LED address `0x40000020` is an example because the question paper does not define the actual board memory map.

Example (toolchain prefix may vary):

```bash
riscv32-unknown-elf-gcc -march=rv32im -mabi=ilp32 -ffreestanding -nostdlib \
  -T ../10-linker-script/sections.lds -Wl,-Map=firmware.map \
  -o firmware.elf startup.S main.c
riscv32-unknown-elf-objcopy -O binary firmware.elf firmware.bin
```
