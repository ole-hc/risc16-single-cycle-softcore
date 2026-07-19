# RISC16 Single-Cycle Processor | Basys3 FPGA

A 16-bit single-cycle RISC processor written in VHDL, targeting the Digilent Basys3 development board (Artix-7).

The full RiSC-16 instruction set is implemented — `ADD`, `ADDI`, `NAND`, `LUI`, `SW`, `LW`, `BEQ` and `JALR` as defined in the [RiSC-16 ISA specification](https://user.eng.umd.edu/~blj/risc/RiSC-isa.pdf). The processor has been validated both in simulation and on real hardware.

---

## Overview

The design follows a classic single-cycle datapath with a Harvard architecture:

| | |
|---|---|
| **Word width** | 16 bit |
| **Registers** | 8 × 16 bit (`r0` hardwired to zero) |
| **Opcode space** | 3 bit |
| **Instruction memory** | 1k × 16 bit ROM |
| **Data memory** | 64k × 16 bit RAM (`LW` / `SW`) |
| **Execution model** | Single cycle |

The instruction ROM is filled in the Vivado editor before synthesis. There is no bootloader or external program load path!

![RISC16 Block Diagram](figures/Risc16v2.svg)

### Instruction Set

| Opcode | Instruction | Format | Operation |
|--------|-------------|--------|-----------|
| `000` | `ADD  rA,rB,rC` | RRR | rA = rB + rC |
| `001` | `ADDI rA,rB,imm7` | RRI | rA = rB + imm7 (signed) |
| `010` | `NAND rA,rB,rC` | RRR | rA = ~(rB & rC) |
| `011` | `LUI  rA,imm10` | RI | rA = imm10 << 6 |
| `100` | `SW   rA,rB,imm7` | RRI | mem[rB + imm7] = rA |
| `101` | `LW   rA,rB,imm7` | RRI | rA = mem[rB + imm7] |
| `110` | `BEQ  rA,rB,imm7` | RRI | if rA == rB: PC = PC + 1 + imm7 |
| `111` | `JALR rA,rB` | RRI | rA = PC + 1; PC = rB |

---

## Implementation Notes

### Clocking

The processor runs on two clocks derived from the Basys3 100 MHz oscillator via the **Clocking Wizard IP**: one for the seven-segment multiplexing and one system clock for the processor itself.

The data RAM is clocked on the **inverted** system clock. This is what makes load and store work in a single cycle: address and write data are computed combinationally during the first half of the cycle, the RAM latches on the falling edge, and the result is written back to the register file on the next rising edge.

### Debug Mode

During normal operation:

- **LEDs** display the current instruction from left to right
- **7-segment display** shows the current Program Counter in hexadecimal

When the controller hits an unknown instruction, the processor halts and enters debug mode:

- **LEDs** display the content of the register selected via switches 0–2
- **7-segment display** continues to show the Program Counter

---

## Repository Structure

| Version | Description |
|---------|-------------|
| **`Risc16v2`** | **Current.** Controller, datapath and Harvard memory with all RiSC-16 instructions implemented. |
| `Risc16v1_2` | Controller, datapath and ROM with `ADD`, `ADDI`, `BEQ`, halt. |
| `Risc16v1_1` | First test of datapath and ROM, controller stimulated from the testbench. |

The `v1_x` versions no longer build, they are kept as build-time checkpoints of how the design grew.

---

## Lessons Learned

### VHDL Process Sensitivity Lists

**Symptom:** The controller only ever produced outputs for the first `"000"` opcode case, regardless of the instruction being decoded.

**Investigation:** The waveform below shows the controller outputs frozen while the instruction changes.

![Waveform showing controller bug](figures/Risc16v1_2_error.png)

**Root cause:** The sensitivity list of the output process contained `instruction` instead of `opcode`. Even though `opcode` was correctly assigned from the upper three bits of `instruction` outside the process, the simulation never picked up on the change.

**Fix:** Replace `instruction` with `opcode` in the sensitivity list of the output process.

**Takeaway:** Always list the signals the process *actually reads*, not the ones they are derived from. I am still not entirely sure how the simulator schedules this — see [vhdl-online.de | Process Execution](https://www.vhdl-online.de/courses/system_design/vhdl_language_and_syntax/process_execution) for further background.

### Constraint File

Only ports of the **top level entity** can be mapped in the constraint file. If you want to connect `debug_addr`, which is needed by the `dp_alu_regfile` entity, the signal has to be routed through every layer of the hierarchy. This adds a lot of overhead to the intermediate layers and reduces the reusability of the individual modules.

Every top level port has to be mapped in the constraints file.

The clock signal cannot be mapped to a button. Vivado rejects this because buttons are not stable clock sources.

### Combinatorial Loops

The `BEQ` hardware path (2's complement extender → `imm16` → mux) feeds part of the instruction back onto itself, which synthesis reports as a combinatorial loop. This warning has to be disabled in the constraints file.

### Seven Segment Display

When displaying a number across all four digits, the multiplexing frequency must not be too high, otherwise every segment appears lit at once. Around 1 kHz works well, which gives roughly 1 ms per digit.

The Basys3 seven-segment display is **active low** on both cathodes and anodes, so the outputs have to be inverted.

### IP Integration

This was my first time integrating an IP core into a project. I used the Clocking Wizard to split the 100 MHz system clock into one clock for the seven-segment multiplexing and one for the processor.
