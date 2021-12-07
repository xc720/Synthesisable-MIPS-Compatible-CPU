ADDIU $a3, $a3, 0         #
BGEZ  $a3, 1              #
ADDIU $a0, $a0, 10        #
ADDIU $a0, $a0, 15        #
JR $zero                #branch on ; result -> $a0 = 15