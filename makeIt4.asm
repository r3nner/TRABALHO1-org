.data

X: .word 5
Y:  .word 6
QUATRO: .word 4

TABULEIRO: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
linhas:    .word 6
colunas:   .word 7
jogador:   .word 1

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

main:

    add $sp, $sp, -4  # coluna = 0($sp)

do:
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

    # printf("Jogador %d, digite uma coluna [1-%d]: ", jogador, colunas)

    lw $t0, jogador      # carrega o valor do jogador

    # imprime a primeira parte da mensagem ("Jogador ")
    la $a0, msg1         # carrega o endereço da string "Jogador "
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    # imprime o número do jogador
    move $a0, $t0        # move o número do jogador para $a0
    li $v0, 1            # syscall para imprimir inteiro
    syscall              # executa a syscall

    # imprime a segunda parte da mensagem (", digite uma coluna [1-7]: ")
    la $a0, msg2         # carrega o endereço da string final
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    
lerColuna:
    # scanf("%d", &coluna)
    # coluna--
    li $v0, 5                 # código de syscall para ler um inteiro
    syscall                   # executa a syscall, o valor lido fica em $v0
    addi $v0, $v0, -1         # coluna--
    sw $v0, 0($sp)            # armazena o valor lido na variável 'coluna'

    # se (!jogada(coluna)) continue
    move $a0, $v0
    jal jogada
    li $t0, 1
    bne $v0, $t0, do

    # se (verificaVitoria()) {
    jal verificaVitoria
    li $t0, 1
    bne $v0, $t0, alterna  # se não é vitória o if é falso

    # imprime
    jal imprimeTabuleiro

    # imprime a primeira parte da mensagem ("Jogador ")
    la $a0, msg1         # carrega o endereço da string "Jogador "
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    # imprime o número do jogador
    lw $a0, jogador        # move o número do jogador para $a0
    li $v0, 1            # syscall para imprimir inteiro
    syscall              # executa a syscall

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
    jal imprimeTabuleiro
    add $sp, $sp, 4
    li $v0, 10           # syscall para encerrar o programa
    syscall              # executa a syscall



imprimeTabuleiro:
    add $sp, $sp, -8             # reserva espaço na pilha para i e j

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



