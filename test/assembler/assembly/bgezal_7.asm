ADDIU $a0, $a0, 11
SUBU $a1, $a1, $a0
BGEZAL $a1, GreaterEqualZero
ADDIU $v0, $v0, 100
GreaterEqualZero:
ADDIU $v0, $v0, 3
ADDU $v0, $v0, $ra
JR $zero            #v0=0xBFC00010+ 103(decimal)=3217031287