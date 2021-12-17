ADDIU $a0, $a0, 3
SUBU $v0, $a1, $a0      #v0=-3-->unsigned=4294967293
SLTIU $v0, $v0, 3       #v0=0
xori $v0, $v0, 65535    #v0=65535
JR $zero