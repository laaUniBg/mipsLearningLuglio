	.eqv ERROR_INCORRECT_INDEX_STUDENT 1
.data
	strMsgFoundValue: .asciiz "stringValue è: "
.text
.globl searchInKeyValueMap



# ---- INIZIO searchInKeyValueMap
# @arg      {int}           $a1 - thisKey
# @arg      {addr|int}      $a2 - thisMap (solo .word maps {key: int, value: addr} -> il value è indirizzo di una stringa .asciiz)
# @returns  {addr.string}	$v1 - thisValue (addr.string)
# @modifies {addr}          $t0 - indirizzo inizio mappa
# @modifies {int}           $t1 - thisKey
# @modifies {bool: 0|1}     $t2 - isFound
# @modifies {addr.string}   $t3 - indirizzoValueString
# @modifies {bool: 0|1}     $t4 - hasSearchedAllLogic

searchInKeyValueMap:
    # salvo $ra per poter chiamare le funzioni dentro le funzioni
    stackPreserveStart($ra)
	move $t0, $a2    # indirizzo inizio map

searchLoop:
	lw $t1, 0($t0)                      # thisKey
	seq $t2, $t1, $a1                   # isFound

	beq $t2, TRUE, isFoundLogic    		# if(isFound)
	beq $t2, FALSE, isNotFoundLogic     # if(!isFound)

# -- 
isFoundLogic:
	lw $t3, 4($t0)    # indirizzoValueString

	stackPreserveStart($a1)
startPrintingIsFound:
	move $a1, strMsgFoundValue
	jal printStringFromAddress

    move $a1, $t3
    jal printStringFromAddress

	move $a1, strNewLine
	jal printStringFromAddress

endPrintingIsFound:
	stackPreserveEnd($a1)
	move $v1, $t3 	# return $v1
	j finallyLogic
# --

isNotFoundLogic:
    seq $t4, $t1, NOT_FOUND # hasSearchedAll
    beq $t4, TRUE, hasSearchedAllLogic
	beq $t4, FALSE, isStillSearchingLogic

hasSearchedAllLogic:
    j finallyLogic

isStillSearchingLogic:
    j finallyLogic

finallyLogic:
	stackPreserveEnd($ra)

	jr $ra
# ---- FINE searchInKeyValueMap
