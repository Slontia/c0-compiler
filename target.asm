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
li $t0, 100
slt $s1, $s2, $t0
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
   # #1 = a
lw $s5, 8($fp)# #1
move $s5, $s4
   # #2 = #1 ADD 1
lw $s6, 12($fp)# #2
addi $s6, $s5, 1
   # a = #2
move $s4, $s6
   # @j init_array_L_0_while_begin
sw $s3, 4($fp)
sw $s4, 0($fp)
sw $s5, 8($fp)
sw $s6, 12($fp)
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
lw $s7, 0($fp)# begin
lw $s7, -4($fp)
   # @para int end
lw $s0, 4($fp)# end
lw $s0, -8($fp)
   # @para int num
lw $s1, 8($fp)# num
lw $s1, -12($fp)
   # @var int mid
   # #0 = begin EQ end
lw $s2, 16($fp)# #0
seq $s2, $s7, $s0
   # @bz #0 find_L_0_else_begin
sw $s0, 4($fp)
sw $s1, 8($fp)
sw $s2, 16($fp)
sw $s7, 0($fp)
lw $s3, 16($fp)# #0
beq $s3, $0, find_L_0_else_begin
nop
   # #2 = find_array ARGET begin
lw $s4, 24($fp)# #2
lw $s5, 0($fp)# begin
sll $t1, $s5, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s4, ($t1)
   # #1 = #2 EQ num
lw $s6, 20($fp)# #1
lw $s7, 8($fp)# num
seq $s6, $s4, $s7
   # @bz #1 find_L_2_else_begin
sw $s3, 16($fp)
sw $s4, 24($fp)
sw $s5, 0($fp)
sw $s6, 20($fp)
sw $s7, 8($fp)
lw $s0, 20($fp)# #1
beq $s0, $0, find_L_2_else_begin
nop
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int begin
li $v0, 1
lw $s1, 0($fp)# begin
move $a0, $s1
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_3_else_over
sw $s0, 20($fp)
sw $s1, 0($fp)
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
   # @j find_L_1_else_over
j find_L_1_else_over
nop
   # find_L_0_else_begin :
find_L_0_else_begin:
   # find_L_1_else_over :
find_L_1_else_over:
   # #1 = begin ADD end
lw $s2, 20($fp)# #1
lw $s3, 0($fp)# begin
lw $s4, 4($fp)# end
add $s2, $s3, $s4
   # #2 = #1 DIV 2
lw $s5, 24($fp)# #2
div $s5, $s2, 2
   # #3 = find_array ARGET #2
lw $s6, 28($fp)# #3
sll $t1, $s5, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s6, ($t1)
   # #0 = #3 LT num
lw $s7, 16($fp)# #0
lw $s0, 8($fp)# num
slt $s7, $s6, $s0
   # mid = #2
lw $s1, 12($fp)# mid
move $s1, $s5
   # @bz #0 find_L_4_else_begin
sw $s0, 8($fp)
sw $s1, 12($fp)
sw $s2, 20($fp)
sw $s3, 0($fp)
sw $s4, 4($fp)
sw $s5, 24($fp)
sw $s6, 28($fp)
sw $s7, 16($fp)
lw $s2, 16($fp)# #0
beq $s2, $0, find_L_4_else_begin
nop
   # #4 = mid ADD 1
lw $s3, 32($fp)# #4
lw $s4, 12($fp)# mid
addi $s3, $s4, 1
   # @push #4
   # @push end
   # @push num
   # @call find
lw $s5, 8($fp)# num
sw $s5, 36($fp)
lw $s6, 4($fp)# end
sw $s6, 40($fp)
sw $s3, 44($fp)
sw $s2, 16($fp)
sw $s3, 32($fp)
sw $s4, 12($fp)
sw $s5, 8($fp)
sw $s6, 4($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 48
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
   # #1 = find_array ARGET mid
lw $s7, 20($fp)# #1
lw $s0, 12($fp)# mid
sll $t1, $s0, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s7, ($t1)
   # #0 = #1 GT num
lw $s1, 16($fp)# #0
lw $s2, 8($fp)# num
sgt $s1, $s7, $s2
   # @bz #0 find_L_6_else_begin
sw $s0, 12($fp)
sw $s1, 16($fp)
sw $s2, 8($fp)
sw $s7, 20($fp)
lw $s3, 16($fp)# #0
beq $s3, $0, find_L_6_else_begin
nop
   # @push begin
   # @push mid
   # @push num
   # @call find
lw $s4, 8($fp)# num
sw $s4, 36($fp)
lw $s5, 12($fp)# mid
sw $s5, 40($fp)
lw $s6, 0($fp)# begin
sw $s6, 44($fp)
sw $s3, 16($fp)
sw $s4, 8($fp)
sw $s5, 12($fp)
sw $s6, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 48
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
   # #1 = find_array ARGET mid
lw $s7, 20($fp)# #1
lw $s0, 12($fp)# mid
sll $t1, $s0, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s7, ($t1)
   # #0 = #1 EQ num
lw $s1, 16($fp)# #0
lw $s2, 8($fp)# num
seq $s1, $s7, $s2
   # @bz #0 find_L_8_else_begin
sw $s0, 12($fp)
sw $s1, 16($fp)
sw $s2, 8($fp)
sw $s7, 20($fp)
lw $s3, 16($fp)# #0
beq $s3, $0, find_L_8_else_begin
nop
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int mid
li $v0, 1
lw $s4, 12($fp)# mid
move $a0, $s4
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_9_else_over
sw $s3, 16($fp)
sw $s4, 12($fp)
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
lw $s5, 0($fp)# size
lw $s5, -4($fp)
   # @para int row
lw $s6, 4($fp)# row
lw $s6, -8($fp)
   # @para int col
lw $s7, 8($fp)# col
lw $s7, -12($fp)
   # #1 = row SUB 1
lw $s0, 16($fp)# #1
addi $s0, $s6, -1
   # #2 = #1 MUL size
lw $s1, 20($fp)# #2
mul $s1, $s0, $s5
   # #3 = col SUB 1
lw $s2, 24($fp)# #3
addi $s2, $s7, -1
   # #0 = #2 ADD #3
lw $s3, 12($fp)# #0
add $s3, $s1, $s2
   # @ret #0
sw $s0, 16($fp)
sw $s1, 20($fp)
sw $s2, 24($fp)
sw $s3, 12($fp)
sw $s5, 0($fp)
sw $s6, 4($fp)
sw $s7, 8($fp)
lw $s4, 12($fp)# #0
move $v0, $s4
jr $ra
nop
   # @ret 0
sw $s4, 12($fp)
li $v0, 0
jr $ra
nop
   # @func zigzag
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
lw $s5, 0($fp)# a
move $s5, $v0
   # zigzag_L_0_while_begin :
sw $s5, 0($fp)
zigzag_L_0_while_begin:
   # #0 = a GE 10
lw $s6, 124($fp)# #0
lw $s7, 0($fp)# a
li $t0, 10
sge $s6, $s7, $t0
   # @bz #0 zigzag_L_1_while_over
sw $s6, 124($fp)
sw $s7, 0($fp)
lw $s0, 124($fp)# #0
beq $s0, $0, zigzag_L_1_while_over
nop
   # @printf string S_5
li $v0, 4
la $a0, S_5
syscall
   # #1 = a
lw $s1, 0($fp)# a
lw $s2, 128($fp)# #1
move $s2, $s1
   # @scanf int a
li $v0, 5
syscall
move $s1, $v0
   # @j zigzag_L_0_while_begin
sw $s0, 124($fp)
sw $s1, 0($fp)
sw $s2, 128($fp)
j zigzag_L_0_while_begin
nop
   # zigzag_L_1_while_over :
zigzag_L_1_while_over:
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # i = 0
lw $s3, 4($fp)# i
li $s3, 0
   # zigzag_L_2_while_begin :
sw $s3, 4($fp)
zigzag_L_2_while_begin:
   # #1 = a MUL a
lw $s4, 128($fp)# #1
lw $s5, 0($fp)# a
mul $s4, $s5, $s5
   # #0 = i LT #1
lw $s6, 124($fp)# #0
lw $s7, 4($fp)# i
slt $s6, $s7, $s4
   # @bz #0 zigzag_L_3_while_over
sw $s4, 128($fp)
sw $s5, 0($fp)
sw $s6, 124($fp)
sw $s7, 4($fp)
lw $s0, 124($fp)# #0
beq $s0, $0, zigzag_L_3_while_over
nop
   # @scanf char temp
li $v0, 12
syscall
lb $s1, 8($fp)# temp
move $s1, $v0
   # matrix = i ARSET temp
lw $s2, 4($fp)# i
add $t1, $s2, $fp
addi $t1, $t1, 16
sb $s1, ($t1)
   # #2 = i
lw $s3, 132($fp)# #2
move $s3, $s2
   # #4 = #2 ADD 1
lw $s4, 140($fp)# #4
addi $s4, $s3, 1
   # #5 = #4 DIV a
lw $s5, 144($fp)# #5
lw $s6, 0($fp)# a
div $s5, $s4, $s6
   # #6 = #5 MUL a
lw $s7, 148($fp)# #6
mul $s7, $s5, $s6
   # #3 = #6 EQ #4
sw $s0, 124($fp) # store reg to mem
lw $s0, 136($fp)# #3
seq $s0, $s7, $s4
   # i = #4
move $s2, $s4
   # @bz #3 zigzag_L_4_else_begin
sw $s0, 136($fp)
sb $s1, 8($fp)
sw $s2, 4($fp)
sw $s3, 132($fp)
sw $s4, 140($fp)
sw $s5, 144($fp)
sw $s6, 0($fp)
sw $s7, 148($fp)
lw $s1, 136($fp)# #3
beq $s1, $0, zigzag_L_4_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j zigzag_L_5_else_over
sw $s1, 136($fp)
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
   # @push a
   # @push 1
   # @push 1
   # @call get_index
li $t0, 1
sw $t0, 152($fp)
li $t0, 1
sw $t0, 156($fp)
lw $s2, 0($fp)# a
sw $s2, 160($fp)
sw $s2, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 164
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
   # col = 1
lw $s5, 120($fp)# col
li $s5, 1
   # row = 1
lw $s6, 116($fp)# row
li $s6, 1
   # zigzag_L_6_while_begin :
sw $s3, 124($fp)
sw $s4, 128($fp)
sw $s5, 120($fp)
sw $s6, 116($fp)
zigzag_L_6_while_begin:
   # #1 = row MUL col
lw $s7, 128($fp)# #1
lw $s0, 116($fp)# row
lw $s1, 120($fp)# col
mul $s7, $s0, $s1
   # #2 = a MUL a
lw $s2, 132($fp)# #2
lw $s3, 0($fp)# a
mul $s2, $s3, $s3
   # #0 = #1 NE #2
lw $s4, 124($fp)# #0
sne $s4, $s7, $s2
   # @bz #0 zigzag_L_7_while_over
sw $s0, 116($fp)
sw $s1, 120($fp)
sw $s2, 132($fp)
sw $s3, 0($fp)
sw $s4, 124($fp)
sw $s7, 128($fp)
lw $s5, 124($fp)# #0
beq $s5, $0, zigzag_L_7_while_over
nop
   # #3 = col EQ a
lw $s6, 136($fp)# #3
lw $s7, 120($fp)# col
lw $s0, 0($fp)# a
seq $s6, $s7, $s0
   # @bz #3 zigzag_L_8_else_begin
sw $s0, 0($fp)
sw $s5, 124($fp)
sw $s6, 136($fp)
sw $s7, 120($fp)
lw $s1, 136($fp)# #3
beq $s1, $0, zigzag_L_8_else_begin
nop
   # #4 = row
lw $s2, 116($fp)# row
lw $s3, 140($fp)# #4
move $s3, $s2
   # #5 = #4 ADD 1
lw $s4, 144($fp)# #5
addi $s4, $s3, 1
   # row = #5
move $s2, $s4
   # @j zigzag_L_9_else_over
sw $s1, 136($fp)
sw $s2, 116($fp)
sw $s3, 140($fp)
sw $s4, 144($fp)
j zigzag_L_9_else_over
nop
   # zigzag_L_8_else_begin :
zigzag_L_8_else_begin:
   # #0 = col
lw $s5, 120($fp)# col
lw $s6, 124($fp)# #0
move $s6, $s5
   # #1 = #0 ADD 1
lw $s7, 128($fp)# #1
addi $s7, $s6, 1
   # col = #1
move $s5, $s7
   # zigzag_L_9_else_over :
sw $s5, 120($fp)
sw $s6, 124($fp)
sw $s7, 128($fp)
zigzag_L_9_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
lw $s0, 120($fp)# col
sw $s0, 152($fp)
lw $s1, 116($fp)# row
sw $s1, 156($fp)
lw $s2, 0($fp)# a
sw $s2, 160($fp)
sw $s0, 120($fp)
sw $s1, 116($fp)
sw $s2, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 164
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
   # i = 0
lw $s5, 4($fp)# i
li $s5, 0
   # #2 = col SUB row
lw $s6, 132($fp)# #2
lw $s7, 120($fp)# col
lw $s0, 116($fp)# row
sub $s6, $s7, $s0
   # tempi = #2
lw $s1, 12($fp)# tempi
move $s1, $s6
   # zigzag_L_10_while_begin :
sw $s0, 116($fp)
sw $s1, 12($fp)
sw $s3, 124($fp)
sw $s4, 128($fp)
sw $s5, 4($fp)
sw $s6, 132($fp)
sw $s7, 120($fp)
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
   # @push a
   # #1 = row ADD 1
lw $s6, 128($fp)# #1
lw $s7, 116($fp)# row
addi $s6, $s7, 1
   # @push #1
   # #2 = col SUB 1
lw $s0, 132($fp)# #2
lw $s1, 120($fp)# col
addi $s0, $s1, -1
   # @push #2
   # @call get_index
sw $s0, 152($fp)
sw $s6, 156($fp)
lw $s2, 0($fp)# a
sw $s2, 160($fp)
sw $s0, 132($fp)
sw $s1, 120($fp)
sw $s2, 0($fp)
sw $s5, 124($fp)
sw $s6, 128($fp)
sw $s7, 116($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 164
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #3
lw $s3, 136($fp)# #3
move $s3, $v0
   # #4 = matrix ARGET #3
lw $s4, 140($fp)# #4
add $t1, $s3, $fp
addi $t1, $t1, 16
lb $s4, ($t1)
   # @printf char #4
li $v0, 11
move $a0, $s4
syscall
   # #5 = col
lw $s5, 120($fp)# col
lw $s6, 144($fp)# #5
move $s6, $s5
   # #6 = i
lw $s7, 4($fp)# i
lw $s0, 148($fp)# #6
move $s0, $s7
   # #7 = row
lw $s1, 116($fp)# row
lw $s2, 152($fp)# #7
move $s2, $s1
   # col = #2
sw $s3, 136($fp) # store reg to mem
lw $s3, 132($fp)# #2
move $s5, $s3
   # #8 = #6 ADD 1
sw $s4, 140($fp) # store reg to mem
lw $s4, 156($fp)# #8
addi $s4, $s0, 1
   # i = #8
move $s7, $s4
   # row = #1
sw $s5, 120($fp) # store reg to mem
lw $s5, 128($fp)# #1
move $s1, $s5
   # @j zigzag_L_10_while_begin
sw $s0, 148($fp)
sw $s1, 116($fp)
sw $s2, 152($fp)
sw $s3, 132($fp)
sw $s4, 156($fp)
sw $s5, 128($fp)
sw $s6, 144($fp)
sw $s7, 4($fp)
j zigzag_L_10_while_begin
nop
   # zigzag_L_11_while_over :
zigzag_L_11_while_over:
   # #0 = row EQ a
lw $s6, 124($fp)# #0
lw $s7, 116($fp)# row
lw $s0, 0($fp)# a
seq $s6, $s7, $s0
   # @bz #0 zigzag_L_12_else_begin
sw $s0, 0($fp)
sw $s6, 124($fp)
sw $s7, 116($fp)
lw $s1, 124($fp)# #0
beq $s1, $0, zigzag_L_12_else_begin
nop
   # #1 = col
lw $s2, 120($fp)# col
lw $s3, 128($fp)# #1
move $s3, $s2
   # #2 = #1 ADD 1
lw $s4, 132($fp)# #2
addi $s4, $s3, 1
   # col = #2
move $s2, $s4
   # @j zigzag_L_13_else_over
sw $s1, 124($fp)
sw $s2, 120($fp)
sw $s3, 128($fp)
sw $s4, 132($fp)
j zigzag_L_13_else_over
nop
   # zigzag_L_12_else_begin :
zigzag_L_12_else_begin:
   # #0 = row
lw $s5, 116($fp)# row
lw $s6, 124($fp)# #0
move $s6, $s5
   # #1 = #0 ADD 1
lw $s7, 128($fp)# #1
addi $s7, $s6, 1
   # row = #1
move $s5, $s7
   # zigzag_L_13_else_over :
sw $s5, 116($fp)
sw $s6, 124($fp)
sw $s7, 128($fp)
zigzag_L_13_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
lw $s0, 120($fp)# col
sw $s0, 160($fp)
lw $s1, 116($fp)# row
sw $s1, 164($fp)
lw $s2, 0($fp)# a
sw $s2, 168($fp)
sw $s0, 120($fp)
sw $s1, 116($fp)
sw $s2, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 172
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
   # i = 0
lw $s5, 4($fp)# i
li $s5, 0
   # #2 = 0 SUB col
lw $s6, 132($fp)# #2
lw $s7, 120($fp)# col
sub $s6, $0, $s7
   # #3 = #2 ADD row
lw $s0, 136($fp)# #3
lw $s1, 116($fp)# row
add $s0, $s6, $s1
   # tempi = #3
lw $s2, 12($fp)# tempi
move $s2, $s0
   # zigzag_L_14_while_begin :
sw $s0, 136($fp)
sw $s1, 116($fp)
sw $s2, 12($fp)
sw $s3, 124($fp)
sw $s4, 128($fp)
sw $s5, 4($fp)
sw $s6, 132($fp)
sw $s7, 120($fp)
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
   # @push a
   # #1 = row SUB 1
lw $s7, 128($fp)# #1
lw $s0, 116($fp)# row
addi $s7, $s0, -1
   # @push #1
   # #2 = col ADD 1
lw $s1, 132($fp)# #2
lw $s2, 120($fp)# col
addi $s1, $s2, 1
   # @push #2
   # @call get_index
sw $s1, 160($fp)
sw $s7, 164($fp)
lw $s3, 0($fp)# a
sw $s3, 168($fp)
sw $s0, 116($fp)
sw $s1, 132($fp)
sw $s2, 120($fp)
sw $s3, 0($fp)
sw $s6, 124($fp)
sw $s7, 128($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 172
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #3
lw $s4, 136($fp)# #3
move $s4, $v0
   # #4 = matrix ARGET #3
lw $s5, 140($fp)# #4
add $t1, $s4, $fp
addi $t1, $t1, 16
lb $s5, ($t1)
   # @printf char #4
li $v0, 11
move $a0, $s5
syscall
   # #5 = col
lw $s6, 120($fp)# col
lw $s7, 144($fp)# #5
move $s7, $s6
   # #6 = i
lw $s0, 4($fp)# i
lw $s1, 148($fp)# #6
move $s1, $s0
   # #7 = row
lw $s2, 116($fp)# row
lw $s3, 152($fp)# #7
move $s3, $s2
   # col = #2
sw $s4, 136($fp) # store reg to mem
lw $s4, 132($fp)# #2
move $s6, $s4
   # #8 = #6 ADD 1
sw $s5, 140($fp) # store reg to mem
lw $s5, 156($fp)# #8
addi $s5, $s1, 1
   # i = #8
move $s0, $s5
   # row = #1
sw $s6, 120($fp) # store reg to mem
lw $s6, 128($fp)# #1
move $s2, $s6
   # @j zigzag_L_14_while_begin
sw $s0, 4($fp)
sw $s1, 148($fp)
sw $s2, 116($fp)
sw $s3, 152($fp)
sw $s4, 132($fp)
sw $s5, 156($fp)
sw $s6, 128($fp)
sw $s7, 144($fp)
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
lw $s7, 0($fp)# n
move $s7, $v0
   # fluctuations_L_0_while_begin :
sw $s7, 0($fp)
fluctuations_L_0_while_begin:
   # #0 = n LE 1
lw $s0, 32($fp)# #0
lw $s1, 0($fp)# n
li $t0, 1
sle $s0, $s1, $t0
   # @bz #0 fluctuations_L_1_while_over
sw $s0, 32($fp)
sw $s1, 0($fp)
lw $s2, 32($fp)# #0
beq $s2, $0, fluctuations_L_1_while_over
nop
   # @printf string S_9
li $v0, 4
la $a0, S_9
syscall
   # @printf string S_8
li $v0, 4
la $a0, S_8
syscall
   # #1 = n
lw $s3, 0($fp)# n
lw $s4, 36($fp)# #1
move $s4, $s3
   # @scanf int n
li $v0, 5
syscall
move $s3, $v0
   # @j fluctuations_L_0_while_begin
sw $s2, 32($fp)
sw $s3, 0($fp)
sw $s4, 36($fp)
j fluctuations_L_0_while_begin
nop
   # fluctuations_L_1_while_over :
fluctuations_L_1_while_over:
   # a = 0
lw $s5, 4($fp)# a
li $s5, 0
   # b = 0
lw $s6, 8($fp)# b
li $s6, 0
   # i = 0
lw $s7, 28($fp)# i
li $s7, 0
   # max_sub = #0
lw $s0, 32($fp)# #0
lw $s1, 24($fp)# max_sub
move $s1, $s0
   # fluctuations_L_2_while_begin :
sw $s0, 32($fp)
sw $s1, 24($fp)
sw $s5, 4($fp)
sw $s6, 8($fp)
sw $s7, 28($fp)
fluctuations_L_2_while_begin:
   # #1 = 0 SUB i
lw $s2, 36($fp)# #1
lw $s3, 28($fp)# i
sub $s2, $0, $s3
   # #2 = 0 SUB #1
lw $s4, 40($fp)# #2
sub $s4, $0, $s2
   # #3 = 0 SUB #2
lw $s5, 44($fp)# #3
sub $s5, $0, $s4
   # #4 = 0 SUB #3
lw $s6, 48($fp)# #4
sub $s6, $0, $s5
   # #0 = #4 LT n
lw $s7, 32($fp)# #0
lw $s0, 0($fp)# n
slt $s7, $s6, $s0
   # @bz #0 fluctuations_L_3_while_over
sw $s0, 0($fp)
sw $s2, 36($fp)
sw $s3, 28($fp)
sw $s4, 40($fp)
sw $s5, 44($fp)
sw $s6, 48($fp)
sw $s7, 32($fp)
lw $s1, 32($fp)# #0
beq $s1, $0, fluctuations_L_3_while_over
nop
   # @scanf int a
li $v0, 5
syscall
lw $s2, 4($fp)# a
move $s2, $v0
   # @printf string S_10
li $v0, 4
la $a0, S_10
syscall
   # #5 = a SUB b
lw $s3, 52($fp)# #5
lw $s4, 8($fp)# b
sub $s3, $s2, $s4
   # @printf int #5
li $v0, 1
move $a0, $s3
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #6 = #5 LE 0
lw $s5, 56($fp)# #6
li $t0, 0
sle $s5, $s3, $t0
   # sub = #5
lw $s6, 20($fp)# sub
move $s6, $s3
   # @bz #6 fluctuations_L_4_else_begin
sw $s1, 32($fp)
sw $s2, 4($fp)
sw $s3, 52($fp)
sw $s4, 8($fp)
sw $s5, 56($fp)
sw $s6, 20($fp)
lw $s7, 56($fp)# #6
beq $s7, $0, fluctuations_L_4_else_begin
nop
   # #7 = sub
lw $s0, 20($fp)# sub
lw $s1, 60($fp)# #7
move $s1, $s0
   # #8 = 0 SUB #7
lw $s2, 64($fp)# #8
sub $s2, $0, $s1
   # sub = #8
move $s0, $s2
   # @j fluctuations_L_5_else_over
sw $s0, 20($fp)
sw $s1, 60($fp)
sw $s2, 64($fp)
sw $s7, 56($fp)
j fluctuations_L_5_else_over
nop
   # fluctuations_L_4_else_begin :
fluctuations_L_4_else_begin:
   # fluctuations_L_5_else_over :
fluctuations_L_5_else_over:
   # #0 = sub GT max_sub
lw $s3, 32($fp)# #0
lw $s4, 20($fp)# sub
lw $s5, 24($fp)# max_sub
sgt $s3, $s4, $s5
   # @bz #0 fluctuations_L_6_else_begin
sw $s3, 32($fp)
sw $s4, 20($fp)
sw $s5, 24($fp)
lw $s6, 32($fp)# #0
beq $s6, $0, fluctuations_L_6_else_begin
nop
   # #1 = max_sub
lw $s7, 24($fp)# max_sub
lw $s0, 36($fp)# #1
move $s0, $s7
   # max_sub = sub
lw $s1, 20($fp)# sub
move $s7, $s1
   # ra = a
lw $s2, 4($fp)# a
lw $s3, 12($fp)# ra
move $s3, $s2
   # rb = b
lw $s4, 8($fp)# b
lw $s5, 16($fp)# rb
move $s5, $s4
   # @j fluctuations_L_7_else_over
sw $s0, 36($fp)
sw $s1, 20($fp)
sw $s2, 4($fp)
sw $s3, 12($fp)
sw $s4, 8($fp)
sw $s5, 16($fp)
sw $s6, 32($fp)
sw $s7, 24($fp)
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
lw $s6, 24($fp)# max_sub
move $a0, $s6
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #0 = i
lw $s7, 28($fp)# i
lw $s0, 32($fp)# #0
move $s0, $s7
   # b = a
lw $s1, 4($fp)# a
lw $s2, 8($fp)# b
move $s2, $s1
   # #1 = #0 ADD 1
lw $s3, 36($fp)# #1
addi $s3, $s0, 1
   # i = #1
move $s7, $s3
   # @j fluctuations_L_2_while_begin
sw $s0, 32($fp)
sw $s1, 4($fp)
sw $s2, 8($fp)
sw $s3, 36($fp)
sw $s6, 24($fp)
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
lw $s4, 24($fp)# max_sub
move $a0, $s4
syscall
   # @printf string S_13
li $v0, 4
la $a0, S_13
syscall
   # @printf int ra
li $v0, 1
lw $s5, 12($fp)# ra
move $a0, $s5
syscall
   # @printf string S_14
li $v0, 4
la $a0, S_14
syscall
   # @printf int rb
li $v0, 1
lw $s6, 16($fp)# rb
move $a0, $s6
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @ret
sw $s4, 24($fp)
sw $s5, 12($fp)
sw $s6, 16($fp)
jr $ra
nop
   # @func fibonacci
fibonacci_E:
   # @var int a
   # @var int b
   # @var int sum
   # @var int n
   # @var int i
   # @printf string S_15
li $v0, 4
la $a0, S_15
syscall
   # @scanf int n
li $v0, 5
syscall
lw $s7, 12($fp)# n
move $s7, $v0
   # #0 = n LE 0
lw $s0, 20($fp)# #0
li $t0, 0
sle $s0, $s7, $t0
   # a = 1
lw $s1, 0($fp)# a
li $s1, 1
   # b = 1
lw $s2, 4($fp)# b
li $s2, 1
   # @bz #0 fibonacci_L_0_else_begin
sw $s0, 20($fp)
sw $s1, 0($fp)
sw $s2, 4($fp)
sw $s7, 12($fp)
lw $s3, 20($fp)# #0
beq $s3, $0, fibonacci_L_0_else_begin
nop
   # @printf string S_16
li $v0, 4
la $a0, S_16
syscall
   # @ret
sw $s3, 20($fp)
jr $ra
nop
   # @j fibonacci_L_1_else_over
j fibonacci_L_1_else_over
nop
   # fibonacci_L_0_else_begin :
fibonacci_L_0_else_begin:
   # fibonacci_L_1_else_over :
fibonacci_L_1_else_over:
   # @printf int a
li $v0, 1
lw $s4, 0($fp)# a
move $a0, $s4
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 1
lw $s5, 20($fp)# #0
lw $s6, 12($fp)# n
li $t0, 1
sle $s5, $s6, $t0
   # @bz #0 fibonacci_L_2_else_begin
sw $s4, 0($fp)
sw $s5, 20($fp)
sw $s6, 12($fp)
lw $s7, 20($fp)# #0
beq $s7, $0, fibonacci_L_2_else_begin
nop
   # @ret
sw $s7, 20($fp)
jr $ra
nop
   # @j fibonacci_L_3_else_over
j fibonacci_L_3_else_over
nop
   # fibonacci_L_2_else_begin :
fibonacci_L_2_else_begin:
   # fibonacci_L_3_else_over :
fibonacci_L_3_else_over:
   # @printf int b
li $v0, 1
lw $s0, 4($fp)# b
move $a0, $s0
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 2
lw $s1, 20($fp)# #0
lw $s2, 12($fp)# n
li $t0, 2
sle $s1, $s2, $t0
   # @bz #0 fibonacci_L_4_else_begin
sw $s0, 4($fp)
sw $s1, 20($fp)
sw $s2, 12($fp)
lw $s3, 20($fp)# #0
beq $s3, $0, fibonacci_L_4_else_begin
nop
   # @ret
sw $s3, 20($fp)
jr $ra
nop
   # @j fibonacci_L_5_else_over
j fibonacci_L_5_else_over
nop
   # fibonacci_L_4_else_begin :
fibonacci_L_4_else_begin:
   # fibonacci_L_5_else_over :
fibonacci_L_5_else_over:
   # i = 3
lw $s4, 16($fp)# i
li $s4, 3
   # fibonacci_L_6_while_begin :
sw $s4, 16($fp)
fibonacci_L_6_while_begin:
   # #0 = i LE n
lw $s5, 20($fp)# #0
lw $s6, 16($fp)# i
lw $s7, 12($fp)# n
sle $s5, $s6, $s7
   # @bz #0 fibonacci_L_7_while_over
sw $s5, 20($fp)
sw $s6, 16($fp)
sw $s7, 12($fp)
lw $s0, 20($fp)# #0
beq $s0, $0, fibonacci_L_7_while_over
nop
   # #1 = a ADD b
lw $s1, 24($fp)# #1
lw $s2, 0($fp)# a
lw $s3, 4($fp)# b
add $s1, $s2, $s3
   # @printf int #1
li $v0, 1
move $a0, $s1
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #2 = a
lw $s4, 28($fp)# #2
move $s4, $s2
   # #3 = b
lw $s5, 32($fp)# #3
move $s5, $s3
   # #5 = n DIV 10
lw $s6, 40($fp)# #5
lw $s7, 12($fp)# n
div $s6, $s7, 10
   # #6 = #5 MUL 10
sw $s0, 20($fp) # store reg to mem
lw $s0, 44($fp)# #6
mul $s0, $s6, 10
   # #7 = i ADD 1
sw $s1, 24($fp) # store reg to mem
lw $s1, 48($fp)# #7
sw $s2, 0($fp) # store reg to mem
lw $s2, 16($fp)# i
addi $s1, $s2, 1
   # #4 = #6 EQ #7
sw $s3, 4($fp) # store reg to mem
lw $s3, 36($fp)# #4
seq $s3, $s0, $s1
   # a = #1
sw $s4, 28($fp) # store reg to mem
lw $s4, 24($fp)# #1
sw $s5, 32($fp) # store reg to mem
lw $s5, 0($fp)# a
move $s5, $s4
   # b = #2
sw $s6, 40($fp) # store reg to mem
lw $s6, 28($fp)# #2
sw $s7, 12($fp) # store reg to mem
lw $s7, 4($fp)# b
move $s7, $s6
   # sum = #1
sw $s0, 44($fp) # store reg to mem
lw $s0, 8($fp)# sum
move $s0, $s4
   # @bz #4 fibonacci_L_8_else_begin
sw $s0, 8($fp)
sw $s1, 48($fp)
sw $s2, 16($fp)
sw $s3, 36($fp)
sw $s4, 24($fp)
sw $s5, 0($fp)
sw $s6, 28($fp)
sw $s7, 4($fp)
lw $s1, 36($fp)# #4
beq $s1, $0, fibonacci_L_8_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j fibonacci_L_9_else_over
sw $s1, 36($fp)
j fibonacci_L_9_else_over
nop
   # fibonacci_L_8_else_begin :
fibonacci_L_8_else_begin:
   # fibonacci_L_9_else_over :
fibonacci_L_9_else_over:
   # #0 = i
lw $s2, 16($fp)# i
lw $s3, 20($fp)# #0
move $s3, $s2
   # #1 = #0 ADD 1
lw $s4, 24($fp)# #1
addi $s4, $s3, 1
   # i = #1
move $s2, $s4
   # @j fibonacci_L_6_while_begin
sw $s2, 16($fp)
sw $s3, 20($fp)
sw $s4, 24($fp)
j fibonacci_L_6_while_begin
nop
   # fibonacci_L_7_while_over :
fibonacci_L_7_while_over:
   # @ret
jr $ra
nop
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
lw $s5, 400($fp)# size
move $s5, $v0
   # sort_L_0_while_begin :
sw $s5, 400($fp)
sort_L_0_while_begin:
   # #0 = size GE 100
lw $s6, 416($fp)# #0
lw $s7, 400($fp)# size
li $t0, 100
sge $s6, $s7, $t0
   # @bz #0 sort_L_1_while_over
sw $s6, 416($fp)
sw $s7, 400($fp)
lw $s0, 416($fp)# #0
beq $s0, $0, sort_L_1_while_over
nop
   # @printf string S_19
li $v0, 4
la $a0, S_19
syscall
   # #1 = size
lw $s1, 400($fp)# size
lw $s2, 420($fp)# #1
move $s2, $s1
   # @scanf int size
li $v0, 5
syscall
move $s1, $v0
   # @j sort_L_0_while_begin
sw $s0, 416($fp)
sw $s1, 400($fp)
sw $s2, 420($fp)
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
   # #1 = a ARGET i
lw $s3, 420($fp)# #1
sll $t1, $s2, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s3, ($t1)
   # @printf int #1
li $v0, 1
move $a0, $s3
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #2 = i
lw $s4, 424($fp)# #2
move $s4, $s2
   # #3 = #2 ADD 1
lw $s5, 428($fp)# #3
addi $s5, $s4, 1
   # i = #3
move $s2, $s5
   # @j sort_L_2_while_begin
sw $s0, 416($fp)
sw $s1, 412($fp)
sw $s2, 404($fp)
sw $s3, 420($fp)
sw $s4, 424($fp)
sw $s5, 428($fp)
j sort_L_2_while_begin
nop
   # sort_L_3_while_over :
sort_L_3_while_over:
   # i = 0
lw $s6, 404($fp)# i
li $s6, 0
   # sort_L_4_while_begin :
sw $s6, 404($fp)
sort_L_4_while_begin:
   # #1 = size SUB 1
lw $s7, 420($fp)# #1
lw $s0, 400($fp)# size
addi $s7, $s0, -1
   # #0 = i LT #1
lw $s1, 416($fp)# #0
lw $s2, 404($fp)# i
slt $s1, $s2, $s7
   # @bz #0 sort_L_5_while_over
sw $s0, 400($fp)
sw $s1, 416($fp)
sw $s2, 404($fp)
sw $s7, 420($fp)
lw $s3, 416($fp)# #0
beq $s3, $0, sort_L_5_while_over
nop
   # j = 0
lw $s4, 408($fp)# j
li $s4, 0
   # sort_L_6_while_begin :
sw $s3, 416($fp)
sw $s4, 408($fp)
sort_L_6_while_begin:
   # #1 = size SUB 1
lw $s5, 420($fp)# #1
lw $s6, 400($fp)# size
addi $s5, $s6, -1
   # #2 = #1 SUB i
lw $s7, 424($fp)# #2
lw $s0, 404($fp)# i
sub $s7, $s5, $s0
   # #0 = j LT #2
lw $s1, 416($fp)# #0
lw $s2, 408($fp)# j
slt $s1, $s2, $s7
   # @bz #0 sort_L_7_while_over
sw $s0, 404($fp)
sw $s1, 416($fp)
sw $s2, 408($fp)
sw $s5, 420($fp)
sw $s6, 400($fp)
sw $s7, 424($fp)
lw $s3, 416($fp)# #0
beq $s3, $0, sort_L_7_while_over
nop
   # #4 = a ARGET j
lw $s4, 432($fp)# #4
lw $s5, 408($fp)# j
sll $t1, $s5, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s4, ($t1)
   # #5 = j ADD 1
lw $s6, 436($fp)# #5
addi $s6, $s5, 1
   # #6 = a ARGET #5
lw $s7, 440($fp)# #6
sll $t1, $s6, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s7, ($t1)
   # #3 = #4 GT #6
lw $s0, 428($fp)# #3
sgt $s0, $s4, $s7
   # @bz #3 sort_L_8_else_begin
sw $s0, 428($fp)
sw $s3, 416($fp)
sw $s4, 432($fp)
sw $s5, 408($fp)
sw $s6, 436($fp)
sw $s7, 440($fp)
lw $s1, 428($fp)# #3
beq $s1, $0, sort_L_8_else_begin
nop
   # @printf string S_23
li $v0, 4
la $a0, S_23
syscall
   # @printf int #4
li $v0, 1
lw $s2, 432($fp)# #4
move $a0, $s2
syscall
   # @printf string S_24
li $v0, 4
la $a0, S_24
syscall
   # @printf int #6
li $v0, 1
lw $s3, 440($fp)# #6
move $a0, $s3
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # a = j ARSET #6
lw $s4, 408($fp)# j
sll $t1, $s4, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s3, ($t1)
   # a = #5 ARSET #4
lw $s5, 436($fp)# #5
sll $t1, $s5, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s2, ($t1)
   # temp = #4
lw $s6, 412($fp)# temp
move $s6, $s2
   # @j sort_L_9_else_over
sw $s1, 428($fp)
sw $s2, 432($fp)
sw $s3, 440($fp)
sw $s4, 408($fp)
sw $s5, 436($fp)
sw $s6, 412($fp)
j sort_L_9_else_over
nop
   # sort_L_8_else_begin :
sort_L_8_else_begin:
   # sort_L_9_else_over :
sort_L_9_else_over:
   # #0 = j
lw $s7, 408($fp)# j
lw $s0, 416($fp)# #0
move $s0, $s7
   # #1 = #0 ADD 1
lw $s1, 420($fp)# #1
addi $s1, $s0, 1
   # j = #1
move $s7, $s1
   # @j sort_L_6_while_begin
sw $s0, 416($fp)
sw $s1, 420($fp)
sw $s7, 408($fp)
j sort_L_6_while_begin
nop
   # sort_L_7_while_over :
sort_L_7_while_over:
   # #0 = i
lw $s2, 404($fp)# i
lw $s3, 416($fp)# #0
move $s3, $s2
   # #1 = #0 ADD 1
lw $s4, 420($fp)# #1
addi $s4, $s3, 1
   # i = #1
move $s2, $s4
   # @j sort_L_4_while_begin
sw $s2, 404($fp)
sw $s3, 416($fp)
sw $s4, 420($fp)
j sort_L_4_while_begin
nop
   # sort_L_5_while_over :
sort_L_5_while_over:
   # @printf string S_25
li $v0, 4
la $a0, S_25
syscall
   # #0 = a ARGET 2
lw $s5, 416($fp)# #0
lw $s5, 8($fp)
   # @printf int #0
li $v0, 1
move $a0, $s5
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
lw $s6, 404($fp)# i
li $s6, 0
   # sort_L_10_while_begin :
sw $s5, 416($fp)
sw $s6, 404($fp)
sort_L_10_while_begin:
   # #0 = i LT size
lw $s7, 416($fp)# #0
lw $s0, 404($fp)# i
lw $s1, 400($fp)# size
slt $s7, $s0, $s1
   # @bz #0 sort_L_11_while_over
sw $s0, 404($fp)
sw $s1, 400($fp)
sw $s7, 416($fp)
lw $s2, 416($fp)# #0
beq $s2, $0, sort_L_11_while_over
nop
   # @printf string S_27
li $v0, 4
la $a0, S_27
syscall
   # #2 = i ADD 1
lw $s3, 424($fp)# #2
lw $s4, 404($fp)# i
addi $s3, $s4, 1
   # #1 = #2 SUB 1
lw $s5, 420($fp)# #1
addi $s5, $s3, -1
   # @printf int #1
li $v0, 1
move $a0, $s5
syscall
   # @printf string S_28
li $v0, 4
la $a0, S_28
syscall
   # #3 = a ARGET #1
lw $s6, 428($fp)# #3
sll $t1, $s5, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s6, ($t1)
   # @printf int #3
li $v0, 1
move $a0, $s6
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #4 = i
lw $s7, 432($fp)# #4
move $s7, $s4
   # #6 = #2 ADD 1
lw $s0, 440($fp)# #6
addi $s0, $s3, 1
   # #7 = #6 DIV 10
lw $s1, 444($fp)# #7
div $s1, $s0, 10
   # #8 = #7 MUL 10
sw $s2, 416($fp) # store reg to mem
lw $s2, 448($fp)# #8
mul $s2, $s1, 10
   # #5 = #8 EQ #6
sw $s3, 424($fp) # store reg to mem
lw $s3, 436($fp)# #5
seq $s3, $s2, $s0
   # i = #2
sw $s4, 404($fp) # store reg to mem
lw $s4, 424($fp)# #2
sw $s5, 420($fp) # store reg to mem
lw $s5, 404($fp)# i
move $s5, $s4
   # @bz #5 sort_L_12_else_begin
sw $s0, 440($fp)
sw $s1, 444($fp)
sw $s2, 448($fp)
sw $s3, 436($fp)
sw $s4, 424($fp)
sw $s5, 404($fp)
sw $s6, 428($fp)
sw $s7, 432($fp)
lw $s6, 436($fp)# #5
beq $s6, $0, sort_L_12_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j sort_L_13_else_over
sw $s6, 436($fp)
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
   # @ret 0
li $v0, 0
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
lw $s7, 0($fp)# i
move $s7, $v0
   # #1 = i DIV 1
lw $s0, 12($fp)# #1
div $s0, $s7, 1
   # #0 = #1 MUL 1
lw $s1, 8($fp)# #0
mul $s1, $s0, 1
   # @be #0 0 select_L_3_case
sw $s0, 12($fp)
sw $s1, 8($fp)
sw $s7, 0($fp)
lw $s2, 8($fp)# #0
beq $s2, 0, select_L_3_case
nop
   # @be #0 1 select_L_4_case
sw $s2, 8($fp)
lw $s3, 8($fp)# #0
beq $s3, 1, select_L_4_case
nop
   # @be #0 2 select_L_5_case
sw $s3, 8($fp)
lw $s4, 8($fp)# #0
beq $s4, 2, select_L_5_case
nop
   # @be #0 3 select_L_6_case
sw $s4, 8($fp)
lw $s5, 8($fp)# #0
beq $s5, 3, select_L_6_case
nop
   # @be #0 4 select_L_7_case
sw $s5, 8($fp)
lw $s6, 8($fp)# #0
beq $s6, 4, select_L_7_case
nop
   # @be #0 5 select_L_8_case
sw $s6, 8($fp)
lw $s7, 8($fp)# #0
beq $s7, 5, select_L_8_case
nop
   # @j select_L_9_default
sw $s7, 8($fp)
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
lw $s0, 4($fp)# num
move $s0, $v0
   # @push 0
   # @push 99
   # @push num
   # @call find
sw $s0, 16($fp)
li $t0, 99
sw $t0, 20($fp)
li $t0, 0
sw $t0, 24($fp)
sw $s0, 4($fp)
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
lw $s1, 8($fp)# #0
lw $s2, 0($fp)# i
li $t0, 0
seq $s1, $s2, $t0
   # @bz #0 select_L_10_else_begin
sw $s1, 8($fp)
sw $s2, 0($fp)
lw $s3, 8($fp)# #0
beq $s3, $0, select_L_10_else_begin
nop
   # @printf string S_38
li $v0, 4
la $a0, S_38
syscall
   # @ret
sw $s3, 8($fp)
jr $ra
nop
   # @j select_L_11_else_over
j select_L_11_else_over
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
