ADDIU $a1, $a1, 12        #
JR $a1                    # jump to mem[4]
ADDIU $a1, $a1, 5         #
ADDIU $a1, $a1, 5         #
JR $zero                  # $a1 should be 17