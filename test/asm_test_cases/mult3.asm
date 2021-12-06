ADDIU $a0, $a0, 64
MULT $a0, $zero
MFLO $v0
MFHI $a2
ADDU $v0, $v0, $a2
JR $zero