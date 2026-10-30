# Q7 — Temperature peripheral/system

**Files:** `temperature_peripheral.v` (read-only peripheral), `tb_temperature_peripheral.v` (testbench).

From this folder:

```bash
iverilog -g2012 -s tb_temperature_peripheral -o q7_sim temperature_peripheral.v tb_temperature_peripheral.v
vvp q7_sim
```

Expected: PASS for a read at `0x40000010`, and no acknowledgement for a different address. The peripheral is a standalone bus target; integrate it into your system address decoder/bus mux for a complete CPU system.