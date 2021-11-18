.data
index: .word 2
num: .word 26
list:
.word 7  # list's size
.word node414 # address of list's head
node66:
.word 120
.word node153
node599:
.word 684
.word node66
node414:
.word 622
.word node599
node116:
.word 624
.word 0
node136:
.word 56
.word node143
node153:
.word 520
.word node136
node143:
.word 496
.word node116



.text
.globl main
main:
la $a0, list
lw $a1, index
lw $a2, num
jal set_value

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
