ADDIU $a0, $a0, 4         #
ADDIU $a1, $a1, 0         #
ADDIU $a2, $a2, 5         #
SUBU  $a1, $a1, $a2       # $a1 = -5
DIV   $a0, $a1            # Hi = a0%a1  LO = a0/a1
JR    $zero               #