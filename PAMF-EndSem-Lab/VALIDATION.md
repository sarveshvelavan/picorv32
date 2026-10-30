# Validation report

Date: 2026-10-30

## Checks completed in the preparation environment

| Area | Check | Result |
|---|---|---|
| C firmware Q5, Q6, Q8, Q11 | GCC C11 syntax-only with `-Wall -Wextra -Werror` | PASS |
| Q10/Q11 | RISC-V Clang assembly/compile and LLD link using `sections.lds` | PASS |
| Q10 boot placement | ELF symbol/section inspection | PASS: `_start` at `0x20000000`; `_estack` at `0x00004000` |
| Verilog source/testbench files | Basic structural checks for balanced module/endmodule and begin/end blocks | PASS (static only) |
| Verilog simulation | Icarus Verilog (`iverilog`/`vvp`) | NOT RUN: simulator unavailable in preparation environment |

## Findings from reviewing the initial handbook source/testbench pairs

- Q1: the small model demonstrates pipeline token overlap only; it is not a complete RISC-V ISA pipeline and has no hazards/forwarding. The self-checking testbench now checks the expected progression of tokens through the four inter-stage registers.
- Q2: the original responder returned a constant NOP and used a registered ready signal; this is a bus smoke-test, not firmware verification. The revised version clearly labels it as a NOP fetch smoke-test and ties the CPU's unused PCPI/IRQ inputs low.
- Q3: the original file generated clock/reset but did not instantiate PicoRV32 despite the question requirement. The revised testbench instantiates the core through the wrapper and checks the 50 MHz clock/reset release timing.
- Q4: the original delay responder did not latch the memory transaction and could re-accept a request around its ready pulse. The revised model has IDLE/WAIT/RESP states, latches address/data/strobes, supports byte writes/readback, and selects 3–7 wait clocks.
- Q7: the original peripheral acknowledged every valid bus request, including unrelated addresses. The revised read-only peripheral acknowledges only a read at `0x40000010`.
- Q9: the original registered-ready implementation could repeat side effects while `mem_valid` remained asserted through the response edge. The revised decoder uses a combinational valid/ready match and captures selected byte lanes on the handshake clock edge.
- Q12: the FSM design structure is retained; the new testbench checks `25 * 4 = 100` and that `valid` is asserted only during DONE.

## Not claimed as verified

- Icarus compile/run for Verilog designs and testbenches is pending execution on a machine with Icarus Verilog, or in the GitHub Actions workflow after this archive is added to the repository.
- Q2's NOP responder is intentionally not a firmware execution proof. A program ROM/RAM image and expected peripheral side effects are still required.
- Board-level behavior for Q5–Q8 and Q11 is not validated. The question paper does not name the ADC/sensor part, full MMIO map, GPIO direction register, CS polarity, or SPI mode. Replace the explicitly marked assumptions with the actual lab hardware definitions.
