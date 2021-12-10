ADDIU $a0, $a0, 4095   #
ADDIU $a0, $a0, 4095   #
ADDIU $a0, $a0, 4095   #
ADDIU $a2, $a2, 0      # a2 = 0x00000
SUBU  $a2, $a2, $a0    # 
ADDIU $a1, $a1, 200    # a1 = 200
SW $a2, 0($a1)         # mem(200) = 12285/-20475
LB $v0, 1($a1)         # v0 = mem(201) = -48
JR $zero                   #