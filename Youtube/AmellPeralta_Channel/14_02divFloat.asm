.data

.text
.globl main

# funzionaaaaa!!!!
main:
	li $t0, 30
	li $t1, 8
	
	mtc1 $t0, $f4
	mtc1 $t1, $f6
	
	cvt.s.w $f4, $f4
	cvt.s.w $f6, $f6
	
	div.s $f8, $f4, $f6
	
	li $v0, 2
	mov.s $f12, $f8
	
	syscall
	