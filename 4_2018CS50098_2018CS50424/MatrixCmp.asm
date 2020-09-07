.globl main
main:

.data
	msg1: .asciiz "Enter 18 numbers:\n"	#user friendly message
	value: .word 0:18			#array of size=18
	
.text
	li $v0, 4				#get ready to return string or character
	la $a0, msg1				#load argument i.e. address of msg1 in register $a0
	syscall					#execute
	
	li $t0, 0				#int i=0;
	li $t1, 18				#int l=18;
	loop1:
	sll $t2, $t0, 2				#shift index left logically by 2 and store it in $t2
	
	li $v0, 5				#get ready to accept a integer value
	syscall					#execute
	sw $v0, value($t2)			#set value[$t2]=$v0
	
	addi $t0, $t0, 1			#i++
	bne $t0, $t1, loop1			#if i!=18 then continue
	
	li $s0, 0				#int sum=0;
	li $t0, 0				#int i=0;
	li $t1, 9				#int l=9;
	loop2:
	addi $t2, $t0, 9			#j is ready
	
	sll $t3, $t0, 2				#shift index left logically by 2 and store it in $t3
	sll $t4, $t2, 2				#shift index left logically by 2 and store it in $t4
	
	lw $t6, value($t3)			#set $t6=value($t3)
	lw $t7, value($t4)			#set $t7=value($t4)
	
	sub $t5, $t6, $t7			#$t5=$t6-$t7
	mult $t5, $t5				#$t5*$t5
	mflo $t5				#$t5=$t5*$t5
	add $s0, $s0, $t5			#$s0=$s0+$t5
	
	addi $t0, $t0, 1			#i++
	bne $t0, $t1, loop2			#if i!=9 then continue
	
	li $s1, 9				#set $s1 to 9
	mtc1 $s0, $f3				#$f3=$s0
	mtc1 $s1, $f4				#$f4=$s1
	cvt.s.w $f3, $f3			#convert word to double
	cvt.s.w $f4, $f4			#convert word to double
	div.s $f2, $f3, $f4			#$f2=$f3/$f4
	
	li $v0, 2				#ready to return integer
	mov.s $f12, $f2				#load argument
	syscall					#execute
	
	li $v0, 10				#get ready to quit
	syscall 				#execute