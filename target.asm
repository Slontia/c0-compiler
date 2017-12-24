.data
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
   # @func main
main_E:
   # @var int a
   # @var int b
   # @var int c
   # a = b ADD 1
lw $s0, 0($fp)# a
lw $s1, 4($fp)# b
addi $s0, $s1, 1
   # #0 = b
lw $s2, 12($fp)# #0
move $s2, $s1
   # @scanf int b
li $v0, 5
syscall
move $s1, $v0
   # @printf int a
li $v0, 1
move $a0, $s0
syscall
   # @ret
sw $s0, 0($fp)
sw $s1, 4($fp)
sw $s2, 12($fp)
jr $ra
nop
