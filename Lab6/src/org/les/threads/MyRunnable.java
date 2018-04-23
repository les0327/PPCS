package org.les.threads;

import org.les.Main;
import org.les.monitor.ResourceMonitor;
import org.les.monitor.SignalMonitor;
import org.les.utils.MathUtils;

import java.util.Arrays;

public class MyRunnable implements Runnable {

    private int id;
    private int scalar;
    private int min;
    private int[] A, B, C, S, T, Z;
    private int[][] MO, MH;
    private ResourceMonitor resourceMonitor;
    private SignalMonitor signalMonitor;

    public MyRunnable(int id, int[] a, int[] b, int[] c, int[] s, int[] t, int[][] MH,
                      ResourceMonitor resourceMonitor, SignalMonitor signalMonitor) {
        this.id = id;
        this.A = a;
        this.B = b;
        this.C = c;
        this.S = s;
        this.T = t;
        this.MH = MH;
        this.resourceMonitor = resourceMonitor;
        this.signalMonitor = signalMonitor;
    }

    public MyRunnable(int id) {
        this.id = id;
    }

    @Override
    public void run() {
        System.out.printf("Thread%d start%n", id);
        try {
            input();
            signalMonitor.waitMinScalarSignal();
            copy();
            calc();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.printf("Thread%d finish%n", id);
    }

    private void input() throws InterruptedException {
        switch (id) {
            case 0:
                Arrays.fill(B, Main.num);

                signalMonitor.setInputSignal();
                break;
            case 2:
                Arrays.fill(C, Main.num);
                for (int i = 0; i < MH.length; i++)
                    Arrays.fill(MH[i], Main.num);

                signalMonitor.setInputSignal();
                break;
            case 3:
                Arrays.fill(S, Main.num);
                Arrays.fill(T, Main.num);
                Z = resourceMonitor.getZ();
                Arrays.fill(Z, Main.num);
                MO = resourceMonitor.getMO();
                for (int i = 0; i < MO.length; i++)
                    Arrays.fill(MO[i], Main.num);
                resourceMonitor.setZ(Z);
                resourceMonitor.setMO(MO);

                signalMonitor.setInputSignal();
                break;
            default:
                signalMonitor.waitInputSignal();

        }
    }

    private void copy() {
        scalar = resourceMonitor.getScalar();
        min = resourceMonitor.getMin();
        Z = resourceMonitor.getZ();
        MO = resourceMonitor.getMO();
    }

    private void calc() throws InterruptedException {
        int[][] MBuf = new int[Main.n][Main.n];
        int leftIndex = (int) (id * Main.h);
        int rightIndex = (int) ((id + 1) * Main.h);
        MathUtils.matrixMul(MO, MH, MBuf, leftIndex, rightIndex);
        MathUtils.vectorMatrixMul(Z, MBuf, A, leftIndex, rightIndex);

        for (int i = leftIndex; i < rightIndex; i++) {
            A[i] = scalar * S[i] + min * A[i];
        }

        if (id == 0) {
            signalMonitor.waitCalcSignal();
            System.out.printf("Thread%d A=%s%n", id, Arrays.toString(A));
        } else {
            signalMonitor.setCalcSignal();
        }
    }
}
