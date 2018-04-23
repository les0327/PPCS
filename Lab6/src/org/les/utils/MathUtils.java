package org.les.utils;

public class MathUtils {

    public static void matrixMul(int[][] MA, int[][] MB, int[][] MC, int from, int to) {
        int length = MA.length;
        for (int i = 0; i < length; i++ ) {
            for (int j = from; j < to; j++) {
                for (int k = 0; k < length; k++) {
                    MC[i][j] += MA[i][k] * MB[k][j];
                }
            }
        }
    }

    public static void vectorMatrixMul(int[] A, int[][] MB, int[] C, int from, int to) {
        int length = A.length;
        for (int i = from; i < to; i++ ) {
            for (int j = 0; j < length; j++) {
                C[i] += A[j] * MB[j][i];
            }
        }
    }
}
