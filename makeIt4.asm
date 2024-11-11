.data

X: .word 5
Y:  .word 6
QUATRO: .word 4

TABULEIRO: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
linhas:    .word 5
colunas:   .word 6
jogador:   .word 1

# vetor de direções {dx, dy} para 4 direções
direcoes: .word 0, 1, 1, 0, 1, 1, 1, -1  

msg1: .asciiz "Jogador "
msg2: .asciiz ", digite uma coluna [1-6]:\n"
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

    jal verificaEmpate
    li $t0, 1
    beq $t0, $v0, endIfEmpate # se (verificaEmpate()) {

    # printf("Empate!")
    la $t8, msgEmpate
    move $a0, $t8
    li $v0, 4
    syscall

    # break
    j FimPrograma

endIfEmpate:

    # printf("Jogador %d, digite uma coluna [1-%d]: ", jogador, Y)

    lw $t0, jogador      # carrega o valor do jogador

    # imprime a primeira parte da mensagem ("Jogador ")
    la $a0, msg1         # carrega o endereço da string "Jogador "
    li $v0, 4            # syscall para imprimir string
    syscall              # executa a syscall

    # imprime o número do jogador
    move $a0, $t0        # move o número do jogador para $a0
    li $v0, 1            # syscall para imprimir inteiro
    syscall              # executa a syscall

    # imprime a segunda parte da mensagem (", digite uma coluna [1-6]: ")
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

    # inicializa o índice i com X - 1
    la $t0, X
    lw $t0, 0($t0)
    addi $t0, $t0, -1
    sw $t0, 0($sp)               # salva i na pilha

foriImprime:                     # loop externo: for (int i = X - 1; i >= 0; i--)
    lw $t1, 0($sp)               # carrega i
    blt $t1, $zero, fimForiImprime  # se i < 0, sai do loop externo

    # inicializa o índice j com 0
    li $t2, 0
    sw $t2, 4($sp)               # salva j na pilha

forjImprime:                     # loop interno: for (int j = 0; j < Y; j++)
    lw $t2, 4($sp)               # carrega j
    lw $t3, Y
    bge $t2, $t3, fimForjImprime  # se j >= Y, sai do loop interno

    # calcula o endereço de TABULEIRO[i][j]
    lw $t1, 0($sp)               # carrega i
    lw $t2, 4($sp)               # carrega j
    lw $t6, Y
    mul $t4, $t1, $t6            # t4 = i * 6 (índice da linha)
    add $t4, $t4, $t2            # t4 = i * 6 + j
    mul $t4, $t4, 4              # t4 = (i * 6 + j) * 4 (para acessar por bytes)
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
    add $sp, $sp, -8              # reserva espaço na pilha para i e j
    li $t0, 0                     # i = 0
    sw $t0, 0($sp)               # armazena i na pilha

foriEmpate:
    lw $t0, 0($sp)               # carrega i
    lw $t1, Y                    # carrega o valor de Y
    bge $t0, $t1, FimForiEmpate  # if (i >= Y) break

    # se (TABULEIRO[X - 1][i] == 0) return 0
    la $t2, X
    lw $t2, 0($t2)
    addi $t2, $t2, -1            # $t2 = X - 1
    lw $t3, 0($sp)               # $t3 = i
    lw $t4, Y
    mul $t4, $t2, $t4            # t4 = (X-1) * Y (índice da linha)
    add $t4, $t4, $t3            # t4 = (X-1) * Y + i
    mul $t4, $t4, 4              # t4 = (X-1) * Y * 4 + i * 4 (para acessar por bytes)
    la $t5, TABULEIRO            # carrega a base de TABULEIRO
    add $t5, $t5, $t4            # endereço de TABULEIRO[X-1][i]
    lw $t6, 0($t5)               # carrega o valor de TABULEIRO[X-1][i] em $t6

    # se TABULEIRO[X-1][i] == 0, retorna 0
    bne $t6, $zero, FimIfEmpateFalse

    # incrementa i
    lw $t0, 0($sp)
    addi $t0, $t0, 1
    sw $t0, 0($sp)               # atualiza i na pilha

    j foriEmpate

FimForiEmpate:
    add $sp, $sp, 8              # restaura a pilha
    li $v0, 1                    # retorna verdadeiro (empate)
    jr $ra                       # retorna para o chamador

FimIfEmpateFalse:
    add $sp, $sp, 8              # restaura a pilha
    li $v0, 0                    # retorna falso (não é empate)
    jr $ra                       # retorna para o chamador
