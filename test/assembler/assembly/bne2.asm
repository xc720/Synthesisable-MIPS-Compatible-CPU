ADDIU $a0, $a0, 4         #
ADDIU $a1, $a1, 5         #
BNE   $a0, $a1, Equal         #
ADDIU $v0, $v0, 2048      #
ADDIU $v0, $v0, 1024      #
JR $zero   #not equal/branch on -> $v0 = 1024