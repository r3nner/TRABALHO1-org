.text 
j main
.include "display_bitmap.asm"

.globl main

.data
tabuleiro:	.space 168
matriz: .word 1, 2, 0, 1, 0, 2, 0   # Linha 1
        .word 2, 0, 0, 1, 1, 0, 0   # Linha 2
        .word 0, 1, 2, 0, 0, 1, 1   # Linha 3
        .word 1, 1, 2, 0, 1, 1, 0   # Linha 4
        .word 0, 0, 2, 2, 0, 0, 1   # Linha 5
        .word 1, 0, 0, 1, 1, 0, 0   # Linha 6


.text

main:

# corpo do programa
            # teste da inicializaÃ§Ã£o da tela: versÃ£o otimizada
            jal     init2_graph_test
            # teste do desenho de linhas
            jal     desenha_numeros
            # teste do desenho de retÃ¢ngulos
            jal     desenha_tabuleiro
            
            jal entrada_pecas
            
	    li $v0, 10
	    syscall
         
            
#####################################################################################################################################                    
                     
init2_graph_test:
# prÃ³logo
            addiu   $sp, $sp, -4        # ajustamos a pilha
            sw      $ra, 0($sp)         # armazenamos o endereÃ§o de retorno na pilha
# corpo do procedimento
            li      $a0, BLUE
            jal     set_background_color
            jal     screen_init2        # inicializamos a tela grÃ¡fica, versÃ£o otimizada
# epÃ­logo
            lw      $ra, 0($sp)         # restauramos o endereÃ§o de retorno
            addiu   $sp, $sp, 4         # restauramos a pilha
            jr	    $ra                 # retornamos ao procedimento chamador
            
#####################################################################################################################################            

desenha_numeros:
# prÃ³logo
            addiu   $sp, $sp, -4        # ajustamos a pilha
            sw      $ra, 0($sp)         # armazenamos o endereÃ§o de retorno na pilha
# corpo do procedimento
            li      $a0, WHITE
            jal     set_foreground_color
            li      $a0, 55 
            li      $a1, 0
            li      $a2, 55
            li      $a3, 63
            jal     draw_line
            li      $a0, 57 #desenha 1
            li      $a1, 5
            li      $a2, 62
            li      $a3, 5
            jal     draw_line 
            li      $a0, 57 
            li      $a1, 5
            li      $a2, 58
            li      $a3, 4
            jal     draw_line
            li      $a0, 57 #desenha 2
            li      $a1, 12
            li      $a2, 57
            li      $a3, 15
            jal     draw_line
            li      $a0, 57
            li      $a1, 15
            li      $a2, 59
            li      $a3, 15
            jal     draw_line
            li      $a0, 59
            li      $a1, 15
            li      $a2, 59
            li      $a3, 12
            jal     draw_line
            li      $a0, 59
            li      $a1, 12
            li      $a2, 62
            li      $a3, 12
            jal     draw_line
            li      $a0, 62
            li      $a1, 12
            li      $a2, 62
            li      $a3, 15
            jal     draw_line #desenha 3
            li      $a0, 57
            li      $a1, 21
            li      $a2, 57
            li      $a3, 24
            jal     draw_line
            li      $a0, 59
            li      $a1, 21
            li      $a2, 59
            li      $a3, 24
            jal     draw_line
            li      $a0, 62
            li      $a1, 21
            li      $a2, 62
            li      $a3, 24
            jal     draw_line
            li      $a0, 57
            li      $a1, 24
            li      $a2, 62
            li      $a3, 24
            jal     draw_line
            li      $a0, 57 #desenha 4
            li      $a1, 30
            li      $a2, 59
            li      $a3, 30
            jal     draw_line
            li      $a0, 57 
            li      $a1, 34
            li      $a2, 62
            li      $a3, 34
            jal     draw_line
            li      $a0, 59 
            li      $a1, 30
            li      $a2, 59
            li      $a3, 34
            jal     draw_line
            li      $a0, 57 #desenha 5
            li      $a1, 38
            li      $a2, 57
            li      $a3, 42
            jal     draw_line
            li      $a0, 59
            li      $a1, 38
            li      $a2, 59
            li      $a3, 42
            jal     draw_line
            li      $a0, 62
            li      $a1, 38
            li      $a2, 62
            li      $a3, 42
            jal     draw_line
            li      $a0, 57
            li      $a1, 38
            li      $a2, 59
            li      $a3, 38
            jal     draw_line
            li      $a0, 59
            li      $a1, 42
            li      $a2, 62
            li      $a3, 42
            jal     draw_line 
            li      $a0, 57 #desenha 6
            li      $a1, 48
            li      $a2, 57
            li      $a3, 52
            jal     draw_line
            li      $a0, 59
            li      $a1, 48
            li      $a2, 59
            li      $a3, 52
            jal     draw_line
            li      $a0, 62
            li      $a1, 48
            li      $a2, 62
            li      $a3, 52
            jal     draw_line
            li      $a0, 57
            li      $a1, 48
            li      $a2, 59
            li      $a3, 48
            jal     draw_line
            li      $a0, 59
            li      $a1, 52
            li      $a2, 62
            li      $a3, 52
            jal     draw_line
            li      $a0, 59
            li      $a1, 48
            li      $a2, 62
            li      $a3, 48
            jal     draw_line
            li      $a0, 57 #deseha 7
            li      $a1, 56
            li      $a2, 57
            li      $a3, 61
            jal     draw_line
            li      $a0, 58 
            li      $a1, 61
            li      $a2, 62
            li      $a3, 57
            jal     draw_line
            li      $a0, BLACK
            jal     set_foreground_color
            li      $a0, 0 #fazer bordas
            li      $a1, 0
            li      $a2, 0
            li      $a3, 63
            jal     draw_line
            li      $a0, 0
            li      $a1, 0
            li      $a2, 63
            li      $a3, 0
            jal     draw_line
            li      $a0, 0
            li      $a1, 63
            li      $a2, 63
            li      $a3, 63
            jal     draw_line
            li      $a0, 63
            li      $a1, 0
            li      $a2, 63
            li      $a3, 63
            jal     draw_line
# epÃ­logo
            lw      $ra, 0($sp)         # restauramos o endereÃ§o de retorno
            addiu   $sp, $sp, 4         # restauramos a pilha
            jr	    $ra                 # retornamos ao procedimento chamador

#####################################################################################################################################            

desenha_tabuleiro:
# prÃ³logo
            addiu   $sp, $sp, -4        # ajustamos a pilha
            sw      $ra, 0($sp)         # armazenamos o endereÃ§o de retorno na pilha
# corpo do procedimento
            li      $a0, 0x0000aa 
            jal     set_foreground_color
            li $s0, 1
            li $s1, 1
            li $s2, 1
            li $s3, 62
loop:  #faz o fundo em azul escuro
	    move $a0, $s0
	    move $a1, $s1
	    move $a2, $s2
	    move $a3, $s3
	    jal draw_line
	    addi $s0, $s0, 1
	    addi $s2, $s2, 1
	    beq $s0, 54, linhas_mat
	    j loop
	    
linhas_mat:     #comeca a separar a matriz em linhas
	    li $a0, 0x0000ff
	    jal set_foreground_color
	    li $s0, 1
            li $s1, 9
            li $s2, 53
            li $s3, 9
            li $s4, 1
loop1:          #loop para separar a matriz em linhas
	    move $a0, $s0
	    move $a1, $s1
	    move $a2, $s2
	    move $a3, $s3
	    jal draw_line
	    addi $s1, $s1, 9
	    addi $s3, $s3, 9
	    beq $s4, 6, colunas_mat
	    addi $s4, $s4, 1
	    j loop1

colunas_mat:   #comeca a separar a matriz em colunas
	    li $a0, 0x0000ff
	    jal set_foreground_color
	    li $s0, 9
            li $s1, 1
            li $s2, 9
            li $s3, 62
            li $s4, 1 
loop2:         #loop da separacao da matriz em colunas
	    move $a0, $s0
	    move $a1, $s1
	    move $a2, $s2
	    move $a3, $s3
	    jal draw_line
	    addi $s0, $s0, 9
	    addi $s2, $s2, 9
	    beq $s4, 5, fim_desenho
	    addi $s4, $s4, 1
	    j loop2
	   
# epÃ­logo
fim_desenho:
            lw      $ra, 0($sp)         # restauramos o endereÃ§o de retorno
            addiu   $sp, $sp, 4         # restauramos a pilha
            jr	    $ra                 # retornamos ao procedimento chamador
           
#####################################################################################################################################               


entrada_pecas:
# prÃ³logo
    addiu   $sp, $sp, -16        # ajustamos a pilha
    sw      $ra, 0($sp)         # armazenamos o endereÃ§o de retorno na pilha

#corpo do procedimento
    li $s6, 47
    la $t0, matriz        #carrega o endereço base da matriz em $t0
    li $s5, 0             # ponteiro que percorre a matriz
    li $t1, 0             #inicializa indice das linhas em 0
    move $s5, $t0         #passa o endereco da matriz para a variavel global $s5

loop_linhas:               #loop das linhas
    addi $t1, $t1, 1       #linha++
    li $t2, 0		  #inicializa indice das colunas como 0
    li $s7, 2             #volta o x para 2

loop_colunas:               #loop das colunas
    addi $t2, $t2, 1        #coluna++

    lw $t7, 0($s5)        #pega o valor do indice da matriz e armazena em $t7

    #verificacao se o valor e 1 ou 2
    beq $t7, 1, chama_desenho1  #se a posicao da matrix== 1, chama a função q imprime vermelho

    beq $t7, 2, chama_desenho2  #se a posicao da matrix== 2, chama a função q imprime amarelo
    
    j pular_desenho #se nao vai pro final do loop

chama_desenho1:            #imprime a peca na posicao correta em vermelho
    sw $t0, 4($sp)         #salvar as variaveis temporarias
    sw $t1, 8($sp)
    sw $t2, 12($sp)
    
    li $a0, RED
    jal set_foreground_color

    move $a0, $s6
    move $a1, $s7
    jal desenha_circulo
    
    lw $t0, 4($sp)  #pegar de volta da memoria as variaveis temporarias salvas
    lw $t1, 8($sp)
    lw $t2, 12($sp)
    
    j pular_desenho

chama_desenho2:           #imprime a peca na posicao correta em amarelo
    sw $t0, 4($sp)        #salvar as variaveis temporarias
    sw $t1, 8($sp)
    sw $t2, 12($sp)

    li $a0, YELLOW
    jal set_foreground_color

    move $a0, $s6
    move $a1, $s7
    jal desenha_circulo
    
    lw $t0, 4($sp)    #pegar de volta da memoria as variaveis temporarias salvas
    lw $t1, 8($sp)
    lw $t2, 12($sp)
    
    j pular_desenho

pular_desenho:
    addi $s5, $s5, 4      #vai para o proximo indice do vetor do tabuleiro

    addi $s7, $s7, 9      #vai para a direita para imprimir as outras pecas 
    
    li $t3, 7             #numero de colunas
    bne $t2, $t3, loop_colunas  # verificacao se completou numero de colunas

    addi $s6, $s6, -9 #sobe na linha do tabuleiro
    
    li $t4, 6                  #numero de linhas
    bne $t1, $t4, loop_linhas  # verificacao se completou numero de linhas
 
# epÃ­logo
fim_entrada:
    lw      $ra, 0($sp)         # restauramos o endereÃ§o de retorno
    addiu   $sp, $sp, 4         # restauramos a pilha
    jr	    $ra                 # retornamos ao procedimento chamador

           
               
#####################################################################################################################################            
            
desenha_circulo:
	    move $s0, $a0
            move $s1, $a1
# prÃ³logo
            addiu   $sp, $sp, -4        # ajustamos a pilha
            sw      $ra, 0($sp)         # armazenamos o endereÃ§o de retorno na pilha
# corpo do procedimento

            addi $s1, $s1, 1
            move $s2, $s0
            move $s3, $s1
            addi $s3, $s3, 3 #primeiros 3 pixels
	    li $s4, 1
	    move $a0, $s0
	    move $a1, $s1
	    move $a2, $s2
	    move $a3, $s3
	    jal draw_line
	    addi $s1, $s1, -1
	    addi $s3, $s3, 1
loop_circulo: #3 linhas de 5 pixels
	    addi $s0, $s0, 1
	    addi $s2, $s2, 1
	    move $a0, $s0
	    move $a1, $s1
	    move $a2, $s2
	    move $a3, $s3
	    jal draw_line
	    beq $s4, 4, ult_linha
	    addi $s4, $s4, 1
	    j loop_circulo
ult_linha: #quinta linha com 3 pixels
	    addi $s0, $s0, 1
	    addi $s1, $s1, 1
	    addi $s2, $s2, 1
	    addi $s3, $s3, -1
	    move $a0, $s0
	    move $a1, $s1
	    move $a2, $s2
	    move $a3, $s3
	    jal draw_line
	   
# epÃ­logo
fim_circulo:
            lw      $ra, 0($sp)         # restauramos o endereÃ§o de retorno
            addiu   $sp, $sp, 4         # restauramos a pilha
            jr	    $ra                 # retornamos ao procedimento chamador

#####################################################################################################################################            
