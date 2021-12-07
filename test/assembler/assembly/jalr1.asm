ADDIU $a1, $a1, 12        # jump to mem[4]
JALR  $a1                 #
ADDIU $a1, $a1, 5         #
ADDIU $a1, $a1, 5         #
JR $zero                  # $a1 should be 17
# And link current pc + 4 to $ra 