addiu $5 $5 5
bgezal $5 1
addiu $5 $5 4
addiu $5 $5 5
jr $0   #branch on/ pc = pc + 8; result -> $5 = 10
        #and link $ra = current + 4