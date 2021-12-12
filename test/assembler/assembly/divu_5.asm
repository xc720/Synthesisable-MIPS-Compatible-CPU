ADDIU $a0, $a0, 6         #
ADDIU $a1, $a1, 6         #
DIVU $zero, $a0, $a1            # Hi = a0%a1  LO = a0/a1
JR    $zero               #