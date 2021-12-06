addiu $4 $4 4
addiu $5 $5 5
beq   $4 $5 1
addiu $2 $2 2048
addiu $2 $2 1024
jr $0   #not equal -> result is $2 = 2048