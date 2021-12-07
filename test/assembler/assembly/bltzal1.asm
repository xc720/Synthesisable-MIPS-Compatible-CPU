ADDIU $a0, $a0, 4     #
BLTZAL   $a0, Equal       #
ADDIU $a0, $a0, 3     #
ADDIU $a0, $a0, 4     #
JR $zero              #result -> $a0 = 11
# And link current pc + 4 to $ra 