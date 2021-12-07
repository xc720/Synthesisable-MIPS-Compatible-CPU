ADDIU $a1, $a1, 5         #
JAL 0                     #
ADDIU $a1, $a1, 5         #
ADDIU $a1, $a1, 5         #
JR $zero                  # $a1 should be 5
# And link current pc + 4 to $ra 