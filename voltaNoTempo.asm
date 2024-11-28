.text 
j main
.include "display_bitmap.asm"

.data

X: .word 5
Y:  .word 6
QUATRO: .word 4

TABULEIRO: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
linhas:    .word 6
colunas:   .word 7
jogador:   .word 1
verm:      .asciiz "vermelho"
amar:      .asciiz "amarelo "

#contadores para verificar vitória
cont1:     .word 0
cont2:     .word 0
cont3:     .word 0
cont4:     .word 0

msg1: .asciiz "Jogador "
msg2: .asciiz ", digite uma coluna [1-7]:\n"
msgEmpate: .asciiz "Empate!\n"
msg3: .asciiz " venceu!\n"
msg4: .asciiz "Jogada indisponível! Tente novamente.\n"
space:    .asciiz "  "           # espaço entre os elementos
newline:  .asciiz "\n"           # nova linha após cada linha do tabuleiro


.text
.globl main


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
    la $t0, TABULEIRO        #carrega o endereço base da matriz em $t0
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


main:

    add $sp, $sp, -4  # coluna = 0($sp)
    # teste da inicializaÃ§Ã£o da tela: versÃ£o otimizada
    jal     init2_graph_test
    # fazer os numeros das colunas
    jal     desenha_numeros
    # fazer o fundo do tabuleiro
    jal     desenha_tabuleiro


do:
    jal entrada_pecas
    jal imprimeTabuleiro

    li $t0, 1
    jal verificaEmpate
    beq $t0, $v0, endIfEmpate # se (verificaEmpate()) {

    # printf("Empate!")
    la $t8, msgEmpate
    move $a0, $t8
    li $v0, 4
    syscall

    # break
    j FimPrograma

endIfEmpate:

    # printf("Jogador ___, digite uma coluna [1-7]: ")

    lw $t0, jogador      # carrega o valor do jogador

    # imprime a primeira parte da mensagem ("Jogador ")
    la $a0, msg1         # carrega o endereço da string "Jogador "
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    # imprime a cor do jogador
    lw $t0, jogador
    li $t1, 1
    beq $t0, $t1, vermelho1
    la $a0, amar
    li $v0, 4
    syscall              # executa a syscall
    j resto1
vermelho1:
    la $a0, verm
    li $v0, 4
    syscall
resto1:
    # imprime a segunda parte da mensagem (", digite uma coluna [1-7]: ")
    la $a0, msg2         # carrega o endereço da string final
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    
lerColuna:
    # syscall para leitura de um caractere
    li $v0, 12                # código de syscall para ler um caractere
    syscall                   # executa a syscall, o caractere fica em $v0
    subu $t0, $v0, '0'        # converte o caractere para um inteiro (ASCII - '0')
    
    # verifica se está no intervalo 1-7
    addi $t0, $t0, -1
    blt $t0, 0, erroEntrada   # se $t0 < 1, vai para 
    bgt $t0, 6, erroEntrada   # se $t0 > 7, vai para
    
    # armazena o número convertido (já validado) na pilha
    sw $t0, 0($sp)            # salva o número no endereço destinado à variável 'coluna'
    lw $a0, 0($sp)            # carrega o valor de 'coluna' em $a0
    jal jogada

    bne $v0, $zero, verVit
erroEntrada:

    la $a0, newline
    li $v0, 4
    syscall

    la $a0, msg4
    li $v0, 4
    syscall
    jal entrada_pecas
    jal imprimeTabuleiro
    j endIfEmpate
    # se (verificaVitoria()) {
verVit:
    jal verificaVitoria
    li $t0, 1
    bne $v0, $t0, alterna  # se não é vitória o if é falso

    # imprime
    jal entrada_pecas
    jal imprimeTabuleiro

    # imprime a primeira parte da mensagem ("Jogador ")
    la $a0, msg1         # carrega o endereço da string "Jogador "
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    # imprime o número do jogador
    lw $t0, jogador
    li $t1, 1
    beq $t0, $t1, vermelho2

    la $a0, amar
    li $v0, 4
    syscall              # executa a syscall
    j resto2

vermelho2:
    la $a0, verm
    li $v0, 4
    syscall
resto2:

    # imprime a segunda parte da mensagem ("venceu!\n")
    la $a0, msg3        # carrega o endereço da string final
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    j FimPrograma

alterna:
    lw $t0, jogador
    li $t1, 1
    bne $t0, $t1, recebe1
recebe2:
    li $t2, 2
    sw $t2, jogador
    j fimAlterna
recebe1:
    sw $t1, jogador

fimAlterna:
    # continua o loop
    j do

FimPrograma:
    jal entrada_pecas
    jal imprimeTabuleiro
    add $sp, $sp, 4
    li $v0, 10           # syscall para encerrar o programa
    syscall              # executa a syscall



imprimeTabuleiro:
    add $sp, $sp, -8             # reserva espaço na pilha para i e j

    la $a0, newline
    li $v0, 4                    # syscall para imprimir string
    syscall

    # inicializa o índice i com linhas - 1
    la $t0, linhas
    lw $t0, 0($t0)
    addi $t0, $t0, -1
    sw $t0, 0($sp)               # salva i na pilha

foriImprime:                     # loop externo: for (int i = linhas - 1; i >= 0; i--)
    lw $t1, 0($sp)               # carrega i
    blt $t1, $zero, fimForiImprime  # se i < 0, sai do loop externo

    # inicializa o índice j com 0
    li $t2, 0
    sw $t2, 4($sp)               # salva j na pilha

forjImprime:                     # loop interno: for (int j = 0; j < colunas; j++)
    lw $t2, 4($sp)               # carrega j
    lw $t3, colunas
    bge $t2, $t3, fimForjImprime  # se j >= colunas, sai do loop interno

    # calcula o endereço de TABULEIRO[i][j]
    lw $t1, 0($sp)               # carrega i
    lw $t2, 4($sp)               # carrega j
    lw $t6, colunas              # carrega o número de colunas
    mul $t4, $t1, $t6            # t4 = i * 7 (índice da linha)
    add $t4, $t4, $t2            # t4 = i * 7 + j
    mul $t4, $t4, 4              # t4 = (i * 7 + j) * 4 (para acessar por bytes)
    la $t5, TABULEIRO            # carrega a base de TABULEIRO
    add $t5, $t5, $t4            # endereço de TABULEIRO[i][j]
    lw $t6, 0($t5)               # carrega o valor de TABULEIRO[i][j] em $t6

    # imprime o valor de TABULEIRO[i][j]
    move $a0, $t6                # coloca o valor em $a0 para imprimir
    li $v0, 1                    # syscall para imprimir inteiro
    syscall

    # imprime o espaço após o número ("  ")
    la $a0, space
    li $v0, 4                    # syscall para imprimir string
    syscall

    # incrementa j e volta para o início do loop interno
    lw $t2, 4($sp)
    addi $t2, $t2, 1
    sw $t2, 4($sp)               # atualiza j na pilha
    j forjImprime

fimForjImprime:
    # imprime a nova linha após o fim de uma linha do tabuleiro
    la $a0, newline
    li $v0, 4                    # syscall para imprimir string
    syscall

    # decrementa i e volta para o início do loop externo
    lw $t1, 0($sp)
    addi $t1, $t1, -1
    sw $t1, 0($sp)               # atualiza i na pilha
    j foriImprime

fimForiImprime:
    add $sp, $sp, 8              # restaura a pilha
    jr $ra                        # retorna para o chamador

verificaEmpate:
    # Registradores usados:
    # $t9 = índice da coluna (j)
    # $t1 = número de colunas
    # $t2 = índice da última linha
    # $t3 = valor da célula atual (TABULEIRO[linhas-1][j])
    # $t4 = endereço calculado da célula

    # Carrega o número de colunas em $t1
    lw $t1, colunas               

    # Carrega o índice da última linha (linhas - 1) em $t2
    lw $t2, linhas                
    subi $t2, $t2, 1              # Última linha: linhas - 1

    # Inicializa o índice da coluna (j = 0)
    li $t9, 0                     

loopColunas:
    # Verifica se j >= colunas
    beq $t9, $t1, fimVerificaEmpate 

    # Calcula o índice unidimensional: (linhas - 1) * colunas + j
    mul $t4, $t2, $t1             # (linhas - 1) * colunas
    add $t4, $t4, $t9             # (linhas - 1) * colunas + j
    mul $t4, $t4, 4               # Multiplica por 4 para obter o deslocamento em bytes

    # Calcula o endereço da célula e carrega o valor
    la $t5, TABULEIRO             # Carrega a base do TABULEIRO
    add $t5, $t5, $t4             # Endereço de TABULEIRO[linhas-1][j]
    lw $t3, 0($t5)                # Valor da célula atual

    # Verifica se o valor da célula é zero
    beq $t3, $zero, retornoUm   # Se é zero, retorna 1

    # Incrementa j e continua o loop
    li $t7, 1
    add $t9, $t9, $t7              
    j loopColunas                 # Próxima coluna

fimVerificaEmpate:
    # Se chegou aqui,
    li $v0, 0                     # Retorna 0 (não há zeros na última linha)
    jr $ra                        # Retorna

retornoUm:
    li $v0, 1                     # Retorna 0 (há pelo menos um zero)
    jr $ra                        # Retorna




jogada: 
    add $sp, $sp, -8       # Reserva espaço na pilha para coluna e linha
    sw $a0, 0($sp)         # Salva coluna em 0($sp)
    sw $zero, 4($sp)       # Inicializa linha = 0 em 4($sp)

whileColuna:
    lw $t0, 4($sp)         # Carrega linha em $t0
    lw $t1, linhas         # Carrega linhas em $t1 (número de linhas)
    bge $t0, $t1, fimWhileColuna  # Se linha >= linhas, sai do loop

    # Calcula o endereço de TABULEIRO[linha][coluna]
    la $t2, TABULEIRO      # Carrega o endereço base de TABULEIRO em $t2
    lw $t3, 0($sp)         # Carrega coluna em $t3
    lw $t9, colunas
    mul $t4, $t0, $t9       # $t4 = linha * colunas
    add $t4, $t4, $t3      # $t4 = linha * colunas + coluna
    mul $t4, $t4, 4        # $t4 = (linha * colunas + coluna) * 4 (offset em bytes)
    add $t9, $t2, $t4      # $t9 = endereço de TABULEIRO[linha][coluna]

    # Verifica se TABULEIRO[linha][coluna] é 0
    lw $t5, 0($t9)         # Carrega o valor de TABULEIRO[linha][coluna] em $t5
    beq $t5, $zero, fimWhileColuna  # Se TABULEIRO[linha][coluna] == 0, sai do loop

    # Incrementa linha
    lw $t6, 4($sp)         # Carrega linha
    addi $t6, $t6, 1       # Incrementa linha
    sw $t6, 4($sp)         # Armazena linha de volta na pilha
    j whileColuna          # Continua o loop

fimWhileColuna:
    # Verifica se a jogada é válida: linha >= linhas ou coluna >= colunas ou coluna < 0
    lw $t0, 4($sp)         # Carrega linha
    lw $t1, linhas              # Carrega linhas
    lw $t2, 0($sp)         # Carrega coluna
    lw $t3, colunas              # Carrega colunas
    bge $t0, $t1, indisponivel   # Se linha >= linhas, vai para indisponível
    bge $t2, $t3, indisponivel   # Se coluna >= colunas, vai para indisponível
    blt $t2, $zero, indisponivel # Se coluna < 0, vai para indisponível

atribui:
    lw $t0, jogador        # Carrega o valor de jogador
    sw $t0, 0($t9)         # Armazena jogador em TABULEIRO[linha][coluna]
    li $v0, 1              # Retorna 1 (jogada válida)
    add $sp, $sp, 8        # Libera o espaço na pilha
    jr $ra                 # Retorna

indisponivel:
    # Imprime mensagem "Jogada indisponível!"
    la $a0, msg4           # Carrega a mensagem de erro em $a0
    li $v0, 4              # Syscall para imprimir string
    syscall                # Executa syscall
    li $v0, 0              # Retorna 0 (jogada inválida)
    add $sp, $sp, 8        # Libera o espaço na pilha
    jr $ra                 # Retorna





verificaVitoria:

    add $sp, $sp, -12
    #i = 0($sp), j = 4($sp), k = 8($sp)
    sw $zero, 0($sp)  #i = 0

#mapa de registradores:
# $t0 = i
# $t1 = j
# $t2 = k
# $t3 = cont1
# $t4 = cont2
# $t5 = cont3
# $t6 = cont4
# $s0 = linhas
# $s1 = colunas
# $s2 = jogador 
# $s3 = &TABULEIRO[0][0]
foriVitoria:
    lw $t0, 0($sp)     #carrega i
    lw $s0, linhas     #carrega linhas
    lw $s1, colunas
    lw $s2, jogador
    la $s3, TABULEIRO
    bge $t0, $s0, FimForiVitoria  # verificação do for. (i >= linhas)

   
    sw $zero, 4($sp)   #carrega j
forjVitoria:

    #conts = 0
    add $t3, $zero, $zero
    add $t4, $zero, $zero
    add $t5, $zero, $zero
    add $t6, $zero, $zero
    

    lw $t1, 4($sp)         # carrega j
    lw $s1, colunas        # carrega colunas
    bge $t1, $s1, FimForjVitoria  # verificação do for. (j >= colunas)
    sw $zero, 8($sp)       # k = 0

    lw $t2, 8($sp)      # k = $t2

    
forkVitoria:
    li $t7, 4
    bge $t2, $t7, FimForkVitoria  # verificação do for. (k >= 4)
    lw $s2, jogador
    la $s3, TABULEIRO


if1:   # if (i + k < linhas && TABULEIRO[i+k][j] == jogador){

    add $t7, $t0, $t2 #$t7 = i + k
    
   

    bge $t7, $s0, if2  # if (i + k >= linhas)
    mul $t8, $t7, $s1  # $t8 = (i + k) * colunas
    add $t9, $t8, $t1  # $t9 = (i + k) * colunas + j
    mul $t9, $t9, 4    # $t9 = ((i + k) * colunas + j) * 4

   
    add $t9, $s3, $t9  # $t9 = &TABULEIRO[(i + k)][j]
    lw $t9, 0($t9)     # $t9 = TABULEIRO[(i + k)][j]
    bne $t9, $s2, if2  # if (TABULEIRO[(i + k)][j] != jogador)
    addi $t3, $t3, 1   # cont1++
    li $t7, 4
    bge $t3, $t7, Vitoria  # if (cont1 >= 4)

if2:   #if (i + k < X && j + k < colunas && TABULEIRO[i+k][j+k] == jogador){
    
    add $t7, $t0, $t2 #$t7 = i + k
    bge $t7, $s0, if3  # if (i + k >= linhas)
    add $t8, $t1, $t2  # $t8 = j + k
    bge $t8, $s1, if3  # if (j + k >= colunas)

    mul $t9, $t7, $s1  # $t9 = (i + k) * colunas
    add $t9, $t9, $t8  # $t9 = (i + k) * colunas + j + k
    mul $t9, $t9, 4    # $t9 = ((i + k) * colunas + j + k) * 4
    add $t9, $s3, $t9  # $t9 = &TABULEIRO[(i + k)][j + k]
    lw $t9, 0($t9)     # $t9 = TABULEIRO[(i + k)][j + k]
    bne $t9, $s2, if3  # if (TABULEIRO[(i + k)][j + k] != jogador)

    

    addi $t4, $t4, 1   # cont2++
    li $t7, 4
    bge $t4, $t7, Vitoria  # if (cont2 >= 4)
if3:   # if (j - k >= 0 && i + k < linhas && TABULEIRO[i + k][j - k] == jogador)


    la $s3, TABULEIRO

    sub $t8, $t1, $t2         # $t8 = j - k
    blt $t8, $zero, if4       # if (j - k < 0), pula para if4

    add $t7, $t0, $t2         # $t7 = i + k
    bge $t7, $s0, if4         # if (i + k >= linhas), pula para if4

    mul $t9, $t7, $s1         # $t9 = (i + k) * colunas
    add $t9, $t9, $t8         # $t9 = (i + k) * colunas + (j - k)
    mul $t9, $t9, 4           # $t9 = ((i + k) * colunas + (j - k)) * 4
    add $t9, $s3, $t9         # $t9 = &TABULEIRO[i + k][j - k]

    lw $t9, 0($t9)            # $t9 = TABULEIRO[i + k][j - k]
    bne $t9, $s2, if4         # if (TABULEIRO[i + k][j - k] != jogador), pula para if4

    addi $t5, $t5, 1          # cont3++
    li $t7, 4
    bge $t5, $t7, Vitoria     # if (cont3 >= 4), vitória


if4:   #if (j + k < colunas && TABULEIRO[i][j+k] == jogador){
    add $t8, $t1, $t2             # $t8 = j + k
    bge $t8, $s1, FimForkVitoria  # if (j + k >= colunas)
    mul $t9, $t0, $s1  # $t9 = i * colunas
    add $t9, $t9, $t8  # $t9 = i * colunas + (j + k)
    mul $t9, $t9, 4    # $t9 = ((i * colunas) + (j + k)) * 4
    add $t9, $s3, $t9  # $t9 = &TABULEIRO[i][j + k]

    lw $t9, 0($t9)                # $t9 = TABULEIRO[j+k][i]

    addi $t2, $t2, 1   # k++
    sw $t2, 8($sp)     # atualiza k na pilha

    bne $t9, $s2, forkVitoria  # if (TABULEIRO[j+k][i] != jogador) continue;
    addi $t6, $t6, 1              # cont4++
    li $t7, 4
    bge $t6, $t7, Vitoria         # if (cont4 >= 4)

    

    j forkVitoria

FimForkVitoria:


    addi $t1, $t1, 1   # j++
    sw $t1, 4($sp)     # atualiza j na pilha
    j forjVitoria

FimForjVitoria:

    addi $t0, $t0, 1   # i++
    sw $t0, 0($sp)     # atualiza i na pilha
    j foriVitoria

FimForiVitoria:
    add $sp, $sp, 12
    li $v0, 0
    jr $ra

Vitoria:
    add $sp, $sp, 12
    li $v0, 1
    jr $ra
