# Potential Error sources

- `a_equ_b` is not reset. It is only changed on a BEQ instruction and not changed back after the next one, etc.

- Signals like `a_equ_b` don't have a default value. They only change from U after the first time they are wrote. 

# Current ERRORs of Risc16v1_2

NONE :)

# Past ERRORs of Risc16v1_2

- the controller only ever set the signals for the first "000" case
	- the problem was in the controller file the sensitivity list of the output process contained `instruction` instead of `opcode`
	- even though `opcode` was mapped to the upper three `instruction` bits outside of the process it was never set
	- didnt really understand why possibly documented in https://www.vhdl-online.de/courses/system_design/vhdl_language_and_syntax/process_execution further investigation required for a deeper understanding of the simulation process

![Risc16v1_2_waveform](figures/Risc16v1_2_error.png)

# Risc16 architecture block diagram

![](figures/Risc16v1_2.drawio.svg)
