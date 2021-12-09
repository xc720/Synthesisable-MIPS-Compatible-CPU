ADDIU $a1, $a1, 5         #
JAL Equal                     #
ADDIU $a1, $a1, 5         #
ADDIU $a1, $a1, 5         #
JR $zero                  # $a1 should be 10
# And link current pc + 4 to $ra 