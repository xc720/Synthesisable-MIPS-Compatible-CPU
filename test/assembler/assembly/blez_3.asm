ADDIU $a0, $a0, 1
SUBU $a1, $a1, $a0
BLEZ $a1, LessEqualZero
ADDIU $v0, $v0, 60
ADDIU $v0, $v0, 100
LessEqualZero:
ADDIU $v0, $v0, 3
JR $zero