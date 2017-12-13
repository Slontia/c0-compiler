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
   # @var int n
   # @var int x
   # @var int y
   # @var int kind
   # @var int m
   # @var int ans
   # @var int _a
   # @var int _b
   # @var char ch
   # @array char[] alphabet 26
   # @call main
addi $fp, $fp, 60
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
   # @exit
   # @func testdefine
testdefine_E:
   # @var int var0
   # @var int var1
   # @array int[] arr1 1
   # @var int var2
   # @array int[] arr2 2
   # @var int var3
   # @array int[] arr3 3
   # @var int var4
   # @array int[] arr4 4
   # @var int var5
   # @array int[] arr5 5
   # @var int var6
   # @array int[] arr6 6
   # @var int var7
   # @array int[] arr7 7
   # @var int var8
   # @array int[] arr8 8
   # @var int var9
   # @array int[] arr9 9
   # @var int var10
   # @array int[] arr10 10
   # @var int var11
   # @array int[] arr11 11
   # @var int var12
   # @array int[] arr12 12
   # @var int var13
   # @array int[] arr13 13
   # @var int var14
   # @array int[] arr14 14
   # @var int var15
   # @array int[] arr15 15
   # @var int var16
   # @array int[] arr16 16
   # @var int var17
   # @array int[] arr17 17
   # @var int var18
   # @array int[] arr18 18
   # @var int var19
   # @array int[] arr19 19
   # @ret
jr $ra
nop
   # @func fibo
fibo_E:
   # @para int n
lw $s0, 0($fp)
lw $s0, -4($fp)
   # #0 = n
lw $s1, 4($fp)
move $s1, $s0
   # #1 = #0
lw $s2, 8($fp)
move $s2, $s1
   # #1 = #1 LT 0
li $t0, 0
slt $s2, $s2, $t0
   # @bz #1 fibo_L_0_else_begin
sw $s0, 0($fp)
sw $s1, 4($fp)
sw $s2, 8($fp)
lw $s3, 8($fp)
beq $s3, $0, fibo_L_0_else_begin
nop
   # @ret -1
sw $s3, 8($fp)
li $v0, -1
jr $ra
nop
   # @j fibo_L_1_else_over
j fibo_L_1_else_over
nop
   # fibo_L_0_else_begin :
fibo_L_0_else_begin:
   # #2 = n
lw $s4, 12($fp)
lw $s5, 0($fp)
move $s4, $s5
   # #3 = #2
lw $s6, 16($fp)
move $s6, $s4
   # #3 = #3 EQ 0
li $t0, 0
seq $s6, $s6, $t0
   # @bz #3 fibo_L_2_else_begin
sw $s4, 12($fp)
sw $s5, 0($fp)
sw $s6, 16($fp)
lw $s7, 16($fp)
beq $s7, $0, fibo_L_2_else_begin
nop
   # @ret 0
sw $s7, 16($fp)
li $v0, 0
jr $ra
nop
   # @j fibo_L_3_else_over
j fibo_L_3_else_over
nop
   # fibo_L_2_else_begin :
fibo_L_2_else_begin:
   # #4 = n
lw $s0, 20($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #5 = #4
lw $s2, 24($fp)
move $s2, $s0
   # #5 = #5 EQ 1
li $t0, 1
seq $s2, $s2, $t0
   # @bz #5 fibo_L_4_else_begin
sw $s0, 20($fp)
sw $s1, 0($fp)
sw $s2, 24($fp)
lw $s3, 24($fp)
beq $s3, $0, fibo_L_4_else_begin
nop
   # @ret 1
sw $s3, 24($fp)
li $v0, 1
jr $ra
nop
   # @j fibo_L_5_else_over
j fibo_L_5_else_over
nop
   # fibo_L_4_else_begin :
fibo_L_4_else_begin:
   # #6 = n
lw $s4, 28($fp)
lw $s5, 0($fp)
move $s4, $s5
   # #7 = #6
lw $s6, 32($fp)
move $s6, $s4
   # #7 = #7 GT 10
li $t0, 10
sgt $s6, $s6, $t0
   # @bz #7 fibo_L_6_else_begin
sw $s4, 28($fp)
sw $s5, 0($fp)
sw $s6, 32($fp)
lw $s7, 32($fp)
beq $s7, $0, fibo_L_6_else_begin
nop
   # @ret -2
sw $s7, 32($fp)
li $v0, -2
jr $ra
nop
   # @j fibo_L_7_else_over
j fibo_L_7_else_over
nop
   # fibo_L_6_else_begin :
fibo_L_6_else_begin:
   # #8 = n
lw $s0, 36($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #9 = #8
lw $s2, 40($fp)
move $s2, $s0
   # #9 = #9 SUB 1
addi $s2, $s2, -1
   # @push #9
   # @call fibo
sw $s2, 44($fp)
sw $s0, 36($fp)
sw $s1, 0($fp)
sw $s2, 40($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 48
jal fibo_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #10
lw $s3, 44($fp)
move $s3, $v0
   # #11 = #10
lw $s4, 48($fp)
move $s4, $s3
   # #12 = #11
lw $s5, 52($fp)
move $s5, $s4
   # #13 = n
lw $s6, 56($fp)
lw $s7, 0($fp)
move $s6, $s7
   # #14 = #13
lw $s0, 60($fp)
move $s0, $s6
   # #14 = #14 SUB 2
addi $s0, $s0, -2
   # @push #14
   # @call fibo
sw $s0, 64($fp)
sw $s0, 60($fp)
sw $s3, 44($fp)
sw $s4, 48($fp)
sw $s5, 52($fp)
sw $s6, 56($fp)
sw $s7, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 68
jal fibo_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #15
lw $s1, 64($fp)
move $s1, $v0
   # #16 = #15
lw $s2, 68($fp)
move $s2, $s1
   # #12 = #12 ADD #16
lw $s3, 52($fp)
add $s3, $s3, $s2
   # @ret #12
sw $s1, 64($fp)
sw $s2, 68($fp)
sw $s3, 52($fp)
lw $s4, 52($fp)
move $v0, $s4
jr $ra
nop
   # fibo_L_7_else_over :
sw $s4, 52($fp)
fibo_L_7_else_over:
   # fibo_L_5_else_over :
fibo_L_5_else_over:
   # fibo_L_3_else_over :
fibo_L_3_else_over:
   # fibo_L_1_else_over :
fibo_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func upcase
upcase_E:
   # @para char x
lb $s5, 0($fp)
lw $s5, -4($fp)
   # @var char y
   # #0 = x
lw $s6, 4($fp)
move $s6, $s5
   # #1 = #0
lw $s7, 8($fp)
move $s7, $s6
   # #1 = #1 GE 97
li $t0, 97
sge $s7, $s7, $t0
   # @bz #1 upcase_L_0_else_begin
sb $s5, 0($fp)
sw $s6, 4($fp)
sw $s7, 8($fp)
lw $s0, 8($fp)
beq $s0, $0, upcase_L_0_else_begin
nop
   # #2 = x
lw $s1, 12($fp)
lb $s2, 0($fp)
move $s1, $s2
   # #3 = #2
lw $s3, 16($fp)
move $s3, $s1
   # #3 = #3 LE 122
li $t0, 122
sle $s3, $s3, $t0
   # @bz #3 upcase_L_2_else_begin
sw $s0, 8($fp)
sw $s1, 12($fp)
sb $s2, 0($fp)
sw $s3, 16($fp)
lw $s4, 16($fp)
beq $s4, $0, upcase_L_2_else_begin
nop
   # #4 = x
lw $s5, 20($fp)
lb $s6, 0($fp)
move $s5, $s6
   # #5 = #4
lw $s7, 24($fp)
move $s7, $s5
   # #5 = #5 SUB 97
addi $s7, $s7, -97
   # #5 = #5 ADD 65
addi $s7, $s7, 65
   # y = #5
lb $s0, 1($fp)
move $s0, $s7
   # #4 = y
move $s5, $s0
   # #5 = #4
move $s7, $s5
   # @ret #5
sb $s0, 1($fp)
sw $s4, 16($fp)
sw $s5, 20($fp)
sb $s6, 0($fp)
sw $s7, 24($fp)
lw $s1, 24($fp)
move $v0, $s1
jr $ra
nop
   # @j upcase_L_3_else_over
sw $s1, 24($fp)
j upcase_L_3_else_over
nop
   # upcase_L_2_else_begin :
upcase_L_2_else_begin:
   # #4 = x
lw $s2, 20($fp)
lb $s3, 0($fp)
move $s2, $s3
   # #5 = #4
lw $s4, 24($fp)
move $s4, $s2
   # @ret #5
sw $s2, 20($fp)
sb $s3, 0($fp)
sw $s4, 24($fp)
lw $s5, 24($fp)
move $v0, $s5
jr $ra
nop
   # upcase_L_3_else_over :
sw $s5, 24($fp)
upcase_L_3_else_over:
   # @j upcase_L_1_else_over
j upcase_L_1_else_over
nop
   # upcase_L_0_else_begin :
upcase_L_0_else_begin:
   # #2 = x
lw $s6, 12($fp)
lb $s7, 0($fp)
move $s6, $s7
   # #3 = #2
lw $s0, 16($fp)
move $s0, $s6
   # @ret #3
sw $s0, 16($fp)
sw $s6, 12($fp)
sb $s7, 0($fp)
lw $s1, 16($fp)
move $v0, $s1
jr $ra
nop
   # upcase_L_1_else_over :
sw $s1, 16($fp)
upcase_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func lowcase
lowcase_E:
   # @para char x
lb $s2, 0($fp)
lw $s2, -4($fp)
   # @var char y
   # #0 = x
lw $s3, 4($fp)
move $s3, $s2
   # #1 = #0
lw $s4, 8($fp)
move $s4, $s3
   # #1 = #1 GE 65
li $t0, 65
sge $s4, $s4, $t0
   # @bz #1 lowcase_L_0_else_begin
sb $s2, 0($fp)
sw $s3, 4($fp)
sw $s4, 8($fp)
lw $s5, 8($fp)
beq $s5, $0, lowcase_L_0_else_begin
nop
   # #2 = x
lw $s6, 12($fp)
lb $s7, 0($fp)
move $s6, $s7
   # #3 = #2
lw $s0, 16($fp)
move $s0, $s6
   # #3 = #3 LE 90
li $t0, 90
sle $s0, $s0, $t0
   # @bz #3 lowcase_L_2_else_begin
sw $s0, 16($fp)
sw $s5, 8($fp)
sw $s6, 12($fp)
sb $s7, 0($fp)
lw $s1, 16($fp)
beq $s1, $0, lowcase_L_2_else_begin
nop
   # #4 = x
lw $s2, 20($fp)
lb $s3, 0($fp)
move $s2, $s3
   # #5 = #4
lw $s4, 24($fp)
move $s4, $s2
   # #5 = #5 SUB 65
addi $s4, $s4, -65
   # #5 = #5 ADD 97
addi $s4, $s4, 97
   # y = #5
lb $s5, 1($fp)
move $s5, $s4
   # #4 = y
move $s2, $s5
   # #5 = #4
move $s4, $s2
   # @ret #5
sw $s1, 16($fp)
sw $s2, 20($fp)
sb $s3, 0($fp)
sw $s4, 24($fp)
sb $s5, 1($fp)
lw $s6, 24($fp)
move $v0, $s6
jr $ra
nop
   # @j lowcase_L_3_else_over
sw $s6, 24($fp)
j lowcase_L_3_else_over
nop
   # lowcase_L_2_else_begin :
lowcase_L_2_else_begin:
   # #4 = x
lw $s7, 20($fp)
lb $s0, 0($fp)
move $s7, $s0
   # #5 = #4
lw $s1, 24($fp)
move $s1, $s7
   # @ret #5
sb $s0, 0($fp)
sw $s1, 24($fp)
sw $s7, 20($fp)
lw $s2, 24($fp)
move $v0, $s2
jr $ra
nop
   # lowcase_L_3_else_over :
sw $s2, 24($fp)
lowcase_L_3_else_over:
   # @j lowcase_L_1_else_over
j lowcase_L_1_else_over
nop
   # lowcase_L_0_else_begin :
lowcase_L_0_else_begin:
   # #2 = x
lw $s3, 12($fp)
lb $s4, 0($fp)
move $s3, $s4
   # #3 = #2
lw $s5, 16($fp)
move $s5, $s3
   # @ret #3
sw $s3, 12($fp)
sb $s4, 0($fp)
sw $s5, 16($fp)
lw $s6, 16($fp)
move $v0, $s6
jr $ra
nop
   # lowcase_L_1_else_over :
sw $s6, 16($fp)
lowcase_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func printspace
printspace_E:
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @ret
jr $ra
nop
   # @func operation
operation_E:
   # @para int x
lw $s7, 0($fp)
lw $s7, -4($fp)
   # @para int y
lw $s0, 4($fp)
lw $s0, -8($fp)
   # @para int kind
lw $s1, 8($fp)
lw $s1, -12($fp)
   # #0 = kind
lw $s2, 12($fp)
move $s2, $s1
   # #1 = #0
lw $s3, 16($fp)
move $s3, $s2
   # @j operation_L_0_switch_branch
sw $s0, 4($fp)
sw $s1, 8($fp)
sw $s2, 12($fp)
sw $s3, 16($fp)
sw $s7, 0($fp)
j operation_L_0_switch_branch
nop
   # operation_L_2_case :
operation_L_2_case:
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #2 = x
lw $s4, 20($fp)
lw $s5, 0($fp)
move $s4, $s5
   # #3 = #2
lw $s6, 24($fp)
move $s6, $s4
   # #4 = y
lw $s7, 28($fp)
lw $s0, 4($fp)
move $s7, $s0
   # #3 = #3 ADD #4
add $s6, $s6, $s7
   # @printf int #3
li $v0, 1
move $a0, $s6
syscall
   # #2 = x
move $s4, $s5
   # #3 = #2
move $s6, $s4
   # #4 = y
move $s7, $s0
   # #3 = #3 ADD #4
add $s6, $s6, $s7
   # @ret #3
sw $s0, 4($fp)
sw $s4, 20($fp)
sw $s5, 0($fp)
sw $s6, 24($fp)
sw $s7, 28($fp)
lw $s1, 24($fp)
move $v0, $s1
jr $ra
nop
   # @j operation_L_1_switch_over
sw $s1, 24($fp)
j operation_L_1_switch_over
nop
   # operation_L_3_case :
operation_L_3_case:
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #2 = x
lw $s2, 20($fp)
lw $s3, 0($fp)
move $s2, $s3
   # #3 = #2
lw $s4, 24($fp)
move $s4, $s2
   # #4 = y
lw $s5, 28($fp)
lw $s6, 4($fp)
move $s5, $s6
   # #3 = #3 SUB #4
sub $s4, $s4, $s5
   # @printf int #3
li $v0, 1
move $a0, $s4
syscall
   # #2 = x
move $s2, $s3
   # #3 = #2
move $s4, $s2
   # #4 = y
move $s5, $s6
   # #3 = #3 SUB #4
sub $s4, $s4, $s5
   # @ret #3
sw $s2, 20($fp)
sw $s3, 0($fp)
sw $s4, 24($fp)
sw $s5, 28($fp)
sw $s6, 4($fp)
lw $s7, 24($fp)
move $v0, $s7
jr $ra
nop
   # @j operation_L_1_switch_over
sw $s7, 24($fp)
j operation_L_1_switch_over
nop
   # operation_L_4_case :
operation_L_4_case:
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #2 = x
lw $s0, 20($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #2 = #2 MUL y
lw $s2, 4($fp)
mul $s0, $s0, $s2
   # #3 = #2
lw $s3, 24($fp)
move $s3, $s0
   # @printf int #3
li $v0, 1
move $a0, $s3
syscall
   # #2 = x
move $s0, $s1
   # #2 = #2 MUL y
mul $s0, $s0, $s2
   # #3 = #2
move $s3, $s0
   # @ret #3
sw $s0, 20($fp)
sw $s1, 0($fp)
sw $s2, 4($fp)
sw $s3, 24($fp)
lw $s4, 24($fp)
move $v0, $s4
jr $ra
nop
   # @j operation_L_1_switch_over
sw $s4, 24($fp)
j operation_L_1_switch_over
nop
   # operation_L_5_case :
operation_L_5_case:
   # #2 = y
lw $s5, 20($fp)
lw $s6, 4($fp)
move $s5, $s6
   # #3 = #2
lw $s7, 24($fp)
move $s7, $s5
   # #3 = #3 NE 0
li $t0, 0
sne $s7, $s7, $t0
   # @bz #3 operation_L_6_else_begin
sw $s5, 20($fp)
sw $s6, 4($fp)
sw $s7, 24($fp)
lw $s0, 24($fp)
beq $s0, $0, operation_L_6_else_begin
nop
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # #4 = x
lw $s1, 28($fp)
lw $s2, 0($fp)
move $s1, $s2
   # #4 = #4 DIV y
lw $s3, 4($fp)
div $s1, $s1, $s3
   # #5 = #4
lw $s4, 32($fp)
move $s4, $s1
   # @printf int #5
li $v0, 1
move $a0, $s4
syscall
   # #4 = x
move $s1, $s2
   # #4 = #4 DIV y
div $s1, $s1, $s3
   # #5 = #4
move $s4, $s1
   # @ret #5
sw $s0, 24($fp)
sw $s1, 28($fp)
sw $s2, 0($fp)
sw $s3, 4($fp)
sw $s4, 32($fp)
lw $s5, 32($fp)
move $v0, $s5
jr $ra
nop
   # @j operation_L_7_else_over
sw $s5, 32($fp)
j operation_L_7_else_over
nop
   # operation_L_6_else_begin :
operation_L_6_else_begin:
   # @printf string S_2
li $v0, 4
la $a0, S_2
syscall
   # @ret 0
li $v0, 0
jr $ra
nop
   # operation_L_7_else_over :
operation_L_7_else_over:
   # @j operation_L_1_switch_over
j operation_L_1_switch_over
nop
   # operation_L_8_default :
operation_L_8_default:
   # @printf string S_3
li $v0, 4
la $a0, S_3
syscall
   # @ret -1
li $v0, -1
jr $ra
nop
   # @j operation_L_1_switch_over
j operation_L_1_switch_over
nop
   # operation_L_0_switch_branch :
operation_L_0_switch_branch:
   # @be #1 1 operation_L_2_case
lw $s6, 16($fp)
beq $s6, 1, operation_L_2_case
nop
   # @be #1 2 operation_L_3_case
sw $s6, 16($fp)
lw $s7, 16($fp)
beq $s7, 2, operation_L_3_case
nop
   # @be #1 3 operation_L_4_case
sw $s7, 16($fp)
lw $s0, 16($fp)
beq $s0, 3, operation_L_4_case
nop
   # @be #1 4 operation_L_5_case
sw $s0, 16($fp)
lw $s1, 16($fp)
beq $s1, 4, operation_L_5_case
nop
   # @j operation_L_8_default
sw $s1, 16($fp)
j operation_L_8_default
nop
   # operation_L_1_switch_over :
operation_L_1_switch_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func display
display_E:
   # @para int m
lw $s2, 0($fp)
lw $s2, -4($fp)
   # @var int i
   # @var char letter
   # #0 = m
lw $s3, 12($fp)
move $s3, $s2
   # #1 = #0
lw $s4, 16($fp)
move $s4, $s3
   # #1 = #1 LE 0
li $t0, 0
sle $s4, $s4, $t0
   # @bz #1 display_L_0_else_begin
sw $s2, 0($fp)
sw $s3, 12($fp)
sw $s4, 16($fp)
lw $s5, 16($fp)
beq $s5, $0, display_L_0_else_begin
nop
   # @ret
sw $s5, 16($fp)
jr $ra
nop
   # @j display_L_1_else_over
j display_L_1_else_over
nop
   # display_L_0_else_begin :
display_L_0_else_begin:
   # #2 = m
lw $s6, 20($fp)
lw $s7, 0($fp)
move $s6, $s7
   # #3 = #2
lw $s0, 24($fp)
move $s0, $s6
   # #3 = #3 GT 26
li $t0, 26
sgt $s0, $s0, $t0
   # @bz #3 display_L_2_else_begin
sw $s0, 24($fp)
sw $s6, 20($fp)
sw $s7, 0($fp)
lw $s1, 24($fp)
beq $s1, $0, display_L_2_else_begin
nop
   # m = 26
lw $s2, 0($fp)
li $s2, 26
   # @j display_L_3_else_over
sw $s1, 24($fp)
sw $s2, 0($fp)
j display_L_3_else_over
nop
   # display_L_2_else_begin :
display_L_2_else_begin:
   # i = 0
lw $s3, 4($fp)
li $s3, 0
   # letter = 97
lb $s4, 8($fp)
li $s4, 97
   # display_L_4_while_begin :
sw $s3, 4($fp)
sb $s4, 8($fp)
display_L_4_while_begin:
   # #4 = i
lw $s5, 28($fp)
lw $s6, 4($fp)
move $s5, $s6
   # #5 = #4
lw $s7, 32($fp)
move $s7, $s5
   # #6 = m
lw $s0, 36($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #7 = #6
lw $s2, 40($fp)
move $s2, $s0
   # #5 = #5 LT #7
slt $s7, $s7, $s2
   # @bz #5 display_L_5_while_over
sw $s0, 36($fp)
sw $s1, 0($fp)
sw $s2, 40($fp)
sw $s5, 28($fp)
sw $s6, 4($fp)
sw $s7, 32($fp)
lw $s3, 32($fp)
beq $s3, $0, display_L_5_while_over
nop
   # #8 = i
lw $s4, 44($fp)
lw $s5, 4($fp)
move $s4, $s5
   # #9 = #8
lw $s6, 48($fp)
move $s6, $s4
   # #10 = letter
lw $s7, 52($fp)
lb $s0, 8($fp)
move $s7, $s0
   # #11 = #10
lw $s1, 56($fp)
move $s1, $s7
   # @push #11
   # @call upcase
sw $s1, 60($fp)
sb $s0, 8($fp)
sw $s1, 56($fp)
sw $s3, 32($fp)
sw $s4, 44($fp)
sw $s5, 4($fp)
sw $s6, 48($fp)
sw $s7, 52($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 64
jal upcase_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #12
lw $s2, 60($fp)
move $s2, $v0
   # #13 = #12
lw $s3, 64($fp)
move $s3, $s2
   # #14 = #13
lw $s4, 68($fp)
move $s4, $s3
   # alphabet = #9 ARSET #14
lw $s5, 48($fp)
add $t1, $s5, $fp
addi $t1, $t1, -1
sb $s4, ($t1)
   # #8 = i
lw $s6, 44($fp)
lw $s7, 4($fp)
move $s6, $s7
   # #9 = #8
move $s5, $s6
   # #10 = letter
lw $s0, 52($fp)
lb $s1, 8($fp)
move $s0, $s1
   # #11 = #10
sw $s2, 60($fp)
lw $s2, 56($fp)
move $s2, $s0
   # @push #11
   # @call upcase
sw $s2, 72($fp)
sw $s0, 52($fp)
sb $s1, 8($fp)
sw $s2, 56($fp)
sw $s3, 64($fp)
sw $s4, 68($fp)
sw $s5, 48($fp)
sw $s6, 44($fp)
sw $s7, 4($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 76
jal upcase_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #12
lw $s3, 60($fp)
move $s3, $v0
   # #13 = #12
lw $s4, 64($fp)
move $s4, $s3
   # #14 = #13
lw $s5, 68($fp)
move $s5, $s4
   # alphabet = #9 ARSET #14
lw $s6, 48($fp)
add $t1, $s6, $fp
addi $t1, $t1, -1
sb $s5, ($t1)
   # #8 = i
lw $s7, 44($fp)
lw $s0, 4($fp)
move $s7, $s0
   # #9 = #8
move $s6, $s7
   # #10 = alphabet ARGET #9
lw $s1, 52($fp)
add $t1, $s6, $fp
addi $t1, $t1, -1
lb $s1, ($t1)
   # #11 = #10
lw $s2, 56($fp)
move $s2, $s1
   # #12 = #11
move $s3, $s2
   # @printf char #12
li $v0, 11
move $a0, $s3
syscall
   # #8 = i
move $s7, $s0
   # #9 = #8
move $s6, $s7
   # #9 = #9 ADD 1
addi $s6, $s6, 1
   # i = #9
move $s0, $s6
   # #8 = letter
sw $s3, 60($fp)
lb $s3, 8($fp)
move $s7, $s3
   # #9 = #8
move $s6, $s7
   # #9 = #9 ADD 1
addi $s6, $s6, 1
   # letter = #9
move $s3, $s6
   # @j display_L_4_while_begin
sw $s0, 4($fp)
sw $s1, 52($fp)
sw $s2, 56($fp)
sb $s3, 8($fp)
sw $s4, 64($fp)
sw $s5, 68($fp)
sw $s6, 48($fp)
sw $s7, 44($fp)
j display_L_4_while_begin
nop
   # display_L_5_while_over :
display_L_5_while_over:
   # @call printspace
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 72
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # i = 0
lw $s4, 4($fp)
li $s4, 0
   # display_L_6_while_begin :
sw $s4, 4($fp)
display_L_6_while_begin:
   # #4 = i
lw $s5, 28($fp)
lw $s6, 4($fp)
move $s5, $s6
   # #5 = #4
lw $s7, 32($fp)
move $s7, $s5
   # #6 = m
lw $s0, 36($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #7 = #6
lw $s2, 40($fp)
move $s2, $s0
   # #5 = #5 LT #7
slt $s7, $s7, $s2
   # @bz #5 display_L_7_while_over
sw $s0, 36($fp)
sw $s1, 0($fp)
sw $s2, 40($fp)
sw $s5, 28($fp)
sw $s6, 4($fp)
sw $s7, 32($fp)
lw $s3, 32($fp)
beq $s3, $0, display_L_7_while_over
nop
   # #8 = i
lw $s4, 44($fp)
lw $s5, 4($fp)
move $s4, $s5
   # #9 = #8
lw $s6, 48($fp)
move $s6, $s4
   # #10 = i
lw $s7, 52($fp)
move $s7, $s5
   # #11 = #10
lw $s0, 56($fp)
move $s0, $s7
   # #12 = alphabet ARGET #11
lw $s1, 60($fp)
add $t1, $s0, $fp
addi $t1, $t1, -1
lb $s1, ($t1)
   # #13 = #12
lw $s2, 64($fp)
move $s2, $s1
   # #14 = #13
sw $s3, 32($fp)
lw $s3, 68($fp)
move $s3, $s2
   # @push #14
   # @call lowcase
sw $s3, 72($fp)
sw $s0, 56($fp)
sw $s1, 60($fp)
sw $s2, 64($fp)
sw $s3, 68($fp)
sw $s4, 44($fp)
sw $s5, 4($fp)
sw $s6, 48($fp)
sw $s7, 52($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 76
jal lowcase_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #15
lw $s4, 72($fp)
move $s4, $v0
   # #16 = #15
lw $s5, 76($fp)
move $s5, $s4
   # #17 = #16
lw $s6, 80($fp)
move $s6, $s5
   # alphabet = #9 ARSET #17
lw $s7, 48($fp)
add $t1, $s7, $fp
addi $t1, $t1, -1
sb $s6, ($t1)
   # #8 = i
lw $s0, 44($fp)
lw $s1, 4($fp)
move $s0, $s1
   # #9 = #8
move $s7, $s0
   # #10 = alphabet ARGET #9
lw $s2, 52($fp)
add $t1, $s7, $fp
addi $t1, $t1, -1
lb $s2, ($t1)
   # #11 = #10
lw $s3, 56($fp)
move $s3, $s2
   # #12 = #11
sw $s4, 72($fp)
lw $s4, 60($fp)
move $s4, $s3
   # @printf char #12
li $v0, 11
move $a0, $s4
syscall
   # #8 = i
move $s0, $s1
   # #9 = #8
move $s7, $s0
   # #9 = #9 ADD 1
addi $s7, $s7, 1
   # i = #9
move $s1, $s7
   # @j display_L_6_while_begin
sw $s0, 44($fp)
sw $s1, 4($fp)
sw $s2, 52($fp)
sw $s3, 56($fp)
sw $s4, 60($fp)
sw $s5, 76($fp)
sw $s6, 80($fp)
sw $s7, 48($fp)
j display_L_6_while_begin
nop
   # display_L_7_while_over :
display_L_7_while_over:
   # @call printspace
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 84
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # display_L_3_else_over :
display_L_3_else_over:
   # display_L_1_else_over :
display_L_1_else_over:
   # @ret
jr $ra
nop
   # @func expre
expre_E:
   # @var int x
   # @var int y
   # @var int z
   # @scanf int x
li $v0, 5
syscall
lw $s5, 0($fp)
move $s5, $v0
   # @scanf int y
li $v0, 5
syscall
lw $s6, 4($fp)
move $s6, $v0
   # #0 = x
lw $s7, 12($fp)
move $s7, $s5
   # #1 = #0
lw $s0, 16($fp)
move $s0, $s7
   # #2 = y
lw $s1, 20($fp)
move $s1, $s6
   # #1 = #1 ADD #2
add $s0, $s0, $s1
   # #3 = #1
lw $s2, 24($fp)
move $s2, $s0
   # #4 = #3
lw $s3, 28($fp)
move $s3, $s2
   # #5 = y
lw $s4, 32($fp)
move $s4, $s6
   # #5 = #5 MUL -2
mul $s4, $s4, -2
   # #6 = 0 SUB #5
sw $s5, 0($fp)
lw $s5, 36($fp)
sub $s5, $0, $s4
   # #7 = #6
sw $s6, 4($fp)
lw $s6, 40($fp)
move $s6, $s5
   # #4 = #4 SUB #7
sub $s3, $s3, $s6
   # #4 = #4 ADD 0
addi $s3, $s3, 0
   # #8 = #4
sw $s7, 12($fp)
lw $s7, 44($fp)
move $s7, $s3
   # #9 = #8
sw $s0, 16($fp)
lw $s0, 48($fp)
move $s0, $s7
   # z = #9
sw $s1, 20($fp)
lw $s1, 8($fp)
move $s1, $s0
   # @printf string S_4
li $v0, 4
la $a0, S_4
syscall
   # #0 = z
sw $s2, 24($fp)
lw $s2, 12($fp)
move $s2, $s1
   # #1 = #0
sw $s3, 28($fp)
lw $s3, 16($fp)
move $s3, $s2
   # @printf int #1
li $v0, 1
move $a0, $s3
syscall
   # @call printspace
sw $s0, 48($fp)
sw $s1, 8($fp)
sw $s2, 12($fp)
sw $s3, 16($fp)
sw $s4, 32($fp)
sw $s5, 36($fp)
sw $s6, 40($fp)
sw $s7, 44($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @ret
jr $ra
nop
   # @func mod
mod_E:
   # @para int x
lw $s4, 0($fp)
lw $s4, -4($fp)
   # @para int y
lw $s5, 4($fp)
lw $s5, -8($fp)
   # @var int z
   # #0 = x
lw $s6, 12($fp)
move $s6, $s4
   # #1 = #0
lw $s7, 16($fp)
move $s7, $s6
   # #2 = x
lw $s0, 20($fp)
move $s0, $s4
   # #2 = #2 DIV y
div $s0, $s0, $s5
   # #2 = #2 MUL y
mul $s0, $s0, $s5
   # #1 = #1 SUB #2
sub $s7, $s7, $s0
   # z = #1
lw $s1, 8($fp)
move $s1, $s7
   # #0 = z
move $s6, $s1
   # #1 = #0
move $s7, $s6
   # @ret #1
sw $s0, 20($fp)
sw $s1, 8($fp)
sw $s4, 0($fp)
sw $s5, 4($fp)
sw $s6, 12($fp)
sw $s7, 16($fp)
lw $s2, 16($fp)
move $v0, $s2
jr $ra
nop
   # @ret 0
sw $s2, 16($fp)
li $v0, 0
jr $ra
nop
   # @func gcd
gcd_E:
   # @para int a
lw $s3, 0($fp)
lw $s3, -4($fp)
   # @para int b
lw $s4, 4($fp)
lw $s4, -8($fp)
   # #0 = b
lw $s5, 8($fp)
move $s5, $s4
   # #1 = #0
lw $s6, 12($fp)
move $s6, $s5
   # #1 = #1 EQ 0
li $t0, 0
seq $s6, $s6, $t0
   # @bz #1 gcd_L_0_else_begin
sw $s3, 0($fp)
sw $s4, 4($fp)
sw $s5, 8($fp)
sw $s6, 12($fp)
lw $s7, 12($fp)
beq $s7, $0, gcd_L_0_else_begin
nop
   # @ret 0
sw $s7, 12($fp)
li $v0, 0
jr $ra
nop
   # @j gcd_L_1_else_over
j gcd_L_1_else_over
nop
   # gcd_L_0_else_begin :
gcd_L_0_else_begin:
   # #2 = a
lw $s0, 16($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #3 = #2
lw $s2, 20($fp)
move $s2, $s0
   # @push #3
   # #4 = b
lw $s3, 24($fp)
lw $s4, 4($fp)
move $s3, $s4
   # #5 = #4
lw $s5, 28($fp)
move $s5, $s3
   # @push #5
   # @call mod
sw $s2, 36($fp)
sw $s5, 32($fp)
sw $s0, 16($fp)
sw $s1, 0($fp)
sw $s2, 20($fp)
sw $s3, 24($fp)
sw $s4, 4($fp)
sw $s5, 28($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 40
jal mod_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #6
lw $s6, 32($fp)
move $s6, $v0
   # #7 = #6
lw $s7, 36($fp)
move $s7, $s6
   # #8 = #7
lw $s0, 40($fp)
move $s0, $s7
   # #8 = #8 EQ 0
li $t0, 0
seq $s0, $s0, $t0
   # @bz #8 gcd_L_2_else_begin
sw $s0, 40($fp)
sw $s6, 32($fp)
sw $s7, 36($fp)
lw $s1, 40($fp)
beq $s1, $0, gcd_L_2_else_begin
nop
   # #9 = b
lw $s2, 44($fp)
lw $s3, 4($fp)
move $s2, $s3
   # #10 = #9
lw $s4, 48($fp)
move $s4, $s2
   # @ret #10
sw $s1, 40($fp)
sw $s2, 44($fp)
sw $s3, 4($fp)
sw $s4, 48($fp)
lw $s5, 48($fp)
move $v0, $s5
jr $ra
nop
   # @j gcd_L_3_else_over
sw $s5, 48($fp)
j gcd_L_3_else_over
nop
   # gcd_L_2_else_begin :
gcd_L_2_else_begin:
   # #9 = b
lw $s6, 44($fp)
lw $s7, 4($fp)
move $s6, $s7
   # #10 = #9
lw $s0, 48($fp)
move $s0, $s6
   # @push #10
   # #11 = a
lw $s1, 52($fp)
lw $s2, 0($fp)
move $s1, $s2
   # #12 = #11
lw $s3, 56($fp)
move $s3, $s1
   # @push #12
   # #13 = b
lw $s4, 60($fp)
move $s4, $s7
   # #14 = #13
lw $s5, 64($fp)
move $s5, $s4
   # @push #14
   # @call mod
sw $s0, 76($fp)
sw $s3, 72($fp)
sw $s5, 68($fp)
sw $s0, 48($fp)
sw $s1, 52($fp)
sw $s2, 0($fp)
sw $s3, 56($fp)
sw $s4, 60($fp)
sw $s5, 64($fp)
sw $s6, 44($fp)
sw $s7, 4($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 80
jal mod_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #15
lw $s6, 68($fp)
move $s6, $v0
   # #16 = #15
lw $s7, 72($fp)
move $s7, $s6
   # #17 = #16
lw $s0, 76($fp)
move $s0, $s7
   # @push #17
   # @call gcd
sw $s0, 80($fp)
sw $s0, 76($fp)
sw $s6, 68($fp)
sw $s7, 72($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 84
jal gcd_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #18
lw $s1, 80($fp)
move $s1, $v0
   # #19 = #18
lw $s2, 84($fp)
move $s2, $s1
   # #20 = #19
lw $s3, 88($fp)
move $s3, $s2
   # @ret #20
sw $s1, 80($fp)
sw $s2, 84($fp)
sw $s3, 88($fp)
lw $s4, 88($fp)
move $v0, $s4
jr $ra
nop
   # gcd_L_3_else_over :
sw $s4, 88($fp)
gcd_L_3_else_over:
   # gcd_L_1_else_over :
gcd_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func optimize
optimize_E:
   # @var int i
   # @var int a
   # @var int b
   # @var int c
   # @var int t1
   # @var int t2
   # @var int t3
   # @var int t4
   # i = 0
lw $s5, 0($fp)
li $s5, 0
   # c = 1
lw $s6, 12($fp)
li $s6, 1
   # b = 1
lw $s7, 8($fp)
li $s7, 1
   # optimize_L_0_while_begin :
sw $s5, 0($fp)
sw $s6, 12($fp)
sw $s7, 8($fp)
optimize_L_0_while_begin:
   # #0 = i
lw $s0, 32($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #1 = #0
lw $s2, 36($fp)
move $s2, $s0
   # #1 = #1 LT 10000
li $t0, 10000
slt $s2, $s2, $t0
   # @bz #1 optimize_L_1_while_over
sw $s0, 32($fp)
sw $s1, 0($fp)
sw $s2, 36($fp)
lw $s3, 36($fp)
beq $s3, $0, optimize_L_1_while_over
nop
   # #2 = i
lw $s4, 40($fp)
lw $s5, 0($fp)
move $s4, $s5
   # #3 = #2
lw $s6, 44($fp)
move $s6, $s4
   # #3 = #3 ADD 1
addi $s6, $s6, 1
   # i = #3
move $s5, $s6
   # #2 = c
lw $s7, 12($fp)
move $s4, $s7
   # #3 = 0 SUB #2
sub $s6, $0, $s4
   # t1 = #3
lw $s0, 16($fp)
move $s0, $s6
   # #2 = b
lw $s1, 8($fp)
move $s4, $s1
   # #2 = #2 MUL t1
mul $s4, $s4, $s0
   # #3 = #2
move $s6, $s4
   # t2 = #3
lw $s2, 20($fp)
move $s2, $s6
   # #2 = c
move $s4, $s7
   # #3 = 0 SUB #2
sub $s6, $0, $s4
   # t3 = #3
sw $s3, 36($fp)
lw $s3, 24($fp)
move $s3, $s6
   # #2 = b
move $s4, $s1
   # #2 = #2 MUL t3
mul $s4, $s4, $s3
   # #3 = #2
move $s6, $s4
   # c = #3
move $s7, $s6
   # #2 = t2
move $s4, $s2
   # #3 = #2
move $s6, $s4
   # #4 = c
sw $s4, 40($fp)
lw $s4, 48($fp)
move $s4, $s7
   # #3 = #3 ADD #4
add $s6, $s6, $s4
   # t4 = #3
sw $s5, 0($fp)
lw $s5, 28($fp)
move $s5, $s6
   # #2 = t4
sw $s6, 44($fp)
lw $s6, 40($fp)
move $s6, $s5
   # #3 = #2
sw $s7, 12($fp)
lw $s7, 44($fp)
move $s7, $s6
   # a = #3
sw $s0, 16($fp)
lw $s0, 4($fp)
move $s0, $s7
   # @j optimize_L_0_while_begin
sw $s0, 4($fp)
sw $s1, 8($fp)
sw $s2, 20($fp)
sw $s3, 24($fp)
sw $s4, 48($fp)
sw $s5, 28($fp)
sw $s6, 40($fp)
sw $s7, 44($fp)
j optimize_L_0_while_begin
nop
   # optimize_L_1_while_over :
optimize_L_1_while_over:
   # #0 = a
lw $s1, 32($fp)
lw $s2, 4($fp)
move $s1, $s2
   # #1 = #0
lw $s3, 36($fp)
move $s3, $s1
   # @printf int #1
li $v0, 1
move $a0, $s3
syscall
   # @call printspace
sw $s1, 32($fp)
sw $s2, 4($fp)
sw $s3, 36($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = b
lw $s4, 32($fp)
lw $s5, 8($fp)
move $s4, $s5
   # #1 = #0
lw $s6, 36($fp)
move $s6, $s4
   # @printf int #1
li $v0, 1
move $a0, $s6
syscall
   # @call printspace
sw $s4, 32($fp)
sw $s5, 8($fp)
sw $s6, 36($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = c
lw $s7, 32($fp)
lw $s0, 12($fp)
move $s7, $s0
   # #1 = #0
lw $s1, 36($fp)
move $s1, $s7
   # @printf int #1
li $v0, 1
move $a0, $s1
syscall
   # @call printspace
sw $s0, 12($fp)
sw $s1, 36($fp)
sw $s7, 32($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = t1
lw $s2, 32($fp)
lw $s3, 16($fp)
move $s2, $s3
   # #1 = #0
lw $s4, 36($fp)
move $s4, $s2
   # @printf int #1
li $v0, 1
move $a0, $s4
syscall
   # @call printspace
sw $s2, 32($fp)
sw $s3, 16($fp)
sw $s4, 36($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = t2
lw $s5, 32($fp)
lw $s6, 20($fp)
move $s5, $s6
   # #1 = #0
lw $s7, 36($fp)
move $s7, $s5
   # @printf int #1
li $v0, 1
move $a0, $s7
syscall
   # @call printspace
sw $s5, 32($fp)
sw $s6, 20($fp)
sw $s7, 36($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = t3
lw $s0, 32($fp)
lw $s1, 24($fp)
move $s0, $s1
   # #1 = #0
lw $s2, 36($fp)
move $s2, $s0
   # @printf int #1
li $v0, 1
move $a0, $s2
syscall
   # @call printspace
sw $s0, 32($fp)
sw $s1, 24($fp)
sw $s2, 36($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = t4
lw $s3, 32($fp)
lw $s4, 28($fp)
move $s3, $s4
   # #1 = #0
lw $s5, 36($fp)
move $s5, $s3
   # @printf int #1
li $v0, 1
move $a0, $s5
syscall
   # @ret
sw $s3, 32($fp)
sw $s4, 28($fp)
sw $s5, 36($fp)
jr $ra
nop
   # @func process
process_E:
   # @var int choice
   # @var char choice_ch
   # @scanf int choice
li $v0, 5
syscall
lw $s6, 0($fp)
move $s6, $v0
   # #0 = choice
lw $s7, 8($fp)
move $s7, $s6
   # #1 = #0
lw $s0, 12($fp)
move $s0, $s7
   # #1 = #1 ADD 97
addi $s0, $s0, 97
   # #1 = #1 SUB 1
addi $s0, $s0, -1
   # choice_ch = #1
lb $s1, 4($fp)
move $s1, $s0
   # #0 = choice_ch
move $s7, $s1
   # #1 = #0
move $s0, $s7
   # @j process_L_0_switch_branch
sw $s0, 12($fp)
sb $s1, 4($fp)
sw $s6, 0($fp)
sw $s7, 8($fp)
j process_L_0_switch_branch
nop
   # process_L_2_case :
process_L_2_case:
   # @call expre
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal expre_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j process_L_1_switch_over
j process_L_1_switch_over
nop
   # process_L_3_case :
process_L_3_case:
   # @scanf int n
li $v0, 5
syscall
lw $s2, 0($gp)
move $s2, $v0
   # #2 = n
lw $s3, 16($fp)
move $s3, $s2
   # #3 = #2
lw $s4, 20($fp)
move $s4, $s3
   # @push #3
   # @call fibo
sw $s4, 24($fp)
sw $s2, 0($gp)
sw $s3, 16($fp)
sw $s4, 20($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 28
jal fibo_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #4
lw $s5, 24($fp)
move $s5, $v0
   # #5 = #4
lw $s6, 28($fp)
move $s6, $s5
   # #6 = #5
lw $s7, 32($fp)
move $s7, $s6
   # ans = #6
lw $s0, 20($gp)
move $s0, $s7
   # @printf string S_5
li $v0, 4
la $a0, S_5
syscall
   # #2 = ans
lw $s1, 16($fp)
move $s1, $s0
   # #3 = #2
lw $s2, 20($fp)
move $s2, $s1
   # @printf int #3
li $v0, 1
move $a0, $s2
syscall
   # @call printspace
sw $s0, 20($gp)
sw $s1, 16($fp)
sw $s2, 20($fp)
sw $s5, 24($fp)
sw $s6, 28($fp)
sw $s7, 32($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 36
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j process_L_1_switch_over
j process_L_1_switch_over
nop
   # process_L_4_case :
process_L_4_case:
   # @scanf int x
li $v0, 5
syscall
lw $s3, 4($gp)
move $s3, $v0
   # @scanf int y
li $v0, 5
syscall
lw $s4, 8($gp)
move $s4, $v0
   # @scanf int kind
li $v0, 5
syscall
lw $s5, 12($gp)
move $s5, $v0
   # #2 = x
lw $s6, 16($fp)
move $s6, $s3
   # #3 = #2
lw $s7, 20($fp)
move $s7, $s6
   # @push #3
   # #4 = y
lw $s0, 24($fp)
move $s0, $s4
   # #5 = #4
lw $s1, 28($fp)
move $s1, $s0
   # @push #5
   # #6 = kind
lw $s2, 32($fp)
move $s2, $s5
   # #7 = #6
sw $s3, 4($gp)
lw $s3, 36($fp)
move $s3, $s2
   # @push #7
   # @call operation
sw $s7, 48($fp)
sw $s1, 44($fp)
sw $s3, 40($fp)
sw $s0, 24($fp)
sw $s1, 28($fp)
sw $s2, 32($fp)
sw $s3, 36($fp)
sw $s4, 8($gp)
sw $s5, 12($gp)
sw $s6, 16($fp)
sw $s7, 20($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal operation_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #8
lw $s4, 40($fp)
move $s4, $v0
   # #9 = #8
lw $s5, 44($fp)
move $s5, $s4
   # #10 = #9
lw $s6, 48($fp)
move $s6, $s5
   # ans = #10
lw $s7, 20($gp)
move $s7, $s6
   # @call printspace
sw $s4, 40($fp)
sw $s5, 44($fp)
sw $s6, 48($fp)
sw $s7, 20($gp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j process_L_1_switch_over
j process_L_1_switch_over
nop
   # process_L_5_case :
process_L_5_case:
   # @scanf int m
li $v0, 5
syscall
lw $s0, 16($gp)
move $s0, $v0
   # #2 = m
lw $s1, 16($fp)
move $s1, $s0
   # #3 = #2
lw $s2, 20($fp)
move $s2, $s1
   # @push #3
   # @call display
sw $s2, 52($fp)
sw $s0, 16($gp)
sw $s1, 16($fp)
sw $s2, 20($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 56
jal display_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j process_L_1_switch_over
j process_L_1_switch_over
nop
   # process_L_6_case :
process_L_6_case:
   # @scanf int _a
li $v0, 5
syscall
lw $s3, 24($gp)
move $s3, $v0
   # @scanf int _b
li $v0, 5
syscall
lw $s4, 28($gp)
move $s4, $v0
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # #2 = _a
lw $s5, 16($fp)
move $s5, $s3
   # #3 = #2
lw $s6, 20($fp)
move $s6, $s5
   # @push #3
   # #4 = _b
lw $s7, 24($fp)
move $s7, $s4
   # #5 = #4
lw $s0, 28($fp)
move $s0, $s7
   # @push #5
   # @call gcd
sw $s6, 56($fp)
sw $s0, 52($fp)
sw $s0, 28($fp)
sw $s3, 24($gp)
sw $s4, 28($gp)
sw $s5, 16($fp)
sw $s6, 20($fp)
sw $s7, 24($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 60
jal gcd_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #6
lw $s1, 32($fp)
move $s1, $v0
   # #7 = #6
lw $s2, 36($fp)
move $s2, $s1
   # #8 = #7
lw $s3, 40($fp)
move $s3, $s2
   # @printf int #8
li $v0, 1
move $a0, $s3
syscall
   # @call printspace
sw $s1, 32($fp)
sw $s2, 36($fp)
sw $s3, 40($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal printspace_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j process_L_1_switch_over
j process_L_1_switch_over
nop
   # process_L_7_case :
process_L_7_case:
   # @printf string S_7
li $v0, 4
la $a0, S_7
syscall
   # @j process_L_1_switch_over
j process_L_1_switch_over
nop
   # process_L_8_default :
process_L_8_default:
   # @call optimize
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal optimize_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j process_L_1_switch_over
j process_L_1_switch_over
nop
   # process_L_0_switch_branch :
process_L_0_switch_branch:
   # @be #1 97 process_L_2_case
lw $s4, 12($fp)
beq $s4, 97, process_L_2_case
nop
   # @be #1 98 process_L_3_case
sw $s4, 12($fp)
lw $s5, 12($fp)
beq $s5, 98, process_L_3_case
nop
   # @be #1 99 process_L_4_case
sw $s5, 12($fp)
lw $s6, 12($fp)
beq $s6, 99, process_L_4_case
nop
   # @be #1 100 process_L_5_case
sw $s6, 12($fp)
lw $s7, 12($fp)
beq $s7, 100, process_L_5_case
nop
   # @be #1 101 process_L_6_case
sw $s7, 12($fp)
lw $s0, 12($fp)
beq $s0, 101, process_L_6_case
nop
   # @be #1 102 process_L_7_case
sw $s0, 12($fp)
lw $s1, 12($fp)
beq $s1, 102, process_L_7_case
nop
   # @j process_L_8_default
sw $s1, 12($fp)
j process_L_8_default
nop
   # process_L_1_switch_over :
process_L_1_switch_over:
   # @ret
jr $ra
nop
   # @func main
main_E:
   # @var int i
   # @var int num
   # i = 0
lw $s2, 0($fp)
li $s2, 0
   # @call testdefine
sw $s2, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 8
jal testdefine_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @scanf int num
li $v0, 5
syscall
lw $s3, 4($fp)
move $s3, $v0
   # main_L_0_while_begin :
sw $s3, 4($fp)
main_L_0_while_begin:
   # #0 = i
lw $s4, 8($fp)
lw $s5, 0($fp)
move $s4, $s5
   # #1 = #0
lw $s6, 12($fp)
move $s6, $s4
   # #2 = num
lw $s7, 16($fp)
lw $s0, 4($fp)
move $s7, $s0
   # #3 = #2
lw $s1, 20($fp)
move $s1, $s7
   # #1 = #1 LT #3
slt $s6, $s6, $s1
   # @bz #1 main_L_1_while_over
sw $s0, 4($fp)
sw $s1, 20($fp)
sw $s4, 8($fp)
sw $s5, 0($fp)
sw $s6, 12($fp)
sw $s7, 16($fp)
lw $s2, 12($fp)
beq $s2, $0, main_L_1_while_over
nop
   # #4 = i
lw $s3, 24($fp)
lw $s4, 0($fp)
move $s3, $s4
   # #5 = #4
lw $s5, 28($fp)
move $s5, $s3
   # #5 = #5 ADD 1
addi $s5, $s5, 1
   # i = #5
move $s4, $s5
   # @call process
sw $s2, 12($fp)
sw $s3, 24($fp)
sw $s4, 0($fp)
sw $s5, 28($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 32
jal process_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @j main_L_0_while_begin
j main_L_0_while_begin
nop
   # main_L_1_while_over :
main_L_1_while_over:
   # @ret
jr $ra
nop
   # @ret
jr $ra
nop
