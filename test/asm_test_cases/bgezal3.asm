ADDIU $a1 $a1 0         #
BGEZAL $a1 1            #
ADDIU $a0 $a0 10        #
ADDIU $a0 $a0 15        #
JR $zero   #branch on ; result -> $a0 = 15
        #AND link pc + 4 to $ra