.data
S_0: .asciiz " "
S_1: .asciiz "operation:"
S_2: .asciiz "cannot div 0!!!"
S_3: .asciiz "operation kind is not in [+-*/]!!!"
S_4: .asciiz "expre:"
S_5: .asciiz "fibo:"
S_6: .asciiz "gcd:"
S_7: .asciiz "string:!#$%&'()*+,-./:;<=>?@[\]^_`{|}~"
.space 4
over_S:
.text
la $gp, over_S
andi $gp, $gp, 0xFFFFFFFC
addi $fp, $fp, 60
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
testdefine_E:
jr $ra
nop
fibo_E:
lw $s0, -4($fp)
slt $t0 $s0 $0
beq $t0, $0, fibo_L_0_else_begin
nop
li $v0, -1
jr $ra
nop
fibo_L_0_else_begin:
seq $t0 $s0 $0
beq $t0, $0, fibo_L_2_else_begin
nop
li $v0, 0
jr $ra
nop
fibo_L_2_else_begin:
li $s1, 1
seq $t0 $s0 $s1
beq $t0, $0, fibo_L_4_else_begin
nop
li $v0, 1
jr $ra
nop
fibo_L_4_else_begin:
li $s1, 10
sgt $t0 $s0 $s1
beq $t0, $0, fibo_L_6_else_begin
nop
li $v0, -2
jr $ra
nop
fibo_L_6_else_begin:
addi $t0 $s0 -1
sw $t0, 4($fp)
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $t0, 8($sp)
addi $fp, $fp, 8
jal fibo_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $t0, 8($sp)
addi $sp, $sp, 12
move $t0, $v0
addi $t1 $s0 -2
sw $t1, 4($fp)
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $t0, 8($sp)
sw $t1, 12($sp)
addi $fp, $fp, 8
jal fibo_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $t0, 8($sp)
lw $t1, 12($sp)
addi $sp, $sp, 16
move $t1, $v0
add $t2 $t0 $t1
move $v0, $t2
jr $ra
nop
fibo_L_7_else_over:
fibo_L_5_else_over:
fibo_L_3_else_over:
fibo_L_1_else_over:
li $v0, 0
jr $ra
nop
upcase_E:
lw $s0, -4($fp)
li $s1, 97
sge $t0 $s0 $s1
beq $t0, $0, upcase_L_0_else_begin
nop
li $s2, 122
sle $t0 $s0 $s2
beq $t0, $0, upcase_L_2_else_begin
nop
addi $t0 $s0 -97
addi $s3 $t0 65
move $v0, $s3
jr $ra
nop
upcase_L_2_else_begin:
move $v0, $s0
jr $ra
nop
upcase_L_3_else_over:
j upcase_L_1_else_over
nop
upcase_L_0_else_begin:
move $v0, $s0
jr $ra
nop
upcase_L_1_else_over:
li $v0, 0
jr $ra
nop
lowcase_E:
lw $s0, -4($fp)
li $s1, 65
sge $t0 $s0 $s1
beq $t0, $0, lowcase_L_0_else_begin
nop
li $s2, 90
sle $t0 $s0 $s2
beq $t0, $0, lowcase_L_2_else_begin
nop
addi $t0 $s0 -65
addi $s3 $t0 97
move $v0, $s3
jr $ra
nop
lowcase_L_2_else_begin:
move $v0, $s0
jr $ra
nop
lowcase_L_3_else_over:
j lowcase_L_1_else_over
nop
lowcase_L_0_else_begin:
move $v0, $s0
jr $ra
nop
lowcase_L_1_else_over:
li $v0, 0
jr $ra
nop
printspace_E:
li $v0, 4
la $a0, S_0
syscall
jr $ra
nop
operation_E:
lw $s2, -4($fp)
lw $s1, -8($fp)
lw $s0, -12($fp)
beq $s0, 1, operation_L_1_case
nop
beq $s0, 2, operation_L_2_case
nop
beq $s0, 3, operation_L_3_case
nop
beq $s0, 4, operation_L_4_case
nop
j operation_L_7_default
nop
operation_L_1_case:
li $v0, 4
la $a0, S_1
syscall
add $t0 $s2 $s1
li $v0, 1
move $a0, $t0
syscall
move $v0, $t0
jr $ra
nop
operation_L_2_case:
li $v0, 4
la $a0, S_1
syscall
sub $t0 $s2 $s1
li $v0, 1
move $a0, $t0
syscall
move $v0, $t0
jr $ra
nop
operation_L_3_case:
li $v0, 4
la $a0, S_1
syscall
mul $t0 $s2 $s1
li $v0, 1
move $a0, $t0
syscall
move $v0, $t0
jr $ra
nop
operation_L_4_case:
sne $t0 $s1 $0
beq $t0, $0, operation_L_5_else_begin
nop
li $v0, 4
la $a0, S_1
syscall
div $t0 $s2 $s1
li $v0, 1
move $a0, $t0
syscall
move $v0, $t0
jr $ra
nop
operation_L_5_else_begin:
li $v0, 4
la $a0, S_2
syscall
li $v0, 0
jr $ra
nop
operation_L_6_else_over:
j operation_L_0_switch_over
nop
operation_L_7_default:
li $v0, 4
la $a0, S_3
syscall
li $v0, -1
jr $ra
nop
operation_L_0_switch_over:
li $v0, 0
jr $ra
nop
display_E:
lw $s2, -4($fp)
sle $t0 $s2 $0
beq $t0, $0, display_L_0_else_begin
nop
jr $ra
nop
display_L_0_else_begin:
li $s0, 26
sgt $t0 $s2 $s0
beq $t0, $0, display_L_2_else_begin
nop
li $s2, 26
j display_L_3_else_over
nop
display_L_2_else_begin:
li $s0, 0
li $s1, 97
display_L_4_while_begin:
slt $t0 $s0 $s2
beq $t0, $0, display_L_5_while_over
nop
sw $s1, 12($fp)
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $t0, 16($sp)
addi $fp, $fp, 16
jal upcase_E
nop
addi $fp, $fp, -16
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $t0, 16($sp)
addi $sp, $sp, 20
move $t0, $v0
add $v0, $s0, $gp
addi $v0, $v0, 33
sb $t0, ($v0)
sw $s1, 12($fp)
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $t0, 16($sp)
addi $fp, $fp, 16
jal upcase_E
nop
addi $fp, $fp, -16
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $t0, 16($sp)
addi $sp, $sp, 20
move $t0, $v0
add $v0, $s0, $gp
addi $v0, $v0, 33
sb $t0, ($v0)
add $v0, $s0, $gp
addi $v0, $v0, 33
lb $t0, ($v0)
li $v0, 11
move $a0, $t0
syscall
addi $s0 $s0 1
addi $s1 $s1 1
j display_L_4_while_begin
nop
display_L_5_while_over:
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s2, 8($sp)
addi $fp, $fp, 12
jal printspace_E
nop
addi $fp, $fp, -12
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s2, 8($sp)
addi $sp, $sp, 12
li $s0, 0
display_L_6_while_begin:
slt $t0 $s0 $s2
beq $t0, $0, display_L_7_while_over
nop
add $v0, $s0, $gp
addi $v0, $v0, 33
lb $t0, ($v0)
sw $t0, 12($fp)
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s2, 8($sp)
sw $t0, 12($sp)
addi $fp, $fp, 16
jal lowcase_E
nop
addi $fp, $fp, -16
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s2, 8($sp)
lw $t0, 12($sp)
addi $sp, $sp, 16
move $t0, $v0
add $v0, $s0, $gp
addi $v0, $v0, 33
sb $t0, ($v0)
add $v0, $s0, $gp
addi $v0, $v0, 33
lb $t0, ($v0)
li $v0, 11
move $a0, $t0
syscall
addi $s0 $s0 1
j display_L_6_while_begin
nop
display_L_7_while_over:
addi $sp, $sp, -4
sw $ra, 0($sp)
addi $fp, $fp, 12
jal printspace_E
nop
addi $fp, $fp, -12
lw $ra, 0($sp)
addi $sp, $sp, 4
display_L_3_else_over:
display_L_1_else_over:
jr $ra
nop
expre_E:
li $v0, 5
syscall
move $s0, $v0
li $v0, 5
syscall
move $s1, $v0
li $v0, 4
la $a0, S_4
syscall
add $t0 $s0 $s1
mul $t1 $s1 -2
sub $t2 $0 $t1
sub $t1 $t0 $t2
li $v0, 1
move $a0, $t1
syscall
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $t0, 4($sp)
sw $t1, 8($sp)
sw $t2, 12($sp)
sw $s0, 0($fp) # store x
sw $s1, 4($fp) # store y
addi $fp, $fp, 12
jal printspace_E
nop
addi $fp, $fp, -12
lw $ra, 0($sp)
lw $t0, 4($sp)
lw $t1, 8($sp)
lw $t2, 12($sp)
addi $sp, $sp, 16
jr $ra
nop
mod_E:
lw $s1, -4($fp)
lw $s0, -8($fp)
div $t0 $s1 $s0
mul $t1 $t0 $s0
sub $s2 $s1 $t1
move $v0, $s2
jr $ra
nop
gcd_E:
lw $s0, -4($fp)
lw $s1, -8($fp)
seq $t0 $s1 $0
beq $t0, $0, gcd_L_0_else_begin
nop
li $v0, 0
jr $ra
nop
gcd_L_0_else_begin:
sw $s1, 8($fp)
sw $s0, 12($fp)
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
addi $fp, $fp, 16
jal mod_E
nop
addi $fp, $fp, -16
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
addi $sp, $sp, 12
move $t0, $v0
seq $t1 $t0 $0
beq $t1, $0, gcd_L_2_else_begin
nop
move $v0, $s1
jr $ra
nop
gcd_L_2_else_begin:
sw $s1, 8($fp)
sw $s0, 12($fp)
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
addi $fp, $fp, 16
jal mod_E
nop
addi $fp, $fp, -16
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
addi $sp, $sp, 12
move $t0, $v0
sw $t0, 8($fp)
sw $s1, 12($fp)
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $t0, 12($sp)
addi $fp, $fp, 16
jal gcd_E
nop
addi $fp, $fp, -16
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $t0, 12($sp)
addi $sp, $sp, 16
move $t0, $v0
move $v0, $t0
jr $ra
nop
gcd_L_3_else_over:
gcd_L_1_else_over:
li $v0, 0
jr $ra
nop
optimize_E:
li $s3, 0
li $s1, 1
li $s4, 1
optimize_L_0_while_begin:
li $t0, 10000
slt $t0 $s3 $t0
beq $t0, $0, optimize_L_1_while_over
nop
addi $s3 $s3 1
sub $s0 $0 $s1
mul $s6 $s4 $s0
sub $s2 $0 $s1
mul $s1 $s4 $s2
add $s5 $s6 $s1
move $s7, $s5
j optimize_L_0_while_begin
nop
optimize_L_1_while_over:
li $v0, 1
move $a0, $s7
syscall
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)
addi $fp, $fp, 32
jal printspace_E
nop
addi $fp, $fp, -32
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
addi $sp, $sp, 32
li $v0, 1
move $a0, $s4
syscall
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)
addi $fp, $fp, 32
jal printspace_E
nop
addi $fp, $fp, -32
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
addi $sp, $sp, 32
li $v0, 1
move $a0, $s1
syscall
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)
addi $fp, $fp, 32
jal printspace_E
nop
addi $fp, $fp, -32
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
addi $sp, $sp, 32
li $v0, 1
move $a0, $s0
syscall
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)
addi $fp, $fp, 32
jal printspace_E
nop
addi $fp, $fp, -32
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
addi $sp, $sp, 32
li $v0, 1
move $a0, $s6
syscall
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)
addi $fp, $fp, 32
jal printspace_E
nop
addi $fp, $fp, -32
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
addi $sp, $sp, 32
li $v0, 1
move $a0, $s2
syscall
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $s2, 12($sp)
sw $s4, 16($sp)
sw $s5, 20($sp)
sw $s6, 24($sp)
sw $s7, 28($sp)
addi $fp, $fp, 32
jal printspace_E
nop
addi $fp, $fp, -32
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $s2, 12($sp)
lw $s4, 16($sp)
lw $s5, 20($sp)
lw $s6, 24($sp)
lw $s7, 28($sp)
addi $sp, $sp, 32
li $v0, 1
move $a0, $s5
syscall
jr $ra
nop
process_E:
li $v0, 5
syscall
move $s3, $v0
addi $t0 $s3 97
addi $s0 $t0 -1
sw $s3, 0($fp) # store choice
beq $s0, 97, process_L_1_case
nop
sw $s3, 0($fp) # store choice
beq $s0, 98, process_L_2_case
nop
sw $s3, 0($fp) # store choice
beq $s0, 99, process_L_3_case
nop
sw $s3, 0($fp) # store choice
beq $s0, 100, process_L_4_case
nop
sw $s3, 0($fp) # store choice
beq $s0, 101, process_L_5_case
nop
sw $s3, 0($fp) # store choice
beq $s0, 102, process_L_6_case
nop
sw $s3, 0($fp) # store choice
j process_L_7_default
nop
sw $s3, 0($fp) # store choice
process_L_1_case:
addi $sp, $sp, -4
sw $ra, 0($sp)
addi $fp, $fp, 8
jal expre_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
addi $sp, $sp, 4
j process_L_0_switch_over
nop
process_L_2_case:
li $v0, 5
syscall
move $s0, $v0
sw $s0, 8($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
sw $s0, 0($gp) # store n
addi $fp, $fp, 12
jal fibo_E
nop
addi $fp, $fp, -12
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
li $v0, 4
la $a0, S_5
syscall
li $v0, 1
move $a0, $t0
syscall
move $s1, $t0
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $t0, 4($sp)
sw $s0, 0($gp) # store n
sw $s1, 20($gp) # store ans
addi $fp, $fp, 8
jal printspace_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $t0, 4($sp)
addi $sp, $sp, 8
sw $s0, 0($gp) # store n
sw $s1, 20($gp) # store ans
j process_L_0_switch_over
nop
sw $s0, 0($gp) # store n
sw $s1, 20($gp) # store ans
process_L_3_case:
li $v0, 5
syscall
move $s0, $v0
li $v0, 5
syscall
move $s1, $v0
li $v0, 5
syscall
move $s2, $v0
sw $s2, 8($fp)
sw $s1, 12($fp)
sw $s0, 16($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
sw $s0, 4($gp) # store x
sw $s1, 8($gp) # store y
sw $s2, 12($gp) # store kind
addi $fp, $fp, 20
jal operation_E
nop
addi $fp, $fp, -20
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
move $s3, $t0
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $t0, 4($sp)
sw $s0, 4($gp) # store x
sw $s1, 8($gp) # store y
sw $s2, 12($gp) # store kind
sw $s3, 20($gp) # store ans
addi $fp, $fp, 8
jal printspace_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $t0, 4($sp)
addi $sp, $sp, 8
sw $s0, 4($gp) # store x
sw $s1, 8($gp) # store y
sw $s2, 12($gp) # store kind
sw $s3, 20($gp) # store ans
j process_L_0_switch_over
nop
sw $s0, 4($gp) # store x
sw $s1, 8($gp) # store y
sw $s2, 12($gp) # store kind
sw $s3, 20($gp) # store ans
process_L_4_case:
li $v0, 5
syscall
move $s0, $v0
sw $s0, 8($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
sw $s0, 16($gp) # store m
addi $fp, $fp, 12
jal display_E
nop
addi $fp, $fp, -12
lw $ra, 0($sp)
addi $sp, $sp, 4
sw $s0, 16($gp) # store m
j process_L_0_switch_over
nop
sw $s0, 16($gp) # store m
process_L_5_case:
li $v0, 5
syscall
move $s0, $v0
li $v0, 5
syscall
move $s1, $v0
li $v0, 4
la $a0, S_6
syscall
sw $s1, 8($fp)
sw $s0, 12($fp)
addi $sp, $sp, -4
sw $ra, 0($sp)
sw $s0, 24($gp) # store _a
sw $s1, 28($gp) # store _b
addi $fp, $fp, 16
jal gcd_E
nop
addi $fp, $fp, -16
lw $ra, 0($sp)
addi $sp, $sp, 4
move $t0, $v0
li $v0, 1
move $a0, $t0
syscall
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $t0, 4($sp)
sw $s0, 24($gp) # store _a
sw $s1, 28($gp) # store _b
addi $fp, $fp, 8
jal printspace_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $t0, 4($sp)
addi $sp, $sp, 8
sw $s0, 24($gp) # store _a
sw $s1, 28($gp) # store _b
j process_L_0_switch_over
nop
sw $s0, 24($gp) # store _a
sw $s1, 28($gp) # store _b
process_L_6_case:
li $v0, 4
la $a0, S_7
syscall
j process_L_0_switch_over
nop
process_L_7_default:
addi $sp, $sp, -4
sw $ra, 0($sp)
addi $fp, $fp, 8
jal optimize_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
addi $sp, $sp, 4
j process_L_0_switch_over
nop
process_L_0_switch_over:
jr $ra
nop
main_E:
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
addi $fp, $fp, 8
jal testdefine_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
addi $sp, $sp, 12
li $s0, 0
li $v0, 5
syscall
move $s1, $v0
main_L_0_while_begin:
slt $t0 $s0 $s1
beq $t0, $0, main_L_1_while_over
nop
addi $s0 $s0 1
addi $sp, $sp, -16
sw $ra, 0($sp)
sw $s0, 4($sp)
sw $s1, 8($sp)
sw $t0, 12($sp)
addi $fp, $fp, 8
jal process_E
nop
addi $fp, $fp, -8
lw $ra, 0($sp)
lw $s0, 4($sp)
lw $s1, 8($sp)
lw $t0, 12($sp)
addi $sp, $sp, 16
j main_L_0_while_begin
nop
main_L_1_while_over:
jr $ra
nop
