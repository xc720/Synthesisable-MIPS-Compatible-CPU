ADDIU $a0, $a0, 24
ADDIU $a1, $a1, 24
BNE $a0, $a1, NotEqual
NOP
ADDIU $v0, $v0, 60
ADDIU $v0, $v0, 100
NotEqual:
JR $zero