ADDIU $a3, $a3, 0         #
BLEZ  $a3, Equal              #
ADDIU $a0, $a0, 15        #
ADDIU $a0, $a0, 15        #
JR $zero                  #branch on ; result -> $a0 = 15