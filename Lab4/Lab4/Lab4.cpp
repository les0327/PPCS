// Lab4.cpp : Defines the entry point for the console application.
//

#include "functions.h"
#include <omp.h>

using namespace std;

int n, p = 4 , num = 1;
float h;
int *A, *B, *C, *S, *T, *Z, *MO, *MH;
int sc_g = 0 , max_g = INT32_MIN;

void mem_alloc();
void input(int tid);
void mem_free();
void F(int *A, int sc, int *S, int max, int *Z, int *MO, int *MH, int from, int to);

omp_lock_t copy_lock;


int main()
{
	cout << "Enter size:" << endl;
	cin >> n;
	h = (float) n / p;
	mem_alloc();

	omp_init_lock(&copy_lock);// init lock

#pragma omp parallel num_threads(p)
	{
		const int tid = omp_get_thread_num();
		cout << "Thread " << tid << " start" << endl;

		input(tid);
	#pragma omp barrier // wait input

		int sc_l;
		int max_l;
		int *Z_l, *MO_l;

		int leftIndex = (int)(tid * h);
		int rightIndex = (int)((tid + 1) * h);

		sc_l = scalar(B, C, leftIndex, rightIndex);
		
	#pragma omp critical(scalar)
		{
			sc_g += sc_l;
		}

		max_l = max(T, leftIndex, rightIndex);

	#pragma omp critical(max)
		{
			if (max_g < max_l)
				max_g = max_l;
		}
	
	#pragma omp barrier // wait finish scalar and max

		omp_set_lock(&copy_lock);
		sc_l = sc_g;
		max_l = max_g;
		Z_l = Z;
		MO_l = MO;
		omp_unset_lock(&copy_lock);

		F(A, sc_l, S, max_l, Z_l, MO_l, MH, leftIndex, rightIndex);

	#pragma omp barrier // wait finish computing
		
	#pragma omp critical
		{
			if (tid == 0) {
				cout << "A = ";
				printVector(A, n);
			}

			cout << "Thread " << tid << " finish" << endl;
		}
	}

	omp_destroy_lock(&copy_lock);
	mem_free();
	cout << "Press any key..." << endl;
	int i;
	cin >> i;

    return 0;
}

void input(int tid) {
	switch(tid) {
		case 0:
			fillArr(B, num, n);
			return;
		case 1:
			fillArr(C, num, n);
			fillArr(MH, num, n*n);
			return;
		case 2:
			fillArr(S, num, n);
			fillArr(MO, num, n*n);
			return;
		case 3:
			fillArr(T, num, n);
			fillArr(Z, num, n);
			//T[2] = 2;
			return;
	}
}

void mem_alloc() {
	A = (int *)malloc(n*4);
	B = (int *)malloc(n*4);
	C = (int *)malloc(n*4);
	S = (int *)malloc(n*4);
	T = (int *)malloc(n*4);
	Z = (int *)malloc(n*4);
	MO = (int *)malloc(n*n*4);
	MH = (int *)malloc(n*n*4);
}

void mem_free() {
	free(A);
	free(B);
	free(C);
	free(S);
	free(T);
	free(Z);
	free(MO);
	free(MH);
}

void F(int *A, int sc, int *S, int max, int *Z, int *MO, int *MH, int from, int to) {
	int *MBuf = (int *)malloc(n * n * 4);
	matrixMultiplication(MO, MH, MBuf, from, to, n);
	vectorMatrixMultiplication(Z, MBuf, A, from, to, n);

	for (int i = from; i < to; i++) {
		A[i] = A[i] * max + sc * S[i];
	}
	free(MBuf);
}

