ADDIU $a0, $a0, 16
BLTZ $a0, SmallerZero
ADDIU $v0, $v0, 66      # Branch delay slot
ADDIU $v0, $v0, 100     # Skipped
SmallerZero:
ADDIU $v0, $v0, 3
JR $zero