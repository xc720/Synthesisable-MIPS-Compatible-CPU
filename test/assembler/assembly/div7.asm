ADDIU $a0, $a0, 0         #
ADDIU $a2, $a2, 4         #
SUBU  $a0, $a0, $a2       # $a0 = -4
ADDIU $a1, $a1, 4         #
DIV   $a0, $a1            # Hi = a0%a1  LO = a0/a1
JR    $zero               #