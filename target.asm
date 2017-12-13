.data
S_0: .asciiz "The result of case i is done!"
S_1: .asciiz "The result of case c is done!"
S_2: .asciiz "result one is:"
S_3: .asciiz "result two is:"
S_4: .asciiz "The sum of numbers between two results is:"
S_5: .asciiz "no result!"
S_6: .asciiz "wrong input!"
.space 4
over_S:
.text
la $gp, over_S
andi $gp, $gp, 0xFFFFFFFC
   # @var int begin
   # @var int end
   # @var int res
   # @var int ps
   # @array char[] _s 300
   # @var char temp
   # @call main
addi $fp, $fp, 320
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
   # @exit
   # @func _asfunc_1
_asfunc_1_E:
   # @para int a
lw $s0, 0($fp)
lw $s0, -4($fp)
   # @para char c
lb $s1, 4($fp)
lw $s1, -8($fp)
   # #0 = a
lw $s2, 8($fp)
move $s2, $s0
   # #1 = #0
lw $s3, 12($fp)
move $s3, $s2
   # #1 = #1 GT 1
li $t0, 1
sgt $s3, $s3, $t0
   # @bz #1 _asfunc_1_L_0_else_begin
sw $s0, 0($fp)
sb $s1, 4($fp)
sw $s2, 8($fp)
sw $s3, 12($fp)
lw $s4, 12($fp)
beq $s4, $0, _asfunc_1_L_0_else_begin
nop
   # #2 = c
lw $s5, 16($fp)
lb $s6, 4($fp)
move $s5, $s6
   # #3 = #2
lw $s7, 20($fp)
move $s7, $s5
   # #3 = #3 SUB 105
addi $s7, $s7, -105
   # @j _asfunc_1_L_2_switch_branch
sw $s4, 12($fp)
sw $s5, 16($fp)
sb $s6, 4($fp)
sw $s7, 20($fp)
j _asfunc_1_L_2_switch_branch
nop
   # _asfunc_1_L_4_case :
_asfunc_1_L_4_case:
   # #4 = a
lw $s0, 24($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #5 = a
lw $s2, 28($fp)
move $s2, $s1
   # #6 = #5
lw $s3, 32($fp)
move $s3, $s2
   # #6 = #6 SUB 1
addi $s3, $s3, -1
   # @push #6
   # @push 105
   # @call _asfunc_1
sw $s3, 40($fp)
li $t0, 105
sw $t0, 36($fp)
sw $s0, 24($fp)
sw $s1, 0($fp)
sw $s2, 28($fp)
sw $s3, 32($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 44
jal _asfunc_1_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #7
lw $s4, 36($fp)
move $s4, $v0
   # #4 = #4 MUL #7
lw $s5, 24($fp)
mul $s5, $s5, $s4
   # #8 = #4
lw $s6, 40($fp)
move $s6, $s5
   # @ret #8
sw $s4, 36($fp)
sw $s5, 24($fp)
sw $s6, 40($fp)
lw $s7, 40($fp)
move $v0, $s7
jr $ra
nop
   # @j _asfunc_1_L_3_switch_over
sw $s7, 40($fp)
j _asfunc_1_L_3_switch_over
nop
   # _asfunc_1_L_5_default :
_asfunc_1_L_5_default:
   # #4 = a
lw $s0, 24($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #5 = a
lw $s2, 28($fp)
move $s2, $s1
   # #6 = #5
lw $s3, 32($fp)
move $s3, $s2
   # #6 = #6 SUB 1
addi $s3, $s3, -1
   # @push #6
   # @push 99
   # @call _asfunc_1
sw $s3, 48($fp)
li $t0, 99
sw $t0, 44($fp)
sw $s0, 24($fp)
sw $s1, 0($fp)
sw $s2, 28($fp)
sw $s3, 32($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 52
jal _asfunc_1_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #7
lw $s4, 36($fp)
move $s4, $v0
   # #4 = #4 MUL #7
lw $s5, 24($fp)
mul $s5, $s5, $s4
   # #8 = #4
lw $s6, 40($fp)
move $s6, $s5
   # @ret #8
sw $s4, 36($fp)
sw $s5, 24($fp)
sw $s6, 40($fp)
lw $s7, 40($fp)
move $v0, $s7
jr $ra
nop
   # @j _asfunc_1_L_3_switch_over
sw $s7, 40($fp)
j _asfunc_1_L_3_switch_over
nop
   # _asfunc_1_L_2_switch_branch :
_asfunc_1_L_2_switch_branch:
   # @be #3 0 _asfunc_1_L_4_case
lw $s0, 20($fp)
beq $s0, 0, _asfunc_1_L_4_case
nop
   # @j _asfunc_1_L_5_default
sw $s0, 20($fp)
j _asfunc_1_L_5_default
nop
   # _asfunc_1_L_3_switch_over :
_asfunc_1_L_3_switch_over:
   # @j _asfunc_1_L_1_else_over
j _asfunc_1_L_1_else_over
nop
   # _asfunc_1_L_0_else_begin :
_asfunc_1_L_0_else_begin:
   # #2 = c
lw $s1, 16($fp)
lb $s2, 4($fp)
move $s1, $s2
   # #3 = #2
lw $s3, 20($fp)
move $s3, $s1
   # @j _asfunc_1_L_6_switch_branch
sw $s1, 16($fp)
sb $s2, 4($fp)
sw $s3, 20($fp)
j _asfunc_1_L_6_switch_branch
nop
   # _asfunc_1_L_8_case :
_asfunc_1_L_8_case:
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @j _asfunc_1_L_7_switch_over
j _asfunc_1_L_7_switch_over
nop
   # _asfunc_1_L_9_default :
_asfunc_1_L_9_default:
   # @printf string S_1
li $v0, 4
la $a0, S_1
syscall
   # @j _asfunc_1_L_7_switch_over
j _asfunc_1_L_7_switch_over
nop
   # _asfunc_1_L_6_switch_branch :
_asfunc_1_L_6_switch_branch:
   # @be #3 105 _asfunc_1_L_8_case
lw $s4, 20($fp)
beq $s4, 105, _asfunc_1_L_8_case
nop
   # @j _asfunc_1_L_9_default
sw $s4, 20($fp)
j _asfunc_1_L_9_default
nop
   # _asfunc_1_L_7_switch_over :
_asfunc_1_L_7_switch_over:
   # @ret 1
li $v0, 1
jr $ra
nop
   # _asfunc_1_L_1_else_over :
_asfunc_1_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func min
min_E:
   # @para int a
lw $s5, 0($fp)
lw $s5, -4($fp)
   # @para int b
lw $s6, 4($fp)
lw $s6, -8($fp)
   # #0 = a
lw $s7, 8($fp)
move $s7, $s5
   # #1 = #0
lw $s0, 12($fp)
move $s0, $s7
   # #2 = b
lw $s1, 16($fp)
move $s1, $s6
   # #3 = #2
lw $s2, 20($fp)
move $s2, $s1
   # #1 = #1 LT #3
slt $s0, $s0, $s2
   # @bz #1 min_L_0_else_begin
sw $s0, 12($fp)
sw $s1, 16($fp)
sw $s2, 20($fp)
sw $s5, 0($fp)
sw $s6, 4($fp)
sw $s7, 8($fp)
lw $s3, 12($fp)
beq $s3, $0, min_L_0_else_begin
nop
   # #4 = a
lw $s4, 24($fp)
lw $s5, 0($fp)
move $s4, $s5
   # #5 = #4
lw $s6, 28($fp)
move $s6, $s4
   # @ret #5
sw $s3, 12($fp)
sw $s4, 24($fp)
sw $s5, 0($fp)
sw $s6, 28($fp)
lw $s7, 28($fp)
move $v0, $s7
jr $ra
nop
   # @j min_L_1_else_over
sw $s7, 28($fp)
j min_L_1_else_over
nop
   # min_L_0_else_begin :
min_L_0_else_begin:
   # #4 = a
lw $s0, 24($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #5 = #4
lw $s2, 28($fp)
move $s2, $s0
   # #6 = b
lw $s3, 32($fp)
lw $s4, 4($fp)
move $s3, $s4
   # #7 = #6
lw $s5, 36($fp)
move $s5, $s3
   # #5 = #5 EQ #7
seq $s2, $s2, $s5
   # @bz #5 min_L_2_else_begin
sw $s0, 24($fp)
sw $s1, 0($fp)
sw $s2, 28($fp)
sw $s3, 32($fp)
sw $s4, 4($fp)
sw $s5, 36($fp)
lw $s6, 28($fp)
beq $s6, $0, min_L_2_else_begin
nop
   # #8 = a
lw $s7, 40($fp)
lw $s0, 0($fp)
move $s7, $s0
   # #9 = #8
lw $s1, 44($fp)
move $s1, $s7
   # @ret #9
sw $s0, 0($fp)
sw $s1, 44($fp)
sw $s6, 28($fp)
sw $s7, 40($fp)
lw $s2, 44($fp)
move $v0, $s2
jr $ra
nop
   # @j min_L_3_else_over
sw $s2, 44($fp)
j min_L_3_else_over
nop
   # min_L_2_else_begin :
min_L_2_else_begin:
   # #8 = b
lw $s3, 40($fp)
lw $s4, 4($fp)
move $s3, $s4
   # #9 = #8
lw $s5, 44($fp)
move $s5, $s3
   # @ret #9
sw $s3, 40($fp)
sw $s4, 4($fp)
sw $s5, 44($fp)
lw $s6, 44($fp)
move $v0, $s6
jr $ra
nop
   # min_L_3_else_over :
sw $s6, 44($fp)
min_L_3_else_over:
   # min_L_1_else_over :
min_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func max
max_E:
   # @para int a
lw $s7, 0($fp)
lw $s7, -4($fp)
   # @para int b
lw $s0, 4($fp)
lw $s0, -8($fp)
   # #0 = a
lw $s1, 8($fp)
move $s1, $s7
   # #1 = #0
lw $s2, 12($fp)
move $s2, $s1
   # #2 = b
lw $s3, 16($fp)
move $s3, $s0
   # #3 = #2
lw $s4, 20($fp)
move $s4, $s3
   # #1 = #1 GT #3
sgt $s2, $s2, $s4
   # @bz #1 max_L_0_else_begin
sw $s0, 4($fp)
sw $s1, 8($fp)
sw $s2, 12($fp)
sw $s3, 16($fp)
sw $s4, 20($fp)
sw $s7, 0($fp)
lw $s5, 12($fp)
beq $s5, $0, max_L_0_else_begin
nop
   # #4 = a
lw $s6, 24($fp)
lw $s7, 0($fp)
move $s6, $s7
   # #5 = #4
lw $s0, 28($fp)
move $s0, $s6
   # @ret #5
sw $s0, 28($fp)
sw $s5, 12($fp)
sw $s6, 24($fp)
sw $s7, 0($fp)
lw $s1, 28($fp)
move $v0, $s1
jr $ra
nop
   # @j max_L_1_else_over
sw $s1, 28($fp)
j max_L_1_else_over
nop
   # max_L_0_else_begin :
max_L_0_else_begin:
   # #4 = b
lw $s2, 24($fp)
lw $s3, 4($fp)
move $s2, $s3
   # #5 = #4
lw $s4, 28($fp)
move $s4, $s2
   # @ret #5
sw $s2, 24($fp)
sw $s3, 4($fp)
sw $s4, 28($fp)
lw $s5, 28($fp)
move $v0, $s5
jr $ra
nop
   # max_L_1_else_over :
sw $s5, 28($fp)
max_L_1_else_over:
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func no_sfc
no_sfc_E:
   # @para int a
lw $s6, 0($fp)
lw $s6, -4($fp)
   # @para int b
lw $s7, 4($fp)
lw $s7, -8($fp)
   # #0 = a
lw $s0, 8($fp)
move $s0, $s6
   # #1 = #0
lw $s1, 12($fp)
move $s1, $s0
   # #1 = #1 GT 2000
li $t0, 2000
sgt $s1, $s1, $t0
   # @bz #1 no_sfc_L_0_else_begin
sw $s0, 8($fp)
sw $s1, 12($fp)
sw $s6, 0($fp)
sw $s7, 4($fp)
lw $s2, 12($fp)
beq $s2, $0, no_sfc_L_0_else_begin
nop
   # res = -1
lw $s3, 8($gp)
li $s3, -1
   # @ret
sw $s2, 12($fp)
sw $s3, 8($gp)
jr $ra
nop
   # @j no_sfc_L_1_else_over
j no_sfc_L_1_else_over
nop
   # no_sfc_L_0_else_begin :
no_sfc_L_0_else_begin:
   # no_sfc_L_1_else_over :
no_sfc_L_1_else_over:
   # #0 = a
lw $s4, 8($fp)
lw $s5, 0($fp)
move $s4, $s5
   # #1 = #0
lw $s6, 12($fp)
move $s6, $s4
   # @push #1
   # #2 = b
lw $s7, 16($fp)
lw $s0, 4($fp)
move $s7, $s0
   # #3 = #2
lw $s1, 20($fp)
move $s1, $s7
   # @push #3
   # @call min
sw $s6, 28($fp)
sw $s1, 24($fp)
sw $s0, 4($fp)
sw $s1, 20($fp)
sw $s4, 8($fp)
sw $s5, 0($fp)
sw $s6, 12($fp)
sw $s7, 16($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 32
jal min_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #4
lw $s2, 24($fp)
move $s2, $v0
   # #5 = #4
lw $s3, 28($fp)
move $s3, $s2
   # #6 = #5
lw $s4, 32($fp)
move $s4, $s3
   # begin = #6
lw $s5, 0($gp)
move $s5, $s4
   # #0 = a
lw $s6, 8($fp)
lw $s7, 0($fp)
move $s6, $s7
   # #1 = #0
lw $s0, 12($fp)
move $s0, $s6
   # @push #1
   # #2 = b
lw $s1, 16($fp)
sw $s2, 24($fp)
lw $s2, 4($fp)
move $s1, $s2
   # #3 = #2
sw $s3, 28($fp)
lw $s3, 20($fp)
move $s3, $s1
   # @push #3
   # @call max
sw $s0, 40($fp)
sw $s3, 36($fp)
sw $s0, 12($fp)
sw $s1, 16($fp)
sw $s2, 4($fp)
sw $s3, 20($fp)
sw $s4, 32($fp)
sw $s5, 0($gp)
sw $s6, 8($fp)
sw $s7, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 44
jal max_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #4
lw $s4, 24($fp)
move $s4, $v0
   # #5 = #4
lw $s5, 28($fp)
move $s5, $s4
   # #6 = #5
lw $s6, 32($fp)
move $s6, $s5
   # end = #6
lw $s7, 4($gp)
move $s7, $s6
   # #0 = begin
lw $s0, 8($fp)
lw $s1, 0($gp)
move $s0, $s1
   # #1 = #0
lw $s2, 12($fp)
move $s2, $s0
   # #2 = end
lw $s3, 16($fp)
move $s3, $s7
   # #1 = #1 ADD #2
add $s2, $s2, $s3
   # #3 = #1
sw $s4, 24($fp)
lw $s4, 20($fp)
move $s4, $s2
   # #4 = end
sw $s5, 28($fp)
lw $s5, 24($fp)
move $s5, $s7
   # #5 = #4
sw $s6, 32($fp)
lw $s6, 28($fp)
move $s6, $s5
   # #6 = begin
sw $s7, 4($gp)
lw $s7, 32($fp)
move $s7, $s1
   # #5 = #5 SUB #6
sub $s6, $s6, $s7
   # #5 = #5 ADD 1
addi $s6, $s6, 1
   # #3 = #3 MUL #5
mul $s4, $s4, $s6
   # #3 = #3 DIV 2
div $s4, $s4, 2
   # #7 = #3
sw $s0, 8($fp)
lw $s0, 36($fp)
move $s0, $s4
   # res = #7
sw $s1, 0($gp)
lw $s1, 8($gp)
move $s1, $s0
   # @ret
sw $s0, 36($fp)
sw $s1, 8($gp)
sw $s2, 12($fp)
sw $s3, 16($fp)
sw $s4, 20($fp)
sw $s5, 24($fp)
sw $s6, 28($fp)
sw $s7, 32($fp)
jr $ra
nop
   # @func print1
print1_E:
   # @para int res1
lw $s2, 0($fp)
lw $s2, -4($fp)
   # @para int res2
lw $s3, 4($fp)
lw $s3, -8($fp)
   # @printf string S_2
li $v0, 4
la $a0, S_2
syscall
   # #0 = res1
lw $s4, 8($fp)
move $s4, $s2
   # #1 = #0
lw $s5, 12($fp)
move $s5, $s4
   # @printf int #1
li $v0, 1
move $a0, $s5
syscall
   # @printf string S_3
li $v0, 4
la $a0, S_3
syscall
   # #0 = res2
move $s4, $s3
   # #1 = #0
move $s5, $s4
   # #1 = #1 ADD 2
addi $s5, $s5, 2
   # #1 = #1 SUB 1
addi $s5, $s5, -1
   # #1 = #1 SUB 1
addi $s5, $s5, -1
   # @printf int #1
li $v0, 1
move $a0, $s5
syscall
   # @ret
sw $s2, 0($fp)
sw $s3, 4($fp)
sw $s4, 8($fp)
sw $s5, 12($fp)
jr $ra
nop
   # @func print2
print2_E:
   # #0 = res
lw $s6, 0($fp)
lw $s7, 8($gp)
move $s6, $s7
   # #1 = #0
lw $s0, 4($fp)
move $s0, $s6
   # #1 = #1 NE -1
li $t0, -1
sne $s0, $s0, $t0
   # @bz #1 print2_L_0_else_begin
sw $s0, 4($fp)
sw $s6, 0($fp)
sw $s7, 8($gp)
lw $s1, 4($fp)
beq $s1, $0, print2_L_0_else_begin
nop
   # @printf string S_4
li $v0, 4
la $a0, S_4
syscall
   # #2 = res
lw $s2, 8($fp)
lw $s3, 8($gp)
move $s2, $s3
   # #3 = #2
lw $s4, 12($fp)
move $s4, $s2
   # @printf int #3
li $v0, 1
move $a0, $s4
syscall
   # @j print2_L_1_else_over
sw $s1, 4($fp)
sw $s2, 8($fp)
sw $s3, 8($gp)
sw $s4, 12($fp)
j print2_L_1_else_over
nop
   # print2_L_0_else_begin :
print2_L_0_else_begin:
   # @printf string S_5
li $v0, 4
la $a0, S_5
syscall
   # print2_L_1_else_over :
print2_L_1_else_over:
   # @ret
jr $ra
nop
   # @func main
main_E:
   # @var int s_firi
   # @var int s_seci
   # @var int ni
   # @var int nc
   # @var int resulti
   # @var int resultc
   # @var int i
   # @var int j
   # @var int k
   # @var int flag
   # @var char s_firc
   # @var char s_secc
   # @var char p_fir
   # @var char p_sec
   # @scanf int s_firi
li $v0, 5
syscall
lw $s5, 0($fp)
move $s5, $v0
   # @scanf int s_seci
li $v0, 5
syscall
lw $s6, 4($fp)
move $s6, $v0
   # @scanf char s_firc
li $v0, 12
syscall
lb $s7, 40($fp)
move $s7, $v0
   # @scanf char s_secc
li $v0, 12
syscall
lb $s0, 41($fp)
move $s0, $v0
   # #0 = s_firi
lw $s1, 44($fp)
move $s1, $s5
   # #1 = #0
lw $s2, 48($fp)
move $s2, $s1
   # #1 = #1 LT 0
li $t0, 0
slt $s2, $s2, $t0
   # @bz #1 main_L_0_else_begin
sb $s0, 41($fp)
sw $s1, 44($fp)
sw $s2, 48($fp)
sw $s5, 0($fp)
sw $s6, 4($fp)
sb $s7, 40($fp)
lw $s3, 48($fp)
beq $s3, $0, main_L_0_else_begin
nop
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # @ret
sw $s3, 48($fp)
jr $ra
nop
   # @j main_L_1_else_over
j main_L_1_else_over
nop
   # main_L_0_else_begin :
main_L_0_else_begin:
   # #2 = s_seci
lw $s4, 52($fp)
lw $s5, 4($fp)
move $s4, $s5
   # #3 = #2
lw $s6, 56($fp)
move $s6, $s4
   # #3 = #3 LT 0
li $t0, 0
slt $s6, $s6, $t0
   # @bz #3 main_L_2_else_begin
sw $s4, 52($fp)
sw $s5, 4($fp)
sw $s6, 56($fp)
lw $s7, 56($fp)
beq $s7, $0, main_L_2_else_begin
nop
   # @printf string S_6
li $v0, 4
la $a0, S_6
syscall
   # @ret
sw $s7, 56($fp)
jr $ra
nop
   # @j main_L_3_else_over
j main_L_3_else_over
nop
   # main_L_2_else_begin :
main_L_2_else_begin:
   # main_L_3_else_over :
main_L_3_else_over:
   # main_L_1_else_over :
main_L_1_else_over:
   # #0 = s_firi
lw $s0, 44($fp)
lw $s1, 0($fp)
move $s0, $s1
   # #1 = #0
lw $s2, 48($fp)
move $s2, $s0
   # #2 = s_seci
lw $s3, 52($fp)
lw $s4, 4($fp)
move $s3, $s4
   # #3 = #2
lw $s5, 56($fp)
move $s5, $s3
   # #1 = #1 GE #3
sge $s2, $s2, $s5
   # @bz #1 main_L_4_else_begin
sw $s0, 44($fp)
sw $s1, 0($fp)
sw $s2, 48($fp)
sw $s3, 52($fp)
sw $s4, 4($fp)
sw $s5, 56($fp)
lw $s6, 48($fp)
beq $s6, $0, main_L_4_else_begin
nop
   # #4 = s_firi
lw $s7, 60($fp)
lw $s0, 0($fp)
move $s7, $s0
   # #5 = #4
lw $s1, 64($fp)
move $s1, $s7
   # ni = #5
lw $s2, 8($fp)
move $s2, $s1
   # @j main_L_5_else_over
sw $s0, 0($fp)
sw $s1, 64($fp)
sw $s2, 8($fp)
sw $s6, 48($fp)
sw $s7, 60($fp)
j main_L_5_else_over
nop
   # main_L_4_else_begin :
main_L_4_else_begin:
   # #4 = s_seci
lw $s3, 60($fp)
lw $s4, 4($fp)
move $s3, $s4
   # #5 = #4
lw $s5, 64($fp)
move $s5, $s3
   # ni = #5
lw $s6, 8($fp)
move $s6, $s5
   # main_L_5_else_over :
sw $s3, 60($fp)
sw $s4, 4($fp)
sw $s5, 64($fp)
sw $s6, 8($fp)
main_L_5_else_over:
   # #0 = ni
lw $s7, 44($fp)
lw $s0, 8($fp)
move $s7, $s0
   # #1 = #0
lw $s1, 48($fp)
move $s1, $s7
   # #1 = #1 LE 0
li $t0, 0
sle $s1, $s1, $t0
   # @bz #1 main_L_6_else_begin
sw $s0, 8($fp)
sw $s1, 48($fp)
sw $s7, 44($fp)
lw $s2, 48($fp)
beq $s2, $0, main_L_6_else_begin
nop
   # main_L_8_while_begin :
sw $s2, 48($fp)
main_L_8_while_begin:
   # #2 = ni
lw $s3, 52($fp)
lw $s4, 8($fp)
move $s3, $s4
   # #3 = #2
lw $s5, 56($fp)
move $s5, $s3
   # #3 = #3 LE 0
li $t0, 0
sle $s5, $s5, $t0
   # @bz #3 main_L_9_while_over
sw $s3, 52($fp)
sw $s4, 8($fp)
sw $s5, 56($fp)
lw $s6, 56($fp)
beq $s6, $0, main_L_9_while_over
nop
   # #4 = ni
lw $s7, 60($fp)
lw $s0, 8($fp)
move $s7, $s0
   # #5 = #4
lw $s1, 64($fp)
move $s1, $s7
   # #5 = #5 ADD 1
addi $s1, $s1, 1
   # ni = #5
move $s0, $s1
   # @j main_L_8_while_begin
sw $s0, 8($fp)
sw $s1, 64($fp)
sw $s6, 56($fp)
sw $s7, 60($fp)
j main_L_8_while_begin
nop
   # main_L_9_while_over :
main_L_9_while_over:
   # @j main_L_7_else_over
j main_L_7_else_over
nop
   # main_L_6_else_begin :
main_L_6_else_begin:
   # #2 = ni
lw $s2, 52($fp)
lw $s3, 8($fp)
move $s2, $s3
   # #3 = #2
lw $s4, 56($fp)
move $s4, $s2
   # #3 = #3 ADD 1
addi $s4, $s4, 1
   # ni = #3
move $s3, $s4
   # main_L_7_else_over :
sw $s2, 52($fp)
sw $s3, 8($fp)
sw $s4, 56($fp)
main_L_7_else_over:
   # #0 = s_firc
lw $s5, 44($fp)
lb $s6, 40($fp)
move $s5, $s6
   # #1 = #0
lw $s7, 48($fp)
move $s7, $s5
   # #2 = s_secc
lw $s0, 52($fp)
lb $s1, 41($fp)
move $s0, $s1
   # #1 = #1 SUB #2
sub $s7, $s7, $s0
   # @j main_L_10_switch_branch
sw $s0, 52($fp)
sb $s1, 41($fp)
sw $s5, 44($fp)
sb $s6, 40($fp)
sw $s7, 48($fp)
j main_L_10_switch_branch
nop
   # main_L_12_case :
main_L_12_case:
   # nc = 1
lw $s2, 12($fp)
li $s2, 1
   # @j main_L_11_switch_over
sw $s2, 12($fp)
j main_L_11_switch_over
nop
   # main_L_13_case :
main_L_13_case:
   # nc = 2
lw $s3, 12($fp)
li $s3, 2
   # @j main_L_11_switch_over
sw $s3, 12($fp)
j main_L_11_switch_over
nop
   # main_L_14_case :
main_L_14_case:
   # nc = 3
lw $s4, 12($fp)
li $s4, 3
   # @j main_L_11_switch_over
sw $s4, 12($fp)
j main_L_11_switch_over
nop
   # main_L_15_case :
main_L_15_case:
   # nc = 4
lw $s5, 12($fp)
li $s5, 4
   # @j main_L_11_switch_over
sw $s5, 12($fp)
j main_L_11_switch_over
nop
   # main_L_16_default :
main_L_16_default:
   # nc = 5
lw $s6, 12($fp)
li $s6, 5
   # @j main_L_11_switch_over
sw $s6, 12($fp)
j main_L_11_switch_over
nop
   # main_L_10_switch_branch :
main_L_10_switch_branch:
   # @be #1 -2 main_L_15_case
lw $s7, 48($fp)
beq $s7, -2, main_L_15_case
nop
   # @be #1 -1 main_L_14_case
sw $s7, 48($fp)
lw $s0, 48($fp)
beq $s0, -1, main_L_14_case
nop
   # @be #1 1 main_L_12_case
sw $s0, 48($fp)
lw $s1, 48($fp)
beq $s1, 1, main_L_12_case
nop
   # @be #1 2 main_L_13_case
sw $s1, 48($fp)
lw $s2, 48($fp)
beq $s2, 2, main_L_13_case
nop
   # @j main_L_16_default
sw $s2, 48($fp)
j main_L_16_default
nop
   # main_L_11_switch_over :
main_L_11_switch_over:
   # #0 = ni
lw $s3, 44($fp)
lw $s4, 8($fp)
move $s3, $s4
   # #1 = #0
lw $s5, 48($fp)
move $s5, $s3
   # @push #1
   # @push 105
   # @call _asfunc_1
sw $s5, 72($fp)
li $t0, 105
sw $t0, 68($fp)
sw $s3, 44($fp)
sw $s4, 8($fp)
sw $s5, 48($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 76
jal _asfunc_1_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #2
lw $s6, 52($fp)
move $s6, $v0
   # #3 = #2
lw $s7, 56($fp)
move $s7, $s6
   # #4 = #3
lw $s0, 60($fp)
move $s0, $s7
   # resulti = #4
lw $s1, 16($fp)
move $s1, $s0
   # #0 = nc
lw $s2, 44($fp)
lw $s3, 12($fp)
move $s2, $s3
   # #1 = #0
lw $s4, 48($fp)
move $s4, $s2
   # @push #1
   # @push 99
   # @call _asfunc_1
sw $s4, 72($fp)
li $t0, 99
sw $t0, 68($fp)
sw $s0, 60($fp)
sw $s1, 16($fp)
sw $s2, 44($fp)
sw $s3, 12($fp)
sw $s4, 48($fp)
sw $s6, 52($fp)
sw $s7, 56($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 76
jal _asfunc_1_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @get #2
lw $s5, 52($fp)
move $s5, $v0
   # #3 = #2
lw $s6, 56($fp)
move $s6, $s5
   # #4 = #3
lw $s7, 60($fp)
move $s7, $s6
   # resultc = #4
lw $s0, 20($fp)
move $s0, $s7
   # #0 = resulti
lw $s1, 44($fp)
lw $s2, 16($fp)
move $s1, $s2
   # #1 = #0
lw $s3, 48($fp)
move $s3, $s1
   # @push #1
   # #2 = resultc
move $s5, $s0
   # #3 = #2
move $s6, $s5
   # @push #3
   # @call print1
sw $s3, 72($fp)
sw $s6, 68($fp)
sw $s0, 20($fp)
sw $s1, 44($fp)
sw $s2, 16($fp)
sw $s3, 48($fp)
sw $s5, 52($fp)
sw $s6, 56($fp)
sw $s7, 60($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 76
jal print1_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = resulti
lw $s4, 44($fp)
lw $s5, 16($fp)
move $s4, $s5
   # #1 = #0
lw $s6, 48($fp)
move $s6, $s4
   # @push #1
   # #2 = resultc
lw $s7, 52($fp)
lw $s0, 20($fp)
move $s7, $s0
   # #3 = #2
lw $s1, 56($fp)
move $s1, $s7
   # @push #3
   # @call no_sfc
sw $s6, 72($fp)
sw $s1, 68($fp)
sw $s0, 20($fp)
sw $s1, 56($fp)
sw $s4, 44($fp)
sw $s5, 16($fp)
sw $s6, 48($fp)
sw $s7, 52($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 76
jal no_sfc_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @call print2
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 68
jal print2_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @ret
jr $ra
nop
   # @ret
jr $ra
nop
