ADDIU $a0, $a0, 99999          #
SUBU $a1, $a1, $a0          #
MULT $a0, $a1               #
MFLO $v0                    #
JR $zero                    #v0=-1409865409