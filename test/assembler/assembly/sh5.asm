LUI $a0, 55555
ADDIU $a0, $a0, 111
ADDIU $a1, $a1, 300
SH $a0, -2($a1)
LH $v0, 0($a1)
JR $zero