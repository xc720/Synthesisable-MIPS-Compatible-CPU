ADDIU $a0, $a0, 18
BGEZ $a0, GreaterEqualZero
ADDIU $v0, $v0, 50          # Branch delay slot
ADDIU $v0, $v0, 100         # Skipped
GreaterEqualZero:
ADDIU $v0, $v0, 3
JR $zero