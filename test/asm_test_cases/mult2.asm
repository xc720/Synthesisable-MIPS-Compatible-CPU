ADDIU $a0, $a0, 64  
SUBU $a1, $a1, $a0  
MULT $a0, $a1       
MFLO $v0            
MFHI $a2            
ADDU $v0, $v0, $a2
JR $zero