ADDIU $a0, $zero, 1     # a0 = 1
SLTI $v0, $a0, -1   # v0 = 1 < -1 = 0
xori $v0, $a0, 0xffff
JR $zero