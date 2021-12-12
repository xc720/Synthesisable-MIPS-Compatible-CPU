ADDIU $v0, $0, 10   #
JAL Equal           # 
ADDIU $v0, $v0, 1   # 
ADDIU $v0, $v0, 10  # 
Equal:                
ADDIU $ra, $ra, 20  #
JALR $t2, $ra       #
ADDIU $v0, $v0, 3   #
ADDIU $v0, $v0, 1   # 
ADDU $v0, $v0, $ra  #
JR $0               #v0=4194343