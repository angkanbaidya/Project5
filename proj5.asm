# Angkan Baidya
# abaidya
# 112309655

#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################

.text

# Part 1
init_list:	
sw $zero,0($a0) #convert size to 0
sw $zero,4($a0)# convert head to 0 
jr $ra


# Part 2
append:
addi $sp, $sp, -16 # Makes space on stack for one register, the ra
	sw $s0, 0($sp) # Stores the caller's s0
	sw $s1, 4($sp) #store s1
	sw $s2, 8($sp) 
	sw $s3, 12($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
move $s0,$a0 #list
move $s3,$a0 #list 2
move $s1,$a1 #store number 
lw $s2,0($s0) #get size 


#loop
lw $t0,4($s0) #get head address
beq $t0,$zero,headzero

nodeincrement:
addi $t0,$t0,4 #increment to the address of next. 
move $t2,$t0 #save the address of the current node
lw $t0,0($t0) #get the address of next node 
beq $t0,$zero,found #tail 
j nodeincrement 

found:
li $a0, 8
li $v0, 9
syscall
move $t1,$v0 #move address to new node to t1 
sw $s1,0($t1) #store num to new node
sw $zero,4($t1) #next node is 0 
sw $t1,0($t2) #save address of new node $t1 to next of t0 
addi $s2,$s2,1 #increment size
sw $s2,0($s3) #put new size in list 
	move $v0,$s2 #store size in v0 
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
addi $sp, $sp, 16 # Makes space on stack for one register, the ra
jr $ra 

headzero:
li $a0, 8
li $v0, 9
syscall
move $t1,$v0 #move address to new node to t1 
sw $s1,0($t1) #store num to new node
sw $zero,4($t1) #next node is 0 
sw $t1,4($s0) #save address of new node $t1 to next of t0 
addi $s2,$s2,1 #increment size
sw $s2,0($s3) #put new size in list 
	move $v0,$s2 #store size in v0 
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
addi $sp, $sp, 16 # Makes space on stack for one register, the ra
jr $ra 

# Part 3
insert:
addi $sp, $sp, -24 # Makes space on stack for one register, the ra
	sw $ra, 0($sp) # Stores $ra register in the stack
	sw $s0, 4($sp) # Stores the caller's s0
	sw $s1, 8($sp) #store s1
	sw $s2, 12($sp) 
	sw $s3, 16($sp)
	sw $s4, 20($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
move $s0,$a0 #list
move $s4,$a0 #list
move $s1,$a1 #num
move $s2,$a2 #index
lw $s3,0($s0) #get size 
bltz $s2,exit
bgt $s2,$s3,exit #if index > size 
beq $s2,$s3,append1
beqz $s3,headzero3
j dowork
headzero3:
li $a0, 8
li $v0, 9
syscall
move $t1,$v0 #move address to new node to t1 
sw $s1,0($t1) #store num to new node
sw $zero,4($t1) #next node is 0 
sw $t1,4($s0) #save address of new node $t1 to next of t0 
addi $s3,$s3,1 #increment size
sw $s3,0($s4) #put new size in list 
	move $v0,$s3 #store size in v0 
	lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
addi $sp, $sp, 24 # Makes space on stack for one register, the ra
jr $ra 


append1:
move $a0,$s0
move $a1,$s1
jal append
addi $s3,$s3,1 
move $v0,$s3 #load size 
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
addi $sp, $sp, 24 # Makes space on stack for one register, the ra
jr $ra 



dowork:
lw $t0,4($s0) #get head address
addi $t9,$s2,-1 
li $t8,0
saveindexbefore:
beq $t8,$t9,saveindexafter1 #u reach second
addi $t0,$t0,4 #increment to the address of next. 
move $t2,$t0 #save the address of the current node
lw $t0,0($t0) #get the address of next node 
move $t7,$t0 #save address of current
addi $t8,$t8,1
j saveindexbefore

saveindexafter1:
move $t9,$s2
li $t8,0
lw $t0,4($s0) #get head address
saveindexafter:
beq $t8,$t9,init #u reach second
addi $t0,$t0,4 #increment to the address of next. 
move $t2,$t0 #save the address of the current node
lw $t0,0($t0) #get the address of next node 
move $t6,$t0 #save address of after
addi $t8,$t8,1
j saveindexafter

#initialize node 
init:
li $a0, 8
li $v0, 9
syscall
move $t0,$v0 #move address to t0 
sw $s1,0($t0) #put num as number in node
sw $t6,4($t0) #insert address of node after into node 
sw $t0,4($t7) #put address of new node as next of old index 
addi $s3,$s3,1 #increment size
sw $s3,0($s4) #store
move $v0,$s3 
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
addi $sp, $sp, 24 # Makes space on stack for one register, the ra
jr $ra 


exit:
li $v0,-1
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
addi $sp, $sp, 24 # Makes space on stack for one register, the ra
jr $ra 

# Part 4
get_value:
addi $sp, $sp, -16 # Makes space on stack for one register, the ra
	sw $s0, 0($sp) # Stores the caller's s0
	sw $s1, 4($sp) #store s1
	sw $s2, 8($sp) 
	sw $s3, 12($sp)
	sw $s4, 20($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0

move $s0,$a0 #list
move $s1,$a0 #list
move $s2,$a1 #index 
lw $s3,0($s0) #get size 
beqz $s3,exit4
bltz $s2,exit4 
bge $s2,$s3,exit4
li $t9,0 #counter
lw $t0,4($s0) #get head address
#function
addi $t6,$s2,1
increment4:
beq $t9,$t6,done4
lw $t8,0($t0) #get number value of current node 
addi $t0,$t0,4 #increment to the address of next. 
lw $t0,0($t0) #get the address of next node 
addi $t9,$t9,1
j increment4

done4:
li $v0,0
move $v1,$t8
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
addi $sp, $sp, 16 # Makes space on stack for one register, the ra
jr $ra 

exit4:
li $v0,-1
li $v1,-1
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
addi $sp, $sp, 16 # Makes space on stack for one register, the ra
jr $ra 

# Part 5
set_value:
addi $sp, $sp, -20 # Makes space on stack for one register, the ra
	sw $s0, 0($sp) # Stores the caller's s0
	sw $s1, 4($sp) #store s1
	sw $s2, 8($sp) 
	sw $s3, 12($sp)
	sw $s4, 16($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
move $s0,$a0 #list
move $s1,$a0 #list
move $s2,$a1 #index 
move $s4,$a2 #num
lw $s3,0($s0) #get size 
beqz $s3,exit5
bltz $s2,exit5
bge $s2,$s3,exit5

li $t9,0 #counter
lw $t0,4($s0) #get head address


#function
addi $t6,$s2,0
increment5:
beq $t9,$t6,init5
addi $t0,$t0,4 #increment to the address of next. 
lw $t0,0($t0) #get the address of next node 
addi $t9,$t9,1
j increment5

init5:
lw $t8,0($t0) #get number value of current node 
sw $s4,0($t0) #store
j done5


done5:
li $v0,0
move $v1,$t8
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
	lw $s4, 16($sp)
addi $sp, $sp, 20 # Makes space on stack for one register, the ra
jr $ra 



exit5:
li $v0,-1
li $v1,-1
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
	lw $s4, 16($sp)
addi $sp, $sp, 20 # Makes space on stack for one register, the ra
jr $ra 


# Part 6
index_of:
addi $sp, $sp, -16 # Makes space on stack for one register, the ra
	sw $s0, 0($sp) # Stores the caller's s0
	sw $s1, 4($sp) #store s1
	sw $s2, 8($sp) 
	sw $s3, 12($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0

move $s0,$a0 #list
move $s1,$a0 #list
move $s2,$a1 #num
lw $s3,0($s0) #get size 
beqz $s3,exit6

#function
li $t9,0 #counter
lw $t0,4($s0) #get head address
#function
increment6:
beq $t9,$s3,exit6
lw $t8,0($t0) #get number value of current node
beq $t8,$s2,found6 
addi $t0,$t0,4 #increment to the address of next. 
lw $t0,0($t0) #get the address of next node 
addi $t9,$t9,1
j increment6



found6:
move $v0,$t9
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
addi $sp, $sp, 16 # Makes space on stack for one register, the ra
jr $ra 





exit6:
li $v0,-1
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
addi $sp, $sp, 16 # Makes space on stack for one register, the ra
jr $ra 



jr $ra

# Part 7
remove:
addi $sp, $sp, -20 # Makes space on stack for one register, the ra
	sw $s0, 0($sp) # Stores the caller's s0
	sw $s1, 4($sp) #store s1
	sw $s2, 8($sp) 
	sw $s3, 12($sp)
	sw $s4, 16($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
move $s0,$a0 #list
move $s1,$a0 #list
move $s2,$a1 #num
lw $s3,0($s0) #get size 
beqz $s3,exit7 #if size = 0 nope
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
#function
li $t9,0 #counter
lw $t0,4($s0) #get head address
#function
increment7:
beq $t9,$s3,exit7
lw $t8,0($t0) #get number value of current node
beq $t8,$s2,next7
addi $t0,$t0,4 #increment to the address of next. 
lw $t0,0($t0) #get the address of next node 
addi $t9,$t9,1
j increment7

next7:
move $t4,$t0 #save found node address
move $s4,$t0 #CASE FOR HEAD
addi $t0,$t0,4 #increment to the address of next. 
lw $t0,0($t0) #get the address of next node 
move $t3,$t0 #save address of next node 
beq $t9,$zero,headcase
j before7

before7:
lw $t0,4($s1) #get head address
addi $t7,$t9,-1
before7c:
beq $t6,$t7,setbefore
addi $t0,$t0,4 #increment to the address of next. 
lw $t0,0($t0) #get the address of next node 
addi $t6,$t6,1
j before7c

setbefore:
sw $t3,4($t0) #put address of next next node as getNext 
j return7 


headcase:
sw $t3 ,4($s1) #save current as head address. 
j return7


return7:
addi $s3,$s3,-1 
sw $s3,0($s1) #get size 
li $v0,0
move $v1,$t9
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
	lw $s4, 16($sp)
addi $sp, $sp, 20 # Makes space on stack for one register, the ra
jr $ra 




exit7:
li $v0,-1
li $v0,-1
	lw $s0, 0($sp) # Stores the caller's s0
	lw $s1, 4($sp) #store s1
	lw $s2, 8($sp) 
	lw $s3, 12($sp)
	lw $s4, 16($sp)
addi $sp, $sp, 20 # Makes space on stack for one register, the ra
jr $ra 


# Part 8
create_deck:
addi $sp, $sp, -8 # Makes space on stack for one register, the ra
	sw $ra, 0($sp) # Stores $ra register in the stack
	sw $s0, 4($sp) # Stores the caller's s0
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0


li $a0, 8
li $v0, 9
syscall


move $s0,$v0 #save return address
move $a0,$v0 
jal init_list

#set counter and initial variables
li $t8,0 #counter
li $t7,8

setDown:
li $t1,'D'
j set2

set2:
li $t4,'2'
andi $t1,$t1,0x00ff00ff
sll $t5,$t4,8 
or $t1,$t5,$t1
j setC


numberloop:
beq $t8,$t7,setT
li $t1,'D'
andi $t1,$t1,0x00ff00ff #mask for value 
addi $t4,$t4,1 #ascii value register increment
sll $t5,$t4,8  #shift ascii value
or $t1,$t5,$t1 
j setC


setC:
li $t2,'C' 
andi $t1,$t1,0x0000ffff
sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
j setD

setD:
li $t2,'D' 
andi $t1,$t1,0x0000ffff
sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
j setH

setH:
li $t2,'H' 
andi $t1,$t1,0x0000ffff
sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
j setS

setS:
li $t2,'S' 
andi $t1,$t1,0x0000ffff
sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
li $t3,4
beq $v0,$t3,numberloop
addi $t8,$t8,1
j numberloop


setT:
li $t1,'D'
andi $t1,$t1,0x00ff00ff
li $t4,'T'
sll $t4,$t4,8 
or $t1,$t4,$t1
j setC1

setJ:
li $t1,'D'
andi $t1,$t1,0x00ff00ff
li $t4,'J'
sll $t4,$t4,8 
or $t1,$t4,$t1
j setC1

setQ:
li $t1,'D'
andi $t1,$t1,0x00ff00ff
li $t4,'Q'
sll $t4,$t4,8 
or $t1,$t4,$t1
j setC1

setK:
li $t1,'D'
andi $t1,$t1,0x00ff00ff
li $t4,'K'
sll $t4,$t4,8 
or $t1,$t4,$t1
j setC1

setA:
li $t1,'D'
andi $t1,$t1,0x00ff00ff
li $t4,'A'
sll $t4,$t4,8 
or $t1,$t4,$t1
j setC1


setC1:
li $t2,'C' 
andi $t1,$t1,0x0000ffff
sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
j setD1

setD1:
li $t2,'D' 
andi $t1,$t1,0x0000ffff

sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
j setH1

setH1:
li $t2,'H' 
andi $t1,$t1,0x0000ffff

sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
j setS1

setS1:
li $t2,'S' 
andi $t1,$t1,0x0000ffff

sll $t2,$t2,16
or $t1,$t1,$t2
move $a0,$s0
move $a1,$t1 
addi $sp,$sp,-8
sw $t7,0($sp)
sw $t8,4($sp)
jal append
lw $t7,0($sp)
lw $t8,4($sp)
addi $sp,$sp,8
move $t1,$a1
li $t3,36
beq $v0,$t3,setJ
li $t3,40
beq $v0,$t3,setQ
li $t3,44
beq $v0,$t3,setK
li $t3,48
beq $v0,$t3,setA
j returnvalues

returnvalues: 
move $v0,$s0
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
addi $sp, $sp, 8 # Makes space on stack for one register, the ra
jr $ra




# Part 9
draw_card:
addi $sp, $sp, -24 # Makes space on stack for one register, the ra
	sw $ra, 0($sp) # Stores $ra register in the stack
	sw $s0, 4($sp) # Stores the caller's s0
	sw $s1, 8($sp) #store s1
	sw $s2, 12($sp) 
	sw $s3, 16($sp)
	sw $s4, 20($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
move $s0,$a0 #list
move $s1,$a0 #list
lw $s2,0($s0) #get size 
beqz $s2,exit9

#function
li $t9,0 #counter
lw $t0,4($s0) #get head address
#function
lw $t8,0($t0) #get number value of current node
move $a0,$s1
move $a1,$t8 #number to remove of head 
jal remove
li $v0,0
move $v1,$t8
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
addi $sp, $sp, 24 # Makes space on stack for one register, the ra
jr $ra 

exit9:
li $v0,-1
li $v1,-1
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
addi $sp, $sp, 24 # Makes space on stack for one register, the ra
jr $ra 


# Part 10
deal_cards:
addi $sp, $sp, -36 # Makes space on stack for one register, the ra
	sw $ra, 0($sp) # Stores $ra register in the stack
	sw $s0, 4($sp) # Stores the caller's s0
	sw $s1, 8($sp) #store s1
	sw $s2, 12($sp) 
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)
li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0
move $s0,$a0 #deck
move $s2,$a1 #players
move $s7,$a1 #players

move $s3,$a2 #num players
move $s4,$a3 # cards per player 
lw $s5,0($s0) #get size 
li $t0,0 
li $s6,0
beqz $s5,exit10
blez $s3,exit10
li $t3,1 #counter for total dealt
blt $s4,$t3,exit10
li $t3,0 #counter for total dealt
li $s5,0
li $s1,0
addi $s3,$s3,-1

outterhandout:
beq $t7,$s4,deckdone
addi $t7,$t7,1
li $s5,0
j handoutplayer1


handoutplayer1:
j draw1
handoutplayer11:
move $s2,$s7 #reset players
lw $t2,0($s2) #load address of player 1 
move $a0,$t2
move $a1,$t1 
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal append
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
addi $s1,$s1,1
j handoutdraw

handoutdraw:
j draw2
handoutfirst:
beq $s5,$s3,outterhandout
addi $s2,$s2,4 #go to next person
lw $t2,0($s2) #get the address of the player
move $a0,$t2 #address to insert
move $a1,$t1 #num to insert
addi $sp,$sp,-40 
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal append
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
addi $s1,$s1,1
addi $s5,$s5,1
beq $s5,$s3,outterhandout
j handoutdraw

deckdone:
move $v0,$s1
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp) 
	lw $s7, 32 ($sp)
addi $sp, $sp, 36 # Makes space on stack for one register, the ra
jr $ra 

draw2:
move $a0,$s0 #load deck
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal draw_card
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
li $t1,-1
beq $v0,$t1,deckdone
#change to UP
move $t1,$v1
andi $t1,$t1,0x00ffff00 #mask for value 
li $t4,'U' #ascii value register increment
sll $t5,$t4,0  #shift ascii value
or $t1,$t5,$t1 
j handoutfirst

draw1:
move $a0,$s0 #load deck
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal draw_card
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
li $t1,-1
beq $v0,$t1,deckdone
#change to UP
move $t1,$v1
andi $t1,$t1,0x00ffff00 #mask for value 
li $t4,'U' #ascii value register increment
sll $t5,$t4,0  #shift ascii value
or $t1,$t5,$t1 
j handoutplayer11

exit10:
li $v0,-1
lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp) 
	lw $s7, 32($sp)
addi $sp, $sp, 36 # Makes space on stack for one register, the ra
jr $ra 



# Part 11
card_points:
addi $sp, $sp, -8 # Makes space on stack for one register, the ra
	sw $s0, 0($sp) # Stores the caller's s0
	sw $s4, 4($sp)
move $s0,$a0 #card 
j firstcheck

thirdcheck:
andi $t1,$s0,0x00ff0000
li $t2,0x00480000
beq $t1,$t2,heart
li $t2, 0x00535155
beq $s0,$t2,queen
li $t2,0x00430000
beq $t1,$t2,club
li $t2,0x00440000
beq $t1,$t2,diamond
li $t2,0x00530000
beq $t1,$t2,spades
j noncard

secondcheck:
andi $t1,$s0,0x0000ff00
li $t2,0x00003400
beq $t1,$t2,thirdcheck
li $t2,0x00003500
beq $t1,$t2,thirdcheck
li $t2,0x00003600
beq $t1,$t2,thirdcheck
li $t2,0x00003700
beq $t1,$t2,thirdcheck
li $t2,0x00003800
beq $t1,$t2,thirdcheck
li $t2,0x00003900
beq $t1,$t2,thirdcheck
li $t2,0x00003200
beq $t1,$t2,thirdcheck
li $t2,0x00003300
beq $t1,$t2,thirdcheck
li $t2,0x00005400
beq $t1,$t2,thirdcheck
li $t2,0x00004a00
beq $t1,$t2,thirdcheck
li $t2,0x00005100
beq $t1,$t2,thirdcheck
li $t2,0x00004b00
beq $t1,$t2,thirdcheck
li $t2,0x00004100
beq $t1,$t2,thirdcheck
j noncard

firstcheck:
andi $t1,$s0,0x000000ff
li $t2,0x00000055
beq $t1,$t2,secondcheck
li $t2,0x00000044
beq $t1,$t2,secondcheck
j noncard


heart:
li $v0,1
lw $s0, 0($sp)
lw $s4, 4($sp)
addi $sp, $sp, 8 # Makes space on stack for one register, the ra
jr $ra

queen:
li $v0,13
lw $s0, 0($sp)
lw $s4, 4($sp)
addi $sp, $sp, 8 # Makes space on stack for one register, the ra
jr $ra

club:
j zeropoints

diamond:
j zeropoints
spades:
j zeropoints

noncard:
li $v0,-1
lw $s0, 0($sp)
lw $s4, 4($sp)
addi $sp, $sp, 8 # Makes space on stack for one register, the ra
jr $ra

zeropoints:
li $v0,0
lw $s0, 0($sp)
lw $s4, 4($sp)
addi $sp, $sp, 8 # Makes space on stack for one register, the ra
jr $ra








# Part 12
simulate_game:
addi $sp, $sp, -36 # Makes space on stack for one register, the ra
	sw $ra, 0($sp) # Stores $ra register in the stack
	sw $s0, 4($sp) # Stores the caller's s0
	sw $s1, 8($sp) #store s1
	sw $s2, 12($sp) 
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)

li $t0,0
li $t1,0
li $t2,0
li $t3,0
li $t4,0
li $t5,0
li $t6,0
li $t7,0
li $t8,0
li $t9,0



move $s0,$a0 #deck
move $s1,$a1 #players
move $s2,$a2 #num rounds
move $s3,$a1 #player2
li $s4,0 #player 1 points
li $s5,0 #player 2 points
li $s6,0 #player 3 points
li $s7,0 #player 4 points





lw $t0,0($s1) #player 1
move $a0,$t0
jal init_list 
lw $t0,4($s1) #player 2
move $a0,$t0
jal init_list 
lw $t0,8($s1) #player 3
move $a0,$t0
jal init_list
lw $t0,12($s1) #player4
move $a0,$t0
jal init_list 
li $t1,4
li $t2,13 
move $a0,$s0 #deck
move $a1,$s1 #players
move $a2,$t1 #num players
move $a3,$t2 #cards per player 
jal deal_cards
#find2cround1
move $s1,$s3 #reset players
lw $t0,0($s1) #player 1
move $a0,$t0
li $t1,4403797
move $a1,$t1 
jal index_of
li $t2,-1
bne $v0,$t2,removeclub1
j check2

check2:
addi $s1,$s1,4
lw $t0,0($s1) #player 2
move $a0,$t0
li $t1,4403797
move $a1,$t1 
jal index_of
li $t2,-1
bne  $v0,$t2,removeclub2
j check3

check3:
addi $s1,$s1,4
lw $t0,0($s1) #player 3
move $a0,$t0
li $t1,4403797
move $a1,$t1 
jal index_of
li $t2,-1
bne  $v0,$t2,removeclub3
j check4

check4:
addi $s1,$s1,4
lw $t0,0($s1) #player4
move $a0,$t0
li $t1,4403797
move $a1,$t1 
jal index_of
li $t2,-1
bne  $v0,$t2,removeclub4

removeclub1:
lw $t0,0($s1) #current index
move $a0,$t0 #current index 
move $a1,$t1 #club number
jal remove 
move $s1,$s3
lw $t0,0($s1) #current index of person who has 2 clubs 
move $t5,$a1
j player1init

removeclub2:
lw $t0,0($s1) #current index
move $a0,$t0 #current index 
move $a1,$t1 #club number
jal remove 
move $s1,$s3
lw $t0,4($s1) #current index of person who has 2 clubs
move $t8,$a1 
j player1init

removeclub3:
lw $t0,0($s1) #current index
move $a0,$t0 #current index 
move $a1,$t1 #club number
jal remove 
move $s1,$s3
lw $t0,8($s1) #current index of person who has 2 clubs 
move $t7,$a1
j player1init

removeclub4:
lw $t0,0($s1) #current index
move $a0,$t0 #current index 
move $a1,$t1 #club number
jal remove 
move $s1,$s3
lw $t0,12($s1) #current index of person who has 2 clubs 
move $t6,$a1
j player1init

player1init:
li $t9,0
li $t1,13
playerone:
move $s1,$s3 #reset players
beq $t9,$t1,notfound1stplayer  #from 1-13
lw $t3,0($s1) #player 1 address
beq $t3,$t0,player2init
move $a0,$t3 #player2
move $a1,$t9 #current index
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal get_value
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t5,$v1 #save value onto t2
andi $t3,$t5,0x00ff0000
li $t4,0x00430000
beq $t3,$t4,preplayer2
addi $t9,$t9,1 
j playerone

preplayer2:
lw $t3,0($s1) #player 1 address
move $a0,$t3
move $a1,$t5
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal remove
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore bac
j player2init

player2init:
li $t9,0
li $t1,13
playertwo:
move $s1,$s3 #reset players
beq $t9,$t1,notfound2ndplayer  #from 1-13
lw $t3,4($s1) #player 2 address
beq $t3,$t0,player3init
move $a0,$t3 #player2
move $a1,$t9 #current index
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal get_value
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t8,$v1 #save value onto t2
andi $t3,$t8,0x00ff0000
li $t4,0x00430000
beq $t3,$t4,preplayer3
addi $t9,$t9,1 
j playertwo

preplayer3:
lw $t3,4($s1) #player 2 address
move $a0,$t3
move $a1,$t8
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal remove
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore bac
j player3init

player3init:
li $t9,0
li $t1,13
playerthree:
move $s1,$s3 #reset players
beq $t9,$t1,notfound3rdplayer  #from 1-13
lw $t3,8($s1) #player 2 address
beq $t3,$t0,player4init
move $a0,$t3 #player2
move $a1,$t9 #current round 
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal get_value
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t7,$v1 #save value onto t2
andi $t3,$t7,0x00ff0000
li $t4,0x00430000
beq $t3,$t4,preplayer4
addi $t9,$t9,1 
j playerthree

preplayer4:
lw $t3,8($s1) #player 1 address
move $a0,$t3
move $a1,$t7
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal remove
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore bac
j player4init


player4init:
li $t9,0
li $t1,13
playerfour:
move $s1,$s3 #reset players
beq $t9,$t1,notfound4thplayer  #from 1-13
lw $t3,12($s1) #player 2 address
beq $t3,$t0,comparevalues
move $a0,$t3 #player2
move $a1,$t9 #current round 
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal get_value
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t6,$v1 #save value onto t2
andi $t3,$t6,0x00ff0000
li $t4,0x00430000
beq $t3,$t4,preround1result
addi $t9,$t9,1 
j playerfour

preround1result:
lw $t3,12($s1) #player 1 address
move $a0,$t3
move $a1,$t6
addi $sp,$sp,-20
sw $t0,0($sp)
sw $t5,4($sp)
sw $t6,8($sp)
sw $t7,12($sp)
sw $t8,16($sp)
jal remove
lw $t0,0($sp)
lw $t5,4($sp)
lw $t6,8($sp)
lw $t7,12($sp)
lw $t8,16($sp)
addi $sp,$sp,20
j comparevalues


notfound1stplayer:
move $s1,$s3 
lw $t3,0($s1)
move $a0,$t3
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal draw_card
move $t5,$v1
move $a0,$t5
jal card_points
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t5,$v0
j player2init

notfound2ndplayer:
move $s1,$s3 #reset players
lw $t3,4($s1) 
move $a0,$t3
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal draw_card
move $t8,$v1 #card of the second player 
move $a0,$t8 #check for card value
jal card_points 
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t8,$v0 #T8 STORES CARD VALUESS OF CARDS WITH NO SAME CASE
j player3init

notfound3rdplayer:
move $s1,$s3 #reset players
lw $t0,8($s1) 
move $a0,$t0 
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal draw_card
move $t7,$v1 #card of the second player 
move $a0,$t7 #check for card value
jal card_points 
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t7,$v0 #T8 STORES CARD VALUESS OF CARDS WITH NO SAME CASE
j player4init

notfound4thplayer:
move $s1,$s3 #reset players
lw $t0,12($s1) 
move $a0,$t0 
addi $sp,$sp,-24
sw $t9,0($sp)
sw $t0,4($sp)
sw $t5,8($sp)
sw $t6,12($sp)
sw $t7,16($sp)
sw $t8,20($sp)
jal draw_card
move $t6,$v1 #card of the second player 
move $a0,$t6 #check for card value
jal card_points 
lw $t9,0($sp)
lw $t0,4($sp)
lw $t5,8($sp)
lw $t6,12($sp)
lw $t7,16($sp)
lw $t8,20($sp)
addi $sp,$sp,24 #restore back
move $t6,$v0 #T8 STORES CARD VALUESS OF CARDS WITH NO SAME CASE
j comparevalues


comparevalues:
bgt $t5,$t8,onethantwo
bgt $t8,$t7,twothanthree
bgt $t7,$t6,round1winnert7
j round1winnert6

onethantwo:
bgt $t5,$t7,onethan3
j threethan4

threethan4:
bgt $t7,$t6,round1winnert7
j round1winnert6

onethan3:
bgt $t5,$t6,round1winnert5
j round1winnert6

twothanthree:
bgt $t8,$t6,round1winnert8
j round1winnert6

round1winnert5:
li $t0,13
beq $t6,$t0,addvalues5
li $t0,1 
beq $t6,$t0,addvalues5
part52:
li $t0,13
beq $t8,$t0,addvalues52
li $t0,1 
beq $t8,$t0,addvalues52
part53:
li $t0,13
beq $t7,$t0,addvalues53
li $t0,1 
beq $t7,$t0,addvalues53
part54:
move $s1,$s3 #reset
lw $t0,0($s1) #address of winner. 
j rounds

round1winnert6:
li $t0,13
beq $t5,$t0,addvalues6
li $t0,1 
beq $t5,$t0,addvalues6
part62:
li $t0,13
beq $t8,$t0,addvalues62
li $t0,1 
beq $t8,$t0,addvalues62
part63:
li $t0,13
beq $t7,$t0,addvalues63
li $t0,1 
beq $t7,$t0,addvalues63
part64:
move $s1,$s3 #reset
lw $t0,12($s1) #address of winner. 
j rounds

round1winnert7:
li $t0,13
beq $t5,$t0,addvalues7
li $t0,1 
beq $t5,$t0,addvalues7
part72:
li $t0,13
beq $t8,$t0,addvalues72
li $t0,1 
beq $t8,$t0,addvalues72
part73:
li $t0,13
beq $t6,$t0,addvalues73
li $t0,1 
beq $t6,$t0,addvalues73
part74:
lw $t0,8($s1) #address of winner. 
j rounds


round1winnert8:
li $t0,13
beq $t5,$t0,addvalues8
li $t0,1 
beq $t5,$t0,addvalues8
part82:
li $t0,13
beq $t7,$t0,addvalues82
li $t0,1 
beq $t7,$t0,addvalues82
part83:
li $t0,13
beq $t6,$t0,addvalues83
li $t0,1 
beq $t6,$t0,addvalues83
part84:
lw $t0,4($s1) #address of winner. 
j rounds


addvalues5:
add $s4,$t6,$s4
j part52
addvalues52:
add $s4,$t8,$s4
j part53
addvalues53:
add $s4,$t7,$s4
j part54

addvalues6:
add $s7,$t5,$s7
j part62
addvalues62:
add $s7,$t8,$s7
j part63
addvalues63:
add $s7,$t7,$s7
j part64

addvalues7:
add $s6,$t5,$s6
j part72
addvalues72:
add $s6,$t8,$s6
j part73
addvalues73:
add $s6,$t6,$s6
j part74

addvalues8:
add $s5,$t5,$s5
j part82
addvalues82:
add $s5,$t7,$s5
j part83
addvalues83:
add $s5,$t6,$s5
j part84


rounds:
addi $s2,$s2,-1
li $t1,0
roundsloop:
beq $t1,$s2,return12
move $a0,$t0
addi $sp,$sp,-8
sw $t0,0($sp)
sw $t1,4($sp)
jal draw_card
lw $t0,0($sp)
lw $t1,4($sp)
addi $sp,$sp,8
move $t2,$v1 
lw $t3,0($s1)
beq $t3,$t0,initialt5
lw $t3,4($s1)
beq $t3,$t0,initialt6
lw $t3,8($s1)
beq $t3,$t0,initialt7
lw $t3,12($s1)
beq $t3,$t0,initialt8
continueroundsloop:
andi $t2,$t2,0x00ff0000
j firstpersoninit

initialt5:
move $t5,$v1
j continueroundsloop
initialt6:
move $t6,$v1
j continueroundsloop
initialt7:
move $t7,$v1
j continueroundsloop
initialt8:
move $t8,$v1
j continueroundsloop

firstpersoninit:
li $t3,0
move $s1,$s3
firstperson:
lw $t4,0($s1)
lw $t4,0($t4)
beq $t3,$t4,firstpersonnotfound
lw $t4,0($s1) #load first person
beq $t4,$t0,secondpersoninit
move $a0,$t4
move $a1,$t3 #current index
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal get_value
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
andi $t9,$v1,0x00ff0000
beq $t9,$t2,presecondperson
addi $t3,$t3,1 
j firstperson


presecondperson:
move $t5,$v1 #first person value in t5
lw $t9,0($s1) #player 1 address
move $a0,$t9 
move $a1,$t5
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal remove
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
j secondpersoninit

secondpersoninit:
li $t3,0
move $s1,$s3
secondperson:
lw $t4,0($s1)
lw $t4,0($t4)
beq $t3,$t4 secondpersonnotfound
lw $t4,4($s1) #load second person
beq $t4,$t0,thirdpersoninit
move $a0,$t4
move $a1,$t3 #current index
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal get_value
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
andi $t9,$v1,0x00ff0000
beq $t9,$t2,prethirdperson
addi $t3,$t3,1 
j secondperson

prethirdperson:
move $t6,$v1 #second person value in t6
lw $t9,4($s1) #player 2 address
move $a0,$t9
move $a1,$t6
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal remove
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
j thirdpersoninit

thirdpersoninit:
li $t3,0
move $s1,$s3
thirdperson:
lw $t4,0($s1)
lw $t4,0($t4)
beq $t3,$t4 thirdpersonnotfound
lw $t4,8($s1) #load second person
beq $t4,$t0,fourthpersoninit
move $a0,$t4
move $a1,$t3 #current index
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal get_value
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
andi $t9,$v1,0x00ff0000
beq $t9,$t2,prefourthperson
addi $t3,$t3,1 
j thirdperson

prefourthperson:
move $t7,$v1 #second person value in t7
lw $t9,8($s1) #player 3 address
move $a0,$t9
move $a1,$t7
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal remove
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
j fourthpersoninit

fourthpersoninit:
li $t3,0
move $s1,$s3
fourthperson:
lw $t4,0($s1)
lw $t4,0($t4)
li $t4,13
beq $t3,$t4 fourthpersonnotfound
lw $t4,12($s1) #load second person
beq $t4,$t0,roundcompleteinit
move $a0,$t4
move $a1,$t3 #current index
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal get_value
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
andi $t9,$v1,0x00ff0000
beq $t9,$t2,preroundcomplete
addi $t3,$t3,1 
j fourthperson

preroundcomplete:
move $t8,$v1
lw $t9,12($s1) #player 4 address
move $a0,$t9
move $a1,$t8
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal remove
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
j roundcompleteinit


firstpersonnotfound:
move $s1,$s3 
lw $t3,0($s1)
move $a0,$t3
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal draw_card
move $t5,$v1
move $a0,$t5
jal card_points
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
move $t5,$v0
j presecondperson

secondpersonnotfound:
move $s1,$s3 #reset players
lw $t3,4($s1) 
move $a0,$t3
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal draw_card
move $t8,$v1 #card of the second player 
move $a0,$t8 #check for card value
jal card_points 
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
move $t6,$v0 #T8 STORES CARD VALUESS OF CARDS WITH NO SAME CASE
j prethirdperson


thirdpersonnotfound:
move $s1,$s3 #reset players
lw $t0,8($s1) 
move $a0,$t0 
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal draw_card
move $t7,$v1 #card of the second player 
move $a0,$t7 #check for card value
jal card_points 
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
move $t7,$v0 #T8 STORES CARD VALUESS OF CARDS WITH NO SAME CASE
j prefourthperson

fourthpersonnotfound:
move $s1,$s3 #reset players
lw $t0,12($s1) 
move $a0,$t0 
addi $sp,$sp,-40
sw $t3,0($sp)
sw $t0,4($sp)
sw $t2,8($sp)
sw $t1,12($sp)
sw $t5,16($sp)
sw $t6,20($sp)
sw $t7,24($sp)
sw $t4,28($sp)
sw $t8,32($sp)
sw $t9,36($sp)
jal draw_card
move $t6,$v1 #card of the second player 
move $a0,$t6 #check for card value
jal card_points 
lw $t3,0($sp)
lw $t0,4($sp)
lw $t2,8($sp)
lw $t1,12($sp)
lw $t5,16($sp)
lw $t6,20($sp)
lw $t7,24($sp)
lw $t4,28($sp)
lw $t8,32($sp)
lw $t9,36($sp)
addi $sp,$sp,40
move $t6,$v0 #T8 STORES CARD VALUESS OF CARDS WITH NO SAME CASE
j preroundcomplete


roundcompleteinit:
move $t0,$t5
move $t2,$t6
move $t3,$t7
move $t4,$t8 #temporary store 
j pointplay 



pointplay:
convertt5:
li $t9,1
beq $t0,$t9,convertt6
li $t9,13
beq $t0,$t9,convertt6
andi $t0,$t0,0x0000ff00
srl $t0,$t0,8
li $t9,'T'
beq $t0,$t9,tent5
li $t9,'Q'
beq $t0,$t9,queent5
li $t9,'A'
beq $t0,$t9,acet5
li $t9,'K'
beq $t0,$t9,kingt5
li $t9,'J'
beq $t0,$t9,jackt5
addi $t0,$t0,-48
j convertt6
convertt6:
li $t9,1
beq $t2,$t9,convertt7
li $t9,13
beq $t2,$t9,convertt7
andi $t2,$t2,0x0000ff00
srl $t2,$t2,8
li $t9,'T'
beq $t2,$t9,tent6
li $t9,'Q'
beq $t2,$t9,queent6
li $t9,'A'
beq $t2,$t9,acet6
li $t9,'K'
beq $t2,$t9,kingt6
li $t9,'J'
beq $t2,$t9,jackt6
addi $t2,$t2,-48
j convertt7
convertt7:
li $t9,1
beq $t3,$t9,convertt8
li $t9,13
beq $t3,$t9,convertt8
andi $t3,$t3,0x0000ff00
srl $t3,$t3,8
li $t9,'T'
beq $t3,$t9,tent7
li $t9,'Q'
beq $t3,$t9,queent7
li $t9,'A'
beq $t3,$t9,acet7
li $t9,'K'
beq $t3,$t9,kingt7
li $t9,'J'
beq $t3,$t9,jackt7
addi $t3,$t3,-48
j convertt8
convertt8:
li $t9,1
beq $t4,$t9,roundcomplete
li $t9,13
beq $t4,$t9,roundcomplete
andi $t4,$t4,0x0000ff00
srl $t4,$t4,8
li $t9,'T'
beq $t4,$t9,tent8
li $t9,'Q'
beq $t4,$t9,queent8
li $t9,'A'
beq $t4,$t9,acet8
li $t9,'K'
beq $t4,$t9,kingt8
li $t9,'J'
beq $t4,$t9,jackt8
addi $t4,$t4,-48
j roundcomplete



tent5:
li $t0,10
j convertt6
jackt5:
li $t0,11
j convertt6
queent5:
li $t0,12
j convertt6
acet5:
li $t0,14
j convertt6
kingt5:
li $t0,13
j convertt6

tent6:
li $t2,10
j convertt7
jackt6:
li $t2,11
j convertt7
queent6:
li $t2,12
j convertt7
acet6:
li $t2,14
j convertt7
kingt6:
li $t2,13
j convertt7

tent7:
li $t3,10
j convertt8
jackt7:
li $t3,11
j convertt8
queent7:
li $t3,12
j convertt8
acet7:
li $t3,14
j convertt8
kingt7:
li $t3,13
j convertt8

tent8:
li $t4,10
j roundcomplete
jackt8:
li $t4,11
j roundcomplete
queent8:
li $t4,12
j roundcomplete
acet8:
li $t4,14
j roundcomplete
kingt8:
li $t4,13
j roundcomplete



roundcomplete:
bgt $t0,$t2,onethantwo1
bgt $t2,$t3,twothanthree1
bgt $t3,$t4,round2winnert71
j round2winnert81

onethantwo1:
bgt $t0,$t3,onethan31
j threethan41

threethan41:
bgt $t3,$t4,round2winnert71
j round2winnert61

onethan31:
bgt $t0,$t4,round2winnert51
j round2winnert81

twothanthree1:
bgt $t2,$t4,round2winnert61
j round2winnert81

round2winnert51:
li $t0,13
beq $t6,$t0,addvalues5
li $t0,1 
beq $t6,$t0,addvalues5
beq $t6,$zero,addvalues5
j t5value1
part521:
li $t0,13
beq $t8,$t0,addvalues52
li $t0,1 
beq $t8,$t0,addvalues52
beq $t8,$zero,addvalues52
j t5value2
part531:
li $t0,13
beq $t7,$t0,addvalues53
li $t0,1 
beq $t7,$t0,addvalues53
beq $t7,$zero,addvalues53
j t5value3
part541:
j t5ownvalue
part551:
move $s1,$s3 
lw $t0,0($s1) #load winner of previous round as player 0
addi $t1,$t1,1
j roundsloop

round2winnert61:
li $t0,13
beq $t5,$t0,addvalues6
li $t0,1 
beq $t5,$t0,addvalues6
beq $t5,$zero,addvalues6
j t6value1
part621:
li $t0,13
beq $t8,$t0,addvalues62
li $t0,1 
beq $t8,$t0,addvalues62
beq $t8,$zero,addvalues62
j t6value2
part631:
li $t0,13
beq $t7,$t0,addvalues63
li $t0,1 
beq $t7,$t0,addvalues63
beq $t7,$zero,addvalues63
j t6value3
part641:
j t6ownvalue
part651:
move $s1,$s3 #reset
lw $t0,4($s1) #address of winner. 
addi $t1,$t1,1
j roundsloop






round2winnert71:
li $t0,13
beq $t5,$t0,addvalues7
li $t0,1 
beq $t5,$t0,addvalues7
beq $t5,$zero,addvalues7
j t7value1
part721:
li $t0,13
beq $t8,$t0,addvalues72
li $t0,1 
beq $t8,$t0,addvalues72
beq $t8,$zero,addvalues72
j t7value2
part731:
li $t0,13
beq $t6,$t0,addvalues73
li $t0,1 
beq $t6,$t0,addvalues73
beq $t6,$zero,addvalues73
j t7value3
part741:
j t7ownvalue
part751:
lw $t0,8($s1) #address of winner. 
addi $t1,$t1,1
j roundsloop




round2winnert81:
li $t0,13
beq $t5,$t0,addvalues8
li $t0,1 
beq $t5,$t0,addvalues8
beq $t5,$zero,addvalues8
j t8value1
part821:
li $t0,13
beq $t7,$t0,addvalues82
li $t0,1 
beq $t7,$t0,addvalues82
beq $t7,$zero,addvalues82
j t8value2
part831:
li $t0,13
beq $t6,$t0,addvalues83
li $t0,1 
beq $t6,$t0,addvalues83
beq $t6,$zero,addvalues83
j t8value3
part841:
j t8ownvalue
part851:
lw $t0,12($s1) #address of winner. 
addi $t1,$t1,1
j roundsloop




t5value1:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t7,8($sp)
sw $t8,12($sp)
lw $t0,0($s1)
move $a0,$t6
jal card_points
move $t6,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t7,8($sp)
lw $t8,12($sp)
addi $sp,$sp,16
add $s4,$s4,$t6
j part521

t5value2:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t7,8($sp)
sw $t6,12($sp)
lw $t0,0($s1)
move $a0,$t8
jal card_points
move $t8,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t7,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s4,$s4,$t8
j part531


t5value3:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t8,8($sp)
sw $t6,12($sp)
lw $t0,0($s1)
move $a0,$t7
jal card_points
move $t7,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t8,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s4,$s4,$t7
j part541

t5ownvalue:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t7,4($sp)
sw $t8,8($sp)
sw $t6,12($sp)
lw $t0,0($s1)
move $a0,$t5
jal card_points
move $t5,$v0 #updated value of t6
lw $t1,0($sp)
lw $t7,4($sp)
lw $t8,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s4,$s4,$t5
j part551


t6value1:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t6,4($sp)
sw $t7,8($sp)
sw $t8,12($sp)
lw $t0,4($s1)
move $a0,$t5
jal card_points
move $t5,$v0 #updated value of t6
lw $t1,0($sp)
lw $t6,4($sp)
lw $t7,8($sp)
lw $t8,12($sp)
addi $sp,$sp,16
add $s5,$s5,$t5
j part621



t6value2:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t7,8($sp)
sw $t6,12($sp)
lw $t0,4($s1)
move $a0,$t8
jal card_points
move $t8,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t7,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s5,$s5,$t8
j part631



t6value3:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t8,8($sp)
sw $t6,12($sp)
lw $t0,4($s1)
move $a0,$t7
jal card_points
move $t7,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t8,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s5,$s5,$t7
j part641


t6ownvalue:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t8,8($sp)
sw $t7,12($sp)
lw $t0,0($s1)
move $a0,$t6
jal card_points
move $t6,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t8,8($sp)
lw $t7,12($sp)
addi $sp,$sp,16
add $s5,$s5,$t6
j part651





t7value1:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t6,4($sp)
sw $t7,8($sp)
sw $t8,12($sp)
lw $t0,8($s1)
move $a0,$t5
jal card_points
move $t5,$v0 #updated value of t6
lw $t1,0($sp)
lw $t6,4($sp)
lw $t7,8($sp)
lw $t8,12($sp)
addi $sp,$sp,16
add $s6,$s6,$t5
j part721


t7value2:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t7,8($sp)
sw $t6,12($sp)
lw $t0,8($s1)
move $a0,$t8
jal card_points
move $t8,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t7,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s6,$s6,$t8
j part731



t7value3:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t8,8($sp)
sw $t7,12($sp)
lw $t0,8($s1)
move $a0,$t6
jal card_points
move $t6,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t8,8($sp)
lw $t7,12($sp)
addi $sp,$sp,16
add $s6,$s6,$t6
j part741

t7ownvalue:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t8,8($sp)
sw $t6,12($sp)
lw $t0,0($s1)
move $a0,$t7
jal card_points
move $t7,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t8,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s6,$s6,$t7
j part751


t8value1:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t6,4($sp)
sw $t7,8($sp)
sw $t8,12($sp)
lw $t0,12($s1)
move $a0,$t5
jal card_points
move $t5,$v0 #updated value of t6
lw $t1,0($sp)
lw $t6,4($sp)
lw $t7,8($sp)
lw $t8,12($sp)
addi $sp,$sp,16
add $s7,$s7,$t5
j part821


t8value2:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t8,8($sp)
sw $t6,12($sp)
lw $t0,12($s1)
move $a0,$t7
jal card_points
move $t7,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t8,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s7,$s7,$t7
j part831

t8value3:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t8,8($sp)
sw $t7,12($sp)
lw $t0,12($s1)
move $a0,$t6
jal card_points
move $t6,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t8,8($sp)
lw $t7,12($sp)
addi $sp,$sp,16
add $s7,$s7,$t6
j part841

t8ownvalue:
addi $sp,$sp,-16
sw $t1,0($sp)
sw $t5,4($sp)
sw $t7,8($sp)
sw $t6,12($sp)
lw $t0,0($s1)
move $a0,$t8
jal card_points
move $t8,$v0 #updated value of t6
lw $t1,0($sp)
lw $t5,4($sp)
lw $t7,8($sp)
lw $t6,12($sp)
addi $sp,$sp,16
add $s7,$s7,$t8
j part851


addvalues51:
add $s4,$t6,$s4
j part521
addvalues521:
add $s4,$t8,$s4
j part531
addvalues531:
add $s4,$t7,$s4
j part541

addvalues61:
add $s5,$t5,$s5
j part621
addvalues621:
add $s5,$t8,$s5
j part631
addvalues631:
add $s5,$t7,$s5
j part641

addvalues71:
add $s6,$t5,$s6
j part721
addvalues721:
add $s6,$t8,$s6
j part731
addvalues731:
add $s6,$t6,$s6
j part741

addvalues81:
add $s7,$t5,$s7
j part821
addvalues821:
add $s7,$t7,$s7
j part831
addvalues831:
add $s7,$t6,$s7
j part841


return12:
setfirst:
move $t1,$s4
j setsecond

setsecond:
andi $t1,$t1,0xffff00ff
sll $t5,$s5,8 
or $t1,$t5,$t1
j setthird

setthird:
andi $t1,$t1,0xff00fff
sll $t5,$s6,16
or $t1,$t5,$t1
j setfourth

setfourth:
andi $t1,$t1,0x00ffffff
sll $t5,$s7,24
or $t1,$t5,$t1
li $t9,6

move $v0,$t1
	lw $ra, 0($sp) # Stores $ra register in the stack
	lw $s0, 4($sp) # Stores the caller's s0
	lw $s1, 8($sp) #store s1
	lw $s2, 12($sp) 
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $s5, 24($sp)
	lw $s6, 28($sp)
	lw $s7, 32($sp)
addi $sp, $sp, 36 # Makes space on stack for one register, the ra
jr $ra












jr $ra

#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
#################### DO NOT CREATE A .data SECTION ####################
