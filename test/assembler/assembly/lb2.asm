ADDIU $a0, $a0, 4095   # a0 = 0xFFF
ADDIU $a0, $a0, 4095   # a0 = 0x1FFE
ADDIU $a0, $a0, 4095   # a0 = 0x2FFD
ADDIU $a0, $a0, 4095   # a0 = 0x3FFC
ADDIU $a0, $a0, 4095   # a0 = 0x4FFB
ADDIU $a1, $a1, 200    # a1 = 200
SW $a0, 0($a1)         # mem(200) = 0x00004FFB
LB $v0, 2($a1)         # v0 = mem(202) = 0x4F
JR $zero                  #