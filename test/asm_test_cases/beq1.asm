ADDIU $4 $4 5
ADDIU $5 $5 5
BEQ   $4 $5 1
ADDIU $2 $2 2048
ADDIU $2 $2 1024
JR $0   #pc = pc + 8 which is $2 = 1024