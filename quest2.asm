.data
x: .float 57.23
index: .float 2
resultado: .float 1
incremento: .float 2
decremento: .float 1
criterio_de_parada: .float 1


.text
.macro power(%base, %exponent)
    l.s $f7, %base
    l.s $f8, %exponent
    l.s $f9, resultado
    l.s $f14, decremento
    loop:
        beq $f8, 0, endloop
        mul.s $f9, $f9, $f7
        sub.s $f8, $f8, $f14
        j loop
    endloop:
    mov.s $f30, $f9
.end_macro

.macro factorial(%number)
    l.s $f10, resultado
    l.s $f11, criterio_de_parada
    l.s $f13, decremento
    loop:
        beq %number, $f11, endloop 
        mul.s $f10, $f10, $f11    
        add.s $f11, $f11, $f13
        j loop               
    endloop:
    
    move $f30, $f10

.end_macro
j main

cosseno:
    li $t0, 2 # index (baseado nos expoentes)
    l.s $f3, resultado # resultado
    mov.s $f4, $f0 # $f4 = $f0 = x
    for:
        bgt $f2, 14, for.end
        power($f4, $t0)
        mov.s $f5, $f30 # $s3 = x^index
        factorial($t0)
        mov.s $f6, $f30 # $s4 = fatorial(index)
        div.s $f5 $f5, $f6 # realiza a divisão e armazena em $f5
        sub.s $f3, $f3, $f5
        
        addi $t0, $t0, 2
    for.end:
    
    mov.s $f30, $f3
    
    
    jal $ra
    

main:
    l.s $f0, x
    jal cosseno
    mov.s $f1, $f30
    li $v0, 2
    add $f12, $f1, $zero
    syscall
