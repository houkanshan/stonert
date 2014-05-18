static class Debugger {
  static void printMatrix(float[][] m) {
    for(int i = 0; i < m.length; i++) {
      for(int j = 0; j < m[i].length; j++) {
        print(m[i][j]);
        print(",");
      }
      println();
    }
  }
}
