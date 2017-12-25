.data
S_0: .asciiz "as:"
.space 4
over_S:
.text
la $gp, over_S
andi $gp, $gp, 0xFFFFFFFC
   # @call main
addi $fp, $fp, 0
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
   # @exit
   # @func function
function_E:
   # @para int a
lw $s0, 0($fp)# a
lw $s0, -4($fp)
   # @var int as
   # #0 = a EQ 1
lw $s1, 8($fp)# #0
li $t9, 1
seq $s1, $s0, $t9
   # as = a
lw $s2, 4($fp)# as
move $s2, $s0
   # @bz #0 function_L_0_else_begin
sw $s0, 0($fp)
sw $s1, 8($fp)
sw $s2, 4($fp)
lw $s3, 8($fp)# #0
beq $s3, $0, function_L_0_else_begin
nop
   # @ret
sw $s3, 8($fp)
jr $ra
nop
   # @j function_L_1_else_over
j function_L_1_else_over
nop
   # function_L_0_else_begin :
function_L_0_else_begin:
   # #0 = a SUB 1
lw $s4, 8($fp)# #0
lw $s5, 0($fp)# a
addi $s4, $s5, -1
   # @push #0
   # @call function
sw $s4, 12($fp)
sw $s4, 8($fp)
sw $s5, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 16
jal function_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # @printf int as
li $v0, 1
lw $s6, 4($fp)# as
move $a0, $s6
syscall
   # function_L_1_else_over :
sw $s6, 4($fp)
function_L_1_else_over:
   # @ret
jr $ra
nop
   # @func main
main_E:
   # @push 12
   # @call function
li $t0, 12
sw $t0, 0($fp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 4
jal function_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # @ret
jr $ra
nop
