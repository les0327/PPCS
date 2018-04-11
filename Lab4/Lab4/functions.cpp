#include "functions.h"

void printVector(int *A, int n) {
    for (int i = 0; i < n; i++)
        printf("%d ", A[i]);
    printf("\n");
}

void fillArr(int *A, int num, int n) {
	for (int i = 0; i < n; i++)
		A[i] = num;
}

/**
 * Multiplication matrix A and B
 * @param A - matrix
 * @param B - matrix
 * @param C=A*B - matrix
 */
void matrixMultiplication(int *A, int *B, int *C, int from, int to, int n) {
    int buf;
    for (int i = 0; i < n; i++ ) {
        for (int j = from; j < to; j++) {
            buf = 0;
            for (int k = 0; k < n; k++) {
                buf += A[i*n + k] * B[k*n + j];
            }
            C[i*n + j] = buf;
        }
    }
}

/**
 * Multiplication vector A with matrix B
 * @param A - vector
 * @param B - matrix
 * @param C=A*B - vector
 */
void vectorMatrixMultiplication(int *A, int *B, int *C, int from, int to, int n) {
    int buf;
    for (int i = from; i < to; i++ ) {
        buf = 0;
        for (int j = 0; j < n; j++) {
            buf += A[j] * B[j*n + i];
        }
        C[i] = buf;
    }
}

int scalar(int *A, int *B, int from, int to) {
	int scalar = 0;
	for (int i = from; i < to; i++)
		scalar += A[i] * B[i];
	return scalar;
}

int max(int *T, int from, int to) {
	int max = INT32_MIN;
	for (int i = from; i < to; i++)
		if (T[i] > max) {
			max = T[i];
		}
	return max;
}