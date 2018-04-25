package org.les;

import org.les.monitor.ResourceMonitor;
import org.les.monitor.SignalMonitor;
import org.les.tasks.MinTask;
import org.les.tasks.ScalarTask;
import org.les.threads.MyRunnable;


import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveTask;

public class Main {

    public static int n = 2400;
    public static int num = 1;
    public static int p = 6;
    public static int LIMIT =  n / 8 + 1;
    public static float h = (float) n / p;

    private volatile static int[] A = new int[n], B = new int[n], C = new int[n], S = new int[n], T = new int[n];
    private volatile static int[][] MH = new int[n][n];
    private static ResourceMonitor resourceMonitor = new ResourceMonitor();
    private static SignalMonitor signalMonitor = new SignalMonitor();
    private static ForkJoinPool forkJoinPool = ForkJoinPool.commonPool();

    public static void main(String[] args) throws InterruptedException {
        Thread[] threads = new Thread[p];
        for (int i = 0; i < threads.length; i++)
            threads[i] = new Thread(new MyRunnable(i, A, B, C, S, T, MH, resourceMonitor, signalMonitor));
        for (Thread thread : threads)
            thread.start();

        signalMonitor.waitInputSignal();

        RecursiveTask<Integer> minTask = new MinTask(T);
        forkJoinPool.execute(minTask);
        resourceMonitor.setMin(minTask.join());

        RecursiveTask<Integer> scalarTask = new ScalarTask(B, C);
        forkJoinPool.execute(scalarTask);
        resourceMonitor.setScalar(scalarTask.join());

        forkJoinPool.shutdown();

        signalMonitor.setMinScalarSignal();

        for (Thread thread : threads)
            thread.join();
    }
}
