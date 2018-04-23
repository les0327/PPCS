package org.les.tasks;

import java.util.concurrent.RecursiveTask;

import static org.les.Main.LIMIT;

public class MinTask extends RecursiveTask<Integer> {

    private int[] A;
    private int from;
    private int to;

    public MinTask(int[] A) {
        this.A = A;
        this.from = 0;
        this.to = A.length;
    }

    public MinTask(int[] A, int from, int to) {
        this.A = A;
        this.from = from;
        this.to = to;
    }

    @Override
    protected Integer compute() {
        if ((to - from) <= LIMIT) {
            return computeDirectly();
        } else {
            int mid = (to + from) / 2;
            RecursiveTask<Integer> task1 = new MinTask(A, from, mid);
            RecursiveTask<Integer> task2 = new MinTask(A, mid, to);
            task1.invoke();
            task2.invoke();
            return Integer.min(task1.join(), task2.join());
        }
    }

    private Integer computeDirectly() {
        int min = Integer.MAX_VALUE;
        for (int i = from; i < to; i++)
            if (A[i] < min)
                min = A[i];
        return min;
    }
}
