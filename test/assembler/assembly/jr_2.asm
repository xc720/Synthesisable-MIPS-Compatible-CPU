ADDIU $v0, $0, 10   #
JAL Equal           #
ADDIU $v0, $v0, 1   #
ADDIU $v0, $v0, 10  #
Equal:                
ADDIU $zero, $zero, 24  #
JR $zero             #
ADDIU $v0, $v0, 3   #
ADDIU $v0, $v0, 1   #
ADDU $v0, $v0, $zero  #
JR $zero            #v0=4194346