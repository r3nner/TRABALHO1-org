#include <stdio.h>
#include <stdlib.h>

#define X 5
#define Y 6
#define QUATRO 4

int TABULEIRO[X][Y] = {0};
int jogador = 1;
int cont1 = 0, cont2 = 0, cont3 = 0, cont4 = 0;

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

int verificaVitoria () {

    for (int i = 0; i < X; i++){
        for (int j = 0; j < Y; j++){
            for (int k = 0; k < 4; k++){
                
                if (i + k < X && TABULEIRO[i+k][j] == jogador){
                    cont1++;
                }
                if (j + k < Y && TABULEIRO[i][j+k] == jogador){
                    cont2++;
                }
                if (i + k < X && j + k < Y && TABULEIRO[i+k][j+k] == jogador){
                    cont3++; 
                }
                if (j-k >= 0 && j+k < Y && TABULEIRO[i+k][j-k] == jogador ){ 
                    cont4++;
                }

            }
                if (cont1 == 4 || cont2 == 4 || cont3 == 4 || cont4 == 4){
                    return 1;
                    
                } else {
                    cont1 = 0;
                    cont2 = 0;  
                    cont3 = 0;
                    cont4 = 0;
                }
            


        }
    }

    return 0;
}

int jogada(int coluna) {
    // Verifica se a coluna é válida
    if (coluna < 0 || coluna >= Y) {
        printf("Coluna inválida!\n");
        return 0;
    }

    // Percorre a coluna de baixo para cima
    for (int i = 0; i < X; i++) {
        if (TABULEIRO[i][coluna] == 0) {
            TABULEIRO[i][coluna] = jogador;
            return 1; // Jogada bem-sucedida
        }
    }

    printf("Coluna cheia!\n");
    return 0; // Jogada falhou, coluna cheia
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



