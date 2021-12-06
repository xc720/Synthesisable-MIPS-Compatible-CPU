ADDIU $a0, $a0, 512
ADDIU $a1, $a1, 1024
MULT $a0, $a1
MFLO $v0
MFHI $a2
ADDU $v0, $v0, $a2
JR $zero