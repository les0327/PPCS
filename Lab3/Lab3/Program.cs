using System;
using System.Threading;

namespace Lab3
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello world");
            int size = 4;
            Threads threads = new Threads(size);

            Thread t1 = new Thread(threads.Task1);
            Thread t2 = new Thread(threads.Task2);
            Thread t3 = new Thread(threads.Task3);
            Thread t4= new Thread(threads.Task4);
            Thread t5= new Thread(threads.Task5);
            Thread t6= new Thread(threads.Task6);

            t1.Name = "Task1";
            t2.Name = "Task2";
            t3.Name = "Task3";

            t1.Priority = ThreadPriority.Highest;
            t2.Priority = ThreadPriority.Normal;
            t3.Priority = ThreadPriority.Lowest;

            Console.WriteLine("Main start");
            t1.Start();
            t2.Start();
            t3.Start();

            t1.Join();
            t2.Join();
            t3.Join();
            Console.WriteLine("Main finish");
            Console.ReadLine();
        }
    }
}
