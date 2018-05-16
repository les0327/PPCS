#include "functions.h"

using namespace std;

int tid;
int n = 12, p, num = 1;
float h;
int leftIndex, rightIndex;

int a;
int *B, *C;
int *MA, *MB, *MC, *MO;
int  *Bi, *Ci, *MAi, *MCi, *MOi;

int *scalars;

void init_memory();
void free_memory();

int main(int argc, char **argv) {

	MPI_Comm graph_comm;
	int *index = new int[12]{ 4, 7, 8, 9, 12, 13, 14, 18, 19, 20, 21, 22};
	int *edges = new int[22]{1,4,7,11, 0,2,3, 1, 1, 0,5,6, 4, 4, 0,8,9,10, 7, 7, 7, 0};


	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &p);
	MPI_Graph_create(MPI_COMM_WORLD, p, index, edges, false, &graph_comm);
	MPI_Comm_rank(MPI_COMM_WORLD, &tid);

	init_memory();


	h = (float) n / p;
	leftIndex = (int)(tid * h);
	rightIndex = (int)((tid + 1) * h);

	cout << "Thread" << tid << " start" << endl;
	
	// T0 input 
	if (tid == 0) {
		fillVector(num, B, n);
		fillVector(num, C, n);
		fillMatrix(num, MB, n);
		fillMatrix(num, MC, n);
		fillMatrix(num, MO, n);
	}

	// Send MB, MC, B, C, MO
	MPI_Bcast(MB, n*n, MPI_INT, 0, graph_comm);
	MPI_Scatter(B, (int) h, MPI_INT, Bi, (int) h, MPI_INT, 0, graph_comm);
	MPI_Scatter(C, (int) h, MPI_INT, Ci, (int) h, MPI_INT, 0, graph_comm);
	MPI_Scatter(MC, (int)(h*n), MPI_INT, MCi, (int)(h*n), MPI_INT, 0, graph_comm);
	MPI_Scatter(MO, (int)(h*n), MPI_INT, MOi, (int)(h*n), MPI_INT, 0, graph_comm);

	// Scalar
	a = scalar(Bi, Ci, (int) h);

	MPI_Gather(&a, 1, MPI_INT, scalars, 1, MPI_INT, 0, graph_comm);

	if (tid == 0) {
		int buf = 0;
		for (int i = 0; i < p; i++) {
			buf += scalars[i];
		}
		a = buf;
	}

	MPI_Bcast(&a, 1, MPI_INT, 0, graph_comm);

	F(MAi, MB, MCi, a, MOi, (int)h, n);

	MPI_Gather(MAi, (int)(h * n), MPI_INT, MA, (int)(h * n), MPI_INT, 0, graph_comm);

	if (tid == 0) {
		cout << "Thread " << tid << ": MA=" << endl;
		printMatrix(MA, n);
	}

	cout << "Thread" << tid << " finish"<< endl;

	free_memory();
	MPI_Finalize();

    return 0;
}

void init_memory() {
	MA = (int *)calloc(n * n, 4);
	MB = (int *)malloc(n * n * 4);
	MC = (int *)malloc(n * n * 4);
	MO = (int *)malloc(n * n * 4);
	MCi = (int *)malloc((int)(n * n * 4));
	MOi = (int *)malloc((int)(n * n * 4));
	MAi = (int *)malloc((int)(n * n * 4));
	B = (int *)malloc(n * 4);
	C = (int *)malloc(n * 4);
	Bi = (int *)malloc((int)(n * 4));
	Ci = (int *)malloc((int)(n * 4));
	scalars = (int *)malloc(p * 4);
}

void free_memory() {
	free(MA);
	free(MB);
	free(MC);
	free(MO);
	free(MAi);
	free(MOi);
	free(MCi);
	free(B);
	free(C);
	free(Bi);
	free(Ci);
	free(scalars);
}

