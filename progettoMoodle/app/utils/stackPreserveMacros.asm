.data

.text
.globl stackPreserveStart
.globl stackPreserveEnd

.macro stackPreserveStart(%registerToSave)
    addi $sp, $sp, -4
    sw %registerToSave, 0($sp)
.end_macro

.macro stackPreserveEnd(%registerToLoad)
    lw %registerToLoad, 0($sp)
    addi $sp, $sp, 4
.end_macro