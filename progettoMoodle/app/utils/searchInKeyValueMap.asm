.data
	strErrorExceptionNotFound: "[EXCEPTION]: thisKey not found... ricordati di usare beq $v1, -1, handleCostumNotFoundException"
.text
.globl searchInKeyValueMap

# ---- INIZIO searchInKeyValueMap
# @arg      {int}           	$a1 - wantedKey
# @arg      {addr|int}      	$a2 - thisMapIndirizzo (solo .word maps {key: int, value: addr|int} -> il value è indirizzo di una stringa .asciiz oppure qualsiasi type di 4byte come int)
# @returns  {addr.string|int}	$v1 - thisValue (4 byte)
# @modifies {addr}          	$t0 - indirizzo inizio mappa (thisKeyIndirizzo)
# @modifies {int}          		$t1 - thisKey (non indirizzo ma valore)
# @modifies {bool: 0|1}     	$t2 - isKeyFound
# @modifies {bool: 0|1}   		$t3 - hasSearchedAll (ovvero thisKey == -1)
# @modifies {int|addr.string}  	$t4 - thisValue (valore non indirizzo)

searchInKeyValueMap:
    # salvo $ra per poter chiamare le funzioni dentro le funzioni
    stackPreserveStart($ra)
	move $t0, $a2    # indirizzo inizio map

	innerSearchLoop:
		lw $t1, 0($t0)                      # thisKey (non indirizzo ma valore)
		seq $t2, $t1, $a1					# isKeyFound -> thisKey == wantedKey ? 1 : 0;
		beq $t2, TRUE, isKeyFoundLogic		# if(isKeyFound) goto isKeyFoundLogic;
			isKeyNotFoundLogic:
				seq $t3, $t1, NOT_FOUND		# hasSearchedAll -> thisKey == -1 ? 1 : 0
				beq $t3, TRUE, hasSearchedAllWithoutFindingKeyLogic
					stillSearchingKeyLogic:
						addi $t0, $t0, 8	# salto al prossimo thisKey
						j innerSearchLoop

					hasSearchedAllWithoutFindingKeyLogic:
						# TODO: il codice sotto di commento serve per il debugging
						# stackPreserveStart($a1)
						# la $a1, strErrorExceptionNotFound
						# jal printStringFromAddress
						# stackPreserveEnd($a1)
						move $v1, NOT_FOUND
						j finallyLogic

			isKeyFoundLogic:
				lw $t4, 4($t0)				# thisValue
				move $v1, $t4				# return thisValue
				j finallyLogic

	finallyLogic:
		stackPreserveEnd($ra)
		jr $ra
		
# # ---- FINE searchInKeyValueMap
