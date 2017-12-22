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
S_22: .asciiz "The sorted array is:\n"
S_23: .asciiz "======================\n"
S_24: .asciiz "|   1. Sort          |\n"
S_25: .asciiz "|   2. Fibonacci     |\n"
S_26: .asciiz "|   3. FluctuaTions  |\n"
S_27: .asciiz "|   4. Zigzag        |\n"
S_28: .asciiz "|   5. Find          |\n"
S_29: .asciiz "|   0. Exit          |\n"
S_30: .asciiz "Please enter your choice(0-5):"
S_31: .asciiz "Please enter a number:"
S_32: .asciiz "Bye"
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
lw $s0, 0($fp)
li $s0, 0
   # init_array_L_0_while_begin :
sw $s0, 0($fp)
init_array_L_0_while_begin:
   # #0 = a LT 100
lw $s1, 4($fp)
lw $s2, 0($fp)
li $t0, 100
slt $s1, $s2, $t0
   # @bz #0 init_array_L_1_while_over
sw $s1, 4($fp)
sw $s2, 0($fp)
lw $s3, 4($fp)
beq $s3, $0, init_array_L_1_while_over
nop
   # find_array = a ARSET a
lw $s4, 0($fp)
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
sw $s4, ($t1)
   # #1 = a
lw $s5, 8($fp)
move $s5, $s4
   # a = #1 ADD 1
addi $s4, $s5, 1
   # @j init_array_L_0_while_begin
sw $s3, 4($fp)
sw $s4, 0($fp)
sw $s5, 8($fp)
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
lw $s6, 0($fp)
lw $s6, -4($fp)
   # @para int end
lw $s7, 4($fp)
lw $s7, -8($fp)
   # @para int num
lw $s0, 8($fp)
lw $s0, -12($fp)
   # @var int mid
   # #0 = begin EQ end
lw $s1, 16($fp)
seq $s1, $s6, $s7
   # @bz #0 find_L_0_else_begin
sw $s0, 8($fp)
sw $s1, 16($fp)
sw $s6, 0($fp)
sw $s7, 4($fp)
lw $s2, 16($fp)
beq $s2, $0, find_L_0_else_begin
nop
   # #1 = find_array ARGET begin
lw $s3, 20($fp)
lw $s4, 0($fp)
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s3, ($t1)
   # #2 = #1 EQ num
lw $s5, 24($fp)
lw $s6, 8($fp)
seq $s5, $s3, $s6
   # @bz #2 find_L_2_else_begin
sw $s2, 16($fp)
sw $s3, 20($fp)
sw $s4, 0($fp)
sw $s5, 24($fp)
sw $s6, 8($fp)
lw $s7, 24($fp)
beq $s7, $0, find_L_2_else_begin
nop
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int begin
li $v0, 1
lw $s0, 0($fp)
move $a0, $s0
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_3_else_over
sw $s0, 0($fp)
sw $s7, 24($fp)
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
   # #0 = begin ADD end
lw $s1, 16($fp)
lw $s2, 0($fp)
lw $s3, 4($fp)
add $s1, $s2, $s3
   # mid = #0 DIV 2
lw $s4, 12($fp)
div $s4, $s1, 2
   # #1 = find_array ARGET mid
lw $s5, 20($fp)
sll $t1, $s4, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s5, ($t1)
   # #2 = #1 LT num
lw $s6, 24($fp)
lw $s7, 8($fp)
slt $s6, $s5, $s7
   # @bz #2 find_L_4_else_begin
sw $s1, 16($fp)
sw $s2, 0($fp)
sw $s3, 4($fp)
sw $s4, 12($fp)
sw $s5, 20($fp)
sw $s6, 24($fp)
sw $s7, 8($fp)
lw $s0, 24($fp)
beq $s0, $0, find_L_4_else_begin
nop
   # #3 = mid ADD 1
lw $s1, 28($fp)
lw $s2, 12($fp)
addi $s1, $s2, 1
   # @push #3
   # @push end
   # @push num
   # @call find
lw $s3, 8($fp)
sw $s3, 32($fp)
lw $s4, 4($fp)
sw $s4, 36($fp)
sw $s1, 40($fp)
sw $s0, 24($fp)
sw $s1, 28($fp)
sw $s2, 12($fp)
sw $s3, 8($fp)
sw $s4, 4($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 44
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
lw $s5, 16($fp)
lw $s6, 12($fp)
sll $t1, $s6, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s5, ($t1)
   # #1 = #0 GT num
lw $s7, 20($fp)
lw $s0, 8($fp)
sgt $s7, $s5, $s0
   # @bz #1 find_L_6_else_begin
sw $s0, 8($fp)
sw $s5, 16($fp)
sw $s6, 12($fp)
sw $s7, 20($fp)
lw $s1, 20($fp)
beq $s1, $0, find_L_6_else_begin
nop
   # @push begin
   # @push mid
   # @push num
   # @call find
lw $s2, 8($fp)
sw $s2, 32($fp)
lw $s3, 12($fp)
sw $s3, 36($fp)
lw $s4, 0($fp)
sw $s4, 40($fp)
sw $s1, 20($fp)
sw $s2, 8($fp)
sw $s3, 12($fp)
sw $s4, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 44
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
lw $s5, 16($fp)
lw $s6, 12($fp)
sll $t1, $s6, 2
add $t1, $t1, $gp
addi $t1, $t1, 4
lw $s5, ($t1)
   # #1 = #0 EQ num
lw $s7, 20($fp)
lw $s0, 8($fp)
seq $s7, $s5, $s0
   # @bz #1 find_L_8_else_begin
sw $s0, 8($fp)
sw $s5, 16($fp)
sw $s6, 12($fp)
sw $s7, 20($fp)
lw $s1, 20($fp)
beq $s1, $0, find_L_8_else_begin
nop
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int mid
li $v0, 1
lw $s2, 12($fp)
move $a0, $s2
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j find_L_9_else_over
sw $s1, 20($fp)
sw $s2, 12($fp)
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
lw $s3, 0($fp)
lw $s3, -4($fp)
   # @para int row
lw $s4, 4($fp)
lw $s4, -8($fp)
   # @para int col
lw $s5, 8($fp)
lw $s5, -12($fp)
   # #0 = row SUB 1
lw $s6, 12($fp)
addi $s6, $s4, -1
   # #1 = #0 MUL size
lw $s7, 16($fp)
mul $s7, $s6, $s3
   # #2 = col SUB 1
lw $s0, 20($fp)
addi $s0, $s5, -1
   # #3 = #1 ADD #2
lw $s1, 24($fp)
add $s1, $s7, $s0
   # @ret #3
sw $s0, 20($fp)
sw $s1, 24($fp)
sw $s3, 0($fp)
sw $s4, 4($fp)
sw $s5, 8($fp)
sw $s6, 12($fp)
sw $s7, 16($fp)
lw $s2, 24($fp)
move $v0, $s2
jr $ra
nop
   # @ret 0
sw $s2, 24($fp)
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
lw $s3, 0($fp)
move $s3, $v0
   # zigzag_L_0_while_begin :
sw $s3, 0($fp)
zigzag_L_0_while_begin:
   # #0 = a GE 10
lw $s4, 124($fp)
lw $s5, 0($fp)
li $t0, 10
sge $s4, $s5, $t0
   # @bz #0 zigzag_L_1_while_over
sw $s4, 124($fp)
sw $s5, 0($fp)
lw $s6, 124($fp)
beq $s6, $0, zigzag_L_1_while_over
nop
   # @printf string S_5
li $v0, 4
la $a0, S_5
syscall
   # #1 = a
lw $s7, 0($fp)
lw $s0, 128($fp)
move $s0, $s7
   # @scanf int a
li $v0, 5
syscall
move $s7, $v0
   # @j zigzag_L_0_while_begin
sw $s0, 128($fp)
sw $s6, 124($fp)
sw $s7, 0($fp)
j zigzag_L_0_while_begin
nop
   # zigzag_L_1_while_over :
zigzag_L_1_while_over:
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # i = 0
lw $s1, 4($fp)
li $s1, 0
   # zigzag_L_2_while_begin :
sw $s1, 4($fp)
zigzag_L_2_while_begin:
   # #1 = a MUL a
lw $s2, 128($fp)
lw $s3, 0($fp)
mul $s2, $s3, $s3
   # #0 = i LT #1
lw $s4, 124($fp)
lw $s5, 4($fp)
slt $s4, $s5, $s2
   # @bz #0 zigzag_L_3_while_over
sw $s2, 128($fp)
sw $s3, 0($fp)
sw $s4, 124($fp)
sw $s5, 4($fp)
lw $s6, 124($fp)
beq $s6, $0, zigzag_L_3_while_over
nop
   # @scanf char temp
li $v0, 12
syscall
lb $s7, 8($fp)
move $s7, $v0
   # matrix = i ARSET temp
lw $s0, 4($fp)
add $t1, $s0, $fp
addi $t1, $t1, 16
sb $s7, ($t1)
   # #2 = i
lw $s1, 132($fp)
move $s1, $s0
   # i = #2 ADD 1
addi $s0, $s1, 1
   # #3 = i DIV a
lw $s2, 136($fp)
lw $s3, 0($fp)
div $s2, $s0, $s3
   # #4 = #3 MUL a
lw $s4, 140($fp)
mul $s4, $s2, $s3
   # #5 = #4 EQ i
lw $s5, 144($fp)
seq $s5, $s4, $s0
   # @bz #5 zigzag_L_4_else_begin
sw $s0, 4($fp)
sw $s1, 132($fp)
sw $s2, 136($fp)
sw $s3, 0($fp)
sw $s4, 140($fp)
sw $s5, 144($fp)
sw $s6, 124($fp)
sb $s7, 8($fp)
lw $s6, 144($fp)
beq $s6, $0, zigzag_L_4_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j zigzag_L_5_else_over
sw $s6, 144($fp)
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
sw $t0, 148($fp)
li $t0, 1
sw $t0, 152($fp)
lw $s7, 0($fp)
sw $s7, 156($fp)
sw $s7, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 160
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #6
lw $s0, 148($fp)
move $s0, $v0
   # #1 = matrix ARGET #0
lw $s1, 128($fp)
lw $s2, 124($fp)
add $t1, $s2, $fp
addi $t1, $t1, 16
lb $s1, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s1
syscall
   # col = 1
lw $s3, 120($fp)
li $s3, 1
   # row = 1
lw $s4, 116($fp)
li $s4, 1
   # zigzag_L_6_while_begin :
sw $s0, 148($fp)
sw $s1, 128($fp)
sw $s2, 124($fp)
sw $s3, 120($fp)
sw $s4, 116($fp)
zigzag_L_6_while_begin:
   # #0 = row MUL col
lw $s5, 124($fp)
lw $s6, 116($fp)
lw $s7, 120($fp)
mul $s5, $s6, $s7
   # #2 = a MUL a
lw $s0, 132($fp)
lw $s1, 0($fp)
mul $s0, $s1, $s1
   # #1 = #0 NE #2
lw $s2, 128($fp)
sne $s2, $s5, $s0
   # @bz #1 zigzag_L_7_while_over
sw $s0, 132($fp)
sw $s1, 0($fp)
sw $s2, 128($fp)
sw $s5, 124($fp)
sw $s6, 116($fp)
sw $s7, 120($fp)
lw $s3, 128($fp)
beq $s3, $0, zigzag_L_7_while_over
nop
   # #3 = col EQ a
lw $s4, 136($fp)
lw $s5, 120($fp)
lw $s6, 0($fp)
seq $s4, $s5, $s6
   # @bz #3 zigzag_L_8_else_begin
sw $s3, 128($fp)
sw $s4, 136($fp)
sw $s5, 120($fp)
sw $s6, 0($fp)
lw $s7, 136($fp)
beq $s7, $0, zigzag_L_8_else_begin
nop
   # #4 = row
lw $s0, 116($fp)
lw $s1, 140($fp)
move $s1, $s0
   # row = #4 ADD 1
addi $s0, $s1, 1
   # @j zigzag_L_9_else_over
sw $s0, 116($fp)
sw $s1, 140($fp)
sw $s7, 136($fp)
j zigzag_L_9_else_over
nop
   # zigzag_L_8_else_begin :
zigzag_L_8_else_begin:
   # #0 = col
lw $s2, 120($fp)
lw $s3, 124($fp)
move $s3, $s2
   # col = #0 ADD 1
addi $s2, $s3, 1
   # zigzag_L_9_else_over :
sw $s2, 120($fp)
sw $s3, 124($fp)
zigzag_L_9_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
lw $s4, 120($fp)
sw $s4, 152($fp)
lw $s5, 116($fp)
sw $s5, 156($fp)
lw $s6, 0($fp)
sw $s6, 160($fp)
sw $s4, 120($fp)
sw $s5, 116($fp)
sw $s6, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 164
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #10
lw $s7, 164($fp)
move $s7, $v0
   # #1 = matrix ARGET #0
lw $s0, 128($fp)
lw $s1, 124($fp)
add $t1, $s1, $fp
addi $t1, $t1, 16
lb $s0, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s0
syscall
   # i = 0
lw $s2, 4($fp)
li $s2, 0
   # tempi = col SUB row
lw $s3, 12($fp)
lw $s4, 120($fp)
lw $s5, 116($fp)
sub $s3, $s4, $s5
   # zigzag_L_10_while_begin :
sw $s0, 128($fp)
sw $s1, 124($fp)
sw $s2, 4($fp)
sw $s3, 12($fp)
sw $s4, 120($fp)
sw $s5, 116($fp)
sw $s7, 164($fp)
zigzag_L_10_while_begin:
   # #0 = i LT tempi
lw $s6, 124($fp)
lw $s7, 4($fp)
lw $s0, 12($fp)
slt $s6, $s7, $s0
   # @bz #0 zigzag_L_11_while_over
sw $s0, 12($fp)
sw $s6, 124($fp)
sw $s7, 4($fp)
lw $s1, 124($fp)
beq $s1, $0, zigzag_L_11_while_over
nop
   # #1 = i
lw $s2, 4($fp)
lw $s3, 128($fp)
move $s3, $s2
   # #2 = col
lw $s4, 120($fp)
lw $s5, 132($fp)
move $s5, $s4
   # #3 = row
lw $s6, 116($fp)
lw $s7, 136($fp)
move $s7, $s6
   # @push a
   # row = #3 ADD 1
addi $s6, $s7, 1
   # @push row
   # col = #2 SUB 1
addi $s4, $s5, -1
   # @push col
   # @call get_index
sw $s4, 168($fp)
sw $s6, 172($fp)
lw $s0, 0($fp)
sw $s0, 176($fp)
sw $s0, 0($fp)
sw $s1, 124($fp)
sw $s2, 4($fp)
sw $s3, 128($fp)
sw $s4, 120($fp)
sw $s5, 132($fp)
sw $s6, 116($fp)
sw $s7, 136($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 180
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #14
lw $s1, 180($fp)
move $s1, $v0
   # #5 = matrix ARGET #4
lw $s2, 144($fp)
lw $s3, 140($fp)
add $t1, $s3, $fp
addi $t1, $t1, 16
lb $s2, ($t1)
   # @printf char #5
li $v0, 11
move $a0, $s2
syscall
   # i = #1 ADD 1
lw $s4, 4($fp)
lw $s5, 128($fp)
addi $s4, $s5, 1
   # @j zigzag_L_10_while_begin
sw $s1, 180($fp)
sw $s2, 144($fp)
sw $s3, 140($fp)
sw $s4, 4($fp)
sw $s5, 128($fp)
j zigzag_L_10_while_begin
nop
   # zigzag_L_11_while_over :
zigzag_L_11_while_over:
   # #0 = row EQ a
lw $s6, 124($fp)
lw $s7, 116($fp)
lw $s0, 0($fp)
seq $s6, $s7, $s0
   # @bz #0 zigzag_L_12_else_begin
sw $s0, 0($fp)
sw $s6, 124($fp)
sw $s7, 116($fp)
lw $s1, 124($fp)
beq $s1, $0, zigzag_L_12_else_begin
nop
   # #1 = col
lw $s2, 120($fp)
lw $s3, 128($fp)
move $s3, $s2
   # col = #1 ADD 1
addi $s2, $s3, 1
   # @j zigzag_L_13_else_over
sw $s1, 124($fp)
sw $s2, 120($fp)
sw $s3, 128($fp)
j zigzag_L_13_else_over
nop
   # zigzag_L_12_else_begin :
zigzag_L_12_else_begin:
   # #0 = row
lw $s4, 116($fp)
lw $s5, 124($fp)
move $s5, $s4
   # row = #0 ADD 1
addi $s4, $s5, 1
   # zigzag_L_13_else_over :
sw $s4, 116($fp)
sw $s5, 124($fp)
zigzag_L_13_else_over:
   # @push a
   # @push row
   # @push col
   # @call get_index
lw $s6, 120($fp)
sw $s6, 184($fp)
lw $s7, 116($fp)
sw $s7, 188($fp)
lw $s0, 0($fp)
sw $s0, 192($fp)
sw $s0, 0($fp)
sw $s6, 120($fp)
sw $s7, 116($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 196
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #10
lw $s1, 164($fp)
move $s1, $v0
   # #1 = matrix ARGET #0
lw $s2, 128($fp)
lw $s3, 124($fp)
add $t1, $s3, $fp
addi $t1, $t1, 16
lb $s2, ($t1)
   # @printf char #1
li $v0, 11
move $a0, $s2
syscall
   # i = 0
lw $s4, 4($fp)
li $s4, 0
   # #2 = 0 SUB col
lw $s5, 132($fp)
lw $s6, 120($fp)
sub $s5, $0, $s6
   # tempi = #2 ADD row
lw $s7, 12($fp)
lw $s0, 116($fp)
add $s7, $s5, $s0
   # zigzag_L_14_while_begin :
sw $s0, 116($fp)
sw $s1, 164($fp)
sw $s2, 128($fp)
sw $s3, 124($fp)
sw $s4, 4($fp)
sw $s5, 132($fp)
sw $s6, 120($fp)
sw $s7, 12($fp)
zigzag_L_14_while_begin:
   # #0 = i LT tempi
lw $s1, 124($fp)
lw $s2, 4($fp)
lw $s3, 12($fp)
slt $s1, $s2, $s3
   # @bz #0 zigzag_L_15_while_over
sw $s1, 124($fp)
sw $s2, 4($fp)
sw $s3, 12($fp)
lw $s4, 124($fp)
beq $s4, $0, zigzag_L_15_while_over
nop
   # #1 = i
lw $s5, 4($fp)
lw $s6, 128($fp)
move $s6, $s5
   # #2 = row
lw $s7, 116($fp)
lw $s0, 132($fp)
move $s0, $s7
   # #3 = col
lw $s1, 120($fp)
lw $s2, 136($fp)
move $s2, $s1
   # @push a
   # row = #2 SUB 1
addi $s7, $s0, -1
   # @push row
   # col = #3 ADD 1
addi $s1, $s2, 1
   # @push col
   # @call get_index
sw $s1, 184($fp)
sw $s7, 188($fp)
lw $s3, 0($fp)
sw $s3, 192($fp)
sw $s0, 132($fp)
sw $s1, 120($fp)
sw $s2, 136($fp)
sw $s3, 0($fp)
sw $s4, 124($fp)
sw $s5, 4($fp)
sw $s6, 128($fp)
sw $s7, 116($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 196
jal get_index_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #14
lw $s4, 180($fp)
move $s4, $v0
   # #5 = matrix ARGET #4
lw $s5, 144($fp)
lw $s6, 140($fp)
add $t1, $s6, $fp
addi $t1, $t1, 16
lb $s5, ($t1)
   # @printf char #5
li $v0, 11
move $a0, $s5
syscall
   # i = #1 ADD 1
lw $s7, 4($fp)
lw $s0, 128($fp)
addi $s7, $s0, 1
   # @j zigzag_L_14_while_begin
sw $s0, 128($fp)
sw $s4, 180($fp)
sw $s5, 144($fp)
sw $s6, 140($fp)
sw $s7, 4($fp)
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
lw $s1, 0($fp)
move $s1, $v0
   # fluctuations_L_0_while_begin :
sw $s1, 0($fp)
fluctuations_L_0_while_begin:
   # #0 = n LE 1
lw $s2, 32($fp)
lw $s3, 0($fp)
li $t0, 1
sle $s2, $s3, $t0
   # @bz #0 fluctuations_L_1_while_over
sw $s2, 32($fp)
sw $s3, 0($fp)
lw $s4, 32($fp)
beq $s4, $0, fluctuations_L_1_while_over
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
lw $s5, 0($fp)
lw $s6, 36($fp)
move $s6, $s5
   # @scanf int n
li $v0, 5
syscall
move $s5, $v0
   # @j fluctuations_L_0_while_begin
sw $s4, 32($fp)
sw $s5, 0($fp)
sw $s6, 36($fp)
j fluctuations_L_0_while_begin
nop
   # fluctuations_L_1_while_over :
fluctuations_L_1_while_over:
   # a = 0
lw $s7, 4($fp)
li $s7, 0
   # b = 0
lw $s0, 8($fp)
li $s0, 0
   # i = 0
lw $s1, 28($fp)
li $s1, 0
   # fluctuations_L_2_while_begin :
sw $s0, 8($fp)
sw $s1, 28($fp)
sw $s7, 4($fp)
fluctuations_L_2_while_begin:
   # #2 = 0 SUB i
lw $s2, 40($fp)
lw $s3, 28($fp)
sub $s2, $0, $s3
   # #3 = 0 SUB #2
lw $s4, 44($fp)
sub $s4, $0, $s2
   # #4 = 0 SUB #3
lw $s5, 48($fp)
sub $s5, $0, $s4
   # #0 = 0 SUB #4
lw $s6, 32($fp)
sub $s6, $0, $s5
   # #1 = #0 LT n
lw $s7, 36($fp)
lw $s0, 0($fp)
slt $s7, $s6, $s0
   # @bz #1 fluctuations_L_3_while_over
sw $s0, 0($fp)
sw $s2, 40($fp)
sw $s3, 28($fp)
sw $s4, 44($fp)
sw $s5, 48($fp)
sw $s6, 32($fp)
sw $s7, 36($fp)
lw $s1, 36($fp)
beq $s1, $0, fluctuations_L_3_while_over
nop
   # @scanf int a
li $v0, 5
syscall
lw $s2, 4($fp)
move $s2, $v0
   # @printf string S_10
li $v0, 4
la $a0, S_10
syscall
   # sub = a SUB b
lw $s3, 20($fp)
lw $s4, 8($fp)
sub $s3, $s2, $s4
   # @printf int sub
li $v0, 1
move $a0, $s3
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #5 = sub LE 0
lw $s5, 52($fp)
li $t0, 0
sle $s5, $s3, $t0
   # @bz #5 fluctuations_L_4_else_begin
sw $s1, 36($fp)
sw $s2, 4($fp)
sw $s3, 20($fp)
sw $s4, 8($fp)
sw $s5, 52($fp)
lw $s6, 52($fp)
beq $s6, $0, fluctuations_L_4_else_begin
nop
   # #6 = sub
lw $s7, 20($fp)
lw $s0, 56($fp)
move $s0, $s7
   # sub = 0 SUB #6
sub $s7, $0, $s0
   # @j fluctuations_L_5_else_over
sw $s0, 56($fp)
sw $s6, 52($fp)
sw $s7, 20($fp)
j fluctuations_L_5_else_over
nop
   # fluctuations_L_4_else_begin :
fluctuations_L_4_else_begin:
   # fluctuations_L_5_else_over :
fluctuations_L_5_else_over:
   # #0 = sub GT max_sub
lw $s1, 32($fp)
lw $s2, 20($fp)
lw $s3, 24($fp)
sgt $s1, $s2, $s3
   # @bz #0 fluctuations_L_6_else_begin
sw $s1, 32($fp)
sw $s2, 20($fp)
sw $s3, 24($fp)
lw $s4, 32($fp)
beq $s4, $0, fluctuations_L_6_else_begin
nop
   # #1 = max_sub
lw $s5, 24($fp)
lw $s6, 36($fp)
move $s6, $s5
   # ra = a
lw $s7, 4($fp)
lw $s0, 12($fp)
move $s0, $s7
   # rb = b
lw $s1, 8($fp)
lw $s2, 16($fp)
move $s2, $s1
   # sub = max_sub
lw $s3, 20($fp)
move $s3, $s5
   # @j fluctuations_L_7_else_over
sw $s0, 12($fp)
sw $s1, 8($fp)
sw $s2, 16($fp)
sw $s3, 20($fp)
sw $s4, 32($fp)
sw $s5, 24($fp)
sw $s6, 36($fp)
sw $s7, 4($fp)
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
lw $s4, 24($fp)
move $a0, $s4
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #0 = i
lw $s5, 28($fp)
lw $s6, 32($fp)
move $s6, $s5
   # b = a
lw $s7, 4($fp)
lw $s0, 8($fp)
move $s0, $s7
   # i = #0 ADD 1
addi $s5, $s6, 1
   # @j fluctuations_L_2_while_begin
sw $s0, 8($fp)
sw $s4, 24($fp)
sw $s5, 28($fp)
sw $s6, 32($fp)
sw $s7, 4($fp)
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
lw $s1, 24($fp)
move $a0, $s1
syscall
   # @printf string S_13
li $v0, 4
la $a0, S_13
syscall
   # @printf int ra
li $v0, 1
lw $s2, 12($fp)
move $a0, $s2
syscall
   # @printf string S_14
li $v0, 4
la $a0, S_14
syscall
   # @printf int rb
li $v0, 1
lw $s3, 16($fp)
move $a0, $s3
syscall
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @ret
sw $s1, 24($fp)
sw $s2, 12($fp)
sw $s3, 16($fp)
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
lw $s4, 12($fp)
move $s4, $v0
   # #0 = n LE 0
lw $s5, 20($fp)
li $t0, 0
sle $s5, $s4, $t0
   # a = 1
lw $s6, 0($fp)
li $s6, 1
   # b = 1
lw $s7, 4($fp)
li $s7, 1
   # @bz #0 fibonacci_L_0_else_begin
sw $s4, 12($fp)
sw $s5, 20($fp)
sw $s6, 0($fp)
sw $s7, 4($fp)
lw $s0, 20($fp)
beq $s0, $0, fibonacci_L_0_else_begin
nop
   # @printf string S_16
li $v0, 4
la $a0, S_16
syscall
   # @ret
sw $s0, 20($fp)
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
lw $s1, 0($fp)
move $a0, $s1
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 1
lw $s2, 20($fp)
lw $s3, 12($fp)
li $t0, 1
sle $s2, $s3, $t0
   # @bz #0 fibonacci_L_2_else_begin
sw $s1, 0($fp)
sw $s2, 20($fp)
sw $s3, 12($fp)
lw $s4, 20($fp)
beq $s4, $0, fibonacci_L_2_else_begin
nop
   # @ret
sw $s4, 20($fp)
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
lw $s5, 4($fp)
move $a0, $s5
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #0 = n LE 2
lw $s6, 20($fp)
lw $s7, 12($fp)
li $t0, 2
sle $s6, $s7, $t0
   # @bz #0 fibonacci_L_4_else_begin
sw $s5, 4($fp)
sw $s6, 20($fp)
sw $s7, 12($fp)
lw $s0, 20($fp)
beq $s0, $0, fibonacci_L_4_else_begin
nop
   # @ret
sw $s0, 20($fp)
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
lw $s1, 16($fp)
li $s1, 3
   # fibonacci_L_6_while_begin :
sw $s1, 16($fp)
fibonacci_L_6_while_begin:
   # #0 = i LE n
lw $s2, 20($fp)
lw $s3, 16($fp)
lw $s4, 12($fp)
sle $s2, $s3, $s4
   # @bz #0 fibonacci_L_7_while_over
sw $s2, 20($fp)
sw $s3, 16($fp)
sw $s4, 12($fp)
lw $s5, 20($fp)
beq $s5, $0, fibonacci_L_7_while_over
nop
   # #1 = b
lw $s6, 4($fp)
lw $s7, 24($fp)
move $s7, $s6
   # b = a
lw $s0, 0($fp)
move $s6, $s0
   # a = b ADD #1
add $s0, $s6, $s7
   # @printf int a
li $v0, 1
move $a0, $s0
syscall
   # @printf string S_17
li $v0, 4
la $a0, S_17
syscall
   # #2 = n DIV 10
lw $s1, 28($fp)
lw $s2, 12($fp)
div $s1, $s2, 10
   # #3 = #2 MUL 10
lw $s3, 32($fp)
mul $s3, $s1, 10
   # #5 = i ADD 1
lw $s4, 40($fp)
sw $s5, 20($fp)
lw $s5, 16($fp)
addi $s4, $s5, 1
   # #4 = #3 EQ #5
sw $s6, 4($fp)
lw $s6, 36($fp)
seq $s6, $s3, $s4
   # sum = a
sw $s7, 24($fp)
lw $s7, 8($fp)
move $s7, $s0
   # @bz #4 fibonacci_L_8_else_begin
sw $s0, 0($fp)
sw $s1, 28($fp)
sw $s2, 12($fp)
sw $s3, 32($fp)
sw $s4, 40($fp)
sw $s5, 16($fp)
sw $s6, 36($fp)
sw $s7, 8($fp)
lw $s0, 36($fp)
beq $s0, $0, fibonacci_L_8_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j fibonacci_L_9_else_over
sw $s0, 36($fp)
j fibonacci_L_9_else_over
nop
   # fibonacci_L_8_else_begin :
fibonacci_L_8_else_begin:
   # fibonacci_L_9_else_over :
fibonacci_L_9_else_over:
   # #0 = i
lw $s1, 16($fp)
lw $s2, 20($fp)
move $s2, $s1
   # i = #0 ADD 1
addi $s1, $s2, 1
   # @j fibonacci_L_6_while_begin
sw $s1, 16($fp)
sw $s2, 20($fp)
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
lw $s3, 400($fp)
move $s3, $v0
   # sort_L_0_while_begin :
sw $s3, 400($fp)
sort_L_0_while_begin:
   # #0 = size GE 100
lw $s4, 416($fp)
lw $s5, 400($fp)
li $t0, 100
sge $s4, $s5, $t0
   # @bz #0 sort_L_1_while_over
sw $s4, 416($fp)
sw $s5, 400($fp)
lw $s6, 416($fp)
beq $s6, $0, sort_L_1_while_over
nop
   # @printf string S_19
li $v0, 4
la $a0, S_19
syscall
   # #1 = size
lw $s7, 400($fp)
lw $s0, 420($fp)
move $s0, $s7
   # @scanf int size
li $v0, 5
syscall
move $s7, $v0
   # @j sort_L_0_while_begin
sw $s0, 420($fp)
sw $s6, 416($fp)
sw $s7, 400($fp)
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
lw $s1, 400($fp)
move $a0, $s1
syscall
   # @printf string S_21
li $v0, 4
la $a0, S_21
syscall
   # i = 0
lw $s2, 404($fp)
li $s2, 0
   # sort_L_2_while_begin :
sw $s1, 400($fp)
sw $s2, 404($fp)
sort_L_2_while_begin:
   # #0 = i LT size
lw $s3, 416($fp)
lw $s4, 404($fp)
lw $s5, 400($fp)
slt $s3, $s4, $s5
   # @bz #0 sort_L_3_while_over
sw $s3, 416($fp)
sw $s4, 404($fp)
sw $s5, 400($fp)
lw $s6, 416($fp)
beq $s6, $0, sort_L_3_while_over
nop
   # @scanf int temp
li $v0, 5
syscall
lw $s7, 412($fp)
move $s7, $v0
   # a = i ARSET temp
lw $s0, 404($fp)
sll $t1, $s0, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s7, ($t1)
   # #1 = i
lw $s1, 420($fp)
move $s1, $s0
   # i = #1 ADD 1
addi $s0, $s1, 1
   # @j sort_L_2_while_begin
sw $s0, 404($fp)
sw $s1, 420($fp)
sw $s6, 416($fp)
sw $s7, 412($fp)
j sort_L_2_while_begin
nop
   # sort_L_3_while_over :
sort_L_3_while_over:
   # i = 0
lw $s2, 404($fp)
li $s2, 0
   # sort_L_4_while_begin :
sw $s2, 404($fp)
sort_L_4_while_begin:
   # #1 = size SUB 1
lw $s3, 420($fp)
lw $s4, 400($fp)
addi $s3, $s4, -1
   # #0 = i LT #1
lw $s5, 416($fp)
lw $s6, 404($fp)
slt $s5, $s6, $s3
   # @bz #0 sort_L_5_while_over
sw $s3, 420($fp)
sw $s4, 400($fp)
sw $s5, 416($fp)
sw $s6, 404($fp)
lw $s7, 416($fp)
beq $s7, $0, sort_L_5_while_over
nop
   # j = 0
lw $s0, 408($fp)
li $s0, 0
   # sort_L_6_while_begin :
sw $s0, 408($fp)
sw $s7, 416($fp)
sort_L_6_while_begin:
   # #0 = size SUB 1
lw $s1, 416($fp)
lw $s2, 400($fp)
addi $s1, $s2, -1
   # #2 = #0 SUB i
lw $s3, 424($fp)
lw $s4, 404($fp)
sub $s3, $s1, $s4
   # #1 = j LT #2
lw $s5, 420($fp)
lw $s6, 408($fp)
slt $s5, $s6, $s3
   # @bz #1 sort_L_7_while_over
sw $s1, 416($fp)
sw $s2, 400($fp)
sw $s3, 424($fp)
sw $s4, 404($fp)
sw $s5, 420($fp)
sw $s6, 408($fp)
lw $s7, 420($fp)
beq $s7, $0, sort_L_7_while_over
nop
   # #3 = a ARGET j
lw $s0, 428($fp)
lw $s1, 408($fp)
sll $t1, $s1, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s0, ($t1)
   # #5 = j ADD 1
lw $s2, 436($fp)
addi $s2, $s1, 1
   # #6 = a ARGET #5
lw $s3, 440($fp)
sll $t1, $s2, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
lw $s3, ($t1)
   # #4 = #3 GT #6
lw $s4, 432($fp)
sgt $s4, $s0, $s3
   # @bz #4 sort_L_8_else_begin
sw $s0, 428($fp)
sw $s1, 408($fp)
sw $s2, 436($fp)
sw $s3, 440($fp)
sw $s4, 432($fp)
sw $s7, 420($fp)
lw $s5, 432($fp)
beq $s5, $0, sort_L_8_else_begin
nop
   # a = j ARSET #6
lw $s6, 440($fp)
lw $s7, 408($fp)
sll $t1, $s7, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s6, ($t1)
   # a = #5 ARSET temp
lw $s0, 412($fp)
lw $s1, 436($fp)
sll $t1, $s1, 2
add $t1, $t1, $fp
addi $t1, $t1, 0
sw $s0, ($t1)
   # @j sort_L_9_else_over
sw $s0, 412($fp)
sw $s1, 436($fp)
sw $s5, 432($fp)
sw $s6, 440($fp)
sw $s7, 408($fp)
j sort_L_9_else_over
nop
   # sort_L_8_else_begin :
sort_L_8_else_begin:
   # sort_L_9_else_over :
sort_L_9_else_over:
   # #0 = j
lw $s2, 408($fp)
lw $s3, 416($fp)
move $s3, $s2
   # j = #0 ADD 1
addi $s2, $s3, 1
   # @j sort_L_6_while_begin
sw $s2, 408($fp)
sw $s3, 416($fp)
j sort_L_6_while_begin
nop
   # sort_L_7_while_over :
sort_L_7_while_over:
   # #0 = i
lw $s4, 404($fp)
lw $s5, 416($fp)
move $s5, $s4
   # i = #0 ADD 1
addi $s4, $s5, 1
   # @j sort_L_4_while_begin
sw $s4, 404($fp)
sw $s5, 416($fp)
j sort_L_4_while_begin
nop
   # sort_L_5_while_over :
sort_L_5_while_over:
   # @printf string S_22
li $v0, 4
la $a0, S_22
syscall
   # i = 0
lw $s6, 404($fp)
li $s6, 0
   # sort_L_10_while_begin :
sw $s6, 404($fp)
sort_L_10_while_begin:
   # #0 = i LT size
lw $s7, 416($fp)
lw $s0, 404($fp)
lw $s1, 400($fp)
slt $s7, $s0, $s1
   # @bz #0 sort_L_11_while_over
sw $s0, 404($fp)
sw $s1, 400($fp)
sw $s7, 416($fp)
lw $s2, 416($fp)
beq $s2, $0, sort_L_11_while_over
nop
   # #1 = i
lw $s3, 404($fp)
lw $s4, 420($fp)
move $s4, $s3
   # i = #1 ADD 1
addi $s3, $s4, 1
   # #2 = i SUB 1
lw $s5, 424($fp)
addi $s5, $s3, -1
   # #3 = a ARGET #2
lw $s6, 428($fp)
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
   # #4 = i ADD 1
lw $s7, 432($fp)
addi $s7, $s3, 1
   # #5 = #4 DIV 10
lw $s0, 436($fp)
div $s0, $s7, 10
   # #6 = #5 MUL 10
lw $s1, 440($fp)
mul $s1, $s0, 10
   # #7 = #6 EQ #4
sw $s2, 416($fp)
lw $s2, 444($fp)
seq $s2, $s1, $s7
   # @bz #7 sort_L_12_else_begin
sw $s0, 436($fp)
sw $s1, 440($fp)
sw $s2, 444($fp)
sw $s3, 404($fp)
sw $s4, 420($fp)
sw $s5, 424($fp)
sw $s6, 428($fp)
sw $s7, 432($fp)
lw $s3, 444($fp)
beq $s3, $0, sort_L_12_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j sort_L_13_else_over
sw $s3, 444($fp)
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
   # @printf string S_23
li $v0, 4
la $a0, S_23
syscall
   # @printf string S_24
li $v0, 4
la $a0, S_24
syscall
   # @printf string S_25
li $v0, 4
la $a0, S_25
syscall
   # @printf string S_26
li $v0, 4
la $a0, S_26
syscall
   # @printf string S_27
li $v0, 4
la $a0, S_27
syscall
   # @printf string S_28
li $v0, 4
la $a0, S_28
syscall
   # @printf string S_29
li $v0, 4
la $a0, S_29
syscall
   # @printf string S_23
li $v0, 4
la $a0, S_23
syscall
   # @printf string S_30
li $v0, 4
la $a0, S_30
syscall
   # @scanf int i
li $v0, 5
syscall
lw $s4, 0($fp)
move $s4, $v0
   # #0 = #0
lw $s5, 8($fp)
move $s5, $s5
   # #0 = i DIV 1
div $s5, $s4, 1
   # #1 = #0 MUL 1
lw $s6, 12($fp)
mul $s6, $s5, 1
   # @be #1 0 select_L_3_case
sw $s4, 0($fp)
sw $s5, 8($fp)
sw $s6, 12($fp)
lw $s7, 12($fp)
beq $s7, 0, select_L_3_case
nop
   # @be #1 1 select_L_4_case
sw $s7, 12($fp)
lw $s0, 12($fp)
beq $s0, 1, select_L_4_case
nop
   # @be #1 2 select_L_5_case
sw $s0, 12($fp)
lw $s1, 12($fp)
beq $s1, 2, select_L_5_case
nop
   # @be #1 3 select_L_6_case
sw $s1, 12($fp)
lw $s2, 12($fp)
beq $s2, 3, select_L_6_case
nop
   # @be #1 4 select_L_7_case
sw $s2, 12($fp)
lw $s3, 12($fp)
beq $s3, 4, select_L_7_case
nop
   # @be #1 5 select_L_8_case
sw $s3, 12($fp)
lw $s4, 12($fp)
beq $s4, 5, select_L_8_case
nop
   # @j select_L_9_default
sw $s4, 12($fp)
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
   # @printf string S_31
li $v0, 4
la $a0, S_31
syscall
   # @scanf int num
li $v0, 5
syscall
lw $s5, 4($fp)
move $s5, $v0
   # @push 0
   # @push 99
   # @push num
   # @call find
sw $s5, 16($fp)
li $t0, 99
sw $t0, 20($fp)
li $t0, 0
sw $t0, 24($fp)
sw $s5, 4($fp)
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
lw $s6, 8($fp)
lw $s7, 0($fp)
li $t0, 0
seq $s6, $s7, $t0
   # @bz #0 select_L_10_else_begin
sw $s6, 8($fp)
sw $s7, 0($fp)
lw $s0, 8($fp)
beq $s0, $0, select_L_10_else_begin
nop
   # @printf string S_32
li $v0, 4
la $a0, S_32
syscall
   # @ret
sw $s0, 8($fp)
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
