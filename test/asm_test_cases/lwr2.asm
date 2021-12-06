LUI $a0, 1024           #
ADDIU $a0, $a0, 128     #
ADDIU $a1, $a1, 256     #
SW $a0, 0($a1)          #
LWR $v0, 2($a1)         #
JR $zero                #