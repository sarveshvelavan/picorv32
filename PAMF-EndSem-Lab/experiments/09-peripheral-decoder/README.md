# Q9 — Peripheral decoder

**Files:** `peripheral_decoder.v` (design), `tb_peripheral_decoder.v` (testbench).

From this folder:

```bash
iverilog -g2012 -s tb_peripheral_decoder -o q9_sim peripheral_decoder.v tb_peripheral_decoder.v
vvp q9_sim
```

The testbench checks that writes to `0x40000004` update the register and writes to a different address are ignored.