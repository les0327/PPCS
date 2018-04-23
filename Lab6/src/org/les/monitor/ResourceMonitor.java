package org.les.monitor;

import org.les.Main;

public class ResourceMonitor {

    private volatile int scalar;
    private volatile int min;
    private volatile int[] Z;
    private volatile int[][] MO;

    public ResourceMonitor() {
        this.scalar = 0;
        this.min = 0;
        this.Z = new int[Main.n];
        this.MO = new int[Main.n][Main.n];
    }

    public synchronized void setScalar(int scalar) {
        this.scalar = scalar;
    }

    public synchronized void setMin(int min) {
        this.min = min;
    }

    public synchronized void setZ(int[] Z) {
        this.Z = Z;
    }

    public synchronized void setMO(int[][] MO) {
        this.MO = MO;
    }

    public int getScalar() {
        return scalar;
    }

    public int getMin() {
        return min;
    }

    public int[] getZ() {
        return Z;
    }

    public int[][] getMO() {
        return MO;
    }
}
