LUI $a0, 55555
ADDIU $a0, $a0, 111 # a0 = 0xd972
ADDIU $a1, $a1, 300
SH $a0, 0($a1) # mem(300) = 0x0000d972
LH $v0, 2($a1) #v0 = 0000
JR $zero