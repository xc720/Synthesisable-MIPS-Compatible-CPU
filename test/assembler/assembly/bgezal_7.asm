ADDIU $a0, $a0, 11
SUBU $a1, $a1, $a0
BGEZAL $a1, GreaterEqualZero
NOP
ADDIU $v0, $v0, 100
GreaterEqualZero:
ADDU $v0, $v0, $ra
JR $zero            #v0=0xBFC00010+ 100(decimal)=3217031284