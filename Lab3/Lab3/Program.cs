using System;
using System.Threading;

namespace Lab3
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Main start");
          
            int size = Convert.ToInt32(Console.ReadLine());
            Functions threadFunctions = new Functions(size);
            Thread[] threads = new Thread[6];

            threads[0] = new Thread(() => threadFunctions.Task1(0));
            threads[1] = new Thread(() => threadFunctions.Task2(1));
            threads[2] = new Thread(() => threadFunctions.Task3(2));
            threads[3] = new Thread(() => threadFunctions.Task4(3));
            threads[4] = new Thread(() => threadFunctions.Taski(4));
            threads[5] = new Thread(() => threadFunctions.Taski(5));

            Console.WriteLine("Main start");

            for (int i = 0; i < 6; i++)
                threads[i].Start();

            for (int i = 0; i < 6; i++)
                threads[i].Join();
            
            Console.WriteLine("Main finish");
            Console.ReadLine();
        }
    }
}
