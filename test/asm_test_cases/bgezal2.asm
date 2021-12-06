ADDIU $3 $3 6
ADDIU $5 $5 2
SUBU  $5 $5 $3   # $5 = -4
BGEZAL $5 1
ADDIU $5 $5 4
ADDIU $5 $5 5
JR $0   #result -> $5 = 5
        #AND link $ra = current pc + 4