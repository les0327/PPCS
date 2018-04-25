package org.les.monitor;

import org.les.Main;

public class SignalMonitor {

    private volatile int inputSignal;
    private volatile int minScalarSignal;
    private volatile int calcSignal;
    private final Object o1 = new Object();
    private final Object o2 = new Object();
    private final Object o3 = new Object();

    public SignalMonitor() {
        this.inputSignal = 0;
        this.minScalarSignal = 0;
        this.calcSignal = 0;
    }

    public void setInputSignal() {
        synchronized (o1) {
            this.inputSignal++;
            if (inputSignal == 3)
                o1.notifyAll();
        }
    }

    public void waitInputSignal() throws InterruptedException {
        synchronized (o1) {
            if (inputSignal != 3)
                o1.wait();
        }
    }

    public void setMinScalarSignal() {
        synchronized (o2) {
        this.minScalarSignal++;
            o2.notifyAll();
        }
    }

    public void waitMinScalarSignal() throws InterruptedException {
        synchronized (o2) {
            if (minScalarSignal != 1)
                o2.wait();
        }
    }

    public void setCalcSignal() {
        synchronized (o3) {
            this.calcSignal++;
            if (calcSignal == 5)
                o3.notifyAll();
        }
    }

    public void waitCalcSignal() throws InterruptedException {
        synchronized (o3) {
            if (calcSignal != 5) {
                o3.wait();
            }
        }
    }
}
