.data
num: .word 37
list:
.word 5  # list's size
.word node761 # address of list's head
node168:
.word 402
.word 0
node814:
.word 978
.word node248
node761:
.word 962
.word node112
node248:
.word 526
.word node168
node112:
.word 762
.word node814


.text
.globl main
main:
la $a0, list
lw $a1, num
jal append

la $t0, list #load list
lw $t1, 0($t0)  #size
addi $t0, $t0, 4 #address of head
li $t3, 0
lw $t1, 0($t0) #num of node
queuePrintLoop:
beq $t3, $t1, endPrint
lw $t0, 0($t1) #number 
move $a0,$t0
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall 
lw $t1, 4($t1) #num of node
move $a0,$t1
li $v0, 1
syscall
li $a0, ' '
li $v0, 11
syscall
j queuePrintLoop


endPrint:

# Write your own code here to verify that the function is correct.

li $v0, 10
syscall

.include "proj5.asm"
