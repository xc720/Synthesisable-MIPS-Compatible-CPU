ADDIU $a0, $a0, 4095   # a0 = 0x00FFF
ADDIU $a0, $a0, 4095   # a0 = 0x01FFE
ADDIU $a0, $a0, 4095   # a0 = 0x02FFD
ADDIU $a0, $a0, 4095   # a0 = 0x03FFC
ADDIU $a0, $a0, 4095   # a0 = 0x04FFB
ADDIU $a2, $a2, 0      # a2 = 0x00000
SUBU  $a2, $a2, $a0    # a2 = 0x0B005/-20475
ADDIU $a1, $a1, 200    # a1 = 200
SW $a2, 0($a1)         # mem(200) = 0x0000B005/-20475
LHU $v0, 1($a1)        # v0 = mem(201) = 0x00b0
JR $zero                  #