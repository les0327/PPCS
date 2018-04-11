#include <limits.h>
#include <stdlib.h>
#include <iostream>

void printVector(int *A, int n);
void fillArr(int *A, int num, int n);
void matrixMultiplication(int *A, int *B, int *C, int from, int to, int n);
void vectorMatrixMultiplication(int *A, int *B, int *C, int from, int to, int n);
int scalar(int *A, int *B, int from, int to);
int max(int *T, int from, int to);
