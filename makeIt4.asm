.data

X: .word 5
Y:  .word 6
QUATRO: .word 4

TABULEIRO: .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
linhas:    .word 5
colunas:   .word 6
jogador:   .word 1

#verificação de vitoria
direcoes: .word 0, 1, 1, 0, 1, 1, 1, -1  # Vetor de direções {dx, dy} para 4 direções


msg1: .asciiz "Jogador "
msg2: .asciiz ", digite uma coluna [1-6]:\n"
msgEmpate: .asciiz "Empate!\n"
msg3: .asciiz "venceu!\n"
msg4: .asciiz "Jogada indisponível! Tente novamente.\n"
space:    .asciiz "  "           # Espaço entre os elementos
newline:  .asciiz "\n"           # Nova linha após cada linha do tabuleiro


.text
.globl main

main:

    add $sp, $sp, -4  # coluna = 0($sp)

do:
    add $sp, $sp, -4                # Reserva espaço na pilha
    sw $ra, 4($sp)                  # Salva o endereço de retorno na pilha
    la $ra, retorna_imprimeTab      # Carrega o endereço de retorno manualmente
    j imprimeTabuleiro              # Salta para imprimeTabuleiro

retorna_imprimeTab:                 # Endereço de retorno após imprimeTabuleiro
    lw $ra, 0($sp)                  # Restaura o valor original de $ra
    add $sp, $sp, 4                 # Libera espaço na pilha

    add $sp, $sp, -4                # Reserva espaço na pilha
    sw $ra, 0($sp)                  # Salva o endereço de retorno na pilha
    la $ra, retorna_verificaEmpate  # Carrega o endereço de retorno manualmente
    j verificaEmpate                # Salta para verificaEmpate

retorna_verificaEmpate:             # Endereço de retorno após verificaEmpate
    lw $ra, 0($sp)                  # Restaura o valor original de $ra
    add $sp, $sp, 4                 # Libera espaço na pilha
    li $t0, 1
    beq $t0, $v0, endIfEmpate #if (verificaEmpate()) {
    #printf("Empate!");
    la $t8, msgEmpate
    move $a0, $t8
    li $v0, 4
    syscall
    #break;
    j FimPrograma

endIfEmpate:

    #printf("Jogador %d, digite uma coluna [1-%d]: ", jogador, Y);

    lw $t0, jogador      # Carrega o valor do jogador

    # Imprime a primeira parte da mensagem ("Jogador ")
    la $a0, msg1         # Carrega o endereço da string "Jogador "
    li $v0, 4            # Syscall para imprimir string
    syscall              # Executa a syscall

    # Imprime o número do jogador
    move $a0, $t0        # Move o número do jogador para $a0
    li $v0, 1            # Syscall para imprimir inteiro
    syscall              # Executa a syscall

    # Imprime a segunda parte da mensagem (", digite uma coluna [1-6]: ")
    la $a0, msg2         # Carrega o endereço da string final
    li $v0, 4            # Syscall para imprimir string
    syscall              # Executa a syscall

    #scanf("%d", &coluna);
    #coluna--;
lerColuna:
    li $v0, 5                 # Código de syscall para ler um inteiro
    syscall                   # Executa a syscall, o valor lido fica em $v0
    addi $v0, $v0, -1         # coluna--;
    sw $v0, 0($sp)            # Armazena o valor lido na variável 'coluna'

    #if (!jogada(coluna)) continue;
    move $a0, $v0
    
    add $sp, $sp, -4                # Reserva espaço na pilha
    sw $ra, 0($sp)                  # Salva o endereço de retorno na pilha
    la $ra, retorna_jogada          # Carrega o endereço de retorno manualmente
    j jogada                        # Salta para jogada

retorna_jogada:                     # Endereço de retorno após jogada
    lw $ra, 0($sp)                  # Restaura o valor original de $ra
    add $sp, $sp, 4                 # Libera espaço na pilha
    
    li $t0, 1
    bne $v0, $t0, do

    #if (verificaVitoria()) {
    
    add $sp, $sp, -4                # Reserva espaço na pilha
    sw $ra, 0($sp)                  # Salva o endereço de retorno na pilha
    la $ra, retorna_verificaVitoria # Carrega o endereço de retorno manualmente
    j verificaVitoria               # Salta para verificaVitoria

retorna_verificaVitoria:            # Endereço de retorno após verificaVitoria
    lw $ra, 0($sp)                  # Restaura o valor original de $ra
    add $sp, $sp, 4                 # Libera espaço na pilha
    
    li $t0, 1
    bne $v0, $t0, alterna  #se não é vitória o if é falso
    #imprime
    jal imprimeTabuleiro

    # Imprime a primeira parte da mensagem ("Jogador ")
    la $a0, msg1         # Carrega o endereço da string "Jogador "
    li $v0, 4            # Syscall para imprimir string
    syscall              # Executa a syscall

    # Imprime o número do jogador
    lw $a0, jogador        # Move o número do jogador para $a0
    li $v0, 1            # Syscall para imprimir inteiro
    syscall              # Executa a syscall

    # Imprime a segunda parte da mensagem ("venceu!\n")
    la $a0, msg3        # Carrega o endereço da string final
    li $v0, 4            # Syscall para imprimir string
    syscall              # Executa a syscall
    j FimPrograma

alterna:
    lw $t0, jogador
    li $t1, 1
    bne $t0, $t1, recebe1
    li $t2, 2
    sw $t2, jogador
    j fimAlterna
recebe1:
    sw $t1, jogador

fimAlterna:
    # Continue o loop
    j do

FimPrograma:
    jal imprimeTabuleiro
    add $sp, $sp, 4
    li $v0, 10           # Syscall para encerrar o programa
    syscall              # Executa a syscall







imprimeTabuleiro:
    add $sp, $sp, -8             # Reserva espaço na pilha para i e j

    # Inicializa o índice i com X - 1
    la $t0, X
    lw $t0, 0($t0)
    addi $t0, $t0, -1
    sw $t0, 0($sp)               # Salva i na pilha

foriImprime:                     # Loop externo: for (int i = X - 1; i >= 0; i--)
    lw $t1, 0($sp)               # Carrega i
    blt $t1, $zero, fimForiImprime  # Se i < 0, sai do loop externo

    # Inicializa o índice j com 0
    li $t2, 0
    sw $t2, 4($sp)               # Salva j na pilha

forjImprime:                     # Loop interno: for (int j = 0; j < Y; j++)
    lw $t2, 4($sp)               # Carrega j
    lw $t3, Y
    bge $t2, $t3, fimForjImprime  # Se j >= Y, sai do loop interno

    # Calcula o endereço de TABULEIRO[i][j]
    lw $t1, 0($sp)               # Carrega i
    lw $t2, 4($sp)               # Carrega j
    lw $t6, Y
    mul $t4, $t1, $t6            # t4 = i * 6 (índice da linha)
    add $t4, $t4, $t2            # t4 = i * 6 + j
    mul $t4, $t4, 4              # t4 = (i * 6 + j) * 4 (para acessar por bytes)
    la $t5, TABULEIRO            # Carrega a base de TABULEIRO
    add $t5, $t5, $t4            # Endereço de TABULEIRO[i][j]
    lw $t6, 0($t5)               # Carrega o valor de TABULEIRO[i][j] em $t6

    # Imprime o valor de TABULEIRO[i][j]
    move $a0, $t6                # Coloca o valor em $a0 para imprimir
    li $v0, 1                    # Syscall para imprimir inteiro
    syscall

    # Imprime o espaço após o número ("  ")
    la $a0, space
    li $v0, 4                    # Syscall para imprimir string
    syscall

    # Incrementa j e volta para o início do loop interno
    lw $t2, 4($sp)
    addi $t2, $t2, 1
    sw $t2, 4($sp)               # Atualiza j na pilha
    j forjImprime

fimForjImprime:
    # Imprime a nova linha após o fim de uma linha do tabuleiro
    la $a0, newline
    li $v0, 4                    # Syscall para imprimir string
    syscall

    # Decrementa i e volta para o início do loop externo
    lw $t1, 0($sp)
    addi $t1, $t1, -1
    sw $t1, 0($sp)               # Atualiza i na pilha
    j foriImprime

fimForiImprime:
    lw $ra, 0($sp)                # Restaura o valor original de $ra
    add $sp, $sp, 8               # Libera a pilha
    jr $ra                         # Retorna para o endereço armazenado


verificaEmpate:
    li $v0, 1                     # Valor de retorno será 1 se não houver empate
    add $sp, $sp, -8              # Reserva espaço na pilha para i e j
    li $t0, 0
    sw $t0, 0($sp)                # i = 0

foriEmpate:      # for (int i = 0; i < X; i++)
    lw $t1, 0($sp)                # Carrega i
    li $t2, X
    bge $t1, $t2, fimForiEmpate         # Se i >= X, saia do loop externo

    li $t3, 0
    sw $t3, 4($sp)                # j = 0

forjEmpate:      # for (int j = 0; j < Y; j++)
    lw $t3, 4($sp)                # Carrega j
    li $t4, Y
    bge $t3, $t4, fimForjEmpate         # Se j >= Y, saia do loop interno

    # Verifica se TABULEIRO[i][j] == 0
    lw $t1, 0($sp)                # Carrega i novamente
    lw $t3, 4($sp)                # Carrega j novamente
    mul $t5, $t1, 6               # t5 = i * 6 (tamanho da linha)
    add $t5, $t5, $t3             # t5 = i * 6 + j
    mul $t5, $t5, 4               # t5 = (i * 6 + j) * 4 (para endereçamento por byte)
    la $t6, TABULEIRO             # Carrega a base de TABULEIRO
    add $t6, $t6, $t5             # Calcula endereço de TABULEIRO[i][j]
    lw $t7, 0($t6)                # Carrega TABULEIRO[i][j]

    # Se TABULEIRO[i][j] == 0, retorna 0 (empate)
    li $t8, 0
    beq $t7, $t8, empatou

    # Incrementa j e volta para o início do loop interno
    addi $t3, $t3, 1
    sw $t3, 4($sp)                # Salva j atualizado
    j forjEmpate

fimForjEmpate:
    # Incrementa i e volta para o início do loop externo
    lw $t1, 0($sp)
    addi $t1, $t1, 1
    sw $t1, 0($sp)                # Salva i atualizado
    j foriEmpate

empatou:
    move $a0, msgEmpate
    li $v0, 4
    syscall
    li $v0, 0  # Configura $v0 para indicar empate

fimForiEmpate:
    lw $ra, 0($sp)                # Restaura o valor original de $ra
    add $sp, $sp, 8               # Libera a pilha
    jr $ra                         # Retorna para o endereço armazenado





jogada:
    add $sp, $sp, -8       # Reserva espaço na pilha para `coluna` e `linha`
    sw $a0, 0($sp)         # Salva `coluna` em 0($sp)
    sw $zero, 4($sp)       # Inicializa `linha = 0` em 4($sp)

whileColuna:
    lw $t0, 4($sp)         # Carrega `linha` em $t0
    li $t1, X              # Carrega `X` em $t1 (número de linhas)
    bge $t0, $t1, fimWhileColuna  # Se `linha >= X`, sai do loop

    # Calcula o endereço de TABULEIRO[linha][coluna]
    la $t2, TABULEIRO      # Carrega o endereço base de TABULEIRO em $t2
    lw $t3, 0($sp)         # Carrega `coluna` em $t3
    mul $t4, $t0, Y        # $t4 = linha * Y
    add $t4, $t4, $t3      # $t4 = linha * Y + coluna
    mul $t4, $t4, 4        # $t4 = (linha * Y + coluna) * 4 (offset em bytes)
    add $t9, $t2, $t4      # $t9 = endereço de TABULEIRO[linha][coluna]

    # Verifica se TABULEIRO[linha][coluna] é 0
    lw $t5, 0($t9)         # Carrega o valor de TABULEIRO[linha][coluna] em $t5
    beq $t5, $zero, fimWhileColuna  # Se TABULEIRO[linha][coluna] == 0, sai do loop

    # Incrementa `linha`
    lw $t6, 4($sp)         # Carrega `linha`
    addi $t6, $t6, 1       # Incrementa `linha`
    sw $t6, 4($sp)         # Armazena `linha` de volta na pilha
    j whileColuna          # Continua o loop

fimWhileColuna:
    # Verifica se a jogada é válida: `linha >= X` ou `coluna >= Y` ou `coluna < 0`
    lw $t0, 4($sp)         # Carrega `linha`
    li $t1, X              # Carrega `X`
    lw $t2, 0($sp)         # Carrega `coluna`
    li $t3, Y              # Carrega `Y`
    bge $t0, $t1, indisponivel   # Se `linha >= X`, vai para indisponível
    bge $t2, $t3, indisponivel   # Se `coluna >= Y`, vai para indisponível
    blt $t2, $zero, indisponivel # Se `coluna < 0`, vai para indisponível

atribui:
    lw $t0, jogador        # Carrega o valor de `jogador`
    sw $t0, 0($t9)         # Armazena `jogador` em TABULEIRO[linha][coluna]
    li $v0, 1              # Retorna 1 (jogada válida)
    
    lw $ra, 0($sp)                # Restaura o valor original de $ra
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

    li $t0, 0             # $t0 = i
    li $v0, 0             # $v0 = 0, valor de retorno

loop_i:  
    # Verifica se i < X
    lw $t1, X
    bge $t0, $t1, fim_verificaVitoria  # Se i >= X, sai da função

    li $t2, 0             # $t2 = j (coluna)

loop_j:
    # Verifica se j < Y
    lw $t3, Y
    bge $t2, $t3, inc_i   # Se j >= Y, incrementa i

    # Carrega TABULEIRO[i][j] para comparar com jogador
    mul $t4, $t0, $t3     # $t4 = i * Y (linha)
    add $t4, $t4, $t2     # $t4 = posição em TABULEIRO (i * Y + j)
    sll $t4, $t4, 2       # Multiplica por 4 para obter o índice de byte
    la $t5, TABULEIRO
    add $t5, $t5, $t4     # $t5 = endereço de TABULEIRO[i][j]
    lw $t6, 0($t5)        # $t6 = TABULEIRO[i][j]

    # Verifica se TABULEIRO[i][j] != jogador
    lw $t7, jogador
    bne $t6, $t7, inc_j   # Se diferente, passa para a próxima coluna

    # Loop de direções
    li $t8, 0             # $t8 = índice da direção (d)

loop_direcoes:
    li $t9, 4             # $t9 = número de direções (4)
    bge $t8, $t9, inc_j   # Se d >= 4, passa para próxima coluna

    # Carrega dx e dy da matriz de direções
    la $t4, direcoes
    mul $t10, $t8, 8      # Cada direção ocupa 8 bytes (dx, dy) em direcoes
    add $t11, $t4, $t10   # Endereço de dx e dy
    lw $t12, 0($t11)      # dx = direcoes[d][0]
    lw $t13, 4($t11)      # dy = direcoes[d][1]

    # Verifica sequência
    li $t14, 1            # match = 1, assume sequência válida
    li $t15, 1            # k = 1

loop_k:
    # Verifica se k < QUATRO
    lw $t16, QUATRO
    bge $t15, $t16, fim_direcao # Se k >= QUATRO, sequência completa

    # Calcula x = i + k * dx e y = j + k * dy
    mul $t17, $t15, $t12  # k * dx
    add $t17, $t0, $t17   # x = i + k * dx

    mul $t18, $t15, $t13  # k * dy
    add $t18, $t2, $t18   # y = j + k * dy

    # Verifica se x < 0, x >= X, y < 0, ou y >= Y
    bltz $t17, invalida   # x < 0
    bge $t17, $t1, invalida # x >= X
    bltz $t18, invalida   # y < 0
    bge $t18, $t3, invalida # y >= Y

    # Carrega TABULEIRO[x][y] para verificar
    mul $t4, $t17, $t3    # $t4 = x * Y (linha)
    add $t4, $t4, $t18    # $t4 = posição em TABULEIRO (x * Y + y)
    sll $t4, $t4, 2       # Multiplica por 4 para obter o índice de byte
    la $t5, TABULEIRO
    add $t5, $t5, $t4     # $t5 = endereço de TABULEIRO[x][y]
    lw $t6, 0($t5)        # $t6 = TABULEIRO[x][y]

    # Verifica se TABULEIRO[x][y] != jogador
    bne $t6, $t7, invalida # Se diferente, sequência inválida

    # Incrementa k e continua verificando
    addi $t15, $t15, 1
    j loop_k

invalida:
    li $t14, 0            # match = 0
fim_direcao:
    # Se match == 1, retorna vitória
    beq $t14, 1, vitoria

    # Incrementa d e verifica próxima direção
    addi $t8, $t8, 1
    j loop_direcoes

inc_j:
    addi $t2, $t2, 1      # Incrementa j
    j loop_j

inc_i:
    addi $t0, $t0, 1      # Incrementa i
    j loop_i

vitoria:
    li $v0, 1             # $v0 = 1, indica vitória
    jr $ra                # Retorna

fimVerificaVitoria:
    lw $ra, 0($sp)                # Restaura o valor original de $ra
    add $sp, $sp, 8               # Libera a pilha
    jr $ra                         # Retorna para o endereço armazenado