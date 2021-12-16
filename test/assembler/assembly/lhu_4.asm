ADDIU $a0, $a0, 4095 
ADDIU $a0, $a0, 4095  
ADDIU $a0, $a0, 4095   
ADDIU $a0, $a0, 4095   
ADDIU $a0, $a0, 4095       
SUBU  $a2, $a2, $a0  
SUBU  $a2, $a2, $a0
SUBU  $a2, $a2, $a0
SUBU  $a2, $a2, $a0
ADDIU $a1, $a1, 20000
SW $a2, 0($a1)         
LHU $v0, 2($a1)        
JR $zero                  
