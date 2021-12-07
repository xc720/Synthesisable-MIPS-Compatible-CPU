ADDIU $a1, $a1, 6     #
ADDIU $a0, $a0, 2     #
SUBU  $a0, $a0, $a1   # $a0 = -4
BGEZAL $a0, 1         #
ADDIU $a0, $a0, 4     #
ADDIU $a0, $a0, 5     #
JR $zero   #result -> $a0 = 5
        #AND link $ra = current pc + 4