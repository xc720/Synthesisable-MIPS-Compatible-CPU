ADDIU $a0, $a0, 4   #
BGTZ $a0, 1         #
ADDIU $a0, $a0, 3   #
ADDIU $a0, $a0, 4   #
JR $zero   #branch on/ pc = pc + 8; result -> $a0 = 8