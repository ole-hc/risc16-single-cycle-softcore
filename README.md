# Potential Error sources

- `a_equ_b` is not reset. It is only changed on a BEQ instruction and not changed back after the next one, etc.

- Signals like `a_equ_b` don't have a default value. They only change from U after the first time they are wrote. 

# Current ERRORs of Risc16v1_2

- first addi doesnt work: 
	- symptom: imm7_op and other signals not set
	- cause: controller process only starts on `instruction` or `a_equ_b` change
- beq substraction doesnt work
	- no further info right now


