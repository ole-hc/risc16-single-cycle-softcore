# Potential Error sources

- `a_equ_b` is not reset. It is only changed on a BEQ instruction and not changed back after the next one, etc.

- Signals like `a_equ_b` don't have a default value. They only change from U after the first time they are wrote. 
