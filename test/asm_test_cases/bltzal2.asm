ADDIU $a1 $a1 22        #
ADDIU $a3 $a3 11        #
SUBU  $a3 $a3 $a1       # $3 = -11
BLTZAL  $a3 1             #
ADDIU $a0 $a0 3         #
ADDIU $a0 $a0 4         #
JR $zero                #branch on; result -> $a0 = 4
# And link current pc + 4 to $ra 