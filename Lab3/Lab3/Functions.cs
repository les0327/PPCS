using System;
using System.Threading;

namespace Lab3
{
    public class Functions
    {
        private readonly int _size;
        private readonly float _h;
        int[] A, Z, S;
        int[] MO, MH;
        int e, d;

        private ManualResetEvent[] manualEvencts = new ManualResetEvent[4]; // manual events for input
        private Object cs = new Object();  // cs
        private AutoResetEvent ev2_1 = new AutoResetEvent(false);
        private AutoResetEvent ev3_4 = new AutoResetEvent(false);
        private AutoResetEvent ev6_5 = new AutoResetEvent(false);
        private AutoResetEvent ev1_4 = new AutoResetEvent(false);
        private AutoResetEvent ev5_4 = new AutoResetEvent(false);

        public void Task1(int id)
        {
            Console.WriteLine("Thread1 start");
            fillVector(1, S); // input S

            manualEvencts[id].Set();
            WaitHandle.WaitAll(manualEvencts);

            int e1, d1;
            int[] S1;
            int[] MO1;

            lock(cs)
            {
                e1 = e;
                d1 = d;
                S1 = S;
                MO1 = MO;
            }

            F(A, e1, Z, d1, S1, MO1, MH, id * _size / 6, (id + 1) * _size / 6);
            vectorSort(A, id * _size / 6, (id + 1) * _size / 6);

            ev2_1.WaitOne(); // wait t2 finish sorting

            float hl = (float)_size / 6;
            int leftSize = (int)hl;
            int rightSize = (int)(hl * 2) - leftSize;
            int rightIndex = leftSize;
            merge(A, 0, rightIndex, leftSize, rightSize, leftSize + rightSize);

            ev1_4.Set(); // signal to t4 about finish merging

            Console.WriteLine("Thread1 end");
        }

        public void Task2(int id)
        {
            Console.WriteLine("Thread2 start");
            fillMatrix(1, MH);

            manualEvencts[id].Set();
            WaitHandle.WaitAll(manualEvencts);

            int e2, d2;
            int[] S2;
            int[] MO2;

            lock (cs)
            {
                e2 = e;
                d2 = d;
                S2 = S;
                MO2 = MO;
            }

            F(A, e2, Z, d2, S2, MO2, MH, id * _size / 6, (id + 1) * _size / 6);
            vectorSort(A, id * _size / 6, (id + 1) * _size / 6);
            ev2_1.Set();

            Console.WriteLine("Thread2 end");
        }

        public void Task3(int id)
        {
            Console.WriteLine("Thread3 start");
            e = 1;
            d = 1;
            fillMatrix(1, MO);

            manualEvencts[id].Set();
            WaitHandle.WaitAll(manualEvencts);

            int e3, d3;
            int[] S3;
            int[] MO3;

            lock (cs)
            {
                e3 = e;
                d3 = d;
                S3 = S;
                MO3 = MO;
            }

            F(A, e3, Z, d3, S3, MO3, MH, id * _size / 6, (id + 1) * _size / 6);
            vectorSort(A, id * _size / 6, (id + 1) * _size / 6);

            ev3_4.Set(); // signal to t4 about finish merging

            Console.WriteLine("Thread3 end");
        }

        public void Task4(int id)
        {
            Console.WriteLine("Thread4 start");
            fillVector(1, Z);
            Z[0] = 4;

            manualEvencts[id].Set();
            WaitHandle.WaitAll(manualEvencts);

            int e4, d4;
            int[] S4;
            int[] MO4;

            lock (cs)
            {
                e4 = e;
                d4 = d;
                S4 = S;
                MO4 = MO;
            }

            F(A, e4, Z, d4, S4, MO4, MH, id * _size / 6, (id + 1) * _size / 6);
            vectorSort(A, id * _size / 6, (id + 1) * _size / 6);

            ev3_4.WaitOne();
            float hl = (float)_size / 6;
            int leftIndex = (int)(2 * hl);
            int leftSize = (int)hl;
            int rightSize = (int)(hl * 2) - leftSize;
            int rightIndex = leftIndex + leftSize;
            merge(A, leftIndex, rightIndex, leftSize, rightSize, leftSize + rightSize);

            ev1_4.WaitOne();
            hl = (float)_size / 3;
            leftIndex = 0;
            leftSize = (int)hl;
            rightSize = (int)(hl * 2) - leftSize;
            rightIndex = leftIndex + leftSize;
            merge(A, leftIndex, rightIndex, leftSize, rightSize, leftSize + rightSize);

            ev5_4.WaitOne();
            leftIndex = 0;
            leftSize = 2 * _size / 3;
            rightSize = _size - leftSize;
            rightIndex = leftIndex + leftSize;
            merge(A, leftIndex, rightIndex, leftSize, rightSize, leftSize + rightSize);

            printVector(A);

            Console.WriteLine("Thread4 end");
        }

        public void Taski(int id)
        {
            Console.WriteLine("Thread" + (id+1) + " start");

            WaitHandle.WaitAll(manualEvencts);

            int ei, di;
            int[] Si;
            int[] MOi;

            lock (cs)
            {
                ei = e;
                di = d;
                Si = S;
                MOi = MO;
            }

            F(A, ei, Z, di, Si, MOi, MH, id * _size / 6, (id + 1) * _size / 6);
            vectorSort(A, id * _size / 6, (id + 1) * _size / 6);

            if ((id + 1) == 6) // t6
            {
                ev6_5.Set(); // signal from t6 to t5 about finish merging
            }
            if ((id + 1) == 5) // t5
            {
                ev6_5.WaitOne(); // t6 wait t5 finish sorting

                float hl = (float)_size / 6;
                int leftSize = (int)hl;
                int rightSize = (int)(hl * 2) - leftSize;
                int rightIndex = leftSize;
                merge(A, 0, rightIndex, leftSize, rightSize, leftSize + rightSize);

                ev5_4.Set(); // signal to t4 about finish merging
            }

            Console.WriteLine("Thread" + (id + 1) + " end");
        }

        public Functions(int size)
        {
            _size = size;
            _h = (float)size / 6;
            A = new int[size];
            Z = new int[size];
            S = new int[size];
            MO = new int[size * size];
            MH = new int[size * size];
            for (int i = 0; i < manualEvencts.Length; i++)
                manualEvencts[i] = new ManualResetEvent(false);
        }

        void printVector(int[] A)
        {
            for (int i = 0; i < _size; i++)
                Console.Write("{0} ", A[i]);
            Console.Write("\n");
        }

        void fillVector(int num, int[] A)
        {
            for (int i = 0; i < _size; i++)
                A[i] = num;
        }

        void fillMatrix(int num, int[] A)
        {
            for (int i = 0; i < _size; i++)
                for (int j = 0; j < _size; j++)
                    A[i * _size + j] = num;
        }

        void matrixMultiplication(int[] A, int[] B, int[] C, int from, int to)
        {
            int buf;
            for (int i = 0; i < _size; i++)
            {
                for (int j = from; j < to; j++)
                {
                    buf = 0;
                    for (int k = 0; k < _size; k++)
                    {
                        buf += A[i * _size + k] * B[k * _size + j];
                    }
                    C[i * _size + j] = buf;
                }
            }
        }

        void vectorMatrixMultiplication(int[] A, int[] B, int[] C, int from, int to)
        {
            int buf;
            for (int i = from; i < to; i++)
            {
                buf = 0;
                for (int j = 0; j < _size; j++)
                {
                    buf += A[j] * B[j * _size + i];
                }
                C[i] = buf;
            }
        }

        void vectorSort(int[] A, int from, int to)
        {
            int index;
            int min;
            for (int i = from; i < to; i++)
            {
                index = i;
                min = A[i];
                for (int j = i + 1; j < to; j++)
                {
                    if (A[j] < min)
                    {
                        index = j;
                        min = A[j];
                    }
                }

                if (index != i)
                {
                    A[index] = A[i];
                    A[i] = min;
                }
            }
        }

        void merge(int[] A, int leftIndex, int rightIndex, int leftSize, int rightSize, int size)
        {
            int index = leftIndex;

            leftSize += leftIndex;
            rightSize += rightIndex;

            int[] buf = new int[size];

            int i;
            for (i = 0; leftIndex < leftSize && rightIndex < rightSize; i++)
            {
                if (A[leftIndex] < A[rightIndex])
                {
                    buf[i] = A[leftIndex];
                    leftIndex++;
                }
                else
                {
                    buf[i] = A[rightIndex];
                    rightIndex++;
                }
            }

            while (leftIndex < leftSize)
            {
                buf[i] = A[leftIndex];
                i++;
                leftIndex++;
            }

            while (rightIndex < rightSize)
            {
                buf[i] = A[rightIndex];
                i++;
                rightIndex++;
            }

            for (i = 0; i < size; i++)
            {
                A[index] = buf[i];
                index++;
            }
        }

        void F(int[] A, int e, int[] Z, int d, int[] S, int[] MO, int[] MH, int from, int to)
        {
            int[] MBuf = new int[_size * _size];

            matrixMultiplication(MO, MH, MBuf, from, to);
            vectorMatrixMultiplication(S, MBuf, A, from, to);

            for (int i = from; i < to; i++)
            {
                A[i] = A[i] * d + e * Z[i];
            }
        }
    }
}