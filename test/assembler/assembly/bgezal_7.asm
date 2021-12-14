ADDIU $a0, $a0, 11
SUBU $a1, $a1, $a0
BGEZAL $a1, GreaterEqualZero
NOP
ADDIU $v0, $v0, 100
GreaterEqualZero:
ADDIU $v0, $v0, 6
ADDU $v0, $v0, $zero
JR $zero