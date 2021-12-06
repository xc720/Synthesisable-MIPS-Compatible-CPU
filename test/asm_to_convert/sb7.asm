ADDIU $a0, $a0, 65555
ADDIU $a1, $a1, 256
SB $a0, 1($a1)
LBU $v0, 0($a1)
JR $ra