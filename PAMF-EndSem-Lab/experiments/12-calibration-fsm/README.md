# Q12 — Temperature calibration FSM

**Files:** `temperature_calibration_fsm.v` (design), `tb_temperature_calibration_fsm.v` (testbench).

From this folder:

```bash
iverilog -g2012 -s tb_temperature_calibration_fsm -o q12_sim temperature_calibration_fsm.v tb_temperature_calibration_fsm.v
vvp q12_sim
```

Expected: PASS for unsigned multiplication `25 * 4 = 100`, with `valid` asserted in the DONE state.