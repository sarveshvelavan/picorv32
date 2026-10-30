# Q4 — Variable-latency memory

**Files:** `variable_latency_memory.v` (design), `tb_variable_latency_memory.v` (testbench).

From this folder:

```bash
iverilog -g2012 -s tb_variable_latency_memory -o q4_sim variable_latency_memory.v tb_variable_latency_memory.v
vvp q4_sim
```

The testbench exercises delayed writes and reads with variable wait cycles. The memory model is a simulation model, not a physical memory controller.