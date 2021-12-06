ADDIU $a0 $a0 5                #
BGEZAL $a0 1                   #
ADDIU $a0 $a0 4                #
ADDIU $a0 $a0 5                #
JR $zero                       #branch on/ pc = pc + 8; result -> $a0 = 10
#AND link $ra = current + 4