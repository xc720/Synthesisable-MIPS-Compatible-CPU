ADDIU $a0, $a0, 10
SUBU $a1, $a1, $a0
DIV $zero, $a0, $a1
MFHI $v0
ADDIU $v0, $v0, 1
JR $zero