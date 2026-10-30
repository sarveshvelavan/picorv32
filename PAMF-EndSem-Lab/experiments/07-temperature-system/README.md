# Q7 — Temperature peripheral/system

**Files:** `temperature_peripheral.v` (read-only peripheral), `tb_temperature_peripheral.v` (testbench).

## 1. Windows setup (one-time)

Open **Command Prompt** and run:

```cmd
winget install --id Icarus.Verilog -e
```

The Windows installer linked by this package includes Icarus Verilog and GTKWave. If Windows asks for permission or licence acceptance, approve it. If `winget` is not recognized, install/update **App Installer** from Microsoft Store, or download the installer from [Icarus Verilog for Windows](https://bleyer.org/icarus/).

Close Command Prompt, open it again, and check:

```cmd
iverilog -V
vvp -V
gtkwave --version
```

If `iverilog` or `vvp` is still not recognized, rerun the installer and enable its PATH option. GTKWave may also need its `bin` folder added to PATH; alternatively, open `gtkwave.exe` from the install folder.

## 2. Open this experiment folder

If you cloned the repository using the Q7 sparse-checkout commands, run this from the folder where `PAMF-Q7` is located:

```cmd
cd /d C:\Users\%USERNAME%\PAMF-Q7\PAMF-EndSem-Lab\experiments\07-temperature-system
dir
```

Make sure these files are listed: `README.md`, `temperature_peripheral.v`, and `tb_temperature_peripheral.v`.

## 3. Compile and run

Run these commands from the Q7 folder:

```cmd
iverilog -g2012 -s tb_temperature_peripheral -o q7_sim temperature_peripheral.v tb_temperature_peripheral.v
vvp q7_sim
```

Expected terminal message:

```
Q7 PASS: matching read selected and wrong address ignored
```

The testbench also creates `q7_temp.vcd`, the waveform dump.

## 4. View the waveform

```cmd
gtkwave q7_temp.vcd
```

GTKWave should open the waveform. In its signal list, select the testbench and DUT signals and add them to the waveform pane.

**Note:** This is a standalone peripheral test. It checks a read at address `0x40000010` and verifies that a different address is not acknowledged. Integrate the peripheral into your system address decoder/bus mux for a complete CPU system.
