ADDIU $v0, $v0, 10
JAL Equal
ADDIU $v0, $v0, 1000
Equal:
ADDU $v0, $v0, $zero      #$zero=4194312
JR $zero                #$v0=4194322