LUI $a0, 10      # a0 = 1
SLTI $v0, $a0, 10    # v0 = 1 <= -1 = 0
XORI $v0, $v0, 31
JR $zero