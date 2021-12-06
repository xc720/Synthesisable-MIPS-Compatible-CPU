ADDIU $5 $5 5
BGEZAL $5 1
ADDIU $5 $5 4
ADDIU $5 $5 5
JR $0   #branch on/ pc = pc + 8; result -> $5 = 10
        #AND link $ra = current + 4