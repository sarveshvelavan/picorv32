# PAMF End-Sem Lab — CO4 & CO5

Each experiment has its **own numbered folder**. You do not need to download all twelve experiments to run one. Use Git sparse-checkout to fetch only the folder you need.

## Folder map

| Experiment | Folder |
|---|---|
| Q1 — 5-stage pipeline model | `experiments/01-pipeline` |
| Q2 — PicoRV32 framework | `experiments/02-picorv32-framework` |
| Q3 — Clock and reset | `experiments/03-clock-reset` |
| Q4 — Variable-latency memory | `experiments/04-variable-memory` |
| Q5 — Interrupt-driven ADC driver | `experiments/05-adc-driver` |
| Q6 — Temperature monitor | `experiments/06-temperature-monitor` |
| Q7 — Temperature peripheral/system | `experiments/07-temperature-system` |
| Q8 — 3-wire SPI GPIO | `experiments/08-spi-gpio` |
| Q9 — Peripheral decoder | `experiments/09-peripheral-decoder` |
| Q10 — Linker script | `experiments/10-linker-script` |
| Q11 — LED firmware/startup | `experiments/11-led-firmware` |
| Q12 — Calibration FSM | `experiments/12-calibration-fsm` |

## Download only the experiment you need

The following example downloads **only Q7** (plus Git's repository metadata). Run in Command Prompt, PowerShell, Git Bash, or a terminal with Git installed:

```bash
git clone --filter=blob:none --no-checkout --branch pamf-endsem-lab --sparse https://github.com/sarveshvelavan/picorv32.git PAMF-Q7
git -C PAMF-Q7 sparse-checkout set PAMF-EndSem-Lab/experiments/07-temperature-system
cd PAMF-Q7/PAMF-EndSem-Lab/experiments/07-temperature-system
```

Now only the Q7 folder's files are checked out. Open its `README.md` and follow the run commands there.

### Choose another experiment

Use the same two Git commands, but change the destination folder and sparse-checkout path. For example, Q4:

```bash
git clone --filter=blob:none --no-checkout --branch pamf-endsem-lab --sparse https://github.com/sarveshvelavan/picorv32.git PAMF-Q4
git -C PAMF-Q4 sparse-checkout set PAMF-EndSem-Lab/experiments/04-variable-memory
cd PAMF-Q4/PAMF-EndSem-Lab/experiments/04-variable-memory
```

Replace `04-variable-memory` with the exact folder name from the table for the experiment you were assigned.

### Pull updates later

From the downloaded experiment clone, run:

```bash
git pull
```

## Dependencies / important exceptions

- **Q2 and Q3** instantiate the official PicoRV32 core. Their sparse checkout must also include the repository-root `picorv32.v` and Q2 wrapper. Use:
  `git -C PAMF-Q2 sparse-checkout set picorv32.v PAMF-EndSem-Lab/experiments/02-picorv32-framework PAMF-EndSem-Lab/experiments/03-clock-reset`
  (For Q2 alone, the Q3 path can be omitted.)
- **Q10 and Q11** work together: Q11's startup/firmware uses Q10's `sections.lds`. Include both folders:
  `git -C PAMF-Q11 sparse-checkout set PAMF-EndSem-Lab/experiments/10-linker-script PAMF-EndSem-Lab/experiments/11-led-firmware`
- **Q5–Q8 and Q11** contain example MMIO addresses/pin assumptions. Confirm them against your actual lab board before running on hardware.
- Q1 is a pipeline-stage demonstration, not a complete RISC-V CPU. Q2 is an instruction-fetch bus smoke test, not proof that application firmware runs.

## Run RTL simulations

Install Icarus Verilog (`iverilog` and `vvp`). Each RTL experiment folder contains its own design and testbench where applicable. Example for Q7:

```bash
iverilog -g2012 -s tb_temperature_peripheral -o q7_sim temperature_peripheral.v tb_temperature_peripheral.v
vvp q7_sim
```

Waveforms are written as `.vcd` files when enabled by the testbench; open them with GTKWave.

## Verification status

C syntax and RISC-V startup/linker checks were performed during preparation. HDL files were structurally reviewed, but Icarus simulation was not run in the preparation environment. The GitHub Actions workflow at `.github/workflows/pamf-rtl.yml` is intended to run selected RTL checks after push; check the Actions tab for actual run status.

The upstream `picorv32.v` is not duplicated in this lab folder. The parent repository's `COPYING` file governs the core's license.
