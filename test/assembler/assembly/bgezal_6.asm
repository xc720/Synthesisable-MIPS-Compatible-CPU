ADDIU $a0, $a0, 19
SUBU $a1, $a1, $a0
BGEZ $a1, GreaterEqualZero
NOP
ADDIU $v0, $v0, 100
GreaterEqualZero:
ADDIU $v0, $v0, 3
JR $zero