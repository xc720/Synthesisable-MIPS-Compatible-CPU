ADDIU $4 $4 4
ADDIU $5 $5 5
BEQ   $4 $5 1
ADDIU $2 $2 2048
ADDIU $2 $2 1024
JR $0   #not equal -> result is $2 = 2048