ADDIU $v0, $0, 10   
JAL Equal
ADDIU $v0, $v0, 12
ADDIU $v0, $v0, 19
Equal:                
ADDIU $ra, $ra, 24
JALR $t2, $ra
ADDIU $v0, $v0, 34
ADDIU $v0, $v0, 18
ADDU $v0, $v0, $ra
ADDU $v0, $v0, $t2 
JR $0               #$v0=10+0xBFC00000*2+24+32+=