#include <stdio.h>
#include <stdlib.h>

#define X 5
#define Y 6
#define QUATRO 4

int TABULEIRO[X][Y] = {0};
int jogador = 1;

void imprimeTabuleiro() {
    for (int i = X - 1; i >= 0; i--) {
        for (int j = 0; j < Y; j++) {
            printf("  %d  ", TABULEIRO[i][j]);
        }
        printf("\n");
    }
}

int verificaEmpate() {
    for (int i = 0; i < X; i++)
        for (int j = 0; j < Y; j++)
            if (TABULEIRO[i][j] == 0) return 0;
    return 1;
}

int verificaVitoria() {
    int i, j, k;

    // Verifica todas as direções para cada posição
    for (i = 0; i < X; i++) {
        for (j = 0; j < Y; j++) {
            if (TABULEIRO[i][j] != jogador) continue;

            // Horizontal, vertical, e diagonais
            int direcoes[4][2] = {{0, 1}, {1, 0}, {1, 1}, {1, -1}};
            for (int d = 0; d < 4; d++) {
                int dx = direcoes[d][0], dy = direcoes[d][1];
                int match = 1;
                for (k = 1; k < QUATRO; k++) {
                    int x = i + k * dx, y = j + k * dy;
                    if (x >= X || y >= Y || y < 0 || TABULEIRO[x][y] != jogador) {
                        match = 0;
                        break;
                    }
                }
                if (match) return 1;
            }
        }
    }
    return 0;
}

int jogada(int coluna) {
    int linha = 0;
    while (linha < X && TABULEIRO[linha][coluna] != 0) linha++;
    if (linha >= X) {
        printf("Jogada indisponível! Tente novamente.\n");
        return 0;  // Jogada inválida
    }
    TABULEIRO[linha][coluna] = jogador;
    return 1;  // Jogada válida
}

int main() {
    int coluna;

    do {
        imprimeTabuleiro();

        // Verifica empate
        if (verificaEmpate()) {
            printf("Empate!\n");
            break;
        }

        printf("Jogador %d, digite uma coluna [1-%d]: ", jogador, Y);
        scanf("%d", &coluna);
        coluna--;

        if (!jogada(coluna)) continue;

        // Verifica vitória
        if (verificaVitoria()) {
            imprimeTabuleiro();
            printf("Jogador %d venceu!\n", jogador);
            break;
        }

        // Alterna jogador
        jogador = (jogador == 1) ? 2 : 1;

    } while (1);
    imprimeTabuleiro();

    return 0;
}
