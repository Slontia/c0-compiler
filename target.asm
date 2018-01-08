.data
S_0: .asciiz "Found: "
S_1: .asciiz "\n"
S_2: .asciiz "[ 404 Not Found ]\n"
S_3: .asciiz "You got a bug!"
S_4: .asciiz "Please enter the length of the matrix: "
S_5: .asciiz "It's too small, my friend! Please enter again: "
S_6: .asciiz "Got it! Please enter the matrix:\n"
S_7: .asciiz "ZIGZAG!\n"
S_8: .asciiz "Please enter the size of the array:"
S_9: .asciiz "Interesting.\n"
S_10: .asciiz "sub: "
S_11: .asciiz "BEST: "
S_12: .asciiz "The maximum fluctuation is "
S_13: .asciiz " from "
S_14: .asciiz " and "
S_15: .asciiz "Please enter the length of the Fibonacci: "
S_16: .asciiz "It's meaningless!\n"
S_17: .asciiz "\t"
S_18: .asciiz "Please enter the size of the array: "
S_19: .asciiz "Invalid size! Please enter the size again: "
S_20: .asciiz "Got it! Now, please enter the "
S_21: .asciiz " elements:\n"
S_22: .asciiz "Got "
S_23: .asciiz "Exchange "
S_24: .asciiz " "
S_25: .asciiz "[2]"
S_26: .asciiz "The sorted array is:\n"
S_27: .asciiz "["
S_28: .asciiz "]"
S_29: .asciiz "======================\n"
S_30: .asciiz "|   1. Sort          |\n"
S_31: .asciiz "|   2. Fibonacci     |\n"
S_32: .asciiz "|   3. FluctuaTions  |\n"
S_33: .asciiz "|   4. Zigzag        |\n"
S_34: .asciiz "|   5. Find          |\n"
S_35: .asciiz "|   0. Exit          |\n"
S_36: .asciiz "Please enter your choice(0-5):"
S_37: .asciiz "Please enter a number:"
S_38: .asciiz "Bye"
.space 4
over_S:
.text
la $gp, over_S
andi $gp, $gp, 0xFFFFFFFC
addi $fp, $fp, 404
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
init_array_E:
li $s0, 0
init_array_L_0_while_begin:
li $s1, 100
slt $t0 $s0 $s1
beq $t0, $0, init_array_L_1_while_over
nop
sll $v0, $s0, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
sw $s0, ($v0)
addi $s0 $s0 1
j init_array_L_0_while_begin
nop
init_array_L_1_while_over:
jr $ra
nop
find_E:
lw $s1, -4($fp)
lw $s3, -8($fp)
lw $s0, -12($fp)
seq $t0 $s1 $s3
beq $t0, $0, find_L_0_else_begin
nop
sll $v0, $s1, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
seq $t1 $t0 $s0
beq $t1, $0, find_L_2_else_begin
nop
li $v0, 4
la $a0, S_0
syscall
li $v0, 1
move $a0, $s1
syscall
li $v0, 4
la $a0, S_1
syscall
j find_L_3_else_over
nop
find_L_2_else_begin:
li $v0, 4
la $a0, S_2
syscall
find_L_3_else_over:
jr $ra
nop
find_L_0_else_begin:
find_L_1_else_over:
add $t0 $s1 $s3
div $s2 $t0 2
sll $v0, $s2, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
slt $t1 $t0 $s0
beq $t1, $0, find_L_4_else_begin
nop
addi $t0 $s2 1
sw $s0, 16($fp)
sw $s3, 20($fp)
sw $t0, 24($fp)
addi $sp, $sp, -28
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $t0, 20($sp)
sw $t1, 24($sp)
addi $fp, $fp, 28
jal find_E
nop
addi $fp, $fp, -28
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $t0, 20($sp)
lw $t1, 24($sp)
addi $sp, $sp, 28
j find_L_5_else_over
nop
find_L_4_else_begin:
sll $v0, $s2, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
sgt $t1 $t0 $s0
beq $t1, $0, find_L_6_else_begin
nop
sw $s0, 16($fp)
sw $s2, 20($fp)
sw $s1, 24($fp)
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $t0, 16($sp)
sw $t1, 20($sp)
addi $fp, $fp, 28
jal find_E
nop
addi $fp, $fp, -28
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $t0, 16($sp)
lw $t1, 20($sp)
addi $sp, $sp, 24
j find_L_7_else_over
nop
find_L_6_else_begin:
sll $v0, $s2, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
seq $t1 $t0 $s0
beq $t1, $0, find_L_8_else_begin
nop
li $v0, 4
la $a0, S_0
syscall
li $v0, 1
move $a0, $s2
syscall
li $v0, 4
la $a0, S_1
syscall
j find_L_9_else_over
nop
find_L_8_else_begin:
li $v0, 4
la $a0, S_3
syscall
find_L_9_else_over:
find_L_7_else_over:
find_L_5_else_over:
jr $ra
nop
get_index_E:
lw $s1, -4($fp)
lw $s0, -8($fp)
lw $s2, -12($fp)
addi $t0 $s0 -1
mul $t1 $t0 $s1
addi $t0 $s2 -1
add $t2 $t1 $t0
move $v0, $t2
jr $ra
nop
zigzag_E:
li $v0, 4
la $a0, S_4
syscall
li $v0, 5
syscall
move $s2, $v0
zigzag_L_0_while_begin:
li $s0, 10
sge $t0 $s2 $s0
beq $t0, $0, zigzag_L_1_while_over
nop
li $v0, 4
la $a0, S_5
syscall
li $v0, 5
syscall
move $s2, $v0
j zigzag_L_0_while_begin
nop
zigzag_L_1_while_over:
li $v0, 4
la $a0, S_6
syscall
li $s0, 0
zigzag_L_2_while_begin:
mul $t0 $s2 $s2
slt $t1 $s0 $t0
beq $t1, $0, zigzag_L_3_while_over
nop
li $v0, 12
syscall
move $s1, $v0
add $v0, $s0, $fp
addi $v0, $v0, 16
sb $s1, ($v0)
addi $s0 $s0 1
div $t0 $s0 $s2
mul $t1 $t0 $s2
seq $t0 $t1 $s0
sb $s1, 8($fp) # store temp
beq $t0, $0, zigzag_L_4_else_begin
nop
li $v0, 4
la $a0, S_1
syscall
sb $s1, 8($fp) # store temp
j zigzag_L_5_else_over
nop
sb $s1, 8($fp) # store temp
zigzag_L_4_else_begin:
zigzag_L_5_else_over:
j zigzag_L_2_while_begin
nop
zigzag_L_3_while_over:
li $v0, 4
la $a0, S_7
syscall
li $s3, 1
li $s0, 1
sw $s0, 124($fp)
sw $s0, 128($fp)
sw $s2, 132($fp)
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $s2, 4($sp)
sw $s3, 8($sp)
sw $s4, 12($sp)
addi $fp, $fp, 136
jal get_index_E
nop
addi $fp, $fp, -136
lw $ra, 0($sp)
lw $s2, 4($sp)
lw $s3, 8($sp)
lw $s4, 12($sp)
addi $sp, $sp, 16
move $t0, $v0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
li $v0, 11
move $a0, $t1
syscall
li $s4, 1
zigzag_L_6_while_begin:
mul $t0 $s3 $s4
mul $t1 $s2 $s2
sne $t2 $t0 $t1
beq $t2, $0, zigzag_L_7_while_over
nop
seq $t0 $s4 $s2
beq $t0, $0, zigzag_L_8_else_begin
nop
addi $s3 $s3 1
j zigzag_L_9_else_over
nop
zigzag_L_8_else_begin:
addi $s4 $s4 1
zigzag_L_9_else_over:
sw $s4, 124($fp)
sw $s3, 128($fp)
sw $s2, 132($fp)
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
addi $fp, $fp, 136
jal get_index_E
nop
addi $fp, $fp, -136
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
addi $sp, $sp, 24
move $t0, $v0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
li $v0, 11
move $a0, $t1
syscall
li $s1, 0
sub $s0 $s4 $s3
zigzag_L_10_while_begin:
slt $t0 $s1 $s0
beq $t0, $0, zigzag_L_11_while_over
nop
addi $s1 $s1 1
addi $s4 $s4 -1
addi $s3 $s3 1
sw $s4, 124($fp)
sw $s3, 128($fp)
sw $s2, 132($fp)
addi $sp, $sp, -28
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $t0, 24($sp)
addi $fp, $fp, 136
jal get_index_E
nop
addi $fp, $fp, -136
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
lw $t0, 24($sp)
addi $sp, $sp, 28
move $t0, $v0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
li $v0, 11
move $a0, $t1
syscall
j zigzag_L_10_while_begin
nop
zigzag_L_11_while_over:
seq $t0 $s3 $s2
beq $t0, $0, zigzag_L_12_else_begin
nop
addi $s4 $s4 1
j zigzag_L_13_else_over
nop
zigzag_L_12_else_begin:
addi $s3 $s3 1
zigzag_L_13_else_over:
sw $s4, 124($fp)
sw $s3, 128($fp)
sw $s2, 132($fp)
addi $sp, $sp, -24
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
addi $fp, $fp, 136
jal get_index_E
nop
addi $fp, $fp, -136
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
addi $sp, $sp, 24
move $t0, $v0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
li $v0, 11
move $a0, $t1
syscall
li $s0, 0
sub $t0 $0 $s4
add $s1 $t0 $s3
zigzag_L_14_while_begin:
slt $t0 $s0 $s1
beq $t0, $0, zigzag_L_15_while_over
nop
addi $s0 $s0 1
addi $s3 $s3 -1
addi $s4 $s4 1
sw $s4, 124($fp)
sw $s3, 128($fp)
sw $s2, 132($fp)
addi $sp, $sp, -28
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s3, 16($sp)
sw $s4, 20($sp)
sw $t0, 24($sp)
addi $fp, $fp, 136
jal get_index_E
nop
addi $fp, $fp, -136
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s3, 16($sp)
lw $s4, 20($sp)
lw $t0, 24($sp)
addi $sp, $sp, 28
move $t0, $v0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
li $v0, 11
move $a0, $t1
syscall
j zigzag_L_14_while_begin
nop
zigzag_L_15_while_over:
j zigzag_L_6_while_begin
nop
zigzag_L_7_while_over:
jr $ra
nop
fluctuations_E:
li $v0, 4
la $a0, S_8
syscall
li $v0, 5
syscall
move $s5, $v0
fluctuations_L_0_while_begin:
li $s0, 1
sle $t0 $s5 $s0
beq $t0, $0, fluctuations_L_1_while_over
nop
li $v0, 4
la $a0, S_9
syscall
li $v0, 4
la $a0, S_8
syscall
li $v0, 5
syscall
move $s5, $v0
j fluctuations_L_0_while_begin
nop
fluctuations_L_1_while_over:
li $s1, 0
li $s0, 0
li $s4, -1
li $s6, 0
sw $s1, 4($fp) # store a
fluctuations_L_2_while_begin:
sub $t0 $0 $s6
sub $t1 $0 $t0
sub $t0 $0 $t1
sub $t1 $0 $t0
slt $t0 $t1 $s5
beq $t0, $0, fluctuations_L_3_while_over
nop
li $v0, 5
syscall
move $s1, $v0
sub $s7 $s1 $s0
li $v0, 4
la $a0, S_10
syscall
li $v0, 1
move $a0, $s7
syscall
li $v0, 4
la $a0, S_1
syscall
sle $t1 $s7 $0
beq $t1, $0, fluctuations_L_4_else_begin
nop
sub $s7 $0 $s7
j fluctuations_L_5_else_over
nop
fluctuations_L_4_else_begin:
fluctuations_L_5_else_over:
sgt $t0 $s7 $s4
beq $t0, $0, fluctuations_L_6_else_begin
nop
move $s2, $s1
move $s3, $s0
move $s4, $s7
j fluctuations_L_7_else_over
nop
fluctuations_L_6_else_begin:
fluctuations_L_7_else_over:
li $v0, 4
la $a0, S_11
syscall
li $v0, 1
move $a0, $s4
syscall
li $v0, 4
la $a0, S_1
syscall
move $s0, $s1
addi $s6 $s6 1
j fluctuations_L_2_while_begin
nop
fluctuations_L_3_while_over:
li $v0, 4
la $a0, S_12
syscall
li $v0, 1
move $a0, $s4
syscall
li $v0, 4
la $a0, S_13
syscall
li $v0, 1
move $a0, $s2
syscall
li $v0, 4
la $a0, S_14
syscall
li $v0, 1
move $a0, $s3
syscall
li $v0, 4
la $a0, S_1
syscall
jr $ra
nop
fibonacci_E:
li $s2, 1
li $v0, 4
la $a0, S_15
syscall
li $s0, 1
li $v0, 5
syscall
move $s1, $v0
sle $t0 $s1 $0
beq $t0, $0, fibonacci_L_0_else_begin
nop
li $v0, 4
la $a0, S_16
syscall
jr $ra
nop
fibonacci_L_0_else_begin:
fibonacci_L_1_else_over:
li $v0, 1
move $a0, $s2
syscall
li $v0, 4
la $a0, S_17
syscall
li $s3, 1
sle $t0 $s1 $s3
beq $t0, $0, fibonacci_L_2_else_begin
nop
jr $ra
nop
fibonacci_L_2_else_begin:
fibonacci_L_3_else_over:
li $v0, 1
move $a0, $s0
syscall
li $v0, 4
la $a0, S_17
syscall
li $s3, 2
sle $t0 $s1 $s3
beq $t0, $0, fibonacci_L_4_else_begin
nop
jr $ra
nop
fibonacci_L_4_else_begin:
fibonacci_L_5_else_over:
li $s3, 3
fibonacci_L_6_while_begin:
sle $t0 $s3 $s1
beq $t0, $0, fibonacci_L_7_while_over
nop
add $s4 $s2 $s0
move $s0, $s2
li $v0, 1
move $a0, $s4
syscall
li $v0, 4
la $a0, S_17
syscall
div $t0 $s1 10
mul $t1 $t0 10
addi $t0 $s3 1
seq $t2 $t1 $t0
move $s2, $s4
sw $s4, 8($fp) # store sum
beq $t2, $0, fibonacci_L_8_else_begin
nop
li $v0, 4
la $a0, S_1
syscall
sw $s4, 8($fp) # store sum
j fibonacci_L_9_else_over
nop
sw $s4, 8($fp) # store sum
fibonacci_L_8_else_begin:
fibonacci_L_9_else_over:
addi $s3 $s3 1
j fibonacci_L_6_while_begin
nop
fibonacci_L_7_while_over:
jr $ra
nop
sort_E:
li $v0, 4
la $a0, S_18
syscall
li $v0, 5
syscall
move $s2, $v0
sort_L_0_while_begin:
li $s0, 100
sge $t0 $s2 $s0
beq $t0, $0, sort_L_1_while_over
nop
li $v0, 4
la $a0, S_19
syscall
li $v0, 5
syscall
move $s2, $v0
j sort_L_0_while_begin
nop
sort_L_1_while_over:
li $v0, 4
la $a0, S_20
syscall
li $v0, 1
move $a0, $s2
syscall
li $v0, 4
la $a0, S_21
syscall
li $s0, 0
sort_L_2_while_begin:
slt $t0 $s0 $s2
beq $t0, $0, sort_L_3_while_over
nop
li $v0, 5
syscall
move $s1, $v0
sll $v0, $s0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
sw $s1, ($v0)
li $v0, 4
la $a0, S_22
syscall
sll $v0, $s0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t0, ($v0)
li $v0, 1
move $a0, $t0
syscall
li $v0, 4
la $a0, S_1
syscall
addi $s0 $s0 1
sw $s1, 412($fp) # store temp
j sort_L_2_while_begin
nop
sw $s1, 412($fp) # store temp
sort_L_3_while_over:
li $s1, 0
sort_L_4_while_begin:
addi $t0 $s2 -1
slt $t1 $s1 $t0
beq $t1, $0, sort_L_5_while_over
nop
li $s0, 0
sort_L_6_while_begin:
addi $t0 $s2 -1
sub $t1 $t0 $s1
slt $t0 $s0 $t1
beq $t0, $0, sort_L_7_while_over
nop
sll $v0, $s0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t1, ($v0)
addi $t0 $s0 1
sll $v0, $t0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t2, ($v0)
sgt $t3 $t1 $t2
beq $t3, $0, sort_L_8_else_begin
nop
li $v0, 4
la $a0, S_23
syscall
li $v0, 1
move $a0, $t1
syscall
li $v0, 4
la $a0, S_24
syscall
li $v0, 1
move $a0, $t2
syscall
li $v0, 4
la $a0, S_1
syscall
sll $v0, $s0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
sw $t2, ($v0)
sll $v0, $t0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
sw $t1, ($v0)
move $s3, $t3
sw $s3, 412($fp) # store temp
j sort_L_9_else_over
nop
sw $s3, 412($fp) # store temp
sort_L_8_else_begin:
sort_L_9_else_over:
addi $s0 $s0 1
j sort_L_6_while_begin
nop
sort_L_7_while_over:
addi $s1 $s1 1
j sort_L_4_while_begin
nop
sort_L_5_while_over:
li $v0, 4
la $a0, S_25
syscall
lw $t0, 8($fp)
li $v0, 1
move $a0, $t0
syscall
li $v0, 4
la $a0, S_1
syscall
li $v0, 4
la $a0, S_26
syscall
li $s0, 0
sort_L_10_while_begin:
slt $t0 $s0 $s2
beq $t0, $0, sort_L_11_while_over
nop
addi $s0 $s0 1
li $v0, 4
la $a0, S_27
syscall
addi $t0 $s0 -1
li $v0, 1
move $a0, $t0
syscall
li $v0, 4
la $a0, S_28
syscall
sll $v0, $t0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t1, ($v0)
li $v0, 1
move $a0, $t1
syscall
li $v0, 4
la $a0, S_17
syscall
addi $t0 $s0 1
div $t1 $t0 10
mul $t2 $t1 10
seq $t1 $t2 $t0
beq $t1, $0, sort_L_12_else_begin
nop
li $v0, 4
la $a0, S_1
syscall
j sort_L_13_else_over
nop
sort_L_12_else_begin:
sort_L_13_else_over:
j sort_L_10_while_begin
nop
sort_L_11_while_over:
li $v0, 48
jr $ra
nop
select_E:
select_L_0_while_begin:
li $v0, 4
la $a0, S_1
syscall
li $v0, 4
la $a0, S_29
syscall
li $v0, 4
la $a0, S_30
syscall
li $v0, 4
la $a0, S_31
syscall
li $v0, 4
la $a0, S_32
syscall
li $v0, 4
la $a0, S_33
syscall
li $v0, 4
la $a0, S_34
syscall
li $v0, 4
la $a0, S_35
syscall
li $v0, 4
la $a0, S_29
syscall
li $v0, 4
la $a0, S_36
syscall
li $v0, 5
syscall
move $s0, $v0
div $t0 $s0 1
mul $t1 $t0 1
beq $t1, 0, select_L_3_case
nop
beq $t1, 1, select_L_4_case
nop
beq $t1, 2, select_L_5_case
nop
beq $t1, 3, select_L_6_case
nop
beq $t1, 4, select_L_7_case
nop
beq $t1, 5, select_L_8_case
nop
j select_L_9_default
nop
select_L_3_case:
j select_L_2_switch_over
nop
select_L_4_case:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)
addi $fp, $fp, 8
jal sort_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 8
j select_L_2_switch_over
nop
select_L_5_case:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)
addi $fp, $fp, 8
jal fibonacci_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 8
j select_L_2_switch_over
nop
select_L_6_case:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)
addi $fp, $fp, 8
jal fluctuations_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 8
j select_L_2_switch_over
nop
select_L_7_case:
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)
addi $fp, $fp, 8
jal zigzag_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 8
j select_L_2_switch_over
nop
select_L_8_case:
li $v0, 4
la $a0, S_37
syscall
li $v0, 5
syscall
move $s1, $v0
sw $s1, 8($fp)
li $s2, 99
sw $s2, 12($fp)
sw $0, 16($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 4($fp) # store num
addi $fp, $fp, 20
jal find_E
nop
addi $fp, $fp, -20
lw $ra, 0($sp)
lw $s0, 4($sp)
addi $sp, $sp, 8
sw $s1, 4($fp) # store num
j select_L_2_switch_over
nop
sw $s1, 4($fp) # store num
select_L_9_default:
li $v0, 4
la $a0, S_9
syscall
j select_L_2_switch_over
nop
select_L_2_switch_over:
seq $t0 $s0 $0
beq $t0, $0, select_L_10_else_begin
nop
li $v0, 4
la $a0, S_38
syscall
jr $ra
nop
select_L_10_else_begin:
select_L_11_else_over:
j select_L_0_while_begin
nop
select_L_1_while_over:
jr $ra
nop
main_E:
addi $sp, $sp, -4
sw $ra, 0($sp)
addi $fp, $fp, 0
jal init_array_E
nop
addi $fp, $fp, -0
lw $ra, 0($sp)
addi $sp, $sp, 4
addi $sp, $sp, -4
sw $ra, 0($sp)
addi $fp, $fp, 0
jal select_E
nop
addi $fp, $fp, -0
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra
nop
