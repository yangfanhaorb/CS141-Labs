nor $t0, $zero, $zero
nor $t1, $zero, $zero
add $t2, $t0, $t1
sub $t3, $zero, $t2
slt $t4, $t2, $t3
sll $t5, $t3, 4
addi $t6, $t5, 10
slti $t7, $t5, 40
sw $t6, 4($t5)
addi $t8, $t5, 4
lw $t9, 0($t8)
ori $s0, $t0, 0
andi $s1, $t0, 0
xori $s2, $t0, 0
