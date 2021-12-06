addiu $4 $4 5
addiu $5 $5 5
beq   $4 $5 2
addiu $2 $2 2048
addiu $2 $2 1024
jr $0   #pc = pc + 8 which is $2 = 1024