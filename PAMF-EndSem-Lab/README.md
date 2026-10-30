# PAMF End-Sem Lab — CO4 & CO5

Twelve organized PAMF end-semester lab experiments, with Verilog design files and self-checking testbenches for the RTL experiments. C firmware and the linker script are included for the firmware-focused questions.

## Add this folder to your existing PicoRV32 clone

This collection is intended to live beside the official `picorv32.v` at the repository root:

```bash
git clone https://github.com/sarveshvelavan/picorv32.git
cd picorv32
# Extract/copy the supplied PAMF-EndSem-Lab folder into this directory.
```

## Clone after it has been pushed

```bash
git clone https://github.com/sarveshvelavan/picorv32.git
cd picorv32/PAMF-EndSem-Lab
```

## Experiment index

| Q | Folder | Design source | Testbench / type |
|---|---|---|---|
| 1 | `experiments/01-pipeline` | `pipeline5.v` | `tb_pipeline5.v` |
| 2 | `experiments/02-picorv32-framework` | `picorv32_system.v` | `tb_picorv32_framework.v` (NOP bus smoke test only) |
| 3 | `experiments/03-clock-reset` | `clock_reset_source.v` | `tb_picorv32_reset.v` (instantiates PicoRV32 via wrapper) |
| 4 | `experiments/04-variable-memory` | `variable_latency_memory.v` | `tb_variable_latency_memory.v` |
| 5 | `experiments/05-adc-driver` | `adc_driver.c` | Firmware; no RTL testbench |
| 6 | `experiments/06-temperature-monitor` | `temperature_monitor.c` | Firmware; no RTL testbench |
| 7 | `experiments/07-temperature-system` | `temperature_peripheral.v` | `tb_temperature_peripheral.v` |
| 8 | `experiments/08-spi-gpio` | `spi3wire.c` | Firmware; no RTL testbench |
| 9 | `experiments/09-peripheral-decoder` | `peripheral_decoder.v` | `tb_peripheral_decoder.v` |
| 10 | `experiments/10-linker-script` | `sections.lds` | GNU linker script; see Q11 startup |
| 11 | `experiments/11-led-firmware` | `main.c`, `startup.S` | Firmware/startup; no RTL testbench |
| 12 | `experiments/12-calibration-fsm` | `temperature_calibration_fsm.v` | `tb_temperature_calibration_fsm.v` |

## Run RTL tests locally

Install Icarus Verilog and GTKWave, then from the `picorv32` repository root:

```bash
# Q1
iverilog -g2012 -s tb_pipeline5 -o /tmp/q1 PAMF-EndSem-Lab/experiments/01-pipeline/pipeline5.v PAMF-EndSem-Lab/experiments/01-pipeline/tb_pipeline5.v
vvp /tmp/q1

# Q2 — requires official picorv32.v in this repository root
iverilog -g2012 -s tb_picorv32_framework -o /tmp/q2 picorv32.v PAMF-EndSem-Lab/experiments/02-picorv32-framework/picorv32_system.v PAMF-EndSem-Lab/experiments/02-picorv32-framework/tb_picorv32_framework.v
vvp /tmp/q2

# Q3 — requires official picorv32.v
iverilog -g2012 -s tb_picorv32_reset -o /tmp/q3 picorv32.v PAMF-EndSem-Lab/experiments/02-picorv32-framework/picorv32_system.v PAMF-EndSem-Lab/experiments/03-clock-reset/clock_reset_source.v PAMF-EndSem-Lab/experiments/03-clock-reset/tb_picorv32_reset.v
vvp /tmp/q3

# Q4
iverilog -g2012 -s tb_variable_latency_memory -o /tmp/q4 PAMF-EndSem-Lab/experiments/04-variable-memory/variable_latency_memory.v PAMF-EndSem-Lab/experiments/04-variable-memory/tb_variable_latency_memory.v
vvp /tmp/q4

# Q7, Q9, Q12 follow the same design + testbench pattern
```

Open a generated waveform with `gtkwave q1_pipeline.vcd` (or the corresponding `.vcd` file).

## Firmware and linker checks

Host syntax checks for the C examples:

```bash
gcc -std=c11 -Wall -Wextra -Werror -fsyntax-only experiments/05-adc-driver/adc_driver.c
gcc -std=c11 -Wall -Wextra -Werror -fsyntax-only experiments/06-temperature-monitor/temperature_monitor.c
gcc -std=c11 -Wall -Wextra -Werror -fsyntax-only experiments/08-spi-gpio/spi3wire.c
gcc -std=c11 -Wall -Wextra -Werror -fsyntax-only experiments/11-led-firmware/main.c
```

For Q11, compile `startup.S` and `main.c` with a RISC-V bare-metal toolchain and use `experiments/10-linker-script/sections.lds`. The startup code copies `.data` from ROM to RAM and clears `.bss` before calling `main`.

## What is and is not verified

- C source syntax was checked with GCC using `-Wall -Wextra -Werror -fsyntax-only`.
- Q10 linker-script syntax and Q11 RISC-V startup/link layout were checked with a RISC-V-targeting Clang/LLD toolchain; `_start` was placed at `0x20000000` and stack top at `0x00004000`.
- HDL sources and testbenches were reviewed and checked for basic module/block balance. Icarus Verilog was unavailable in the authoring environment, so **no local Icarus simulation pass is claimed**. The GitHub Actions workflow under the repository-root `.github/workflows/` runs Icarus elaboration/simulation after import.
- Q1 is a token/stage overlap demonstration, not a complete RISC-V ISA pipeline (no decode, ALU, forwarding or hazard handling).
- Q2's constant-NOP responder verifies instruction-fetch/bus activity only. It does not verify user firmware. For firmware verification, add the proper ROM/RAM image and peripheral model.
- Q3 is simulation stimulus (20 ns clock, active-low reset released at 200 ns), not synthesizable clock hardware.
- Q4 models a full word-addressed memory with byte write strobes and variable 3–7 cycle response; initialize memory with a firmware image for a CPU integration test.
- Q5 ADC interrupt hooks (`adc_irq_save`/`adc_irq_restore`) must be implemented for your processor/board interrupt controller.
- Q5–Q8 and Q11 use assumed MMIO addresses because the question paper does not provide a full board register map or named sensor part. Confirm the actual address, scaling, CS polarity and SPI sampling edge before hardware use.
- Q7 is a standalone read-only sensor peripheral target. It must be integrated into a system address decoder/bus mux.
- Q10 requires startup section `.crt0`; Q11 supplies it in `startup.S`.
- Q12 is unsigned 16-bit multiplication. Signed/fixed-point scaling was not specified in the question paper.

## Upstream core

This project uses the upstream `picorv32.v` in the parent repository and does not duplicate it. Consult the repository's `COPYING` file for the core license.
