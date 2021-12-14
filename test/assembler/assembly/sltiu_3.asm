ADDIU $a0, $a0, 3
SUBU $v0, $a1, $a0
SLTIU $v0, $v0, 3
xori $v0, $v0, 65535			# $v0 = $t1 ^ 0xffff = 

JR $zero