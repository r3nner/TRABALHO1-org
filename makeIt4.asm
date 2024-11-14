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


verificaVitoria:
    add $sp, $sp, -32
    #0($sp) = i, 4($sp) = j, 8($sp) = k, 12($sp) = dx, 16($sp) = dy, 20($sp) = x, 24($sp) = y, 28($sp) = match

foriVitoria:
    li $t0, 0
    sw $t0, 0($sp)               # i = 0

    lw $t1, X                   # $t1 = X
    bge $t0, $t1, FimForiVitoria

forjVitoria:
    li $t0, 0
    sw $t0, 4($sp)               # j = 0
    lw $t1, Y                   # $t1 = Y
    bge $t0, $t1, FimForjVitoria

    lw $t0, 0($sp)               # i
    lw $t1, 4($sp)               # j
    lw $t2, Y                    # $t2 = Y
    mul $t3, $t0, $t2            # t3 = i * Y
    add $t3, $t3, $t1            # t3 = i * Y + j
    mul $t3, $t3, 4              # t3 = (i * Y + j) * 4
    la $t4, TABULEIRO            # carrega a base de TABULEIRO
    add $t4, $t4, $t3            # endereço de TABULEIRO[i][j]
    lw $t5, 0($t4)               # carrega o valor de TABULEIRO[i][j] em $t5
    lw $t6, jogador              # carrega o valor de jogador em $t6
    bne $t5, $t6, FimForjVitoria # desvia se TABULEIRO[i][j] != jogador
# Endereço base para a matriz `direcoes` linearizada
    la      $t0, direcoes          # $t0 aponta para direcoes[0]
    
    li      $t1, 0                 # d = 0 (contador de direção)
fordVitoria:
    # Verifica se d < 4
    li      $t2, 4
    bge     $t1, $t2, endFordVitoria

    # Carrega dx e dy a partir de direcoes[d * 2] e direcoes[d * 2 + 1]
    sll     $t3, $t1, 1            # d * 2, pois cada direção ocupa 2 inteiros
    add     $t4, $t0, $t3          # Endereço de direcoes[d * 2]
    lw      $t5, 0($t4)            # dx = direcoes[d * 2]
    lw      $t6, 4($t4)            # dy = direcoes[d * 2 + 1]
    sw      $t5, 12($sp)           # Armazena dx na pilha
    sw      $t6, 16($sp)           # Armazena dy na pilha
    li      $t7, 1
    sw      $t7, 28($sp)           # match = 1 (assume sequência encontrada)

    # Inicializa k para o loop interno
    li      $t8, 1                 # k = 1
    sw      $t8, 8($sp)            # Armazena k na pilha
forkVitoria:
    # Verifica se k < QUATRO
    lw      $t8, 8($sp)            # Carrega k
    lw      $t9, QUATRO            # Carrega QUATRO
    bge     $t8, $t9, endForkVitoria

    # Calcula x = i + k * dx
    lw      $t7, 0($sp)            # Carrega i
    lw      $t5, 12($sp)           # Carrega dx
    mul     $t6, $t8, $t5          # k * dx
    add     $t7, $t7, $t6          # x = i + k * dx
    sw      $t7, 20($sp)           # Armazena x na pilha

    # Calcula y = j + k * dy
    lw      $t7, 4($sp)            # Carrega j
    lw      $t5, 16($sp)           # Carrega dy
    mul     $t6, $t8, $t5          # k * dy
    add     $t7, $t7, $t6          # y = j + k * dy
    sw      $t7, 24($sp)           # Armazena y na pilha

        # Verifica se x < 0
    lw      $t0, 20($sp)           # Carrega x
    bltz    $t0, condicao_falsa    # Se x < 0, pula para `condicao_falsa`

    # Verifica se x >= X
    lw      $t1, X                 # Carrega valor de X
    bge     $t0, $t1, condicao_falsa # Se x >= X, pula para `condicao_falsa`

    # Verifica se y < 0
    lw      $t0, 24($sp)           # Carrega y
    bltz    $t0, condicao_falsa    # Se y < 0, pula para `condicao_falsa`

    # Verifica se y >= Y
    lw      $t1, Y                 # Carrega valor de Y
    bge     $t0, $t1, condicao_falsa # Se y >= Y, pula para `condicao_falsa`

    # Calcula o endereço de TABULEIRO[x][y]
    lw      $t2, 20($sp)           # Carrega x
    lw      $t3, 24($sp)           # Carrega y
    mul     $t2, $t2, Y            # x * Y (número de colunas por linha)
    add     $t2, $t2, $t3          # Endereço linear de TABULEIRO[x][y]
    sll     $t2, $t2, 2            # Multiplica por 4 (cada elemento tem 4 bytes)
    la      $t4, TABULEIRO         # Carrega o endereço base de TABULEIRO
    add     $t2, $t4, $t2          # Endereço completo de TABULEIRO[x][y]
    lw      $t5, 0($t2)            # Carrega TABULEIRO[x][y]

    # Verifica se TABULEIRO[x][y] != jogador
    lw      $t6, jogador           # Carrega o valor de jogador
    bne     $t5, $t6, condicao_falsa # Se TABULEIRO[x][y] != jogador, pula para `condicao_falsa`

    # Se todas as condições são falsas, continua normalmente

    j       fim_condicional         # Continua o código após o bloco if
    

condicao_falsa:
    li      $t7, 0                 # match = 0
    sw      $t7, 28($sp)           # Armazena match na pilha
    # Adicione um desvio aqui se quiser pular o loop ou ir direto ao fim
    j endForkVitoria

fim_condicional:

    # Incrementa k e continua o loop interno
    addi    $t8, $t8, 1
    sw      $t8, 8($sp)            # Atualiza k na pilha
    j       forkVitoria
    

endForkVitoria:
    # Verifica se match == 1
    lw      $t7, 28($sp)           # Carrega match da pilha
    li      $t8, 1                 # Carrega o valor 1 em $t8
    bne     $t7, $t8, continuarFordVitoria # Se match != 1, continua com o próximo `d`

    # Se match == 1, retorna 1
    li      $v0, 1                 # Coloca 1 em $v0 como retorno
    add     $sp, $sp, 32           # Libera o espaço da pilha
    jr      $ra                    # Retorna
    

continuarFordVitoria:
    # Incrementa d e continua o loop externo
    addi    $t1, $t1, 1
    j       fordVitoria
    

endFordVitoria:
    # Desaloca espaço da pilha
    add     $sp, $sp, 32           # Libera os 32 bytes da pilha
    jr      $ra                    # Retorna
    