.data

.text

# ==========
# @procedure allocateArray
# @in  $a3 : byteForEveryElement
# @in  $a4 : sizeArray
# @in  $a5 :
# @in  $a6 :

# @out $v1 : indirizzoArrayDinamico 
# @out $v2 :
# @out $v3 :

# @out $f1 :
# @out $f2 :
# @out $f3 :

# @mod $t
# ==========
malloc:
    li $v0, 9
    add $t0, $a3, $a4
    add		$t0, $t1, $t2		# $t0 = $t1 + $t2
    
