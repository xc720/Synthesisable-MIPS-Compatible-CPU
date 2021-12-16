LUI $a0, 0x1020           #
ADDIU $a0, $a0, 0x3040     #a0 = 0x10203040
ADDIU $a1, $a1, 256     #a1 = 0x100
SW $a0, 0($a1)          #mem(256) = 0x40302010
ADDIU $v0, $zero, 0xFFFF
LWL $v0, 1($a1)        #v0 = 0x80000000
JR $zero                #0x00000008