ADDIU $a3 $a3 0         #
BGTZ $a3 1              #
ADDIU $a0 $a0 10        #
ADDIU $a0 $a0 15        #
JR $zero   #result -> $a0 = 25