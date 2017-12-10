.data
S_0: .asciiz "Please input ten numbers:"
.space 4
over_S:
.text
la $gp, over_S
andi $gp, $gp, 0xFFFFFFFC
   # @var int b
   # @call main
addi $fp, $fp, 4
add $fp, $fp, $gp
jal main_E
nop
li $v0, 10
syscall
   # @exit
   # @func sort
sort_E:
   # @array int[] a 10
   # @var int i
   # @var int j
   # @var int temp
   # @printf string S_0
li $v0, 4
la $a0, S_0
syscall
   # i = 0
lw $s0, 40($fp)
li $s0, 0
   # sort_L_0_while_begin :
sw $s0, 40($fp)
sort_L_0_while_begin:
   # #0 = i
lw $s1, 52($fp)
lw $s2, 40($fp)
move $s1, $s2
   # #1 = #0
lw $s3, 56($fp)
move $s3, $s1
   # #1 = #1 LT 10
li $t1, 10
slt $s3, $s3, $t1
   # @bz #1 sort_L_1_while_over
sw $s1, 52($fp)
sw $s2, 40($fp)
sw $s3, 56($fp)
lw $s4, 56($fp)
beq $s4, $0, sort_L_1_while_over
nop
   # @scanf temp
li $v0, 5
syscall
lw $s5, 48($fp)
move $s5, $v0
   # #2 = i
lw $s6, 60($fp)
lw $s7, 40($fp)
move $s6, $s7
   # #3 = #2
lw $s0, 64($fp)
move $s0, $s6
   # #4 = temp
lw $s1, 68($fp)
move $s1, $s5
   # #5 = #4
lw $s2, 72($fp)
move $s2, $s1
   # a = #3 ARSET #5
sll $t1, $s0, 2
add $t1, $t1, $fp
sw $s2, ($t1)
   # #6 = i
lw $s3, 76($fp)
move $s3, $s7
   # #7 = #6
sw $s4, 56($fp)
lw $s4, 80($fp)
move $s4, $s3
   # #7 = #7 ADD 1
addi $s4, $s4, 1
   # i = #7
move $s7, $s4
   # @j sort_L_0_while_begin
sw $s0, 64($fp)
sw $s1, 68($fp)
sw $s2, 72($fp)
sw $s3, 76($fp)
sw $s4, 80($fp)
sw $s5, 48($fp)
sw $s6, 60($fp)
sw $s7, 40($fp)
j sort_L_0_while_begin
nop
   # sort_L_1_while_over :
sort_L_1_while_over:
   # i = 0
lw $s5, 40($fp)
li $s5, 0
   # sort_L_2_while_begin :
sw $s5, 40($fp)
sort_L_2_while_begin:
   # #8 = i
lw $s6, 84($fp)
lw $s7, 40($fp)
move $s6, $s7
   # #9 = #8
lw $s0, 88($fp)
move $s0, $s6
   # #9 = #9 LT 9
li $t1, 9
slt $s0, $s0, $t1
   # @bz #9 sort_L_3_while_over
sw $s0, 88($fp)
sw $s6, 84($fp)
sw $s7, 40($fp)
lw $s1, 88($fp)
beq $s1, $0, sort_L_3_while_over
nop
   # j = 0
lw $s2, 44($fp)
li $s2, 0
   # sort_L_4_while_begin :
sw $s1, 88($fp)
sw $s2, 44($fp)
sort_L_4_while_begin:
   # #10 = j
lw $s3, 92($fp)
lw $s4, 44($fp)
move $s3, $s4
   # #11 = #10
lw $s5, 96($fp)
move $s5, $s3
   # #12 = i
lw $s6, 100($fp)
lw $s7, 40($fp)
move $s6, $s7
   # #13 = 9
lw $s0, 104($fp)
li $s0, 9
   # #13 = #13 SUB #12
sub $s0, $s0, $s6
   # #11 = #11 LT #13
slt $s5, $s5, $s0
   # @bz #11 sort_L_5_while_over
sw $s0, 104($fp)
sw $s3, 92($fp)
sw $s4, 44($fp)
sw $s5, 96($fp)
sw $s6, 100($fp)
sw $s7, 40($fp)
lw $s1, 96($fp)
beq $s1, $0, sort_L_5_while_over
nop
   # #14 = j
lw $s2, 108($fp)
lw $s3, 44($fp)
move $s2, $s3
   # #15 = #14
lw $s4, 112($fp)
move $s4, $s2
   # #16 = a ARGET #15
lw $s5, 116($fp)
sll $t1, $s4, 2
add $t1, $t1, $fp
lw $s5, ($t1)
   # #17 = #16
lw $s6, 120($fp)
move $s6, $s5
   # #18 = #17
lw $s7, 124($fp)
move $s7, $s6
   # #19 = j
lw $s0, 128($fp)
move $s0, $s3
   # #20 = #19
sw $s1, 96($fp)
lw $s1, 132($fp)
move $s1, $s0
   # #20 = #20 ADD 1
addi $s1, $s1, 1
   # #21 = a ARGET #20
sw $s2, 108($fp)
lw $s2, 136($fp)
sll $t1, $s1, 2
add $t1, $t1, $fp
lw $s2, ($t1)
   # #22 = #21
sw $s3, 44($fp)
lw $s3, 140($fp)
move $s3, $s2
   # #23 = #22
sw $s4, 112($fp)
lw $s4, 144($fp)
move $s4, $s3
   # #18 = #18 GT #23
sgt $s7, $s7, $s4
   # @bz #18 sort_L_6_else_begin
sw $s0, 128($fp)
sw $s1, 132($fp)
sw $s2, 136($fp)
sw $s3, 140($fp)
sw $s4, 144($fp)
sw $s5, 116($fp)
sw $s6, 120($fp)
sw $s7, 124($fp)
lw $s5, 124($fp)
beq $s5, $0, sort_L_6_else_begin
nop
   # #24 = j
lw $s6, 148($fp)
lw $s7, 44($fp)
move $s6, $s7
   # #25 = #24
lw $s0, 152($fp)
move $s0, $s6
   # #26 = a ARGET #25
lw $s1, 156($fp)
sll $t1, $s0, 2
add $t1, $t1, $fp
lw $s1, ($t1)
   # #27 = #26
lw $s2, 160($fp)
move $s2, $s1
   # #28 = #27
lw $s3, 164($fp)
move $s3, $s2
   # temp = #28
lw $s4, 48($fp)
move $s4, $s3
   # #29 = j
sw $s5, 124($fp)
lw $s5, 168($fp)
move $s5, $s7
   # #30 = #29
sw $s6, 148($fp)
lw $s6, 172($fp)
move $s6, $s5
   # #31 = j
sw $s7, 44($fp)
lw $s7, 176($fp)
sw $s0, 152($fp)
lw $s0, 44($fp)
move $s7, $s0
   # #32 = #31
sw $s1, 156($fp)
lw $s1, 180($fp)
move $s1, $s7
   # #32 = #32 ADD 1
addi $s1, $s1, 1
   # #33 = a ARGET #32
sw $s2, 160($fp)
lw $s2, 184($fp)
sll $t1, $s1, 2
add $t1, $t1, $fp
lw $s2, ($t1)
   # #34 = #33
sw $s3, 164($fp)
lw $s3, 188($fp)
move $s3, $s2
   # #35 = #34
sw $s4, 48($fp)
lw $s4, 192($fp)
move $s4, $s3
   # a = #30 ARSET #35
sll $t1, $s6, 2
add $t1, $t1, $fp
sw $s4, ($t1)
   # #36 = j
sw $s5, 168($fp)
lw $s5, 196($fp)
move $s5, $s0
   # #37 = #36
sw $s6, 172($fp)
lw $s6, 200($fp)
move $s6, $s5
   # #37 = #37 ADD 1
addi $s6, $s6, 1
   # #38 = temp
sw $s7, 176($fp)
lw $s7, 204($fp)
sw $s0, 44($fp)
lw $s0, 48($fp)
move $s7, $s0
   # #39 = #38
sw $s1, 180($fp)
lw $s1, 208($fp)
move $s1, $s7
   # a = #37 ARSET #39
sll $t1, $s6, 2
add $t1, $t1, $fp
sw $s1, ($t1)
   # @j sort_L_7_else_over
sw $s0, 48($fp)
sw $s1, 208($fp)
sw $s2, 184($fp)
sw $s3, 188($fp)
sw $s4, 192($fp)
sw $s5, 196($fp)
sw $s6, 200($fp)
sw $s7, 204($fp)
j sort_L_7_else_over
nop
   # sort_L_6_else_begin :
sort_L_6_else_begin:
   # sort_L_7_else_over :
sort_L_7_else_over:
   # #40 = j
lw $s2, 212($fp)
lw $s3, 44($fp)
move $s2, $s3
   # #41 = #40
lw $s4, 216($fp)
move $s4, $s2
   # #41 = #41 ADD 1
addi $s4, $s4, 1
   # j = #41
move $s3, $s4
   # @j sort_L_4_while_begin
sw $s2, 212($fp)
sw $s3, 44($fp)
sw $s4, 216($fp)
j sort_L_4_while_begin
nop
   # sort_L_5_while_over :
sort_L_5_while_over:
   # #42 = i
lw $s5, 220($fp)
lw $s6, 40($fp)
move $s5, $s6
   # #43 = #42
lw $s7, 224($fp)
move $s7, $s5
   # #43 = #43 ADD 1
addi $s7, $s7, 1
   # i = #43
move $s6, $s7
   # @j sort_L_2_while_begin
sw $s5, 220($fp)
sw $s6, 40($fp)
sw $s7, 224($fp)
j sort_L_2_while_begin
nop
   # sort_L_3_while_over :
sort_L_3_while_over:
   # i = 0
lw $s0, 40($fp)
li $s0, 0
   # sort_L_8_while_begin :
sw $s0, 40($fp)
sort_L_8_while_begin:
   # #44 = i
lw $s1, 228($fp)
lw $s2, 40($fp)
move $s1, $s2
   # #45 = #44
lw $s3, 232($fp)
move $s3, $s1
   # #45 = #45 LT 10
li $t1, 10
slt $s3, $s3, $t1
   # @bz #45 sort_L_9_while_over
sw $s1, 228($fp)
sw $s2, 40($fp)
sw $s3, 232($fp)
lw $s4, 232($fp)
beq $s4, $0, sort_L_9_while_over
nop
   # #46 = i
lw $s5, 236($fp)
lw $s6, 40($fp)
move $s5, $s6
   # #47 = #46
lw $s7, 240($fp)
move $s7, $s5
   # #47 = #47 ADD 1
addi $s7, $s7, 1
   # i = #47
move $s6, $s7
   # #48 = i
lw $s0, 244($fp)
move $s0, $s6
   # #49 = #48
lw $s1, 248($fp)
move $s1, $s0
   # #49 = #49 SUB 1
addi $s1, $s1, -1
   # #50 = a ARGET #49
lw $s2, 252($fp)
sll $t1, $s1, 2
add $t1, $t1, $fp
lw $s2, ($t1)
   # #51 = #50
lw $s3, 256($fp)
move $s3, $s2
   # #52 = #51
sw $s4, 232($fp)
lw $s4, 260($fp)
move $s4, $s3
   # @printf int #52
li $v0, 1
move $a0, $s4
syscall
   # @j sort_L_8_while_begin
sw $s0, 244($fp)
sw $s1, 248($fp)
sw $s2, 252($fp)
sw $s3, 256($fp)
sw $s4, 260($fp)
sw $s5, 236($fp)
sw $s6, 40($fp)
sw $s7, 240($fp)
j sort_L_8_while_begin
nop
   # sort_L_9_while_over :
sort_L_9_while_over:
   # @ret 53
li $v0, 53
jr $ra
nop
   # @ret 0
li $v0, 0
jr $ra
nop
   # @func main
main_E:
   # @var int a
   # a = 5
lw $s5, 0($fp)
li $s5, 5
   # b = 3
lw $s6, 0($gp)
li $s6, 3
   # @call sort
sw $s5, 0($fp)
sw $s6, 0($gp)
addi $sp, $sp, -8
sw $ra, 0($sp)
sw $fp, 4($sp)
addi $fp, $fp, 4
jal sort_E
nop
lw $ra, 0($sp)
lw $fp, 4($sp)
addi $sp, $sp, 8
   # #0 = b
lw $s7, 4($fp)
lw $s0, 0($gp)
move $s7, $s0
   # #1 = #0
lw $s1, 8($fp)
move $s1, $s7
   # @printf int #1
li $v0, 1
move $a0, $s1
syscall
   # #2 = a
lw $s2, 12($fp)
lw $s3, 0($fp)
move $s2, $s3
   # #3 = #2
lw $s4, 16($fp)
move $s4, $s2
   # @printf int #3
li $v0, 1
move $a0, $s4
syscall
   # @ret
sw $s0, 0($gp)
sw $s1, 8($fp)
sw $s2, 12($fp)
sw $s3, 0($fp)
sw $s4, 16($fp)
sw $s7, 4($fp)
jr $ra
nop
