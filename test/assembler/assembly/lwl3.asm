LUI $a0, 1024           #0x3C040400 
ADDIU $a0, $a0, 128     #0x24840080
ADDIU $a1, $a1, 256     #0x24A50100
SW $a0, 0($a1)          #0xACA40000
LWL $v0, -4($a1)        #0x88A2FFFC
JR $zero                #0x00000008