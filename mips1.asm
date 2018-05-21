## 2017-2018 Proje

## Mehmet ilkay Atalay 1306140083
## Courage Armah       1306130126



.data

entrShow: .asciiz  "  Enter an integer between '1-10' "
showValid: .asciiz  "  Entered number is valid"
myArray: .space	40 		#4byte integer memory allocaton
resultDia: .asciiz "  Result is "
entrShow6: .asciiz  "  Enter an integer between '1-10' for array "
bestJoke: .asciiz "    MIPS will be champion architecture of CPU's at World"


.text

	#index register $t5
	addi $t5, $zero, 0
	#set max adress int
	addi $t6, $zero, 40
	#set for f(n)=10
	addi $t7, $zero, 3	
	#set for sub 4
	addi $t8, $zero, 4

.globl main

main:
	#set bounds
	addi $t1,$zero,1
	addi $t2,$zero,10
	addi $t3,$zero,6
	

	##Prompt user enter a value
	
	li $v0,4 	##showing code
	la $a0,entrShow
	syscall 
	
	##Get the input
	
	li $v0, 5	#tells system want to get an integer
	syscall	
	
	##Store the result
	
	move $t0,$v0
	
	##Display 
	
	li $v0, 4
	la $a0, showValid
	syscall
	
	##Show integer
	li $v0, 1 	## print int code
	move $a0,$t0
	syscall
	
	bgt $t0,$t2,main 	#if greater than 10 turn back loop
	beq $t0,$t2,joke	#do a joke
	blt $t0,$t1,main 	#if smaller than 1 turn back loop
	bgt $t0,$t3,array	#if bigger than 6 go array
	ble $t0,$t3,func	#if smalller than 6 go function	

array:
	######################################################################

	li $v0, 4
	la $a0, entrShow6	#show enter number
	syscall

	li $v0, 5		#tells system want to get an integer
	syscall
	
	move $s6,$v0		#store the value

	sb $s6, myArray($t5)	#assign first integer to zero index of array
	addi $t5,$t5,4		#iterate index for next memory adress
	bge $t5,$t6, finishShow	#when array size be equal to 10 go finish 
	b array
	
finishShow:
	
	######################################################################
	
		##Get the input
	
	lb  $v0, myArray($t5) 	#get last element for show
	subu $t5,$t5,$t8	#decrease 4 for getting previous index
	
	move $t9,$v0
	
	##Show integer
	li $v0, 1 	## print int code
	move $a0,$t9
	syscall
	
	bne $t5,$zero,finishShow #branch not equal zero for recursive
	b finish		#branch finish
	
	

	######################################################################
	
func:
	######################################################################
	blt $t0,$t7,ten		#jump for result 10
recursive:
	sll $s3,$t0,1		#shift left for 2n
	sub $t0,$t0,$t1		#decrease t0 "1"
	bne $t0,$t5, recursive	#branch if not equal zero
	mul $t0,$s3,$t0		#generate result
	
	li $v0, 4
	la $a0, resultDia	#show result dialog
	syscall
	
	li $v0, 1
	move $a0,$t0		#show result number
	syscall	
	b finish
	######################################################################
ten:

	li $v0, 4
	la $a0, resultDia	#show result dialog
	syscall
	
	li $v0, 1
	move $a0,$t2		#show result number ten
	syscall
	b finish
	######################################################################
joke:
	######################################################################
	
	li $v0, 4
	la $a0, bestJoke       #show joke	
	syscall
	
	######################################################################

finish:

	li $v0, 10	#For exit
	syscall
	
	
	
