ADDIU $a0, $a0, 18
BGTZ $a0, GreaterZero
NOP
ADDIU $v0, $v0, 60
ADDIU $v0, $v0, 100
GreaterZero:
ADDIU $v0, $v0, 6
JR $zero            #v0=6