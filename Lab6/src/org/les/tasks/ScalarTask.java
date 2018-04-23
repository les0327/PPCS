package org.les.tasks;

import java.util.concurrent.RecursiveTask;

import static org.les.Main.LIMIT;

public class ScalarTask extends RecursiveTask<Integer> {

    private int[] A;
    private int[] B;
    private int from;
    private int to;

    public ScalarTask(int[] A, int[] B) {
        this.A = A;
        this.B = B;
        this.from = 0;
        this.to = A.length;
    }

    public ScalarTask(int[] A, int[] B, int from, int to) {
        this.A = A;
        this.B = B;
        this.from = from;
        this.to = to;
    }

    @Override
    protected Integer compute() {
        if ((to - from) <= LIMIT) {
            return computeDirectly();
        } else {
            int mid = (to + from) / 2;
            RecursiveTask<Integer> task1 = new ScalarTask(A, B, from, mid);
            RecursiveTask<Integer> task2 = new ScalarTask(A, B, mid, to);
            task1.fork();
            task2.fork();
            return task1.join() + task2.join();
        }
    }

    private Integer computeDirectly() {
        int scalar = 0;
        for (int i = from; i < to; i++)
            scalar += A[i] * B[i];
        return scalar;
    }
}
