LUI $a0, 1024               #
ADDIU $a0, $a0, 128         #a0 = 0x480
ADDIU $a1, $a1, 256         #a1 = 0x100
SW $a0, 0($a1)              #mem(256) = 0x00000480
LWR $v0, -4($a1)            #v0 = 0
JR $zero                    #