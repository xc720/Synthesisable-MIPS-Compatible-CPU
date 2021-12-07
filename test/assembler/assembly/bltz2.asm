ADDIU $a1, $a1, 22        #
ADDIU $a3, $a3, 11        #
SUBU  $a3, $a3, $a1       # $3 = -11
BLTZ  $a3, Equal              #
ADDIU $a0, $a0, 3         #
ADDIU $a0, $a0, 4         #
JR $zero                  #branch on; result -> $a0 = 4