ADDIU $a0 $a0 4         #
ADDIU $a1 $a1 5         #
BEQ   $a0 $a1 1         #
ADDIU $v0 $v0 2048      #
ADDIU $v0 $v0 1024      #
JR $zero   #not equal -> result is $vo = 2048