addiu $3 $3 0
bgezal $3 1
addiu $4 $4 10
addiu $4 $4 15
jr $0   #branch on ; result -> $4 = 15
        #and link pc + 4 to $ra