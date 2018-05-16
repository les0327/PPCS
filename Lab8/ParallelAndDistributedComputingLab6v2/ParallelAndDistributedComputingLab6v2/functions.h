#include <mpi.h>
#include <iostream>
#include <cstdio>
#include <cstdlib>

void printMatrix(int *MA, int n);
void printVector(int *A, int n);

void fillVector(int num, int *A, int n);
void fillMatrix(int num, int *A, int n);

int scalar(int *B, int *C, int h);


void F(int *MA, int *MB, int *MC, int scalar, int *MO, int h, int n);

