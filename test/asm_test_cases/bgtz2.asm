addiu $1 $0 22
addiu $3 $3 11
subu  $3 $3 $1  # $3 = -11
bgtz $3 1
addiu $4 $4 3
addiu $4 $4 4
jr $0   #result -> $4 = 7