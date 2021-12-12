ADDIU $a0, $a0, 0         #
ADDIU $a2, $a2, 5         #
SUBU  $a0, $a0, $a2       #$a0 = -5
ADDIU $a1, $a1, 4         #
DIVU $zero, $a0, $a1            # Hi = -5%4  LO = -5/4
JR    $zero               #