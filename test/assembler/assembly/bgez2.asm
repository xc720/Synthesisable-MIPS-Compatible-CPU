ADDIU $a1, $a0, 22                #
ADDIU $a3, $a3, 11                #
SUBU  $a3, $a3, $a1               # $a3 = -11
BGEZ $a3, Equal                       #
ADDIU $a0, $a0, 3                 #
ADDIU $a0, $a0, 4                 #
JR $zero                        #result -> $a0 = 7