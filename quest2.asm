.data
x: .float 57.23

.text
.macro power(%base, %exponent)
    li.s $f7, %base
    li.s $f8, %exponent
    li.s $f9, 1
    li.s $f14, -1
    loop:
        beq $f8, 0, endloop
        mul.s $f9, $f9, $f7
        add.s $f8, $f8, $f14
        j loop
    endloop:
    move $f30, $t2
.end_macro

.macro factorial(%number)
    li.s $f10, 1           
    li.s $f11, 1
    li.s $f13, 1       
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
    li.s $f2, 2 # index (baseado nos expoentes)
    li.s $f3, 1 # valor inicial
    li.s $f12, 2
    move $f4, $f0 # $s2 = x
    for:
        bgt $f2, 14, for.end
        power($f4, $f2)
        move $f5, $f30 # $s3 = x^index
        factorial($f2)
        move $f6, $f30 # $s4 = fatorial(index)
        div.s $f5 $f5, $f6 # realiza a divisão e armazena em $f5
        sub.s $f3, $f3, $f5
        
        add.s $f2, $f2, $f12
    for.end:
    
    move $f30, $s1
    
    
    jal $ra
    

main:
    l.s $f0, x
    jal cosseno
    move $f1, $f30
    li $v0, 2
    add $f12, $f1, $zero
    syscall
