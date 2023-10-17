class ForestManager {
  ArrayList<Forest> forests;

  ForestManager() {
    forests = new ArrayList<Forest>();
  }

  void addForest(int x1, int y1, int x2, int y2, int density) {
    Forest forest = new Forest(x1, y1, x2, y2, density);
    forests.add(forest);
  }

  void display() {
    for (Forest forest : forests) {
      forest.display();
    }
  }
  
  Forest getForestByCoordenate(int x, int y) {
    for (Forest forest : forests) {
      if (x >= forest.x1 && x <= forest.x2 && y >= forest.y1 && y <= forest.y2) {
        return forest;
      }
    }
    return null; // Retorna null si no se encuentra ningún bosque que contenga la posición (x, y)
  }
}
