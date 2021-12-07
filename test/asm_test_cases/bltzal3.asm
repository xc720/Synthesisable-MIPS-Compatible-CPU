ADDIU $a3, $a3, 0         #
BLTZ $a3, 1               #
ADDIU $a0, $a0, 15        #
ADDIU $a0, $a0, 15        #
JR $zero                  #result $a0 = 30
# And link current pc + 4 to $ra