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
   # @var int a
   # @array int[] find_array 100
   # @call main
addi $fp, $fp, 404
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
   # @exit
   # @func init_array
init_array_E:
   # @label 0
   # @var int a
   # a = 0
li $s0, 0
   # init_array_L_0_while_begin :
init_array_L_0_while_begin:
   # #0 = a LT 100
li $s1, 100
slt $t0 $s0 $s1
   # @bz #0 init_array_L_1_while_over
beq $t0, $0, init_array_L_1_while_over
nop
   # @label 1
   # find_array = a ARSET a
sll $v0, $s0, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
sw $s0, ($v0)
   # a = a ADD 1
addi $s0 $s0 1
   # @j init_array_L_0_while_begin
j init_array_L_0_while_begin
nop
   # init_array_L_1_while_over :
init_array_L_1_while_over:
   # @ret
jr $ra
nop
   # @func find
find_E:
   # @label 0
   # @para int begin
lw $s1, -4($fp)
   # @para int end
lw $s3, -8($fp)
   # @para int num
lw $s2, -12($fp)
   # @var int mid
   # #0 = begin EQ end
seq $t0 $s1 $s3
   # @bz #0 find_L_0_else_begin
beq $t0, $0, find_L_0_else_begin
nop
   # @label 1
   # #0 = find_array ARGET begin
sll $v0, $s1, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
   # #1 = #0 EQ num
seq $t1 $t0 $s2
   # @bz #1 find_L_2_else_begin
beq $t1, $0, find_L_2_else_begin
nop
   # @label 2
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int begin
li $v0, 1
move $a0, $s1
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_3_else_over
j find_L_3_else_over
nop
   # find_L_2_else_begin :
find_L_2_else_begin:
   # @printf string S_2
li $v0, 4
la $a0, S_2
syscall
   # find_L_3_else_over :
find_L_3_else_over:
   # @ret
jr $ra
nop
   # find_L_0_else_begin :
find_L_0_else_begin:
   # find_L_1_else_over :
find_L_1_else_over:
   # #0 = begin ADD end
add $t0 $s1 $s3
   # mid = #0 DIV 2
div $s0 $t0 2
   # #0 = find_array ARGET mid
sll $v0, $s0, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
   # #1 = #0 LT num
slt $t1 $t0 $s2
   # @bz #1 find_L_4_else_begin
beq $t1, $0, find_L_4_else_begin
nop
   # @label 3
   # #0 = mid ADD 1
addi $t0 $s0 1
   # @push #0
   # @push end
   # @push num
   # @call find
sw $s2, 16($fp)
sw $s3, 20($fp)
sw $t0, 24($fp)
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 12($sp)
sw $s2, 16($sp)
sw $s3, 20($sp)
sw $t0, 24($sp)
sw $t1, 28($sp)
addi $fp, $fp, 28
jal find_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
lw $s1, 12($sp)
lw $s2, 16($sp)
lw $s3, 20($sp)
lw $t0, 24($sp)
lw $t1, 28($sp)
addi $sp, $sp, 32
   # @j find_L_5_else_over
j find_L_5_else_over
nop
   # find_L_4_else_begin :
find_L_4_else_begin:
   # #0 = find_array ARGET mid
sll $v0, $s0, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
   # #1 = #0 GT num
sgt $t1 $t0 $s2
   # @bz #1 find_L_6_else_begin
beq $t1, $0, find_L_6_else_begin
nop
   # @label 4
   # @push begin
   # @push mid
   # @push num
   # @call find
sw $s2, 16($fp)
sw $s0, 20($fp)
sw $s1, 24($fp)
addi $sp, $sp, -28
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 12($sp)
sw $s2, 16($sp)
sw $t0, 20($sp)
sw $t1, 24($sp)
addi $fp, $fp, 28
jal find_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
lw $s1, 12($sp)
lw $s2, 16($sp)
lw $t0, 20($sp)
lw $t1, 24($sp)
addi $sp, $sp, 28
   # @j find_L_7_else_over
j find_L_7_else_over
nop
   # find_L_6_else_begin :
find_L_6_else_begin:
   # #0 = find_array ARGET mid
sll $v0, $s0, 2
add $v0, $v0, $gp
addi $v0, $v0, 4
lw $t0, ($v0)
   # #1 = #0 EQ num
seq $t1 $t0 $s2
   # @bz #1 find_L_8_else_begin
beq $t1, $0, find_L_8_else_begin
nop
   # @label 5
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int mid
li $v0, 1
move $a0, $s0
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_9_else_over
j find_L_9_else_over
nop
   # find_L_8_else_begin :
find_L_8_else_begin:
   # @printf string S_3
li $v0, 4
la $a0, S_3
syscall
   # find_L_9_else_over :
find_L_9_else_over:
   # find_L_7_else_over :
find_L_7_else_over:
   # find_L_5_else_over :
find_L_5_else_over:
   # @ret
jr $ra
nop
   # @func get_index
get_index_E:
   # @label 0
   # @para int size
lw $s2, -4($fp)
   # @para int row
lw $s1, -8($fp)
   # @para int col
lw $s0, -12($fp)
   # #0 = row SUB 1
addi $t0 $s1 -1
   # #1 = #0 MUL size
mul $t1 $t0 $s2
   # #0 = col SUB 1
addi $t0 $s0 -1
   # #2 = #1 ADD #0
add $t2 $t1 $t0
   # @ret #2
move $v0, $t2
jr $ra
nop
   # @func zigzag
zigzag_E:
   # @label 0
   # @var int a
   # @var int i
   # @var char temp
   # @var int tempi
   # @array char[] matrix 100
   # @var int row
   # @var int col
   # @printf string S_4
li $v0, 4
la $a0, S_4
syscall
   # @scanf int a
li $v0, 5
syscall
move $s1, $v0
   # zigzag_L_0_while_begin :
zigzag_L_0_while_begin:
   # #0 = a GE 10
li $s0, 10
sge $t0 $s1 $s0
   # @bz #0 zigzag_L_1_while_over
beq $t0, $0, zigzag_L_1_while_over
nop
   # @label 1
   # @printf string S_5
li $v0, 4
la $a0, S_5
syscall
   # @scanf int a
li $v0, 5
syscall
move $s1, $v0
   # @j zigzag_L_0_while_begin
j zigzag_L_0_while_begin
nop
   # zigzag_L_1_while_over :
zigzag_L_1_while_over:
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # i = 0
li $s0, 0
   # zigzag_L_2_while_begin :
zigzag_L_2_while_begin:
   # #0 = a MUL a
mul $t0 $s1 $s1
   # #1 = i LT #0
slt $t1 $s0 $t0
   # @bz #1 zigzag_L_3_while_over
beq $t1, $0, zigzag_L_3_while_over
nop
   # @label 2
   # @scanf char temp
li $v0, 12
syscall
move $s2, $v0
   # matrix = i ARSET temp
add $v0, $s0, $fp
addi $v0, $v0, 16
sb $s2, ($v0)
   # i = i ADD 1
addi $s0 $s0 1
   # #0 = i DIV a
div $t0 $s0 $s1
   # #1 = #0 MUL a
mul $t1 $t0 $s1
   # #0 = #1 EQ i
seq $t0 $t1 $s0
   # @bz #0 zigzag_L_4_else_begin
sb $s2, 8($fp) # store temp
beq $t0, $0, zigzag_L_4_else_begin
nop
   # @label 3
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j zigzag_L_5_else_over
sb $s2, 8($fp) # store temp
j zigzag_L_5_else_over
nop
   # zigzag_L_4_else_begin :
sb $s2, 8($fp) # store temp
zigzag_L_4_else_begin:
   # zigzag_L_5_else_over :
zigzag_L_5_else_over:
   # @j zigzag_L_2_while_begin
j zigzag_L_2_while_begin
nop
   # zigzag_L_3_while_over :
zigzag_L_3_while_over:
   # @printf string S_7
li $v0, 4
la $a0, S_7
syscall
   # row = 1
li $s4, 1
   # @push a
   # @push 1
   # @push 1
   # @call get_index
li $s2, 1
sw $s2, 124($fp)
sw $s2, 128($fp)
sw $s1, 132($fp)
addi $sp, $sp, -20
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 12($sp)
sw $s4, 16($sp)
addi $fp, $fp, 136
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
lw $s1, 12($sp)
lw $s4, 16($sp)
addi $sp, $sp, 20
   # @get #0
move $t0, $v0
   # #1 = matrix ARGET #0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
   # @printf char #1
li $v0, 11
move $a0, $t1
syscall
   # col = 1
li $s0, 1
   # zigzag_L_6_while_begin :
zigzag_L_6_while_begin:
   # #0 = row MUL col
mul $t0 $s4 $s0
   # #1 = a MUL a
mul $t1 $s1 $s1
   # #2 = #0 NE #1
sne $t2 $t0 $t1
   # @bz #2 zigzag_L_7_while_over
beq $t2, $0, zigzag_L_7_while_over
nop
   # @label 4
   # #0 = col EQ a
seq $t0 $s0 $s1
   # @bz #0 zigzag_L_8_else_begin
beq $t0, $0, zigzag_L_8_else_begin
nop
   # @label 5
   # row = row ADD 1
addi $s4 $s4 1
   # @j zigzag_L_9_else_over
j zigzag_L_9_else_over
nop
   # zigzag_L_8_else_begin :
zigzag_L_8_else_begin:
   # col = col ADD 1
addi $s0 $s0 1
   # zigzag_L_9_else_over :
zigzag_L_9_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
sw $s0, 124($fp)
sw $s4, 128($fp)
sw $s1, 132($fp)
addi $sp, $sp, -28
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 12($sp)
sw $s2, 16($sp)
sw $s3, 20($sp)
sw $s4, 24($sp)
addi $fp, $fp, 136
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
lw $s1, 12($sp)
lw $s2, 16($sp)
lw $s3, 20($sp)
lw $s4, 24($sp)
addi $sp, $sp, 28
   # @get #0
move $t0, $v0
   # #1 = matrix ARGET #0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
   # @printf char #1
li $v0, 11
move $a0, $t1
syscall
   # i = 0
li $s3, 0
   # tempi = col SUB row
sub $s2 $s0 $s4
   # zigzag_L_10_while_begin :
zigzag_L_10_while_begin:
   # #0 = i LT tempi
slt $t0 $s3 $s2
   # @bz #0 zigzag_L_11_while_over
beq $t0, $0, zigzag_L_11_while_over
nop
   # @label 6
   # i = i ADD 1
addi $s3 $s3 1
   # col = col SUB 1
addi $s0 $s0 -1
   # row = row ADD 1
addi $s4 $s4 1
   # @push a
   # @push row
   # @push col
   # @call get_index
sw $s0, 124($fp)
sw $s4, 128($fp)
sw $s1, 132($fp)
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 12($sp)
sw $s2, 16($sp)
sw $s3, 20($sp)
sw $s4, 24($sp)
sw $t0, 28($sp)
addi $fp, $fp, 136
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
lw $s1, 12($sp)
lw $s2, 16($sp)
lw $s3, 20($sp)
lw $s4, 24($sp)
lw $t0, 28($sp)
addi $sp, $sp, 32
   # @get #0
move $t0, $v0
   # #1 = matrix ARGET #0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
   # @printf char #1
li $v0, 11
move $a0, $t1
syscall
   # @j zigzag_L_10_while_begin
j zigzag_L_10_while_begin
nop
   # zigzag_L_11_while_over :
zigzag_L_11_while_over:
   # #0 = row EQ a
seq $t0 $s4 $s1
   # @bz #0 zigzag_L_12_else_begin
beq $t0, $0, zigzag_L_12_else_begin
nop
   # @label 7
   # col = col ADD 1
addi $s0 $s0 1
   # @j zigzag_L_13_else_over
j zigzag_L_13_else_over
nop
   # zigzag_L_12_else_begin :
zigzag_L_12_else_begin:
   # row = row ADD 1
addi $s4 $s4 1
   # zigzag_L_13_else_over :
zigzag_L_13_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
sw $s0, 124($fp)
sw $s4, 128($fp)
sw $s1, 132($fp)
addi $sp, $sp, -28
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 12($sp)
sw $s2, 16($sp)
sw $s3, 20($sp)
sw $s4, 24($sp)
addi $fp, $fp, 136
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
lw $s1, 12($sp)
lw $s2, 16($sp)
lw $s3, 20($sp)
lw $s4, 24($sp)
addi $sp, $sp, 28
   # @get #0
move $t0, $v0
   # #1 = matrix ARGET #0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
   # @printf char #1
li $v0, 11
move $a0, $t1
syscall
   # i = 0
li $s3, 0
   # #0 = 0 SUB col
sub $t0 $0 $s0
   # tempi = #0 ADD row
add $s2 $t0 $s4
   # zigzag_L_14_while_begin :
zigzag_L_14_while_begin:
   # #0 = i LT tempi
slt $t0 $s3 $s2
   # @bz #0 zigzag_L_15_while_over
beq $t0, $0, zigzag_L_15_while_over
nop
   # @label 8
   # i = i ADD 1
addi $s3 $s3 1
   # row = row SUB 1
addi $s4 $s4 -1
   # col = col ADD 1
addi $s0 $s0 1
   # @push a
   # @push row
   # @push col
   # @call get_index
sw $s0, 124($fp)
sw $s4, 128($fp)
sw $s1, 132($fp)
addi $sp, $sp, -32
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 12($sp)
sw $s2, 16($sp)
sw $s3, 20($sp)
sw $s4, 24($sp)
sw $t0, 28($sp)
addi $fp, $fp, 136
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
lw $s1, 12($sp)
lw $s2, 16($sp)
lw $s3, 20($sp)
lw $s4, 24($sp)
lw $t0, 28($sp)
addi $sp, $sp, 32
   # @get #0
move $t0, $v0
   # #1 = matrix ARGET #0
add $v0, $t0, $fp
addi $v0, $v0, 16
lb $t1, ($v0)
   # @printf char #1
li $v0, 11
move $a0, $t1
syscall
   # @j zigzag_L_14_while_begin
j zigzag_L_14_while_begin
nop
   # zigzag_L_15_while_over :
zigzag_L_15_while_over:
   # @j zigzag_L_6_while_begin
j zigzag_L_6_while_begin
nop
   # zigzag_L_7_while_over :
zigzag_L_7_while_over:
   # @ret
jr $ra
nop
   # @func fluctuations
fluctuations_E:
   # @label 0
   # @var int n
   # @var int a
   # @var int b
   # @var int ra
   # @var int rb
   # @var int sub
   # @var int max_sub
   # @var int i
   # @printf string S_8
li $v0, 4
la $a0, S_8
syscall
   # @scanf int n
li $v0, 5
syscall
move $s0, $v0
   # fluctuations_L_0_while_begin :
fluctuations_L_0_while_begin:
   # #0 = n LE 1
li $s1, 1
sle $t0 $s0 $s1
   # @bz #0 fluctuations_L_1_while_over
beq $t0, $0, fluctuations_L_1_while_over
nop
   # @label 1
   # @printf string S_9
li $v0, 4
la $a0, S_9
syscall
   # @printf string S_8
li $v0, 4
la $a0, S_8
syscall
   # @scanf int n
li $v0, 5
syscall
move $s0, $v0
   # @j fluctuations_L_0_while_begin
j fluctuations_L_0_while_begin
nop
   # fluctuations_L_1_while_over :
fluctuations_L_1_while_over:
   # a = 0
li $s4, 0
   # b = 0
li $s5, 0
   # max_sub = -1
li $s2, -1
   # i = 0
li $s1, 0
   # fluctuations_L_2_while_begin :
sw $s4, 4($fp) # store a
fluctuations_L_2_while_begin:
   # #0 = 0 SUB i
sub $t0 $0 $s1
   # #1 = 0 SUB #0
sub $t1 $0 $t0
   # #0 = 0 SUB #1
sub $t0 $0 $t1
   # #1 = 0 SUB #0
sub $t1 $0 $t0
   # #0 = #1 LT n
slt $t0 $t1 $s0
   # @bz #0 fluctuations_L_3_while_over
beq $t0, $0, fluctuations_L_3_while_over
nop
   # @label 2
   # @scanf int a
li $v0, 5
syscall
move $s7, $v0
   # sub = a SUB b
sub $s4 $s7 $s5
   # @printf string S_10
li $v0, 4
la $a0, S_10
syscall
   # @printf int sub
li $v0, 1
move $a0, $s4
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #1 = sub LE 0
sle $t1 $s4 $0
   # @bz #1 fluctuations_L_4_else_begin
beq $t1, $0, fluctuations_L_4_else_begin
nop
   # @label 3
   # sub = 0 SUB sub
sub $s4 $0 $s4
   # @j fluctuations_L_5_else_over
j fluctuations_L_5_else_over
nop
   # fluctuations_L_4_else_begin :
fluctuations_L_4_else_begin:
   # fluctuations_L_5_else_over :
fluctuations_L_5_else_over:
   # #0 = sub GT max_sub
sgt $t0 $s4 $s2
   # @bz #0 fluctuations_L_6_else_begin
beq $t0, $0, fluctuations_L_6_else_begin
nop
   # @label 4
   # ra = a
move $s3, $s7
   # rb = b
move $s6, $s5
   # max_sub = sub
move $s2, $s4
   # @j fluctuations_L_7_else_over
j fluctuations_L_7_else_over
nop
   # fluctuations_L_6_else_begin :
fluctuations_L_6_else_begin:
   # fluctuations_L_7_else_over :
fluctuations_L_7_else_over:
   # @printf string S_11
li $v0, 4
la $a0, S_11
syscall
   # @printf int max_sub
li $v0, 1
move $a0, $s2
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # b = a
move $s5, $s7
   # i = i ADD 1
addi $s1 $s1 1
   # @j fluctuations_L_2_while_begin
j fluctuations_L_2_while_begin
nop
   # fluctuations_L_3_while_over :
fluctuations_L_3_while_over:
   # @printf string S_12
li $v0, 4
la $a0, S_12
syscall
   # @printf int max_sub
li $v0, 1
move $a0, $s2
syscall
   # @printf string S_13
li $v0, 4
la $a0, S_13
syscall
   # @printf int ra
li $v0, 1
move $a0, $s3
syscall
   # @printf string S_14
li $v0, 4
la $a0, S_14
syscall
   # @printf int rb
li $v0, 1
move $a0, $s6
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @ret
jr $ra
nop
   # @func fibonacci
fibonacci_E:
   # @label 0
   # @var int a
   # @var int b
   # @var int sum
   # @var int n
   # @var int i
   # a = 1
li $s3, 1
   # @printf string S_15
li $v0, 4
la $a0, S_15
syscall
   # b = 1
li $s1, 1
   # @scanf int n
li $v0, 5
syscall
move $s2, $v0
   # #0 = n LE 0
sle $t0 $s2 $0
   # @bz #0 fibonacci_L_0_else_begin
beq $t0, $0, fibonacci_L_0_else_begin
nop
   # @label 1
   # @printf string S_16
li $v0, 4
la $a0, S_16
syscall
   # @ret
jr $ra
nop
   # fibonacci_L_0_else_begin :
fibonacci_L_0_else_begin:
   # fibonacci_L_1_else_over :
fibonacci_L_1_else_over:
   # @printf int a
li $v0, 1
move $a0, $s3
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 1
li $s0, 1
sle $t0 $s2 $s0
   # @bz #0 fibonacci_L_2_else_begin
beq $t0, $0, fibonacci_L_2_else_begin
nop
   # @label 2
   # @ret
jr $ra
nop
   # fibonacci_L_2_else_begin :
fibonacci_L_2_else_begin:
   # fibonacci_L_3_else_over :
fibonacci_L_3_else_over:
   # @printf int b
li $v0, 1
move $a0, $s1
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 2
li $s0, 2
sle $t0 $s2 $s0
   # @bz #0 fibonacci_L_4_else_begin
beq $t0, $0, fibonacci_L_4_else_begin
nop
   # @label 3
   # @ret
jr $ra
nop
   # fibonacci_L_4_else_begin :
fibonacci_L_4_else_begin:
   # fibonacci_L_5_else_over :
fibonacci_L_5_else_over:
   # i = 3
li $s0, 3
   # fibonacci_L_6_while_begin :
fibonacci_L_6_while_begin:
   # #0 = i LE n
sle $t0 $s0 $s2
   # @bz #0 fibonacci_L_7_while_over
beq $t0, $0, fibonacci_L_7_while_over
nop
   # @label 4
   # sum = a ADD b
add $s4 $s3 $s1
   # b = a
move $s1, $s3
   # @printf int sum
li $v0, 1
move $a0, $s4
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n DIV 10
div $t0 $s2 10
   # #1 = #0 MUL 10
mul $t1 $t0 10
   # #0 = i ADD 1
addi $t0 $s0 1
   # #2 = #1 EQ #0
seq $t2 $t1 $t0
   # a = sum
move $s3, $s4
   # @bz #2 fibonacci_L_8_else_begin
sw $s4, 8($fp) # store sum
beq $t2, $0, fibonacci_L_8_else_begin
nop
   # @label 5
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j fibonacci_L_9_else_over
sw $s4, 8($fp) # store sum
j fibonacci_L_9_else_over
nop
   # fibonacci_L_8_else_begin :
sw $s4, 8($fp) # store sum
fibonacci_L_8_else_begin:
   # fibonacci_L_9_else_over :
fibonacci_L_9_else_over:
   # i = i ADD 1
addi $s0 $s0 1
   # @j fibonacci_L_6_while_begin
j fibonacci_L_6_while_begin
nop
   # fibonacci_L_7_while_over :
fibonacci_L_7_while_over:
   # @ret
jr $ra
nop
   # @func sort
sort_E:
   # @label 0
   # @array int[] a 100
   # @var int size
   # @var int i
   # @var int j
   # @var int temp
   # @printf string S_18
li $v0, 4
la $a0, S_18
syscall
   # @scanf int size
li $v0, 5
syscall
move $s2, $v0
   # sort_L_0_while_begin :
sort_L_0_while_begin:
   # #0 = size GE 100
li $s0, 100
sge $t0 $s2 $s0
   # @bz #0 sort_L_1_while_over
beq $t0, $0, sort_L_1_while_over
nop
   # @label 1
   # @printf string S_19
li $v0, 4
la $a0, S_19
syscall
   # @scanf int size
li $v0, 5
syscall
move $s2, $v0
   # @j sort_L_0_while_begin
j sort_L_0_while_begin
nop
   # sort_L_1_while_over :
sort_L_1_while_over:
   # @printf string S_20
li $v0, 4
la $a0, S_20
syscall
   # @printf int size
li $v0, 1
move $a0, $s2
syscall
   # @printf string S_21
li $v0, 4
la $a0, S_21
syscall
   # i = 0
li $s0, 0
   # sort_L_2_while_begin :
sort_L_2_while_begin:
   # #0 = i LT size
slt $t0 $s0 $s2
   # @bz #0 sort_L_3_while_over
beq $t0, $0, sort_L_3_while_over
nop
   # @label 2
   # @scanf int temp
li $v0, 5
syscall
move $s1, $v0
   # a = i ARSET temp
sll $v0, $s0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
sw $s1, ($v0)
   # @printf string S_22
li $v0, 4
la $a0, S_22
syscall
   # #0 = a ARGET i
sll $v0, $s0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t0, ($v0)
   # @printf int #0
li $v0, 1
move $a0, $t0
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # i = i ADD 1
addi $s0 $s0 1
   # @j sort_L_2_while_begin
sw $s1, 412($fp) # store temp
j sort_L_2_while_begin
nop
   # sort_L_3_while_over :
sw $s1, 412($fp) # store temp
sort_L_3_while_over:
   # i = 0
li $s0, 0
   # sort_L_4_while_begin :
sort_L_4_while_begin:
   # #0 = size SUB 1
addi $t0 $s2 -1
   # #1 = i LT #0
slt $t1 $s0 $t0
   # @bz #1 sort_L_5_while_over
beq $t1, $0, sort_L_5_while_over
nop
   # @label 3
   # j = 0
li $s1, 0
   # sort_L_6_while_begin :
sort_L_6_while_begin:
   # #0 = size SUB 1
addi $t0 $s2 -1
   # #1 = #0 SUB i
sub $t1 $t0 $s0
   # #0 = j LT #1
slt $t0 $s1 $t1
   # @bz #0 sort_L_7_while_over
beq $t0, $0, sort_L_7_while_over
nop
   # @label 4
   # #1 = a ARGET j
sll $v0, $s1, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t1, ($v0)
   # #0 = j ADD 1
addi $t0 $s1 1
   # #2 = a ARGET #0
sll $v0, $t0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t2, ($v0)
   # #3 = #1 GT #2
sgt $t3 $t1 $t2
   # @bz #3 sort_L_8_else_begin
beq $t3, $0, sort_L_8_else_begin
nop
   # @label 5
   # @printf string S_23
li $v0, 4
la $a0, S_23
syscall
   # @printf int #1
li $v0, 1
move $a0, $t1
syscall
   # @printf string S_24
li $v0, 4
la $a0, S_24
syscall
   # @printf int #2
li $v0, 1
move $a0, $t2
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # a = j ARSET #2
sll $v0, $s1, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
sw $t2, ($v0)
   # a = #0 ARSET #1
sll $v0, $t0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
sw $t1, ($v0)
   # temp = #3
move $s3, $t3
   # @j sort_L_9_else_over
sw $s3, 412($fp) # store temp
j sort_L_9_else_over
nop
   # sort_L_8_else_begin :
sw $s3, 412($fp) # store temp
sort_L_8_else_begin:
   # sort_L_9_else_over :
sort_L_9_else_over:
   # j = j ADD 1
addi $s1 $s1 1
   # @j sort_L_6_while_begin
j sort_L_6_while_begin
nop
   # sort_L_7_while_over :
sort_L_7_while_over:
   # i = i ADD 1
addi $s0 $s0 1
   # @j sort_L_4_while_begin
j sort_L_4_while_begin
nop
   # sort_L_5_while_over :
sort_L_5_while_over:
   # @printf string S_25
li $v0, 4
la $a0, S_25
syscall
   # #0 = a ARGET 2
lw $t0, 8($fp)
   # @printf int #0
li $v0, 1
move $a0, $t0
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @printf string S_26
li $v0, 4
la $a0, S_26
syscall
   # i = 0
li $s0, 0
   # sort_L_10_while_begin :
sort_L_10_while_begin:
   # #0 = i LT size
slt $t0 $s0 $s2
   # @bz #0 sort_L_11_while_over
beq $t0, $0, sort_L_11_while_over
nop
   # @label 6
   # i = i ADD 1
addi $s0 $s0 1
   # @printf string S_27
li $v0, 4
la $a0, S_27
syscall
   # #0 = i SUB 1
addi $t0 $s0 -1
   # @printf int #0
li $v0, 1
move $a0, $t0
syscall
   # @printf string S_28
li $v0, 4
la $a0, S_28
syscall
   # #1 = a ARGET #0
sll $v0, $t0, 2
add $v0, $v0, $fp
addi $v0, $v0, 0
lw $t1, ($v0)
   # @printf int #1
li $v0, 1
move $a0, $t1
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = i ADD 1
addi $t0 $s0 1
   # #1 = #0 DIV 10
div $t1 $t0 10
   # #2 = #1 MUL 10
mul $t2 $t1 10
   # #1 = #2 EQ #0
seq $t1 $t2 $t0
   # @bz #1 sort_L_12_else_begin
beq $t1, $0, sort_L_12_else_begin
nop
   # @label 7
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j sort_L_13_else_over
j sort_L_13_else_over
nop
   # sort_L_12_else_begin :
sort_L_12_else_begin:
   # sort_L_13_else_over :
sort_L_13_else_over:
   # @j sort_L_10_while_begin
j sort_L_10_while_begin
nop
   # sort_L_11_while_over :
sort_L_11_while_over:
   # @ret 48
li $v0, 48
jr $ra
nop
   # @func select
select_E:
   # @label 0
   # @var int i
   # @var int num
   # select_L_0_while_begin :
select_L_0_while_begin:
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @printf string S_29
li $v0, 4
la $a0, S_29
syscall
   # @printf string S_30
li $v0, 4
la $a0, S_30
syscall
   # @printf string S_31
li $v0, 4
la $a0, S_31
syscall
   # @printf string S_32
li $v0, 4
la $a0, S_32
syscall
   # @printf string S_33
li $v0, 4
la $a0, S_33
syscall
   # @printf string S_34
li $v0, 4
la $a0, S_34
syscall
   # @printf string S_35
li $v0, 4
la $a0, S_35
syscall
   # @printf string S_29
li $v0, 4
la $a0, S_29
syscall
   # @printf string S_36
li $v0, 4
la $a0, S_36
syscall
   # @scanf int i
li $v0, 5
syscall
move $s0, $v0
   # #0 = i DIV 1
div $t0 $s0 1
   # #1 = #0 MUL 1
mul $t1 $t0 1
   # @be #1 0 select_L_3_case
beq $t1, 0, select_L_3_case
nop
   # @label 1
   # @be #1 1 select_L_4_case
beq $t1, 1, select_L_4_case
nop
   # @label 2
   # @be #1 2 select_L_5_case
beq $t1, 2, select_L_5_case
nop
   # @label 3
   # @be #1 3 select_L_6_case
beq $t1, 3, select_L_6_case
nop
   # @label 4
   # @be #1 4 select_L_7_case
beq $t1, 4, select_L_7_case
nop
   # @label 5
   # @be #1 5 select_L_8_case
beq $t1, 5, select_L_8_case
nop
   # @label 6
   # @j select_L_9_default
j select_L_9_default
nop
   # select_L_3_case :
select_L_3_case:
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_4_case :
select_L_4_case:
   # @call sort
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
addi $fp, $fp, 8
jal sort_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
addi $sp, $sp, 12
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_5_case :
select_L_5_case:
   # @call fibonacci
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
addi $fp, $fp, 8
jal fibonacci_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
addi $sp, $sp, 12
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_6_case :
select_L_6_case:
   # @call fluctuations
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
addi $fp, $fp, 8
jal fluctuations_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
addi $sp, $sp, 12
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_7_case :
select_L_7_case:
   # @call zigzag
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
addi $fp, $fp, 8
jal zigzag_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
addi $sp, $sp, 12
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_8_case :
select_L_8_case:
   # @printf string S_37
li $v0, 4
la $a0, S_37
syscall
   # @scanf int num
li $v0, 5
syscall
move $s1, $v0
   # @push 0
   # @push 99
   # @push num
   # @call find
sw $s1, 8($fp)
li $s2, 99
sw $s2, 12($fp)
sw $0, 16($fp)
addi $sp, $sp, -12
sw $ra, 0($sp)
sw $fp, 4($sp)
sw $s0, 8($sp)
sw $s1, 4($fp) # store num
addi $fp, $fp, 20
jal find_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
lw $s0, 8($sp)
addi $sp, $sp, 12
   # @j select_L_2_switch_over
sw $s1, 4($fp) # store num
j select_L_2_switch_over
nop
   # select_L_9_default :
sw $s1, 4($fp) # store num
select_L_9_default:
   # @printf string S_9
li $v0, 4
la $a0, S_9
syscall
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_2_switch_over :
select_L_2_switch_over:
   # #0 = i EQ 0
seq $t0 $s0 $0
   # @bz #0 select_L_10_else_begin
beq $t0, $0, select_L_10_else_begin
nop
   # @label 7
   # @printf string S_38
li $v0, 4
la $a0, S_38
syscall
   # @ret
jr $ra
nop
   # select_L_10_else_begin :
select_L_10_else_begin:
   # select_L_11_else_over :
select_L_11_else_over:
   # @j select_L_0_while_begin
j select_L_0_while_begin
nop
   # select_L_1_while_over :
select_L_1_while_over:
   # @ret
jr $ra
nop
   # @func main
main_E:
   # @label 0
   # @call init_array
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 0
jal init_array_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @call select
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 0
jal select_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @ret
jr $ra
nop
