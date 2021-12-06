addiu $3 $3 6
addiu $5 $5 2
subu  $5 $5 $3   # $5 = -4
bgezal $5 1
addiu $5 $5 4
addiu $5 $5 5
jr $0   #result -> $5 = 5
        #and link $ra = current pc + 4