ADDIU $v0, $v0, 5         #
J Equal                       #
ADDIU $v0, $v0, 5         #
ADDIU $v0, $v0, 5         #
Equal:
JR $zero                  # $v0 should be 5