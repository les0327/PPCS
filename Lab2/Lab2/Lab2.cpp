// Lab2.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>



int main()
{
	int * A = (int *)malloc(10 * 4);

	for (int i = 0; i < 10; i++)
		A[i] = 20 - i;

	printVector(A);

	vectorSort(A, 0, 5);

	vectorSort(A, 5, 10);
	printVector(A);


	merge(A, 0, 5, 5);

	printVector(A);
	
	free(A);

	int i;
	scanf_s("%d", &i);

    return 0;
}

