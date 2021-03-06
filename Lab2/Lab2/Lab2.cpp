// Lab2.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <windows.h>
#include <iostream>

using std::cout;
using std::cin;

int n;
const int num = 1;

int e, d;
int *A, *Z, *S;
int *MO, *MH;

HANDLE Semaphore1 = CreateSemaphore(NULL, 0, 3, NULL);
HANDLE Semaphore2 = CreateSemaphore(NULL, 0, 3, NULL);
HANDLE Semaphore3 = CreateSemaphore(NULL, 0, 3, NULL);
HANDLE Semaphore4 = CreateSemaphore(NULL, 0, 3, NULL);

HANDLE Mutex = CreateMutex(NULL, FALSE, NULL);

CRITICAL_SECTION CS;

HANDLE Event2_1 = CreateEvent(NULL, TRUE, FALSE, NULL); // from t2 to t1 about finish sorting
HANDLE Event3_4 = CreateEvent(NULL, TRUE, FALSE, NULL); // from t3 to t4 about finish sorting
HANDLE Event1_4 = CreateEvent(NULL, TRUE, FALSE, NULL); // from t1 to t4 about finish merging

void thread1() {
	cout << "Thread 1 start\n";

	// enter data
	S = (int *)malloc(n * 4);
	fillVector(num, S, n);
	
	// signal to t2, t3, t4
	ReleaseSemaphore(Semaphore1, 3, NULL);
	// wait t2, t3, t4
	WaitForSingleObject(Semaphore2, INFINITE);
	WaitForSingleObject(Semaphore3, INFINITE);
	WaitForSingleObject(Semaphore4, INFINITE);

	//copy shared variables
	WaitForSingleObject(Mutex, INFINITE);
	int e1 = e;
	int d1 = d;
	ReleaseMutex(Mutex);

	//copy shared variables
	EnterCriticalSection(&CS);
	int *S1 = S;
	int *MO1 = MO;
	LeaveCriticalSection(&CS);

	F(A, e1, Z, d1, S1, MO1, MH, 0, n/4, n);
	vectorSort(A, 0, n / 4);

	// wait untill t2 finish sorting
	WaitForSingleObject(Event2_1, INFINITE);
	float hl = (float) n / 4;
	auto leftSize = (int)hl;
	auto rightSize = (int)(hl * 2) - leftSize;
	int rightIndex = leftSize;
	merge(A, 0, rightIndex, leftSize, rightSize, leftSize + rightSize);

	// signal to t4 about finish merging
	SetEvent(Event1_4);

	cout << "Thread 1 finish\n";
}

void thread2() {
	cout << "Thread 2 start\n";

	MH = (int *)malloc(n * n * 4);
	fillMatrix(num, MH, n);

	// signal to t1, t3, t4
	ReleaseSemaphore(Semaphore2, 3, NULL);
	// wait t1, t3, t4
	WaitForSingleObject(Semaphore1, INFINITE);
	WaitForSingleObject(Semaphore3, INFINITE);
	WaitForSingleObject(Semaphore4, INFINITE);

	//copy shared variables
	WaitForSingleObject(Mutex, INFINITE);
	int e2 = e;
	int d2 = d;
	ReleaseMutex(Mutex);

	//copy shared variables
	EnterCriticalSection(&CS);
	int *S2 = S;
	int *MO2 = MO;
	LeaveCriticalSection(&CS);

	F(A, e2, Z, d2, S2, MO2, MH, n / 4, n / 2, n);
	vectorSort(A, n /4, n / 2);

	// signal to t1 about finish sorting
	SetEvent(Event2_1);

	cout << "Thread 2 finish\n";
}

void thread3() {
	cout << "Thread 3 start\n";

	e = 1;
	d = 1;
	MO = (int *)malloc(n * n * 4);
	fillMatrix(num, MO, n);

	// signal to t1, t2, t4
	ReleaseSemaphore(Semaphore3, 3, NULL);
	// wait t1, t2, t4
	WaitForSingleObject(Semaphore1, INFINITE);
	WaitForSingleObject(Semaphore2, INFINITE);
	WaitForSingleObject(Semaphore4, INFINITE);

	//copy shared variables
	WaitForSingleObject(Mutex, INFINITE);
	int e3 = e;
	int d3 = d;
	ReleaseMutex(Mutex);

	//copy shared variables
	EnterCriticalSection(&CS);
	int *S3 = S;
	int *MO3 = MO;
	LeaveCriticalSection(&CS);

	F(A, e3, Z, d3, S3, MO3, MH, n / 2, 3 * n / 4, n);
	vectorSort(A, n / 2, 3 * n / 4);

	// signal to t4 about finish sorting
	SetEvent(Event3_4);

	cout << "Thread 3 finish\n";
}

void thread4() {
	cout << "Thread 4 start\n";

	A = (int *)malloc(n * 4);
	Z = (int *)malloc(n * 4);
	fillVector(num, Z, n);
	Z[0] = 4;
	// signal to t1, t2, t3
	ReleaseSemaphore(Semaphore4, 3, NULL);
	// wait t1, t2, t3
	WaitForSingleObject(Semaphore1, INFINITE);
	WaitForSingleObject(Semaphore2, INFINITE);
	WaitForSingleObject(Semaphore3, INFINITE);

	//copy shared variables
	WaitForSingleObject(Mutex, INFINITE);
	int e4 = e;
	int d4 = d;
	ReleaseMutex(Mutex);

	//copy shared variables
	EnterCriticalSection(&CS);
	int *S4 = S;
	int *MO4 = MO;
	LeaveCriticalSection(&CS);

	F(A, e4, Z, d4, S4, MO4, MH, 3 * n / 4, n, n);
	vectorSort(A, 3 * n / 4, n);

	// wait untill t3 finish sorting
	WaitForSingleObject(Event3_4, INFINITE);
	float hl = (float) n / 4;
	auto leftIndex = (int)(hl * 2);
	auto leftSize = (int)hl;
	auto rightSize = (int)(hl * 2) - leftSize;
	int rightIndex = leftIndex + leftSize;
	merge(A, leftIndex, rightIndex, leftSize, rightSize, leftSize + rightSize);
	
	// wait untill t1 finish merging
	WaitForSingleObject(Event1_4, INFINITE);
	hl = (float) n / 2;
	leftIndex = 0;
	leftSize = (int)hl;
	rightSize = (int)(hl * 2) - leftSize;
	rightIndex = leftIndex + leftSize;
	merge(A, leftIndex, rightIndex, leftSize, rightSize, leftSize + rightSize);

	if (n < 17) {
		cout << "A = ";
		printVector(A, n);
	}

	cout << "Thread 4 finish\n";
}

void freeMemory() {
	free(A);
	free(Z);
	free(S);
	free(MO);
	free(MH);
}

int main()
{
	cout << "Main start\n";

	cout << "Enter n\n";
	cin >> n;

	InitializeCriticalSection(&CS);

	HANDLE hThread[4];
	DWORD Tid1, Tid2, Tid3, Tid4;

	hThread[0] = CreateThread(NULL, 300000000, (LPTHREAD_START_ROUTINE)thread1, NULL, 0, &Tid1);
	hThread[1] = CreateThread(NULL, 300000000, (LPTHREAD_START_ROUTINE)thread2, NULL, 0, &Tid2);
	hThread[2] = CreateThread(NULL, 300000000, (LPTHREAD_START_ROUTINE)thread3, NULL, 0, &Tid3);
	hThread[3] = CreateThread(NULL, 300000000, (LPTHREAD_START_ROUTINE)thread4, NULL, 0, &Tid4);

	WaitForMultipleObjects(4, hThread, TRUE, INFINITE);

	for (int i = 0; i < 3; i++) {
		CloseHandle(hThread[i]);
	}

	DeleteCriticalSection(&CS);

	cout << "Main finish\n";

	freeMemory();

	int i;
	cout << "Enter num to exit\n";
	cin >> i;

	return 0;
}

