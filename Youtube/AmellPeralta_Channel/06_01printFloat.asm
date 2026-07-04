.data
	PI: .float 3.14

.text
.globl main

main:
	li $v0, 2
	lwc1 $f12, PI
	syscall
	j exit
	
exit:
	li $v0, 10
	syscall
