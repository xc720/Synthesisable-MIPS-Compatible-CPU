ADDIU $a0, $a0, 6         #
ADDIU $a1, $a1, 6         #
DIVU  $a0, $a1            # Hi = a0%a1  LO = a0/a1
MFLO  $v0                 #
JR    $zero               #