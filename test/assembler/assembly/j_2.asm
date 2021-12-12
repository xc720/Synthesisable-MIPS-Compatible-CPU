ADDIU $a1, $a1, 3         #
ADDIU $v0, $v0, 5         #
J Equal                   #
ADDIU $v0, $v0, 5         #
JR $zero
Equal:
JR $zero                 # $v0 should be 5