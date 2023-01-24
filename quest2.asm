.data
x: .float 1.0472
index: .float 2
resultado: .float 1
incremento: .float 2
decremento: .float 1
criterio_de_parada: .float 1
conversion: .word 0
zero: .float 0
expoente: .word 0


.text
.macro power()
    lw $t0, expoente
    
    l.s $f9, resultado
    loop:
        beq $t0, 0, endloop
        mul.s $f9, $f9, $f0 # multiplica resultado pela base novamente
        subi $t0, $t0, 1 # subtrai index do loop (expoente)
        j loop
    endloop:
    mov.s $f30, $f9
.end_macro

.macro factorial($number)
    l.s $f10, resultado
    li $t0, 1 # index para verificar parada do loop
    loop:
        beq $number, $t0, endloop 
    	mtc1 $t0, $f11
    	cvt.s.w $f11, $f11
        mul.s $f10, $f10, $f11    
        addi $t0, $t0, 1
        j loop               
    endloop:
    
    mov.s $f30, $f10

.end_macro
j main

cosseno:
    li $s0, 2 # index (baseado nos expoentes)
    l.s $f3, resultado # resultado
    mov.s $f4, $f0 # $f4 = $f0 = x
    for:
        bgt $s0, 14, for.end
        cvt.w.s $f4, $f4 # converte float para int
        s.s $f4, conversion # armazena num .word
       	lw $t1, conversion # pega o float armazenado no .word no formato certo
       	sw $s0, expoente
        power # Recebe apenas o parametro expoente já que a base sempre será x para esse programa
        mov.s $f5, $f30 # $s3 = x^index
        factorial($t0)
        mov.s $f6, $f30 # $s4 = fatorial(index)
        div.s $f5 $f5, $f6 # realiza a divisão e armazena em $f5
        sub.s $f3, $f3, $f5
        
        addi $s0, $s0, 2
    for.end:
    
    mov.s $f30, $f3
    
    
    jr $ra
    

main:
    l.s $f0, x
    jal cosseno
    mov.s $f1, $f30
    li $v0, 2
    l.s $f29, zero
    add.s $f12, $f1, $f29
    syscall
