ADDIU $1 $0 22
ADDIU $3 $3 11
SUBU  $3 $3 $1  # $3 = -11
BLEZ $3 1
ADDIU $4 $4 3
ADDIU $4 $4 4
JR $0   #branch on; result -> $4 = 7