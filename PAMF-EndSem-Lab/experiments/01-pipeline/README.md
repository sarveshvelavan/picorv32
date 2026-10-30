# Q1 — 5-stage pipeline model

**Files:** `pipeline5.v` (design), `tb_pipeline5.v` (testbench).

From this folder:

```bash
iverilog -g2012 -s tb_pipeline5 -o q1_sim pipeline5.v tb_pipeline5.v
vvp q1_sim
```

Expected: a PASS message confirming successive instruction tokens in the pipeline registers. This is a pipeline timing demonstration, not a full RISC-V pipeline.