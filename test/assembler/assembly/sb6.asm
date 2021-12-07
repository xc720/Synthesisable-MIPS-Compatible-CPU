ADDIU $a0, $a0, 11111
ADDIU $a1, $a1, 256
SB $a0, 1($a1)
LBU $v0, 2($a1)
JR $zero