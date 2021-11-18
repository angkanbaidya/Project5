.data
num: .word 24
index: .word 3
list:
.word 6  # list's size
.word node761 # address of list's head
node130:
.word 293
.word 0
node248:
.word 526
.word node168
node112:
.word 762
.word node814
node814:
.word 978
.word node248
node761:
.word 962
.word node112
node168:
.word 402
.word node130



.text
.globl main
main:
la $a0, list
lw $a1, num
lw $a2, index
jal insert



# Write your own code here to verify that the function is correct.

li $v0, 10
syscall

.include "proj5.asm"
