ADDIU $a0, $a0, 55555
ADDIU $a1, $a1, 44444
MULT $a0, $a1
MFLO $v0
MFHI $a2
ADDU $v0, $v0, $a2
JR $zero