ADDIU $a1 $a1 22        #
ADDIU $a3 $a3 11        #
SUBU  $a3 $a3 $a1       # $a3 = -11
BGTZ $a3 1              #
ADDIU $a0 $a0 3         #
ADDIU $a0 $a0 4         #
JR $zero   #result -> $a0 = 7