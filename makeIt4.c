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
    int dx, dy, x, y, match;

    // Verifica todas as direções para cada posição
    for (i = 0; i < X; i++) {
        for (j = 0; j < Y; j++) {
            // Continue para a próxima posição se não houver peça do jogador
            if (TABULEIRO[i][j] != jogador) continue;

            // Verifica nas quatro direções possíveis
            int direcoes[4][2] = {{0, 1}, {1, 0}, {1, 1}, {1, -1}};
            for (int d = 0; d < 4; d++) {
                dx = direcoes[d][0];
                dy = direcoes[d][1];
                match = 1;  // Assume que encontrou uma sequência de QUATRO

                for (k = 1; k < QUATRO; k++) {
                    x = i + k * dx;
                    y = j + k * dy;

                    // Verifica se `x` e `y` estão dentro dos limites e se a posição contém a peça do jogador
                    if (x < 0 || x >= X || y < 0 || y >= Y || TABULEIRO[x][y] != jogador) {
                        match = 0;
                        break;
                    }
                }

                // Se uma sequência de QUATRO foi encontrada
                if (match == 1) return 1;
            }
        }
    }
    return 0;
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
        if (jogador == 1){
            jogador = 2;
        } else {
            jogador = 1;
        }

    } while (1);
    imprimeTabuleiro();

    return 0;
}
