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
   # @var int a
   # a = 0
lw $s0, 0($fp)# a
li $s0, 0
   # init_array_L_0_while_begin :
sw $s0, 0($fp)
init_array_L_0_while_begin:
   # #0 = a LT 100
lw $s1, 4($fp)# #0
lw $s2, 0($fp)# a
li $t9, 100
slt $s1, $s2, $t9
   # @bz #0 init_array_L_1_while_over
sw $s1, 4($fp)
sw $s2, 0($fp)
lw $s3, 4($fp)# #0
beq $s3, $0, init_array_L_1_while_over
nop
   # find_array = a ARSET a
lw $s4, 0($fp)# a
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
sw $s4, ($t1)
   # a = a ADD 1
addi $s4, $s4, 1
   # @j init_array_L_0_while_begin
sw $s3, 4($fp)
sw $s4, 0($fp)
j init_array_L_0_while_begin
nop
   # init_array_L_1_while_over :
init_array_L_1_while_over:
   # @ret
jr $ra
nop
   # @func find
find_E:
   # @para int begin
lw $s5, 0($fp)# begin
lw $s5, -4($fp)
   # @para int end
lw $s6, 4($fp)# end
lw $s6, -8($fp)
   # @para int num
lw $s7, 8($fp)# num
lw $s7, -12($fp)
   # @var int mid
   # #0 = begin EQ end
lw $s0, 16($fp)# #0
seq $s0, $s5, $s6
   # @bz #0 find_L_0_else_begin
sw $s0, 16($fp)
sw $s5, 0($fp)
sw $s6, 4($fp)
sw $s7, 8($fp)
lw $s1, 16($fp)# #0
beq $s1, $0, find_L_0_else_begin
nop
   # #0 = find_array ARGET begin
lw $s2, 0($fp)# begin
sll $t1, $s2, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s1, ($t1)
   # #1 = #0 EQ num
lw $s3, 20($fp)# #1
lw $s4, 8($fp)# num
seq $s3, $s1, $s4
   # @bz #1 find_L_2_else_begin
sw $s1, 16($fp)
sw $s2, 0($fp)
sw $s3, 20($fp)
sw $s4, 8($fp)
lw $s5, 20($fp)# #1
beq $s5, $0, find_L_2_else_begin
nop
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int begin
li $v0, 1
lw $s6, 0($fp)# begin
move $a0, $s6
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_3_else_over
sw $s5, 20($fp)
sw $s6, 0($fp)
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
lw $s7, 16($fp)# #0
lw $s0, 0($fp)# begin
lw $s1, 4($fp)# end
add $s7, $s0, $s1
   # mid = #0 DIV 2
lw $s2, 12($fp)# mid
div $s2, $s7, 2
   # #0 = find_array ARGET mid
sll $t1, $s2, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s7, ($t1)
   # #1 = #0 LT num
lw $s3, 20($fp)# #1
lw $s4, 8($fp)# num
slt $s3, $s7, $s4
   # @bz #1 find_L_4_else_begin
sw $s0, 0($fp)
sw $s1, 4($fp)
sw $s2, 12($fp)
sw $s3, 20($fp)
sw $s4, 8($fp)
sw $s7, 16($fp)
lw $s5, 20($fp)# #1
beq $s5, $0, find_L_4_else_begin
nop
   # #0 = mid ADD 1
lw $s6, 16($fp)# #0
lw $s7, 12($fp)# mid
addi $s6, $s7, 1
   # @push #0
   # @push end
   # @push num
   # @call find
lw $s0, 8($fp)# num
sw $s0, 24($fp)
lw $s1, 4($fp)# end
sw $s1, 28($fp)
sw $s6, 32($fp)
sw $s0, 8($fp)
sw $s1, 4($fp)
sw $s5, 20($fp)
sw $s6, 16($fp)
sw $s7, 12($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 36
jal find_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j find_L_5_else_over
j find_L_5_else_over
nop
   # find_L_4_else_begin :
find_L_4_else_begin:
   # #0 = find_array ARGET mid
lw $s2, 16($fp)# #0
lw $s3, 12($fp)# mid
sll $t1, $s3, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s2, ($t1)
   # #1 = #0 GT num
lw $s4, 20($fp)# #1
lw $s5, 8($fp)# num
sgt $s4, $s2, $s5
   # @bz #1 find_L_6_else_begin
sw $s2, 16($fp)
sw $s3, 12($fp)
sw $s4, 20($fp)
sw $s5, 8($fp)
lw $s6, 20($fp)# #1
beq $s6, $0, find_L_6_else_begin
nop
   # @push begin
   # @push mid
   # @push num
   # @call find
lw $s7, 8($fp)# num
sw $s7, 24($fp)
lw $s0, 12($fp)# mid
sw $s0, 28($fp)
lw $s1, 0($fp)# begin
sw $s1, 32($fp)
sw $s0, 12($fp)
sw $s1, 0($fp)
sw $s6, 20($fp)
sw $s7, 8($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 36
jal find_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j find_L_7_else_over
j find_L_7_else_over
nop
   # find_L_6_else_begin :
find_L_6_else_begin:
   # #0 = find_array ARGET mid
lw $s2, 16($fp)# #0
lw $s3, 12($fp)# mid
sll $t1, $s3, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s2, ($t1)
   # #1 = #0 EQ num
lw $s4, 20($fp)# #1
lw $s5, 8($fp)# num
seq $s4, $s2, $s5
   # @bz #1 find_L_8_else_begin
sw $s2, 16($fp)
sw $s3, 12($fp)
sw $s4, 20($fp)
sw $s5, 8($fp)
lw $s6, 20($fp)# #1
beq $s6, $0, find_L_8_else_begin
nop
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int mid
li $v0, 1
lw $s7, 12($fp)# mid
move $a0, $s7
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_9_else_over
sw $s6, 20($fp)
sw $s7, 12($fp)
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
   # @para int size
lw $s0, 0($fp)# size
lw $s0, -4($fp)
   # @para int row
lw $s1, 4($fp)# row
lw $s1, -8($fp)
   # @para int col
lw $s2, 8($fp)# col
lw $s2, -12($fp)
   # #0 = row SUB 1
lw $s3, 12($fp)# #0
addi $s3, $s1, -1
   # #1 = #0 MUL size
lw $s4, 16($fp)# #1
mul $s4, $s3, $s0
   # #0 = col SUB 1
addi $s3, $s2, -1
   # #2 = #1 ADD #0
lw $s5, 20($fp)# #2
add $s5, $s4, $s3
   # @ret #2
sw $s0, 0($fp)
sw $s1, 4($fp)
sw $s2, 8($fp)
sw $s3, 12($fp)
sw $s4, 16($fp)
sw $s5, 20($fp)
lw $s6, 20($fp)# #2
move $v0, $s6
jr $ra
nop
   # @func zigzag
sw $s6, 20($fp)
zigzag_E:
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
lw $s7, 0($fp)# a
move $s7, $v0
   # zigzag_L_0_while_begin :
sw $s7, 0($fp)
zigzag_L_0_while_begin:
   # #0 = a GE 10
lw $s0, 124($fp)# #0
lw $s1, 0($fp)# a
li $t9, 10
sge $s0, $s1, $t9
   # @bz #0 zigzag_L_1_while_over
sw $s0, 124($fp)
sw $s1, 0($fp)
lw $s2, 124($fp)# #0
beq $s2, $0, zigzag_L_1_while_over
nop
   # @printf string S_5
li $v0, 4
la $a0, S_5
syscall
   # @scanf int a
li $v0, 5
syscall
lw $s3, 0($fp)# a
move $s3, $v0
   # @j zigzag_L_0_while_begin
sw $s2, 124($fp)
sw $s3, 0($fp)
j zigzag_L_0_while_begin
nop
   # zigzag_L_1_while_over :
zigzag_L_1_while_over:
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # i = 0
lw $s4, 4($fp)# i
li $s4, 0
   # zigzag_L_2_while_begin :
sw $s4, 4($fp)
zigzag_L_2_while_begin:
   # #0 = a MUL a
lw $s5, 124($fp)# #0
lw $s6, 0($fp)# a
mul $s5, $s6, $s6
   # #1 = i LT #0
lw $s7, 128($fp)# #1
lw $s0, 4($fp)# i
slt $s7, $s0, $s5
   # @bz #1 zigzag_L_3_while_over
sw $s0, 4($fp)
sw $s5, 124($fp)
sw $s6, 0($fp)
sw $s7, 128($fp)
lw $s1, 128($fp)# #1
beq $s1, $0, zigzag_L_3_while_over
nop
   # @scanf char temp
li $v0, 12
syscall
lb $s2, 8($fp)# temp
move $s2, $v0
   # matrix = i ARSET temp
lw $s3, 4($fp)# i
add $t1, $s3, $fp
addi $t1, $t1, 16
sb $s2, ($t1)
   # i = i ADD 1
addi $s3, $s3, 1
   # #0 = i DIV a
lw $s4, 124($fp)# #0
lw $s5, 0($fp)# a
div $s4, $s3, $s5
   # #1 = #0 MUL a
mul $s1, $s4, $s5
   # #0 = #1 EQ i
seq $s4, $s1, $s3
   # @bz #0 zigzag_L_4_else_begin
sw $s1, 128($fp)
sb $s2, 8($fp)
sw $s3, 4($fp)
sw $s4, 124($fp)
sw $s5, 0($fp)
lw $s6, 124($fp)# #0
beq $s6, $0, zigzag_L_4_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j zigzag_L_5_else_over
sw $s6, 124($fp)
j zigzag_L_5_else_over
nop
   # zigzag_L_4_else_begin :
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
lw $s7, 116($fp)# row
li $s7, 1
   # @push a
   # @push 1
   # @push 1
   # @call get_index
li $t0, 1
sw $t0, 132($fp)
li $t0, 1
sw $t0, 136($fp)
lw $s0, 0($fp)# a
sw $s0, 140($fp)
sw $s0, 0($fp)
sw $s7, 116($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 144
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #0
lw $s1, 124($fp)# #0
move $s1, $v0
   # #1 = matrix ARGET #0
lw $s2, 128($fp)# #1
add $t1, $s1, $fp
addi $t1, $t1, 16
lb $s2, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s2
syscall
   # col = 1
lw $s3, 120($fp)# col
li $s3, 1
   # zigzag_L_6_while_begin :
sw $s1, 124($fp)
sw $s2, 128($fp)
sw $s3, 120($fp)
zigzag_L_6_while_begin:
   # #0 = row MUL col
lw $s4, 124($fp)# #0
lw $s5, 116($fp)# row
lw $s6, 120($fp)# col
mul $s4, $s5, $s6
   # #1 = a MUL a
lw $s7, 128($fp)# #1
lw $s0, 0($fp)# a
mul $s7, $s0, $s0
   # #2 = #0 NE #1
lw $s1, 132($fp)# #2
sne $s1, $s4, $s7
   # @bz #2 zigzag_L_7_while_over
sw $s0, 0($fp)
sw $s1, 132($fp)
sw $s4, 124($fp)
sw $s5, 116($fp)
sw $s6, 120($fp)
sw $s7, 128($fp)
lw $s2, 132($fp)# #2
beq $s2, $0, zigzag_L_7_while_over
nop
   # #0 = col EQ a
lw $s3, 124($fp)# #0
lw $s4, 120($fp)# col
lw $s5, 0($fp)# a
seq $s3, $s4, $s5
   # @bz #0 zigzag_L_8_else_begin
sw $s2, 132($fp)
sw $s3, 124($fp)
sw $s4, 120($fp)
sw $s5, 0($fp)
lw $s6, 124($fp)# #0
beq $s6, $0, zigzag_L_8_else_begin
nop
   # row = row ADD 1
lw $s7, 116($fp)# row
addi $s7, $s7, 1
   # @j zigzag_L_9_else_over
sw $s6, 124($fp)
sw $s7, 116($fp)
j zigzag_L_9_else_over
nop
   # zigzag_L_8_else_begin :
zigzag_L_8_else_begin:
   # col = col ADD 1
lw $s0, 120($fp)# col
addi $s0, $s0, 1
   # zigzag_L_9_else_over :
sw $s0, 120($fp)
zigzag_L_9_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
lw $s1, 120($fp)# col
sw $s1, 136($fp)
lw $s2, 116($fp)# row
sw $s2, 140($fp)
lw $s3, 0($fp)# a
sw $s3, 144($fp)
sw $s1, 120($fp)
sw $s2, 116($fp)
sw $s3, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 148
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #0
lw $s4, 124($fp)# #0
move $s4, $v0
   # #1 = matrix ARGET #0
lw $s5, 128($fp)# #1
add $t1, $s4, $fp
addi $t1, $t1, 16
lb $s5, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s5
syscall
   # i = 0
lw $s6, 4($fp)# i
li $s6, 0
   # tempi = col SUB row
lw $s7, 12($fp)# tempi
lw $s0, 120($fp)# col
lw $s1, 116($fp)# row
sub $s7, $s0, $s1
   # zigzag_L_10_while_begin :
sw $s0, 120($fp)
sw $s1, 116($fp)
sw $s4, 124($fp)
sw $s5, 128($fp)
sw $s6, 4($fp)
sw $s7, 12($fp)
zigzag_L_10_while_begin:
   # #0 = i LT tempi
lw $s2, 124($fp)# #0
lw $s3, 4($fp)# i
lw $s4, 12($fp)# tempi
slt $s2, $s3, $s4
   # @bz #0 zigzag_L_11_while_over
sw $s2, 124($fp)
sw $s3, 4($fp)
sw $s4, 12($fp)
lw $s5, 124($fp)# #0
beq $s5, $0, zigzag_L_11_while_over
nop
   # i = i ADD 1
lw $s6, 4($fp)# i
addi $s6, $s6, 1
   # col = col SUB 1
lw $s7, 120($fp)# col
addi $s7, $s7, -1
   # row = row ADD 1
lw $s0, 116($fp)# row
addi $s0, $s0, 1
   # @push a
   # @push row
   # @push col
   # @call get_index
sw $s7, 136($fp)
sw $s0, 140($fp)
lw $s1, 0($fp)# a
sw $s1, 144($fp)
sw $s0, 116($fp)
sw $s1, 0($fp)
sw $s5, 124($fp)
sw $s6, 4($fp)
sw $s7, 120($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 148
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #0
lw $s2, 124($fp)# #0
move $s2, $v0
   # #1 = matrix ARGET #0
lw $s3, 128($fp)# #1
add $t1, $s2, $fp
addi $t1, $t1, 16
lb $s3, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s3
syscall
   # @j zigzag_L_10_while_begin
sw $s2, 124($fp)
sw $s3, 128($fp)
j zigzag_L_10_while_begin
nop
   # zigzag_L_11_while_over :
zigzag_L_11_while_over:
   # #0 = row EQ a
lw $s4, 124($fp)# #0
lw $s5, 116($fp)# row
lw $s6, 0($fp)# a
seq $s4, $s5, $s6
   # @bz #0 zigzag_L_12_else_begin
sw $s4, 124($fp)
sw $s5, 116($fp)
sw $s6, 0($fp)
lw $s7, 124($fp)# #0
beq $s7, $0, zigzag_L_12_else_begin
nop
   # col = col ADD 1
lw $s0, 120($fp)# col
addi $s0, $s0, 1
   # @j zigzag_L_13_else_over
sw $s0, 120($fp)
sw $s7, 124($fp)
j zigzag_L_13_else_over
nop
   # zigzag_L_12_else_begin :
zigzag_L_12_else_begin:
   # row = row ADD 1
lw $s1, 116($fp)# row
addi $s1, $s1, 1
   # zigzag_L_13_else_over :
sw $s1, 116($fp)
zigzag_L_13_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
lw $s2, 120($fp)# col
sw $s2, 136($fp)
lw $s3, 116($fp)# row
sw $s3, 140($fp)
lw $s4, 0($fp)# a
sw $s4, 144($fp)
sw $s2, 120($fp)
sw $s3, 116($fp)
sw $s4, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 148
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #0
lw $s5, 124($fp)# #0
move $s5, $v0
   # #1 = matrix ARGET #0
lw $s6, 128($fp)# #1
add $t1, $s5, $fp
addi $t1, $t1, 16
lb $s6, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s6
syscall
   # i = 0
lw $s7, 4($fp)# i
li $s7, 0
   # #0 = 0 SUB col
lw $s0, 120($fp)# col
sub $s5, $0, $s0
   # tempi = #0 ADD row
lw $s1, 12($fp)# tempi
lw $s2, 116($fp)# row
add $s1, $s5, $s2
   # zigzag_L_14_while_begin :
sw $s0, 120($fp)
sw $s1, 12($fp)
sw $s2, 116($fp)
sw $s5, 124($fp)
sw $s6, 128($fp)
sw $s7, 4($fp)
zigzag_L_14_while_begin:
   # #0 = i LT tempi
lw $s3, 124($fp)# #0
lw $s4, 4($fp)# i
lw $s5, 12($fp)# tempi
slt $s3, $s4, $s5
   # @bz #0 zigzag_L_15_while_over
sw $s3, 124($fp)
sw $s4, 4($fp)
sw $s5, 12($fp)
lw $s6, 124($fp)# #0
beq $s6, $0, zigzag_L_15_while_over
nop
   # i = i ADD 1
lw $s7, 4($fp)# i
addi $s7, $s7, 1
   # row = row SUB 1
lw $s0, 116($fp)# row
addi $s0, $s0, -1
   # col = col ADD 1
lw $s1, 120($fp)# col
addi $s1, $s1, 1
   # @push a
   # @push row
   # @push col
   # @call get_index
sw $s1, 136($fp)
sw $s0, 140($fp)
lw $s2, 0($fp)# a
sw $s2, 144($fp)
sw $s0, 116($fp)
sw $s1, 120($fp)
sw $s2, 0($fp)
sw $s6, 124($fp)
sw $s7, 4($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 148
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #0
lw $s3, 124($fp)# #0
move $s3, $v0
   # #1 = matrix ARGET #0
lw $s4, 128($fp)# #1
add $t1, $s3, $fp
addi $t1, $t1, 16
lb $s4, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s4
syscall
   # @j zigzag_L_14_while_begin
sw $s3, 124($fp)
sw $s4, 128($fp)
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
lw $s5, 0($fp)# n
move $s5, $v0
   # fluctuations_L_0_while_begin :
sw $s5, 0($fp)
fluctuations_L_0_while_begin:
   # #0 = n LE 1
lw $s6, 32($fp)# #0
lw $s7, 0($fp)# n
li $t9, 1
sle $s6, $s7, $t9
   # @bz #0 fluctuations_L_1_while_over
sw $s6, 32($fp)
sw $s7, 0($fp)
lw $s0, 32($fp)# #0
beq $s0, $0, fluctuations_L_1_while_over
nop
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
lw $s1, 0($fp)# n
move $s1, $v0
   # @j fluctuations_L_0_while_begin
sw $s0, 32($fp)
sw $s1, 0($fp)
j fluctuations_L_0_while_begin
nop
   # fluctuations_L_1_while_over :
fluctuations_L_1_while_over:
   # a = 0
lw $s2, 4($fp)# a
li $s2, 0
   # b = 0
lw $s3, 8($fp)# b
li $s3, 0
   # max_sub = #0
lw $s4, 32($fp)# #0
lw $s5, 24($fp)# max_sub
move $s5, $s4
   # i = 0
lw $s6, 28($fp)# i
li $s6, 0
   # fluctuations_L_2_while_begin :
sw $s2, 4($fp)
sw $s3, 8($fp)
sw $s4, 32($fp)
sw $s5, 24($fp)
sw $s6, 28($fp)
fluctuations_L_2_while_begin:
   # #0 = 0 SUB i
lw $s7, 32($fp)# #0
lw $s0, 28($fp)# i
sub $s7, $0, $s0
   # #1 = 0 SUB #0
lw $s1, 36($fp)# #1
sub $s1, $0, $s7
   # #0 = 0 SUB #1
sub $s7, $0, $s1
   # #1 = 0 SUB #0
sub $s1, $0, $s7
   # #0 = #1 LT n
lw $s2, 0($fp)# n
slt $s7, $s1, $s2
   # @bz #0 fluctuations_L_3_while_over
sw $s0, 28($fp)
sw $s1, 36($fp)
sw $s2, 0($fp)
sw $s7, 32($fp)
lw $s3, 32($fp)# #0
beq $s3, $0, fluctuations_L_3_while_over
nop
   # @scanf int a
li $v0, 5
syscall
lw $s4, 4($fp)# a
move $s4, $v0
   # sub = a SUB b
lw $s5, 20($fp)# sub
lw $s6, 8($fp)# b
sub $s5, $s4, $s6
   # @printf string S_10
li $v0, 4
la $a0, S_10
syscall
   # @printf int sub
li $v0, 1
move $a0, $s5
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #1 = sub LE 0
lw $s7, 36($fp)# #1
li $t9, 0
sle $s7, $s5, $t9
   # @bz #1 fluctuations_L_4_else_begin
sw $s3, 32($fp)
sw $s4, 4($fp)
sw $s5, 20($fp)
sw $s6, 8($fp)
sw $s7, 36($fp)
lw $s0, 36($fp)# #1
beq $s0, $0, fluctuations_L_4_else_begin
nop
   # sub = 0 SUB sub
lw $s1, 20($fp)# sub
sub $s1, $0, $s1
   # @j fluctuations_L_5_else_over
sw $s0, 36($fp)
sw $s1, 20($fp)
j fluctuations_L_5_else_over
nop
   # fluctuations_L_4_else_begin :
fluctuations_L_4_else_begin:
   # fluctuations_L_5_else_over :
fluctuations_L_5_else_over:
   # #0 = sub GT max_sub
lw $s2, 32($fp)# #0
lw $s3, 20($fp)# sub
lw $s4, 24($fp)# max_sub
sgt $s2, $s3, $s4
   # @bz #0 fluctuations_L_6_else_begin
sw $s2, 32($fp)
sw $s3, 20($fp)
sw $s4, 24($fp)
lw $s5, 32($fp)# #0
beq $s5, $0, fluctuations_L_6_else_begin
nop
   # ra = a
lw $s6, 4($fp)# a
lw $s7, 12($fp)# ra
move $s7, $s6
   # rb = b
lw $s0, 8($fp)# b
lw $s1, 16($fp)# rb
move $s1, $s0
   # max_sub = sub
lw $s2, 20($fp)# sub
lw $s3, 24($fp)# max_sub
move $s3, $s2
   # @j fluctuations_L_7_else_over
sw $s0, 8($fp)
sw $s1, 16($fp)
sw $s2, 20($fp)
sw $s3, 24($fp)
sw $s5, 32($fp)
sw $s6, 4($fp)
sw $s7, 12($fp)
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
lw $s4, 24($fp)# max_sub
move $a0, $s4
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # b = a
lw $s5, 4($fp)# a
lw $s6, 8($fp)# b
move $s6, $s5
   # i = i ADD 1
lw $s7, 28($fp)# i
addi $s7, $s7, 1
   # @j fluctuations_L_2_while_begin
sw $s4, 24($fp)
sw $s5, 4($fp)
sw $s6, 8($fp)
sw $s7, 28($fp)
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
lw $s0, 24($fp)# max_sub
move $a0, $s0
syscall
   # @printf string S_13
li $v0, 4
la $a0, S_13
syscall
   # @printf int ra
li $v0, 1
lw $s1, 12($fp)# ra
move $a0, $s1
syscall
   # @printf string S_14
li $v0, 4
la $a0, S_14
syscall
   # @printf int rb
li $v0, 1
lw $s2, 16($fp)# rb
move $a0, $s2
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @ret
sw $s0, 24($fp)
sw $s1, 12($fp)
sw $s2, 16($fp)
jr $ra
nop
   # @func fibonacci
fibonacci_E:
   # @var int a
   # @var int b
   # @var int sum
   # @var int n
   # @var int i
   # a = 1
lw $s3, 0($fp)# a
li $s3, 1
   # @printf string S_15
li $v0, 4
la $a0, S_15
syscall
   # b = 1
lw $s4, 4($fp)# b
li $s4, 1
   # @scanf int n
li $v0, 5
syscall
lw $s5, 12($fp)# n
move $s5, $v0
   # #0 = n LE 0
lw $s6, 20($fp)# #0
li $t9, 0
sle $s6, $s5, $t9
   # @bz #0 fibonacci_L_0_else_begin
sw $s3, 0($fp)
sw $s4, 4($fp)
sw $s5, 12($fp)
sw $s6, 20($fp)
lw $s7, 20($fp)# #0
beq $s7, $0, fibonacci_L_0_else_begin
nop
   # @printf string S_16
li $v0, 4
la $a0, S_16
syscall
   # @ret
sw $s7, 20($fp)
jr $ra
nop
   # fibonacci_L_0_else_begin :
fibonacci_L_0_else_begin:
   # fibonacci_L_1_else_over :
fibonacci_L_1_else_over:
   # @printf int a
li $v0, 1
lw $s0, 0($fp)# a
move $a0, $s0
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 1
lw $s1, 20($fp)# #0
lw $s2, 12($fp)# n
li $t9, 1
sle $s1, $s2, $t9
   # @bz #0 fibonacci_L_2_else_begin
sw $s0, 0($fp)
sw $s1, 20($fp)
sw $s2, 12($fp)
lw $s3, 20($fp)# #0
beq $s3, $0, fibonacci_L_2_else_begin
nop
   # @ret
sw $s3, 20($fp)
jr $ra
nop
   # fibonacci_L_2_else_begin :
fibonacci_L_2_else_begin:
   # fibonacci_L_3_else_over :
fibonacci_L_3_else_over:
   # @printf int b
li $v0, 1
lw $s4, 4($fp)# b
move $a0, $s4
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 2
lw $s5, 20($fp)# #0
lw $s6, 12($fp)# n
li $t9, 2
sle $s5, $s6, $t9
   # @bz #0 fibonacci_L_4_else_begin
sw $s4, 4($fp)
sw $s5, 20($fp)
sw $s6, 12($fp)
lw $s7, 20($fp)# #0
beq $s7, $0, fibonacci_L_4_else_begin
nop
   # @ret
sw $s7, 20($fp)
jr $ra
nop
   # fibonacci_L_4_else_begin :
fibonacci_L_4_else_begin:
   # fibonacci_L_5_else_over :
fibonacci_L_5_else_over:
   # i = 3
lw $s0, 16($fp)# i
li $s0, 3
   # fibonacci_L_6_while_begin :
sw $s0, 16($fp)
fibonacci_L_6_while_begin:
   # #0 = i LE n
lw $s1, 20($fp)# #0
lw $s2, 16($fp)# i
lw $s3, 12($fp)# n
sle $s1, $s2, $s3
   # @bz #0 fibonacci_L_7_while_over
sw $s1, 20($fp)
sw $s2, 16($fp)
sw $s3, 12($fp)
lw $s4, 20($fp)# #0
beq $s4, $0, fibonacci_L_7_while_over
nop
   # sum = a ADD b
lw $s5, 8($fp)# sum
lw $s6, 0($fp)# a
lw $s7, 4($fp)# b
add $s5, $s6, $s7
   # b = a
move $s7, $s6
   # @printf int sum
li $v0, 1
move $a0, $s5
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n DIV 10
lw $s0, 12($fp)# n
div $s4, $s0, 10
   # #1 = #0 MUL 10
lw $s1, 24($fp)# #1
mul $s1, $s4, 10
   # #0 = i ADD 1
lw $s2, 16($fp)# i
addi $s4, $s2, 1
   # #2 = #1 EQ #0
lw $s3, 28($fp)# #2
seq $s3, $s1, $s4
   # a = sum
move $s6, $s5
   # @bz #2 fibonacci_L_8_else_begin
sw $s0, 12($fp)
sw $s1, 24($fp)
sw $s2, 16($fp)
sw $s3, 28($fp)
sw $s4, 20($fp)
sw $s5, 8($fp)
sw $s6, 0($fp)
sw $s7, 4($fp)
lw $s4, 28($fp)# #2
beq $s4, $0, fibonacci_L_8_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j fibonacci_L_9_else_over
sw $s4, 28($fp)
j fibonacci_L_9_else_over
nop
   # fibonacci_L_8_else_begin :
fibonacci_L_8_else_begin:
   # fibonacci_L_9_else_over :
fibonacci_L_9_else_over:
   # i = i ADD 1
lw $s5, 16($fp)# i
addi $s5, $s5, 1
   # @j fibonacci_L_6_while_begin
sw $s5, 16($fp)
j fibonacci_L_6_while_begin
nop
   # fibonacci_L_7_while_over :
fibonacci_L_7_while_over:
   # @ret
jr $ra
nop
   # @func sort
sort_E:
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
lw $s6, 400($fp)# size
move $s6, $v0
   # sort_L_0_while_begin :
sw $s6, 400($fp)
sort_L_0_while_begin:
   # #0 = size GE 100
lw $s7, 416($fp)# #0
lw $s0, 400($fp)# size
li $t9, 100
sge $s7, $s0, $t9
   # @bz #0 sort_L_1_while_over
sw $s0, 400($fp)
sw $s7, 416($fp)
lw $s1, 416($fp)# #0
beq $s1, $0, sort_L_1_while_over
nop
   # @printf string S_19
li $v0, 4
la $a0, S_19
syscall
   # @scanf int size
li $v0, 5
syscall
lw $s2, 400($fp)# size
move $s2, $v0
   # @j sort_L_0_while_begin
sw $s1, 416($fp)
sw $s2, 400($fp)
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
lw $s3, 400($fp)# size
move $a0, $s3
syscall
   # @printf string S_21
li $v0, 4
la $a0, S_21
syscall
   # i = 0
lw $s4, 404($fp)# i
li $s4, 0
   # sort_L_2_while_begin :
sw $s3, 400($fp)
sw $s4, 404($fp)
sort_L_2_while_begin:
   # #0 = i LT size
lw $s5, 416($fp)# #0
lw $s6, 404($fp)# i
lw $s7, 400($fp)# size
slt $s5, $s6, $s7
   # @bz #0 sort_L_3_while_over
sw $s5, 416($fp)
sw $s6, 404($fp)
sw $s7, 400($fp)
lw $s0, 416($fp)# #0
beq $s0, $0, sort_L_3_while_over
nop
   # @scanf int temp
li $v0, 5
syscall
lw $s1, 412($fp)# temp
move $s1, $v0
   # a = i ARSET temp
lw $s2, 404($fp)# i
sll $t1, $s2, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s1, ($t1)
   # @printf string S_22
li $v0, 4
la $a0, S_22
syscall
   # #0 = a ARGET i
sll $t1, $s2, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s0, ($t1)
   # @printf int #0
li $v0, 1
move $a0, $s0
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # i = i ADD 1
addi $s2, $s2, 1
   # @j sort_L_2_while_begin
sw $s0, 416($fp)
sw $s1, 412($fp)
sw $s2, 404($fp)
j sort_L_2_while_begin
nop
   # sort_L_3_while_over :
sort_L_3_while_over:
   # i = 0
lw $s3, 404($fp)# i
li $s3, 0
   # sort_L_4_while_begin :
sw $s3, 404($fp)
sort_L_4_while_begin:
   # #0 = size SUB 1
lw $s4, 416($fp)# #0
lw $s5, 400($fp)# size
addi $s4, $s5, -1
   # #1 = i LT #0
lw $s6, 420($fp)# #1
lw $s7, 404($fp)# i
slt $s6, $s7, $s4
   # @bz #1 sort_L_5_while_over
sw $s4, 416($fp)
sw $s5, 400($fp)
sw $s6, 420($fp)
sw $s7, 404($fp)
lw $s0, 420($fp)# #1
beq $s0, $0, sort_L_5_while_over
nop
   # j = 0
lw $s1, 408($fp)# j
li $s1, 0
   # sort_L_6_while_begin :
sw $s0, 420($fp)
sw $s1, 408($fp)
sort_L_6_while_begin:
   # #0 = size SUB 1
lw $s2, 416($fp)# #0
lw $s3, 400($fp)# size
addi $s2, $s3, -1
   # #1 = #0 SUB i
lw $s4, 420($fp)# #1
lw $s5, 404($fp)# i
sub $s4, $s2, $s5
   # #0 = j LT #1
lw $s6, 408($fp)# j
slt $s2, $s6, $s4
   # @bz #0 sort_L_7_while_over
sw $s2, 416($fp)
sw $s3, 400($fp)
sw $s4, 420($fp)
sw $s5, 404($fp)
sw $s6, 408($fp)
lw $s7, 416($fp)# #0
beq $s7, $0, sort_L_7_while_over
nop
   # #1 = a ARGET j
lw $s0, 420($fp)# #1
lw $s1, 408($fp)# j
sll $t1, $s1, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s0, ($t1)
   # #0 = j ADD 1
addi $s7, $s1, 1
   # #2 = a ARGET #0
lw $s2, 424($fp)# #2
sll $t1, $s7, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s2, ($t1)
   # #3 = #1 GT #2
lw $s3, 428($fp)# #3
sgt $s3, $s0, $s2
   # @bz #3 sort_L_8_else_begin
sw $s0, 420($fp)
sw $s1, 408($fp)
sw $s2, 424($fp)
sw $s3, 428($fp)
sw $s7, 416($fp)
lw $s4, 428($fp)# #3
beq $s4, $0, sort_L_8_else_begin
nop
   # @printf string S_23
li $v0, 4
la $a0, S_23
syscall
   # @printf int #1
li $v0, 1
lw $s5, 420($fp)# #1
move $a0, $s5
syscall
   # @printf string S_24
li $v0, 4
la $a0, S_24
syscall
   # @printf int #2
li $v0, 1
lw $s6, 424($fp)# #2
move $a0, $s6
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # a = j ARSET #2
lw $s7, 408($fp)# j
sll $t1, $s7, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s6, ($t1)
   # a = #0 ARSET #1
lw $s0, 416($fp)# #0
sll $t1, $s0, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s5, ($t1)
   # temp = #3
lw $s1, 412($fp)# temp
move $s1, $s4
   # @j sort_L_9_else_over
sw $s0, 416($fp)
sw $s1, 412($fp)
sw $s4, 428($fp)
sw $s5, 420($fp)
sw $s6, 424($fp)
sw $s7, 408($fp)
j sort_L_9_else_over
nop
   # sort_L_8_else_begin :
sort_L_8_else_begin:
   # sort_L_9_else_over :
sort_L_9_else_over:
   # j = j ADD 1
lw $s2, 408($fp)# j
addi $s2, $s2, 1
   # @j sort_L_6_while_begin
sw $s2, 408($fp)
j sort_L_6_while_begin
nop
   # sort_L_7_while_over :
sort_L_7_while_over:
   # i = i ADD 1
lw $s3, 404($fp)# i
addi $s3, $s3, 1
   # @j sort_L_4_while_begin
sw $s3, 404($fp)
j sort_L_4_while_begin
nop
   # sort_L_5_while_over :
sort_L_5_while_over:
   # @printf string S_25
li $v0, 4
la $a0, S_25
syscall
   # #0 = a ARGET 2
lw $s4, 416($fp)# #0
lw $s4, 8($fp)
   # @printf int #0
li $v0, 1
move $a0, $s4
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
lw $s5, 404($fp)# i
li $s5, 0
   # sort_L_10_while_begin :
sw $s4, 416($fp)
sw $s5, 404($fp)
sort_L_10_while_begin:
   # #0 = i LT size
lw $s6, 416($fp)# #0
lw $s7, 404($fp)# i
lw $s0, 400($fp)# size
slt $s6, $s7, $s0
   # @bz #0 sort_L_11_while_over
sw $s0, 400($fp)
sw $s6, 416($fp)
sw $s7, 404($fp)
lw $s1, 416($fp)# #0
beq $s1, $0, sort_L_11_while_over
nop
   # i = i ADD 1
lw $s2, 404($fp)# i
addi $s2, $s2, 1
   # @printf string S_27
li $v0, 4
la $a0, S_27
syscall
   # #0 = i SUB 1
addi $s1, $s2, -1
   # @printf int #0
li $v0, 1
move $a0, $s1
syscall
   # @printf string S_28
li $v0, 4
la $a0, S_28
syscall
   # #1 = a ARGET #0
lw $s3, 420($fp)# #1
sll $t1, $s1, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s3, ($t1)
   # @printf int #1
li $v0, 1
move $a0, $s3
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = i ADD 1
addi $s1, $s2, 1
   # #1 = #0 DIV 10
div $s3, $s1, 10
   # #2 = #1 MUL 10
lw $s4, 424($fp)# #2
mul $s4, $s3, 10
   # #1 = #2 EQ #0
seq $s3, $s4, $s1
   # @bz #1 sort_L_12_else_begin
sw $s1, 416($fp)
sw $s2, 404($fp)
sw $s3, 420($fp)
sw $s4, 424($fp)
lw $s5, 420($fp)# #1
beq $s5, $0, sort_L_12_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j sort_L_13_else_over
sw $s5, 420($fp)
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
lw $s6, 0($fp)# i
move $s6, $v0
   # #0 = i DIV 1
lw $s7, 8($fp)# #0
div $s7, $s6, 1
   # #1 = #0 MUL 1
lw $s0, 12($fp)# #1
mul $s0, $s7, 1
   # @be #1 0 select_L_3_case
sw $s0, 12($fp)
sw $s6, 0($fp)
sw $s7, 8($fp)
lw $s1, 12($fp)# #1
beq $s1, 0, select_L_3_case
nop
   # @be #1 1 select_L_4_case
sw $s1, 12($fp)
lw $s2, 12($fp)# #1
beq $s2, 1, select_L_4_case
nop
   # @be #1 2 select_L_5_case
sw $s2, 12($fp)
lw $s3, 12($fp)# #1
beq $s3, 2, select_L_5_case
nop
   # @be #1 3 select_L_6_case
sw $s3, 12($fp)
lw $s4, 12($fp)# #1
beq $s4, 3, select_L_6_case
nop
   # @be #1 4 select_L_7_case
sw $s4, 12($fp)
lw $s5, 12($fp)# #1
beq $s5, 4, select_L_7_case
nop
   # @be #1 5 select_L_8_case
sw $s5, 12($fp)
lw $s6, 12($fp)# #1
beq $s6, 5, select_L_8_case
nop
   # @j select_L_9_default
sw $s6, 12($fp)
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
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal sort_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_5_case :
select_L_5_case:
   # @call fibonacci
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal fibonacci_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_6_case :
select_L_6_case:
   # @call fluctuations
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal fluctuations_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_7_case :
select_L_7_case:
   # @call zigzag
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal zigzag_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
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
lw $s7, 4($fp)# num
move $s7, $v0
   # @push 0
   # @push 99
   # @push num
   # @call find
sw $s7, 16($fp)
li $t0, 99
sw $t0, 20($fp)
li $t0, 0
sw $t0, 24($fp)
sw $s7, 4($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 28
jal find_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j select_L_2_switch_over
j select_L_2_switch_over
nop
   # select_L_9_default :
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
lw $s0, 8($fp)# #0
lw $s1, 0($fp)# i
li $t9, 0
seq $s0, $s1, $t9
   # @bz #0 select_L_10_else_begin
sw $s0, 8($fp)
sw $s1, 0($fp)
lw $s2, 8($fp)# #0
beq $s2, $0, select_L_10_else_begin
nop
   # @printf string S_38
li $v0, 4
la $a0, S_38
syscall
   # @ret
sw $s2, 8($fp)
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
