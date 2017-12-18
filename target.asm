.data
S_0: .asciiz " "
S_1: .asciiz "="
S_2: .asciiz "ERROR:Divided by ZERO. "
S_3: .asciiz "Undefined operation:"
S_4: .asciiz "Please select one from set {+,-,*,/}. "
S_5: .asciiz "Please input a smaller one:"
S_6: .asciiz "True"
S_7: .asciiz "False"
S_8: .asciiz "Wrong number:"
S_9: .asciiz "    "
.space 4
over_S:
.text
la $gp, over_S
andi $gp, $gp, 0xFFFFFFFC
   # @array int[] list 10
   # @var char op
   # @call main
addi $fp, $fp, 44
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
   # @exit
   # @func fact
fact_E:
   # @para int n
lw $s0, 0($fp)
lw $s0, -4($fp)
   # #0 = n
lw $s1, 4($fp)
move $s1, $s0
   # #1 = #0
lw $s2, 8($fp)
move $s2, $s1
   # #1 = #1 EQ 0
li $t0, 0
seq $s2, $s2, $t0
   # @bz #1 fact_L_0_else_begin
sw $s0, 0($fp)
sw $s1, 4($fp)
sw $s2, 8($fp)
lw $s3, 8($fp)
beq $s3, $0, fact_L_0_else_begin
nop
   # @ret 1
sw $s3, 8($fp)
li $v0, 1
jr $ra
nop
   # @j fact_L_1_else_over
j fact_L_1_else_over
nop
   # fact_L_0_else_begin :
fact_L_0_else_begin:
   # #2 = n
lw $s4, 0($fp)
lw $s5, 12($fp)
move $s5, $s4
   # #3 = n
lw $s6, 16($fp)
move $s6, $s4
   # #4 = #3
lw $s7, 20($fp)
move $s7, $s6
   # #4 = #4 SUB 1
addi $s7, $s7, -1
   # @push #4
   # @call fact
sw $s7, 24($fp)
sw $s4, 0($fp)
sw $s5, 12($fp)
sw $s6, 16($fp)
sw $s7, 20($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 28
jal fact_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #5
lw $s0, 24($fp)
move $s0, $v0
   # #2 = #2 MUL #5
lw $s1, 12($fp)
mul $s1, $s1, $s0
   # #6 = #2
lw $s2, 28($fp)
move $s2, $s1
   # @ret #6
sw $s0, 24($fp)
sw $s1, 12($fp)
sw $s2, 28($fp)
lw $s3, 28($fp)
move $v0, $s3
jr $ra
nop
   # fact_L_1_else_over :
sw $s3, 28($fp)
fact_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func isletter
isletter_E:
   # @para char c1
lb $s4, 0($fp)
lw $s4, -4($fp)
   # #0 = c1
lw $s5, 4($fp)
move $s5, $s4
   # #1 = #0
lw $s6, 8($fp)
move $s6, $s5
   # #1 = #1 EQ 95
li $t0, 95
seq $s6, $s6, $t0
   # @bz #1 isletter_L_0_else_begin
sb $s4, 0($fp)
sw $s5, 4($fp)
sw $s6, 8($fp)
lw $s7, 8($fp)
beq $s7, $0, isletter_L_0_else_begin
nop
   # @ret 1
sw $s7, 8($fp)
li $v0, 1
jr $ra
nop
   # @j isletter_L_1_else_over
j isletter_L_1_else_over
nop
   # isletter_L_0_else_begin :
isletter_L_0_else_begin:
   # #2 = c1
lb $s0, 0($fp)
lw $s1, 12($fp)
move $s1, $s0
   # #3 = #2
lw $s2, 16($fp)
move $s2, $s1
   # #3 = #3 GE 97
li $t0, 97
sge $s2, $s2, $t0
   # @bz #3 isletter_L_2_else_begin
sb $s0, 0($fp)
sw $s1, 12($fp)
sw $s2, 16($fp)
lw $s3, 16($fp)
beq $s3, $0, isletter_L_2_else_begin
nop
   # #4 = c1
lb $s4, 0($fp)
lw $s5, 20($fp)
move $s5, $s4
   # #5 = #4
lw $s6, 24($fp)
move $s6, $s5
   # #5 = #5 LE 122
li $t0, 122
sle $s6, $s6, $t0
   # @bz #5 isletter_L_4_else_begin
sw $s3, 16($fp)
sb $s4, 0($fp)
sw $s5, 20($fp)
sw $s6, 24($fp)
lw $s7, 24($fp)
beq $s7, $0, isletter_L_4_else_begin
nop
   # @ret 1
sw $s7, 24($fp)
li $v0, 1
jr $ra
nop
   # @j isletter_L_5_else_over
j isletter_L_5_else_over
nop
   # isletter_L_4_else_begin :
isletter_L_4_else_begin:
   # @ret 0
li $v0, 0
jr $ra
nop
   # isletter_L_5_else_over :
isletter_L_5_else_over:
   # @j isletter_L_3_else_over
j isletter_L_3_else_over
nop
   # isletter_L_2_else_begin :
isletter_L_2_else_begin:
   # #4 = c1
lb $s0, 0($fp)
lw $s1, 20($fp)
move $s1, $s0
   # #5 = #4
lw $s2, 24($fp)
move $s2, $s1
   # #5 = #5 GE 65
li $t0, 65
sge $s2, $s2, $t0
   # @bz #5 isletter_L_6_else_begin
sb $s0, 0($fp)
sw $s1, 20($fp)
sw $s2, 24($fp)
lw $s3, 24($fp)
beq $s3, $0, isletter_L_6_else_begin
nop
   # #6 = c1
lb $s4, 0($fp)
lw $s5, 28($fp)
move $s5, $s4
   # #7 = #6
lw $s6, 32($fp)
move $s6, $s5
   # #7 = #7 LE 90
li $t0, 90
sle $s6, $s6, $t0
   # @bz #7 isletter_L_8_else_begin
sw $s3, 24($fp)
sb $s4, 0($fp)
sw $s5, 28($fp)
sw $s6, 32($fp)
lw $s7, 32($fp)
beq $s7, $0, isletter_L_8_else_begin
nop
   # @ret 1
sw $s7, 32($fp)
li $v0, 1
jr $ra
nop
   # @j isletter_L_9_else_over
j isletter_L_9_else_over
nop
   # isletter_L_8_else_begin :
isletter_L_8_else_begin:
   # isletter_L_9_else_over :
isletter_L_9_else_over:
   # @j isletter_L_7_else_over
j isletter_L_7_else_over
nop
   # isletter_L_6_else_begin :
isletter_L_6_else_begin:
   # isletter_L_7_else_over :
isletter_L_7_else_over:
   # isletter_L_3_else_over :
isletter_L_3_else_over:
   # isletter_L_1_else_over :
isletter_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func choose_pivot
choose_pivot_E:
   # @para int i
lw $s0, 0($fp)
lw $s0, -4($fp)
   # @para int j
lw $s1, 4($fp)
lw $s1, -8($fp)
   # #0 = i
lw $s2, 8($fp)
move $s2, $s0
   # #1 = #0
lw $s3, 12($fp)
move $s3, $s2
   # #2 = j
lw $s4, 16($fp)
move $s4, $s1
   # #1 = #1 ADD #2
add $s3, $s3, $s4
   # #3 = #1
lw $s5, 20($fp)
move $s5, $s3
   # #3 = #3 DIV 2
div $s5, $s5, 2
   # #4 = #3
lw $s6, 24($fp)
move $s6, $s5
   # @ret #4
sw $s0, 0($fp)
sw $s1, 4($fp)
sw $s2, 8($fp)
sw $s3, 12($fp)
sw $s4, 16($fp)
sw $s5, 20($fp)
sw $s6, 24($fp)
lw $s7, 24($fp)
move $v0, $s7
jr $ra
nop
   # @ret 0
sw $s7, 24($fp)
li $v0, 0
jr $ra
nop
   # @func printlist
printlist_E:
   # @para int n
lw $s0, 0($fp)
lw $s0, -4($fp)
   # @var int i
   # i = 0
lw $s1, 4($fp)
li $s1, 0
   # printlist_L_0_while_begin :
sw $s0, 0($fp)
sw $s1, 4($fp)
printlist_L_0_while_begin:
   # #0 = i
lw $s2, 4($fp)
lw $s3, 8($fp)
move $s3, $s2
   # #1 = #0
lw $s4, 12($fp)
move $s4, $s3
   # #2 = n
lw $s5, 0($fp)
lw $s6, 16($fp)
move $s6, $s5
   # #3 = #2
lw $s7, 20($fp)
move $s7, $s6
   # #1 = #1 LT #3
slt $s4, $s4, $s7
   # @bz #1 printlist_L_1_while_over
sw $s2, 4($fp)
sw $s3, 8($fp)
sw $s4, 12($fp)
sw $s5, 0($fp)
sw $s6, 16($fp)
sw $s7, 20($fp)
lw $s0, 12($fp)
beq $s0, $0, printlist_L_1_while_over
nop
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # #4 = i
lw $s1, 4($fp)
lw $s2, 24($fp)
move $s2, $s1
   # #5 = #4
lw $s3, 28($fp)
move $s3, $s2
   # #6 = list ARGET #5
lw $s4, 32($fp)
sll $t1, $s3, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
lw $s4, ($t1)
   # #7 = #6
lw $s5, 36($fp)
move $s5, $s4
   # #8 = #7
lw $s6, 40($fp)
move $s6, $s5
   # @printf int #8
li $v0, 1
move $a0, $s6
syscall
   # #4 = i
move $s2, $s1
   # #5 = #4
move $s3, $s2
   # #5 = #5 ADD 1
addi $s3, $s3, 1
   # i = #5
move $s1, $s3
   # @j printlist_L_0_while_begin
sw $s0, 12($fp)
sw $s1, 4($fp)
sw $s2, 24($fp)
sw $s3, 28($fp)
sw $s4, 32($fp)
sw $s5, 36($fp)
sw $s6, 40($fp)
j printlist_L_0_while_begin
nop
   # printlist_L_1_while_over :
printlist_L_1_while_over:
   # @ret
jr $ra
nop
   # @func quicksort
quicksort_E:
   # @para int m
lw $s7, 0($fp)
lw $s7, -4($fp)
   # @para int n
lw $s0, 4($fp)
lw $s0, -8($fp)
   # @var int key
   # @var int x
   # @var int y
   # @var int z
   # @var int tmp
   # #0 = m
lw $s1, 28($fp)
move $s1, $s7
   # #1 = #0
lw $s2, 32($fp)
move $s2, $s1
   # @push #1
   # #2 = n
lw $s3, 36($fp)
move $s3, $s0
   # #3 = #2
lw $s4, 40($fp)
move $s4, $s3
   # @push #3
   # @call choose_pivot
sw $s4, 44($fp)
sw $s2, 48($fp)
sw $s0, 4($fp)
sw $s1, 28($fp)
sw $s2, 32($fp)
sw $s3, 36($fp)
sw $s4, 40($fp)
sw $s7, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal choose_pivot_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #4
lw $s5, 44($fp)
move $s5, $v0
   # #5 = #4
lw $s6, 48($fp)
move $s6, $s5
   # #6 = #5
lw $s7, 52($fp)
move $s7, $s6
   # #7 = list ARGET #6
lw $s0, 56($fp)
sll $t1, $s7, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
lw $s0, ($t1)
   # #8 = #7
lw $s1, 60($fp)
move $s1, $s0
   # #9 = #8
lw $s2, 64($fp)
move $s2, $s1
   # key = #9
lw $s3, 8($fp)
move $s3, $s2
   # #0 = m
lw $s4, 0($fp)
sw $s5, 44($fp)
lw $s5, 28($fp)
move $s5, $s4
   # #1 = #0
sw $s6, 48($fp)
lw $s6, 32($fp)
move $s6, $s5
   # x = #1
sw $s7, 52($fp)
lw $s7, 12($fp)
move $s7, $s6
   # #0 = n
sw $s0, 56($fp)
lw $s0, 4($fp)
move $s5, $s0
   # #1 = #0
move $s6, $s5
   # y = #1
sw $s1, 60($fp)
lw $s1, 16($fp)
move $s1, $s6
   # quicksort_L_0_while_begin :
sw $s0, 4($fp)
sw $s1, 16($fp)
sw $s2, 64($fp)
sw $s3, 8($fp)
sw $s4, 0($fp)
sw $s5, 28($fp)
sw $s6, 32($fp)
sw $s7, 12($fp)
quicksort_L_0_while_begin:
   # #0 = x
lw $s2, 12($fp)
lw $s3, 28($fp)
move $s3, $s2
   # #1 = #0
lw $s4, 32($fp)
move $s4, $s3
   # #2 = y
lw $s5, 16($fp)
lw $s6, 36($fp)
move $s6, $s5
   # #3 = #2
lw $s7, 40($fp)
move $s7, $s6
   # #1 = #1 LE #3
sle $s4, $s4, $s7
   # @bz #1 quicksort_L_1_while_over
sw $s2, 12($fp)
sw $s3, 28($fp)
sw $s4, 32($fp)
sw $s5, 16($fp)
sw $s6, 36($fp)
sw $s7, 40($fp)
lw $s0, 32($fp)
beq $s0, $0, quicksort_L_1_while_over
nop
   # quicksort_L_2_while_begin :
sw $s0, 32($fp)
quicksort_L_2_while_begin:
   # #4 = key
lw $s1, 8($fp)
lw $s2, 44($fp)
move $s2, $s1
   # #5 = #4
lw $s3, 48($fp)
move $s3, $s2
   # #6 = y
lw $s4, 16($fp)
lw $s5, 52($fp)
move $s5, $s4
   # #7 = #6
lw $s6, 56($fp)
move $s6, $s5
   # #8 = list ARGET #7
lw $s7, 60($fp)
sll $t1, $s6, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
lw $s7, ($t1)
   # #9 = #8
lw $s0, 64($fp)
move $s0, $s7
   # #10 = #9
sw $s1, 8($fp)
lw $s1, 68($fp)
move $s1, $s0
   # #5 = #5 LT #10
slt $s3, $s3, $s1
   # @bz #5 quicksort_L_3_while_over
sw $s0, 64($fp)
sw $s1, 68($fp)
sw $s2, 44($fp)
sw $s3, 48($fp)
sw $s4, 16($fp)
sw $s5, 52($fp)
sw $s6, 56($fp)
sw $s7, 60($fp)
lw $s2, 48($fp)
beq $s2, $0, quicksort_L_3_while_over
nop
   # #11 = y
lw $s3, 16($fp)
lw $s4, 72($fp)
move $s4, $s3
   # #12 = #11
lw $s5, 76($fp)
move $s5, $s4
   # #12 = #12 SUB 1
addi $s5, $s5, -1
   # y = #12
move $s3, $s5
   # @j quicksort_L_2_while_begin
sw $s2, 48($fp)
sw $s3, 16($fp)
sw $s4, 72($fp)
sw $s5, 76($fp)
j quicksort_L_2_while_begin
nop
   # quicksort_L_3_while_over :
quicksort_L_3_while_over:
   # quicksort_L_4_while_begin :
quicksort_L_4_while_begin:
   # #4 = key
lw $s6, 8($fp)
lw $s7, 44($fp)
move $s7, $s6
   # #5 = #4
lw $s0, 48($fp)
move $s0, $s7
   # #6 = x
lw $s1, 12($fp)
lw $s2, 52($fp)
move $s2, $s1
   # #7 = #6
lw $s3, 56($fp)
move $s3, $s2
   # #8 = list ARGET #7
lw $s4, 60($fp)
sll $t1, $s3, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
lw $s4, ($t1)
   # #9 = #8
lw $s5, 64($fp)
move $s5, $s4
   # #10 = #9
sw $s6, 8($fp)
lw $s6, 68($fp)
move $s6, $s5
   # #5 = #5 GT #10
sgt $s0, $s0, $s6
   # @bz #5 quicksort_L_5_while_over
sw $s0, 48($fp)
sw $s1, 12($fp)
sw $s2, 52($fp)
sw $s3, 56($fp)
sw $s4, 60($fp)
sw $s5, 64($fp)
sw $s6, 68($fp)
sw $s7, 44($fp)
lw $s7, 48($fp)
beq $s7, $0, quicksort_L_5_while_over
nop
   # #11 = x
lw $s0, 12($fp)
lw $s1, 72($fp)
move $s1, $s0
   # #12 = #11
lw $s2, 76($fp)
move $s2, $s1
   # #12 = #12 ADD 1
addi $s2, $s2, 1
   # x = #12
move $s0, $s2
   # @j quicksort_L_4_while_begin
sw $s0, 12($fp)
sw $s1, 72($fp)
sw $s2, 76($fp)
sw $s7, 48($fp)
j quicksort_L_4_while_begin
nop
   # quicksort_L_5_while_over :
quicksort_L_5_while_over:
   # #4 = x
lw $s3, 12($fp)
lw $s4, 44($fp)
move $s4, $s3
   # #5 = #4
lw $s5, 48($fp)
move $s5, $s4
   # #6 = y
lw $s6, 16($fp)
lw $s7, 52($fp)
move $s7, $s6
   # #7 = #6
lw $s0, 56($fp)
move $s0, $s7
   # #5 = #5 LE #7
sle $s5, $s5, $s0
   # @bz #5 quicksort_L_6_else_begin
sw $s0, 56($fp)
sw $s3, 12($fp)
sw $s4, 44($fp)
sw $s5, 48($fp)
sw $s6, 16($fp)
sw $s7, 52($fp)
lw $s1, 48($fp)
beq $s1, $0, quicksort_L_6_else_begin
nop
   # #8 = x
lw $s2, 12($fp)
lw $s3, 60($fp)
move $s3, $s2
   # #9 = #8
lw $s4, 64($fp)
move $s4, $s3
   # #10 = list ARGET #9
lw $s5, 68($fp)
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
lw $s5, ($t1)
   # #11 = #10
lw $s6, 72($fp)
move $s6, $s5
   # #12 = #11
lw $s7, 76($fp)
move $s7, $s6
   # tmp = #12
lw $s0, 24($fp)
move $s0, $s7
   # #8 = x
move $s3, $s2
   # #9 = #8
move $s4, $s3
   # #10 = y
sw $s1, 48($fp)
lw $s1, 16($fp)
move $s5, $s1
   # #11 = #10
move $s6, $s5
   # #12 = list ARGET #11
sll $t1, $s6, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
lw $s7, ($t1)
   # #13 = #12
sw $s2, 12($fp)
lw $s2, 80($fp)
move $s2, $s7
   # #14 = #13
sw $s3, 60($fp)
lw $s3, 84($fp)
move $s3, $s2
   # list = #9 ARSET #14
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $s3, ($t1)
   # #8 = y
sw $s4, 64($fp)
lw $s4, 60($fp)
move $s4, $s1
   # #9 = #8
sw $s5, 68($fp)
lw $s5, 64($fp)
move $s5, $s4
   # #10 = tmp
sw $s6, 72($fp)
lw $s6, 68($fp)
move $s6, $s0
   # #11 = #10
sw $s7, 76($fp)
lw $s7, 72($fp)
move $s7, $s6
   # list = #9 ARSET #11
sll $t1, $s5, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $s7, ($t1)
   # #8 = x
sw $s0, 24($fp)
lw $s0, 12($fp)
move $s4, $s0
   # #9 = #8
move $s5, $s4
   # #9 = #9 ADD 1
addi $s5, $s5, 1
   # x = #9
move $s0, $s5
   # #8 = y
move $s4, $s1
   # #9 = #8
move $s5, $s4
   # #9 = #9 SUB 1
addi $s5, $s5, -1
   # y = #9
move $s1, $s5
   # @j quicksort_L_7_else_over
sw $s0, 12($fp)
sw $s1, 16($fp)
sw $s2, 80($fp)
sw $s3, 84($fp)
sw $s4, 60($fp)
sw $s5, 64($fp)
sw $s6, 68($fp)
sw $s7, 72($fp)
j quicksort_L_7_else_over
nop
   # quicksort_L_6_else_begin :
quicksort_L_6_else_begin:
   # quicksort_L_7_else_over :
quicksort_L_7_else_over:
   # @j quicksort_L_0_while_begin
j quicksort_L_0_while_begin
nop
   # quicksort_L_1_while_over :
quicksort_L_1_while_over:
   # #0 = x
lw $s1, 12($fp)
lw $s2, 28($fp)
move $s2, $s1
   # #1 = #0
lw $s3, 32($fp)
move $s3, $s2
   # #2 = n
lw $s4, 4($fp)
lw $s5, 36($fp)
move $s5, $s4
   # #3 = #2
lw $s6, 40($fp)
move $s6, $s5
   # #1 = #1 LT #3
slt $s3, $s3, $s6
   # @bz #1 quicksort_L_8_else_begin
sw $s1, 12($fp)
sw $s2, 28($fp)
sw $s3, 32($fp)
sw $s4, 4($fp)
sw $s5, 36($fp)
sw $s6, 40($fp)
lw $s7, 32($fp)
beq $s7, $0, quicksort_L_8_else_begin
nop
   # #4 = x
lw $s0, 12($fp)
lw $s1, 44($fp)
move $s1, $s0
   # #5 = #4
lw $s2, 48($fp)
move $s2, $s1
   # @push #5
   # #6 = n
lw $s3, 4($fp)
lw $s4, 52($fp)
move $s4, $s3
   # #7 = #6
lw $s5, 56($fp)
move $s5, $s4
   # @push #7
   # @call quicksort
sw $s5, 88($fp)
sw $s2, 92($fp)
sw $s0, 12($fp)
sw $s1, 44($fp)
sw $s2, 48($fp)
sw $s3, 4($fp)
sw $s4, 52($fp)
sw $s5, 56($fp)
sw $s7, 32($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 96
jal quicksort_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j quicksort_L_9_else_over
j quicksort_L_9_else_over
nop
   # quicksort_L_8_else_begin :
quicksort_L_8_else_begin:
   # quicksort_L_9_else_over :
quicksort_L_9_else_over:
   # #0 = m
lw $s6, 0($fp)
lw $s7, 28($fp)
move $s7, $s6
   # #1 = #0
lw $s0, 32($fp)
move $s0, $s7
   # #2 = y
lw $s1, 16($fp)
lw $s2, 36($fp)
move $s2, $s1
   # #3 = #2
lw $s3, 40($fp)
move $s3, $s2
   # #1 = #1 LT #3
slt $s0, $s0, $s3
   # @bz #1 quicksort_L_10_else_begin
sw $s0, 32($fp)
sw $s1, 16($fp)
sw $s2, 36($fp)
sw $s3, 40($fp)
sw $s6, 0($fp)
sw $s7, 28($fp)
lw $s4, 32($fp)
beq $s4, $0, quicksort_L_10_else_begin
nop
   # #4 = m
lw $s5, 0($fp)
lw $s6, 44($fp)
move $s6, $s5
   # #5 = #4
lw $s7, 48($fp)
move $s7, $s6
   # @push #5
   # #6 = y
lw $s0, 16($fp)
lw $s1, 52($fp)
move $s1, $s0
   # #7 = #6
lw $s2, 56($fp)
move $s2, $s1
   # @push #7
   # @call quicksort
sw $s2, 88($fp)
sw $s7, 92($fp)
sw $s0, 16($fp)
sw $s1, 52($fp)
sw $s2, 56($fp)
sw $s4, 32($fp)
sw $s5, 0($fp)
sw $s6, 44($fp)
sw $s7, 48($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 96
jal quicksort_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j quicksort_L_11_else_over
j quicksort_L_11_else_over
nop
   # quicksort_L_10_else_begin :
quicksort_L_10_else_begin:
   # quicksort_L_11_else_over :
quicksort_L_11_else_over:
   # @ret
jr $ra
nop
   # @func exprcheck
exprcheck_E:
   # @var int a
   # @var int b
   # @var int res
   # @var int flag
   # @var char op
   # @scanf int a
li $v0, 5
syscall
lw $s3, 0($fp)
move $s3, $v0
   # @scanf char op
li $v0, 12
syscall
lb $s4, 16($fp)
move $s4, $v0
   # @scanf int b
li $v0, 5
syscall
lw $s5, 4($fp)
move $s5, $v0
   # #0 = a
lw $s6, 20($fp)
move $s6, $s3
   # #1 = #0
lw $s7, 24($fp)
move $s7, $s6
   # @printf int #1
li $v0, 1
move $a0, $s7
syscall
   # #0 = op
move $s6, $s4
   # #1 = #0
move $s7, $s6
   # @printf char #1
li $v0, 11
move $a0, $s7
syscall
   # #0 = b
move $s6, $s5
   # #1 = #0
move $s7, $s6
   # @printf int #1
li $v0, 1
move $a0, $s7
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # flag = 1
lw $s0, 12($fp)
li $s0, 1
   # #0 = op
move $s6, $s4
   # #1 = #0
move $s7, $s6
   # @j exprcheck_L_0_switch_branch
sw $s0, 12($fp)
sw $s3, 0($fp)
sb $s4, 16($fp)
sw $s5, 4($fp)
sw $s6, 20($fp)
sw $s7, 24($fp)
j exprcheck_L_0_switch_branch
nop
   # exprcheck_L_2_case :
exprcheck_L_2_case:
   # #2 = a
lw $s1, 0($fp)
lw $s2, 28($fp)
move $s2, $s1
   # #3 = #2
lw $s3, 32($fp)
move $s3, $s2
   # #4 = b
lw $s4, 4($fp)
lw $s5, 36($fp)
move $s5, $s4
   # #3 = #3 ADD #4
add $s3, $s3, $s5
   # res = #3
lw $s6, 8($fp)
move $s6, $s3
   # #2 = res
move $s2, $s6
   # #3 = #2
move $s3, $s2
   # @printf int #3
li $v0, 1
move $a0, $s3
syscall
   # flag = 0
lw $s7, 12($fp)
li $s7, 0
   # @j exprcheck_L_1_switch_over
sw $s1, 0($fp)
sw $s2, 28($fp)
sw $s3, 32($fp)
sw $s4, 4($fp)
sw $s5, 36($fp)
sw $s6, 8($fp)
sw $s7, 12($fp)
j exprcheck_L_1_switch_over
nop
   # exprcheck_L_3_case :
exprcheck_L_3_case:
   # #2 = a
lw $s0, 0($fp)
lw $s1, 28($fp)
move $s1, $s0
   # #3 = #2
lw $s2, 32($fp)
move $s2, $s1
   # #4 = b
lw $s3, 4($fp)
lw $s4, 36($fp)
move $s4, $s3
   # #3 = #3 SUB #4
sub $s2, $s2, $s4
   # res = #3
lw $s5, 8($fp)
move $s5, $s2
   # #2 = res
move $s1, $s5
   # #3 = #2
move $s2, $s1
   # @printf int #3
li $v0, 1
move $a0, $s2
syscall
   # flag = 0
lw $s6, 12($fp)
li $s6, 0
   # @j exprcheck_L_1_switch_over
sw $s0, 0($fp)
sw $s1, 28($fp)
sw $s2, 32($fp)
sw $s3, 4($fp)
sw $s4, 36($fp)
sw $s5, 8($fp)
sw $s6, 12($fp)
j exprcheck_L_1_switch_over
nop
   # exprcheck_L_4_case :
exprcheck_L_4_case:
   # #2 = a
lw $s7, 0($fp)
lw $s0, 28($fp)
move $s0, $s7
   # #2 = #2 MUL b
lw $s1, 4($fp)
mul $s0, $s0, $s1
   # #3 = #2
lw $s2, 32($fp)
move $s2, $s0
   # res = #3
lw $s3, 8($fp)
move $s3, $s2
   # #2 = res
move $s0, $s3
   # #3 = #2
move $s2, $s0
   # @printf int #3
li $v0, 1
move $a0, $s2
syscall
   # flag = 0
lw $s4, 12($fp)
li $s4, 0
   # @j exprcheck_L_1_switch_over
sw $s0, 28($fp)
sw $s1, 4($fp)
sw $s2, 32($fp)
sw $s3, 8($fp)
sw $s4, 12($fp)
sw $s7, 0($fp)
j exprcheck_L_1_switch_over
nop
   # exprcheck_L_5_case :
exprcheck_L_5_case:
   # flag = 0
lw $s5, 12($fp)
li $s5, 0
   # #2 = b
lw $s6, 4($fp)
lw $s7, 28($fp)
move $s7, $s6
   # #3 = #2
lw $s0, 32($fp)
move $s0, $s7
   # #3 = #3 EQ 0
li $t0, 0
seq $s0, $s0, $t0
   # @bz #3 exprcheck_L_6_else_begin
sw $s0, 32($fp)
sw $s5, 12($fp)
sw $s6, 4($fp)
sw $s7, 28($fp)
lw $s1, 32($fp)
beq $s1, $0, exprcheck_L_6_else_begin
nop
   # @printf string S_2
li $v0, 4
la $a0, S_2
syscall
   # @j exprcheck_L_7_else_over
sw $s1, 32($fp)
j exprcheck_L_7_else_over
nop
   # exprcheck_L_6_else_begin :
exprcheck_L_6_else_begin:
   # #4 = a
lw $s2, 0($fp)
lw $s3, 36($fp)
move $s3, $s2
   # #4 = #4 DIV b
lw $s4, 4($fp)
div $s3, $s3, $s4
   # #5 = #4
lw $s5, 40($fp)
move $s5, $s3
   # res = #5
lw $s6, 8($fp)
move $s6, $s5
   # #4 = res
move $s3, $s6
   # #5 = #4
move $s5, $s3
   # @printf int #5
li $v0, 1
move $a0, $s5
syscall
   # exprcheck_L_7_else_over :
sw $s2, 0($fp)
sw $s3, 36($fp)
sw $s4, 4($fp)
sw $s5, 40($fp)
sw $s6, 8($fp)
exprcheck_L_7_else_over:
   # @j exprcheck_L_1_switch_over
j exprcheck_L_1_switch_over
nop
   # exprcheck_L_0_switch_branch :
exprcheck_L_0_switch_branch:
   # @be #1 42 exprcheck_L_4_case
lw $s7, 24($fp)
beq $s7, 42, exprcheck_L_4_case
nop
   # @be #1 43 exprcheck_L_2_case
sw $s7, 24($fp)
lw $s0, 24($fp)
beq $s0, 43, exprcheck_L_2_case
nop
   # @be #1 45 exprcheck_L_3_case
sw $s0, 24($fp)
lw $s1, 24($fp)
beq $s1, 45, exprcheck_L_3_case
nop
   # @be #1 47 exprcheck_L_5_case
sw $s1, 24($fp)
lw $s2, 24($fp)
beq $s2, 47, exprcheck_L_5_case
nop
   # exprcheck_L_1_switch_over :
sw $s2, 24($fp)
exprcheck_L_1_switch_over:
   # #0 = flag
lw $s3, 12($fp)
lw $s4, 20($fp)
move $s4, $s3
   # #1 = #0
lw $s5, 24($fp)
move $s5, $s4
   # @bz #1 exprcheck_L_8_else_begin
sw $s3, 12($fp)
sw $s4, 20($fp)
sw $s5, 24($fp)
lw $s6, 24($fp)
beq $s6, $0, exprcheck_L_8_else_begin
nop
   # @printf string S_3
li $v0, 4
la $a0, S_3
syscall
   # #2 = op
lb $s7, 16($fp)
lw $s0, 28($fp)
move $s0, $s7
   # #3 = #2
lw $s1, 32($fp)
move $s1, $s0
   # @printf char #3
li $v0, 11
move $a0, $s1
syscall
   # @printf string S_4
li $v0, 4
la $a0, S_4
syscall
   # @j exprcheck_L_9_else_over
sw $s0, 28($fp)
sw $s1, 32($fp)
sw $s6, 24($fp)
sb $s7, 16($fp)
j exprcheck_L_9_else_over
nop
   # exprcheck_L_8_else_begin :
exprcheck_L_8_else_begin:
   # exprcheck_L_9_else_over :
exprcheck_L_9_else_over:
   # @ret
jr $ra
nop
   # @func arraychek
arraychek_E:
   # @var int i
   # i = 0
lw $s2, 0($fp)
li $s2, 0
   # arraychek_L_0_while_begin :
sw $s2, 0($fp)
arraychek_L_0_while_begin:
   # #0 = i
lw $s3, 0($fp)
lw $s4, 4($fp)
move $s4, $s3
   # #1 = #0
lw $s5, 8($fp)
move $s5, $s4
   # #1 = #1 LT 10
li $t0, 10
slt $s5, $s5, $t0
   # @bz #1 arraychek_L_1_while_over
sw $s3, 0($fp)
sw $s4, 4($fp)
sw $s5, 8($fp)
lw $s6, 8($fp)
beq $s6, $0, arraychek_L_1_while_over
nop
   # #2 = i
lw $s7, 0($fp)
lw $s0, 12($fp)
move $s0, $s7
   # #3 = #2
lw $s1, 16($fp)
move $s1, $s0
   # #4 = i
lw $s2, 20($fp)
move $s2, $s7
   # #5 = 10
lw $s3, 24($fp)
li $s3, 10
   # #5 = #5 SUB #4
sub $s3, $s3, $s2
   # list = #3 ARSET #5
sll $t1, $s1, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $s3, ($t1)
   # #2 = i
move $s0, $s7
   # #3 = #2
move $s1, $s0
   # #3 = #3 ADD 1
addi $s1, $s1, 1
   # i = #3
move $s7, $s1
   # @j arraychek_L_0_while_begin
sw $s0, 12($fp)
sw $s1, 16($fp)
sw $s2, 20($fp)
sw $s3, 24($fp)
sw $s6, 8($fp)
sw $s7, 0($fp)
j arraychek_L_0_while_begin
nop
   # arraychek_L_1_while_over :
arraychek_L_1_while_over:
   # #0 = 1
lw $s4, 4($fp)
li $s4, 1
   # list = #0 ARSET 16
li $t0, 16
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $t0, ($t1)
   # #0 = 2
li $s4, 2
   # list = #0 ARSET 3
li $t0, 3
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $t0, ($t1)
   # #0 = 3
li $s4, 3
   # list = #0 ARSET -8
li $t0, -8
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $t0, ($t1)
   # #0 = 4
li $s4, 4
   # list = #0 ARSET 40
li $t0, 40
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $t0, ($t1)
   # #0 = 5
li $s4, 5
   # list = #0 ARSET -1
li $t0, -1
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $t0, ($t1)
   # #0 = 6
li $s4, 6
   # list = #0 ARSET 2
li $t0, 2
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $t0, ($t1)
   # #0 = 7
li $s4, 7
   # list = #0 ARSET -10
li $t0, -10
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 0
sw $t0, ($t1)
   # i = 1
lw $s5, 0($fp)
li $s5, 1
   # @push 0
   # @push 1
   # @push 1
   # @call choose_pivot
li $t0, 1
sw $t0, 28($fp)
li $t0, 1
sw $t0, 32($fp)
sw $s4, 4($fp)
sw $s5, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 36
jal choose_pivot_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #0
lw $s6, 4($fp)
move $s6, $v0
   # #1 = #0
lw $s7, 8($fp)
move $s7, $s6
   # #2 = #1
lw $s0, 12($fp)
move $s0, $s7
   # #3 = i
lw $s1, 0($fp)
lw $s2, 16($fp)
move $s2, $s1
   # #2 = #2 SUB #3
sub $s0, $s0, $s2
   # @push #2
   # @call choose_pivot
sw $s0, 28($fp)
li $t0, 0
sw $t0, 32($fp)
sw $s0, 12($fp)
sw $s1, 0($fp)
sw $s2, 16($fp)
sw $s6, 4($fp)
sw $s7, 8($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 36
jal choose_pivot_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #4
lw $s3, 20($fp)
move $s3, $v0
   # #5 = #4
lw $s4, 24($fp)
move $s4, $s3
   # #6 = #5
lw $s5, 28($fp)
move $s5, $s4
   # @push #6
   # @push 9
   # @push 9
   # @call choose_pivot
li $t0, 9
sw $t0, 32($fp)
li $t0, 9
sw $t0, 36($fp)
sw $s3, 20($fp)
sw $s4, 24($fp)
sw $s5, 28($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 40
jal choose_pivot_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #7
lw $s6, 32($fp)
move $s6, $v0
   # #8 = #7
lw $s7, 36($fp)
move $s7, $s6
   # #9 = #8
lw $s0, 40($fp)
move $s0, $s7
   # @push #9
   # @call quicksort
sw $s0, 44($fp)
lw $s1, 28($fp)
sw $s1, 48($fp)
sw $s0, 40($fp)
sw $s1, 28($fp)
sw $s6, 32($fp)
sw $s7, 36($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal quicksort_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @push 10
   # @call printlist
li $t0, 10
sw $t0, 44($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 48
jal printlist_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @ret
jr $ra
nop
   # @func recurcheck
recurcheck_E:
   # @var int i
   # @scanf int i
li $v0, 5
syscall
lw $s2, 0($fp)
move $s2, $v0
   # recurcheck_L_0_while_begin :
sw $s2, 0($fp)
recurcheck_L_0_while_begin:
   # #0 = i
lw $s3, 0($fp)
lw $s4, 4($fp)
move $s4, $s3
   # #1 = #0
lw $s5, 8($fp)
move $s5, $s4
   # #1 = 13 LE #1
li $t0, 13
sle $s5, $t0, $s5
   # @bz #1 recurcheck_L_1_while_over
sw $s3, 0($fp)
sw $s4, 4($fp)
sw $s5, 8($fp)
lw $s6, 8($fp)
beq $s6, $0, recurcheck_L_1_while_over
nop
   # @printf string S_5
li $v0, 4
la $a0, S_5
syscall
   # @scanf int i
li $v0, 5
syscall
lw $s7, 0($fp)
move $s7, $v0
   # @j recurcheck_L_0_while_begin
sw $s6, 8($fp)
sw $s7, 0($fp)
j recurcheck_L_0_while_begin
nop
   # recurcheck_L_1_while_over :
recurcheck_L_1_while_over:
   # #0 = i
lw $s0, 0($fp)
lw $s1, 4($fp)
move $s1, $s0
   # #1 = #0
lw $s2, 8($fp)
move $s2, $s1
   # @push #1
   # @call fact
sw $s2, 12($fp)
sw $s0, 0($fp)
sw $s1, 4($fp)
sw $s2, 8($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal fact_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #2
lw $s3, 12($fp)
move $s3, $v0
   # #3 = #2
lw $s4, 16($fp)
move $s4, $s3
   # #4 = #3
lw $s5, 20($fp)
move $s5, $s4
   # @printf int #4
li $v0, 1
move $a0, $s5
syscall
   # @ret
sw $s3, 12($fp)
sw $s4, 16($fp)
sw $s5, 20($fp)
jr $ra
nop
   # @func lettercheck
lettercheck_E:
   # @var char x
   # @scanf char x
li $v0, 12
syscall
lb $s6, 0($fp)
move $s6, $v0
   # #0 = x
lw $s7, 4($fp)
move $s7, $s6
   # #1 = #0
lw $s0, 8($fp)
move $s0, $s7
   # @push #1
   # @call isletter
sw $s0, 12($fp)
sw $s0, 8($fp)
sb $s6, 0($fp)
sw $s7, 4($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal isletter_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #2
lw $s1, 12($fp)
move $s1, $v0
   # #3 = #2
lw $s2, 16($fp)
move $s2, $s1
   # #4 = #3
lw $s3, 20($fp)
move $s3, $s2
   # @bz #4 lettercheck_L_0_else_begin
sw $s1, 12($fp)
sw $s2, 16($fp)
sw $s3, 20($fp)
lw $s4, 20($fp)
beq $s4, $0, lettercheck_L_0_else_begin
nop
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # @j lettercheck_L_1_else_over
sw $s4, 20($fp)
j lettercheck_L_1_else_over
nop
   # lettercheck_L_0_else_begin :
lettercheck_L_0_else_begin:
   # @printf string S_7
li $v0, 4
la $a0, S_7
syscall
   # lettercheck_L_1_else_over :
lettercheck_L_1_else_over:
   # @ret
jr $ra
nop
   # @func main
main_E:
   # @var int choice
   # @scanf int choice
li $v0, 5
syscall
lw $s5, 0($fp)
move $s5, $v0
   # main_L_0_while_begin :
sw $s5, 0($fp)
main_L_0_while_begin:
   # #0 = choice
lw $s6, 0($fp)
lw $s7, 4($fp)
move $s7, $s6
   # #1 = #0
lw $s0, 8($fp)
move $s0, $s7
   # #1 = #1 NE 0
li $t0, 0
sne $s0, $s0, $t0
   # @bz #1 main_L_1_while_over
sw $s0, 8($fp)
sw $s6, 0($fp)
sw $s7, 4($fp)
lw $s1, 8($fp)
beq $s1, $0, main_L_1_while_over
nop
   # #2 = choice
lw $s2, 0($fp)
lw $s3, 12($fp)
move $s3, $s2
   # #3 = #2
lw $s4, 16($fp)
move $s4, $s3
   # #3 = #3 ADD 0
addi $s4, $s4, 0
   # #4 = #3
lw $s5, 20($fp)
move $s5, $s4
   # #4 = #4 MUL 4
mul $s5, $s5, 4
   # #4 = #4 DIV 4
div $s5, $s5, 4
   # #5 = #4
lw $s6, 24($fp)
move $s6, $s5
   # #5 = #5 ADD 19
addi $s6, $s6, 19
   # #5 = #5 SUB 19
addi $s6, $s6, -19
   # @j main_L_2_switch_branch
sw $s1, 8($fp)
sw $s2, 0($fp)
sw $s3, 12($fp)
sw $s4, 16($fp)
sw $s5, 20($fp)
sw $s6, 24($fp)
j main_L_2_switch_branch
nop
   # main_L_4_case :
main_L_4_case:
   # @call exprcheck
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 28
jal exprcheck_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j main_L_3_switch_over
j main_L_3_switch_over
nop
   # main_L_5_case :
main_L_5_case:
   # @call arraychek
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 28
jal arraychek_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j main_L_3_switch_over
j main_L_3_switch_over
nop
   # main_L_6_case :
main_L_6_case:
   # @call recurcheck
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 28
jal recurcheck_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j main_L_3_switch_over
j main_L_3_switch_over
nop
   # main_L_7_case :
main_L_7_case:
   # @call lettercheck
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 28
jal lettercheck_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j main_L_3_switch_over
j main_L_3_switch_over
nop
   # main_L_8_default :
main_L_8_default:
   # @printf string S_8
li $v0, 4
la $a0, S_8
syscall
   # #6 = choice
lw $s7, 0($fp)
lw $s0, 28($fp)
move $s0, $s7
   # #7 = #6
lw $s1, 32($fp)
move $s1, $s0
   # @printf int #7
li $v0, 1
move $a0, $s1
syscall
   # @j main_L_3_switch_over
sw $s0, 28($fp)
sw $s1, 32($fp)
sw $s7, 0($fp)
j main_L_3_switch_over
nop
   # main_L_2_switch_branch :
main_L_2_switch_branch:
   # @be #5 1 main_L_4_case
lw $s2, 24($fp)
beq $s2, 1, main_L_4_case
nop
   # @be #5 2 main_L_5_case
sw $s2, 24($fp)
lw $s3, 24($fp)
beq $s3, 2, main_L_5_case
nop
   # @be #5 3 main_L_6_case
sw $s3, 24($fp)
lw $s4, 24($fp)
beq $s4, 3, main_L_6_case
nop
   # @be #5 4 main_L_7_case
sw $s4, 24($fp)
lw $s5, 24($fp)
beq $s5, 4, main_L_7_case
nop
   # @j main_L_8_default
sw $s5, 24($fp)
j main_L_8_default
nop
   # main_L_3_switch_over :
main_L_3_switch_over:
   # @printf string S_9
li $v0, 4
la $a0, S_9
syscall
   # @scanf int choice
li $v0, 5
syscall
lw $s6, 0($fp)
move $s6, $v0
   # @j main_L_0_while_begin
sw $s6, 0($fp)
j main_L_0_while_begin
nop
   # main_L_1_while_over :
main_L_1_while_over:
   # @ret
jr $ra
nop
