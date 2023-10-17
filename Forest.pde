class Forest {
  ArrayList<Tree> trees;
  int x1;
  int y1;
  int x2;
  int y2;
  int density;

  Forest(int x1, int y1, int x2, int y2, int density) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.density = density;
    trees = new ArrayList<Tree>();

    float startX = -img.width / 2;
    float startY = -img.height;
    float gx1 = startX + x1 * gridSize;
    float gy1 = startY + y1 * gridSize;
    float gx2 = (x2 - x1) * gridSize;
    float gy2 = (y2 - y1) * gridSize;

    int numberOfTrees = density;
    ArrayList<Float> usedXPositions = new ArrayList<Float>();

    for (int i = 0; i < numberOfTrees; i++) {
      float randomX;
      do {
        randomX = gx1 + random(gx2);
      } while (usedXPositions.contains(randomX)); 
      usedXPositions.add(randomX);

      float randomY = gy1 + random(gy2);
      trees.add(new Tree(randomX, randomY));
    }
  }

  void display() {
    for (Tree tree : trees) {
      tree.display();
    }
  }
}
