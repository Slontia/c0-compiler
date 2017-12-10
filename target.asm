   # @call main
addi $fp, $fp, 0
jal main_E
nop
li $v0, 10
syscall
   # @exit
   # @func fibonacci
fibonacci_E:
   # @var int a
   # @var int b
   # @var int sum
   # @var int n
   # @var int i
   # a = 1
lw $s0, 0($fp)
li $s0, 1
   # #0 = a
lw $s1, 20($fp)
move $s1, $s0
   # #1 = #0
lw $s2, 24($fp)
move $s2, $s1
   # b = #1
lw $s3, 4($fp)
move $s3, $s2
   # @scanf n
li $v0, 5
syscall
lw $s4, 12($fp)
move $s4, $a0
   # #2 = a
lw $s5, 28($fp)
move $s5, $s0
   # #3 = #2
lw $s6, 32($fp)
move $s6, $s5
   # @printf int #3
li $v0, 1
move $a0, $s6
syscall
   # #4 = b
lw $s7, 36($fp)
move $s7, $s3
   # #5 = #4
sw $s0, 0($fp)
lw $s0, 40($fp)
move $s0, $s7
   # @printf int #5
li $v0, 1
move $a0, $s0
syscall
   # i = 3
sw $s1, 20($fp)
lw $s1, 16($fp)
li $s1, 3
   # fibonacci_L_0_while_begin :
fibonacci_L_0_while_begin:
   # #6 = i
sw $s2, 24($fp)
lw $s2, 44($fp)
move $s2, $s1
   # #7 = #6
sw $s3, 4($fp)
lw $s3, 48($fp)
move $s3, $s2
   # #8 = n
sw $s4, 12($fp)
lw $s4, 52($fp)
sw $s5, 28($fp)
lw $s5, 12($fp)
move $s4, $s5
   # #9 = #8
sw $s6, 32($fp)
lw $s6, 56($fp)
move $s6, $s4
   # #7 = #7 LE #9
sle $s3, $s3, $s6
   # @bz #7 fibonacci_L_1_while_over
beq $s3, $0, fibonacci_L_1_while_over
nop
   # #10 = a
sw $s7, 36($fp)
lw $s7, 60($fp)
sw $s0, 40($fp)
lw $s0, 0($fp)
move $s7, $s0
   # #11 = #10
sw $s1, 16($fp)
lw $s1, 64($fp)
move $s1, $s7
   # #12 = b
sw $s2, 44($fp)
lw $s2, 68($fp)
sw $s3, 48($fp)
lw $s3, 4($fp)
move $s2, $s3
   # #11 = #11 ADD #12
add $s1, $s1, $s2
   # sum = #11
sw $s4, 52($fp)
lw $s4, 8($fp)
move $s4, $s1
   # #13 = a
sw $s5, 12($fp)
lw $s5, 72($fp)
move $s5, $s0
   # #14 = #13
sw $s6, 56($fp)
lw $s6, 76($fp)
move $s6, $s5
   # b = #14
move $s3, $s6
   # #15 = sum
sw $s7, 60($fp)
lw $s7, 80($fp)
move $s7, $s4
   # #16 = #15
sw $s0, 0($fp)
lw $s0, 84($fp)
move $s0, $s7
   # a = #16
sw $s1, 64($fp)
lw $s1, 0($fp)
move $s1, $s0
   # #17 = sum
sw $s2, 68($fp)
lw $s2, 88($fp)
move $s2, $s4
   # #18 = #17
sw $s3, 4($fp)
lw $s3, 92($fp)
move $s3, $s2
   # @printf int #18
li $v0, 1
move $a0, $s3
syscall
   # #19 = i
sw $s4, 8($fp)
lw $s4, 96($fp)
sw $s5, 72($fp)
lw $s5, 16($fp)
move $s4, $s5
   # #20 = #19
sw $s6, 76($fp)
lw $s6, 100($fp)
move $s6, $s4
   # #20 = #20 ADD 1
addi $s6, $s6, 1
   # i = #20
move $s5, $s6
   # @j fibonacci_L_0_while_begin
j fibonacci_L_0_while_begin
nop
   # fibonacci_L_1_while_over :
fibonacci_L_1_while_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func main
main_E:
   # @call fibonacci
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $sp, $sp, -4
sw $s0, 0($sp)
addi $sp, $sp, -4
sw $s1, 0($sp)
addi $sp, $sp, -4
sw $s2, 0($sp)
addi $sp, $sp, -4
sw $s3, 0($sp)
addi $sp, $sp, -4
sw $s4, 0($sp)
addi $sp, $sp, -4
sw $s5, 0($sp)
addi $sp, $sp, -4
sw $s6, 0($sp)
addi $sp, $sp, -4
sw $s7, 0($sp)
addi $fp, $fp, 0
jal fibonacci_E
nop
lw $s7, 0($sp)
addi $sp, $sp, 4
lw $s6, 0($sp)
addi $sp, $sp, 4
lw $s5, 0($sp)
addi $sp, $sp, 4
lw $s4, 0($sp)
addi $sp, $sp, 4
lw $s3, 0($sp)
addi $sp, $sp, 4
lw $s2, 0($sp)
addi $sp, $sp, 4
lw $s1, 0($sp)
addi $sp, $sp, 4
lw $s0, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @ret
jr $ra
nop
