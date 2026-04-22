# Potential Error sources

- `a_equ_b` is not reset. It is only changed on a BEQ instruction and not changed back after the next one, etc.

- Signals like `a_equ_b` don't have a default value. They only change from U after the first time they are wrote. 

# Current ERRORs of Risc16v1_2

- first addi doesnt work: 
	- symptome: imm7_op and other signals not set
	- cause: controller process only starts on `instruction` or `a_equ_b` change
- when the processor goes into idle `pc_load` gets set to '0' --> pc doesnt increment anymore cant be undone by a reset because the controller is not connected to the reset signal

Solution to these two problems: connect the reset to controller and add it to its activation list

- the controller only ever set the signals for the first "000" case
	- the problem was in the controller file the sensitivity list of the output process contained `instruction` instead of `opcode`
	- even though `opcode` was mapped to the upper three `instruction` bits outside of the process it was never set
	- didnt really understand why possibly documented in https://www.vhdl-online.de/courses/system_design/vhdl_language_and_syntax/process_execution further investigation required for a deeper understanding of the simulation process

![Risc16v1_2_waveform](figures/Risc16v1_2_error.png)

