ADDIU $v0, $v0, 10
JAL Equal
ADDIU $v0, $v0, 188
ADDIU $v0, $v0, 1876
Equal:
ADDU $v0, $v0, $ra
JR $zero        #v0=10