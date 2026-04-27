# RISC16 Single-Cycle Processor | Basys3 FPGA

A 16-bit single-cycle RISC processor implemented in VHDL, targeting the Digilent Basys3 development board.

---

## Architecture

![RISC16 Block Diagram](figures/Risc16v1_2.drawio.svg)

The processor follows a classic single-cycle datapath design with a 3-bit opcode space.

### Clock Source
The processor clock can be connected either to the Basys3 onboard system clock or to a pushbutton. Configurable via the constraints file.

### Debug Mode

- **LEDs** display the current instruction from left to right
- **7-segment display** always shows the current Program Counter value in hexadecimal (both in normal operation and debug mode)

When the processor halts (after a `HALT` instruction), it enters debug mode:
- **LEDs** display the content of the register selected via switches 0–2

---

## Todo

1. Add 7-segment display logic to the processor (DONE)
2. Create the constraints file
	- Current errors: only toplevel ports can be mapped in the constraints file --> lower level ports have to be routet upwards.
3. Implement missing instructions (`LW`, `SW`, etc.)
4. Add build tcl script

---

## Known Limitations & Potential Error Sources

- `a_equ_b` is not reset between instructions — it retains its value from the last `BEQ` and is not cleared until the next `BEQ` executes.
- Signals like `a_equ_b` have no default value and remain uninitialized (`U`) until first written.

---

## Lessons Learned

### VHDL Process Sensitivity Lists

**Symptom:** The controller only ever produced outputs for the first `"000"` opcode case, regardless of the actual instruction being decoded.

**Investigation:** The waveform below shows the controller outputs frozen despite changing instructions.

![Waveform showing controller bug](figures/Risc16v1_2_error.png)

**Root cause:** The sensitivity list of the output process contained `instruction` instead of `opcode`. Even though `opcode` was correctly assigned to the upper three bits of `instruction` outside the process, the process itself never re-evaluated when `opcode` changed.

**Fix:** Replace `instruction` with `opcode` in the sensitivity list of the output process.

**Takeaway:** In VHDL, a process only re-evaluates when a signal in its sensitivity list changes. Derived signals assigned outside a process are not automatically tracked — always list the signals the process *actually reads*, not their sources. See [vhdl-online.de | Process Execution](https://www.vhdl-online.de/courses/system_design/vhdl_language_and_syntax/process_execution) for further background.

### Constraint file

Only ports of the top level entity can be mapped to the constraint file. This means if you want to connect the debug_addr - which are needed by the `dp_alu_regfile` entity - you have to connect the signal throug every layer of the Risc16v1_2 entity. 
This not only adds much overhead to the different layers but also reduces reusablity of the different modules.  
