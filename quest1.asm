.data
	break_string: .asciiz "\n"
	resto: .asciiz "\nResto: "
	quociente: .asciiz "Quociente: "
	
	# EDITAR ENTRADAS DO PROGRAMA AQUI
	dividendo: .word 24
	divisor: .word 9

.text
j main
divisao:
	add $t0, $zero, $a0
	add $t1, $zero, $zero
	add $t3, $zero, $a1
	beq $a0, $zero, zero
	beq $a1, $zero, zero

	loop:
		slt $t2, $t0, $a1
		bne $t2, $zero, loop.end
		addi $t1, $t1, 1 #contador
		sub $t0, $t0, $a1
		add $t3, $t0, $zero
		j loop
	loop.end:
		add $v0, $t1, $zero #retorno o quociente
		add $v1, $t3, $zero #retorna o resto
		jr $ra
	
	zero:
		li $v0, 0 #retorno o quociente
		li $v1, 0 #retorna o resto
		jr $ra

main:
	lw $a0, dividendo
	lw $a1, divisor
	jal divisao
	move $t0, $v0
	move $t1, $v1

	li $v0, 4
	la $a0, quociente
	syscall

	li $v0, 1
	move $a0, $t0,
	syscall

	li $v0, 4
	la $a0, resto
	syscall

	li $v0, 1
	move $a0, $t1
	syscall
    
