#include "functions.h"


void printMatrix(int *MA, int n) {
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++)
			printf("%d ", MA[i*n + j]);
		printf("\n");
	}
	printf("\n");
}

void printVector(int *A, int n) {
	for (int j = 0; j < n; j++)
		printf("%d ", A[j]);
	printf("\n");
}

void fillVector(int num, int *A, int n) {
    for (int i = 0; i < n; i++)
        A[i] = num;
}

void fillMatrix(int num, int *A, int n) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++)
            A[i*n + j] = num;
}

int scalar(int *B, int *C, int h) {
	int scalar = 0;
	for (int i = 0; i < h; i++) {
		scalar += B[i] * C[i];
	}
	return scalar;
}

void matrixMultiplication(const int *A, const int *B, int *C, int h, int n) {
    int buf;
    for (int i = 0; i < n; i++ ) {
        for (int j = 0; j < h; j++) {
            buf = 0;
            for (int k = 0; k < n; k++) {
                buf += A[i*n + k] * B[j*n + k];
            }
            C[j*n + i] = buf;
        }
    }
}


void F(int *MA, int *MB, int *MC, int scalar, int *MO, int h, int n) {
    matrixMultiplication(MB, MC, MA, h, n);
   
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < h; j++) {
			MA[j*n + i] += scalar * MO[j*n + i];
		}
	}
}