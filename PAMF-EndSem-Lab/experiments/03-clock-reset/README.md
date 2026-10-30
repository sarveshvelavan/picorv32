# Q3 — Clock and reset

**Files:** `clock_reset_source.v` (simulation clock/reset source), `tb_picorv32_reset.v` (testbench).

Depends on the official `picorv32.v` and the shared wrapper in Q2. Sparse-checkout all dependencies:

```bash
git -C PAMF-Q3 sparse-checkout set picorv32.v PAMF-EndSem-Lab/experiments/02-picorv32-framework PAMF-EndSem-Lab/experiments/03-clock-reset
```

From the repository root:

```bash
iverilog -g2012 -s tb_picorv32_reset -o q3_sim picorv32.v PAMF-EndSem-Lab/experiments/02-picorv32-framework/picorv32_system.v PAMF-EndSem-Lab/experiments/03-clock-reset/clock_reset_source.v PAMF-EndSem-Lab/experiments/03-clock-reset/tb_picorv32_reset.v
vvp q3_sim
```

Clock/reset source is simulation-only, not synthesizable clock hardware.