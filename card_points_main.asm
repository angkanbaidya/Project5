.data
card: .word 1234567

.text
.globl main
main:
lw $a0, card
jal card_points

# Write your own code here to verify that the function is correct.

li $v0, 10
syscall

.include "proj5.asm"
