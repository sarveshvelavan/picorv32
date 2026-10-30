# Q2 — PicoRV32 framework

**Files:** `picorv32_system.v` (wrapper), `tb_picorv32_framework.v` (testbench).

This experiment depends on the official `picorv32.v` at the repository root. If you used sparse checkout, include all three paths:

```bash
git -C PAMF-Q2 sparse-checkout set picorv32.v PAMF-EndSem-Lab/experiments/02-picorv32-framework
```

From the repository root:

```bash
iverilog -g2012 -s tb_picorv32_framework -o q2_sim picorv32.v PAMF-EndSem-Lab/experiments/02-picorv32-framework/picorv32_system.v PAMF-EndSem-Lab/experiments/02-picorv32-framework/tb_picorv32_framework.v
vvp q2_sim
```

This is a constant-NOP instruction-fetch bus smoke test. It does not demonstrate execution of a user firmware image.