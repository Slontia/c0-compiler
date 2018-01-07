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
   # label:0
   # uses:
   # defs:
   # a 
   # label:init_array_L_0_while_begin
   # uses:
   # a defs:
   # 
