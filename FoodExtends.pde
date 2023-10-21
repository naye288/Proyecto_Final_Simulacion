
class Tree extends Food {
  int sizeTree;
  int leafRadius;
  ArrayList<Integer> treeLeafColors;

  Tree(float x, float y) {
    super(x, y);
    sizeTree = (int) random(2, 8);
    leafRadius = (int) random(2, 4);
    positions = new ArrayList<PVector>();
    treeLeafColors = new ArrayList<Integer>();

    float posX = random(-sizeTree, sizeTree);
    float posY = random(-sizeTree, sizeTree);
    float posZ = random(2, 5);

    positions.add(new PVector(posX, posY, posZ));

    int colorLeaf = color(61 + random(-10, 10), 84 + random(-10, 10), 39 + random(-10, 10));
    treeLeafColors.add(colorLeaf);
  }

  void display() {
    // Dibuja el tronco del árbol
    pushMatrix();
    translate(x, y, 0);
    stroke(139, 69, 19);
    strokeWeight(5);
    line(0, 0, 0, 0, 0, sizeTree);
    popMatrix();

    // Dibuja la copa del árbol
    pushMatrix();
    translate(x, y, sizeTree + leafRadius);
    int colorLeaf = treeLeafColors.get(0);
    fill(colorLeaf);
    noStroke();
    sphere(leafRadius);
    popMatrix();
  }
}

class Wheat extends Food {
  ArrayList<Integer> wheatColors;

  public Food create(float x, float y) {
    return new Wheat(x, y);
  }

  Wheat(float x, float y) {
    super(x, y);
    int lengthLine = (int) random(2, 5);

    wheatColors = new ArrayList<Integer>();
    positions = new ArrayList<PVector>();
    for (int i = 0; i < 15; i++) {
      float posX = random(-lengthLine, lengthLine);
      float posY = random(-lengthLine, lengthLine);
      float posZ = random(2, 5);
      positions.add(new PVector(posX, posY, posZ));

      int colorWheat = color(255, 165 + random(-20, 20), 0);
      wheatColors.add(colorWheat);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y, 1);
    strokeWeight(3);

    for (int i = 0; i < positions.size(); i++) {
      PVector position = positions.get(i);
      float wheatX = position.x;
      float wheatY = position.y;
      float wheatZ = position.z;
      int colorWheat = wheatColors.get(i);

      stroke(colorWheat);
      line(wheatX, wheatY, 0, wheatX, wheatY, wheatZ);
    }
    popMatrix();
  }
}
class Corn extends Food {
  ArrayList<Integer> cornStemColors;
  ArrayList<Integer> cornCornColors;

  public Food create(float x, float y) {
    return new Corn(x, y);
  }

  Corn(float x, float y) {
    super(x, y);
    int lengthLine = (int) random(2, 5);

    cornStemColors = new ArrayList<Integer>();
    cornCornColors = new ArrayList<Integer>();
    positions = new ArrayList<PVector>();
    for (int i = 0; i < 15; i++) {
      float posX = random(-lengthLine, lengthLine);
      float posY = random(-lengthLine, lengthLine);
      float posZ = random(2, 5);
      positions.add(new PVector(posX, posY, posZ));

      int colorStem = color(124, 252 - random(-20, 20), 0);
      cornStemColors.add(colorStem);

      int colorCorn = color(252 - random(-5, 3), 196 - random(-5, 5), 101);
      cornCornColors.add(colorCorn);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y, 1);
    for (int i = 0; i < positions.size(); i++) {
      PVector position = positions.get(i);
      float posX = position.x;
      float posY = position.y;
      float posZ = position.z;
      int colorCorn = cornCornColors.get(i);
      int colorStem = cornStemColors.get(i);

      strokeWeight(2);
      stroke(colorStem);
      line(posX, posY, 0, posX, posY, posZ);

      stroke(colorCorn);
      strokeWeight(5);
      line(posX, posY, posZ, posX, posY, posZ +1);
    }
    popMatrix();
  }
}


class Rice extends Food {
  ArrayList<Integer> riceStemColors;
  ArrayList<Integer> riceSeedColors;

  public Food create(float x, float y) {
    return new Rice(x, y);
  }

  Rice(float x, float y) {
    super(x, y);
    positions = new ArrayList<PVector>();
    riceStemColors = new ArrayList<Integer>();
    riceSeedColors = new ArrayList<Integer>();
    int lengthLine = (int) random(2, 5);

    for (int i = 0; i < 15; i++) {
      float posX = random(-lengthLine, lengthLine);
      float posY = random(-lengthLine, lengthLine);
      float posZ = random(2, 5);
      positions.add(new PVector(posX, posY, posZ));

      int colorStem = color(124, 252 - random(-20, 20), 0);
      riceStemColors.add(colorStem);
      int colorSeed = color(226 - random(-20, 20), 143 - random(-20, 20), 63);
      riceSeedColors.add(colorSeed);
    }
  }

  void display() {
    pushMatrix();
    translate(x, y, 1);
    strokeWeight(3);

    for (int i = 0; i < positions.size(); i++) {
      PVector position = positions.get(i);
      float riceX = position.x;
      float riceY = position.y;
      float riceZ = position.z;

      int colorSeed = riceSeedColors.get(i);
      int colorStem = riceStemColors.get(i);

      // Parte Verde
      strokeWeight(2);
      stroke(colorStem);
      line(riceX, riceY, 0, riceX, riceY, riceZ);

      // Semilla
      stroke(colorSeed);
      strokeWeight(2);
      line(riceX, riceY, riceZ, riceX, riceY, riceZ + 1);
    }
    popMatrix();
  }
}

class Fly extends Food {
  ArrayList<Integer> flyColors;

  public Food create(float x, float y) {
    return new Fly(x, y);
  }

  Fly(float x, float y) {
    super(x, y);
    int lengthLine = (int) random(2, 5);

    flyColors = new ArrayList<Integer>();
    positions = new ArrayList<PVector>();
    float posX = random(-lengthLine, lengthLine);
    float posY = random(-lengthLine, lengthLine);
    float posZ = random(2, 5);
    positions.add(new PVector(posX, posY, posZ));

    int colorFly = color(255, 165 + random(-20, 20), 0);
    flyColors.add(colorFly);
  }
  void display() {
    pushMatrix();
    translate(x, y, 1);

    PVector position = positions.get(0);
    float posX = position.x;
    float posY = position.y;
    float posZ = position.z;

    noStroke();
    fill(#408127);

    // Cuerpo de la mosca
    translate(posX, posY, posZ + 2.5);
    sphere(1);

    // Ojos de la mosca
    float eyeSpacing = 1.0;
    float eyeY = -0.6;
    float eyeZ = 0.6;

    translate(-eyeSpacing, eyeY, eyeZ);
    fill(255);
    sphere(0.2);

    translate(2 * eyeSpacing, 0, 0);
    sphere(0.2);

    popMatrix();
  }
}
class Blueberries extends Food {
  ArrayList<Integer> blueberriesColors;

  public Food create(float x, float y) {
    return new Blueberries(x, y);
  }

  Blueberries(float x, float y) {
    super(x, y);
    int lengthLine = (int) random(2, 5);

    blueberriesColors = new ArrayList<Integer>();
    positions = new ArrayList<PVector>();
    float posX = random(-lengthLine, lengthLine);
    float posY = random(-lengthLine, lengthLine);
    float posZ = random(2, 4);
    positions.add(new PVector(posX, posY, posZ));

    int colorBlueberries = color(31 + random(-4, 10), 81 + random(-5, 5), 230 + random(-20, 20));
    blueberriesColors.add(colorBlueberries);
  }
  void display() {
    pushMatrix();
    translate(x, y, 1);

    PVector position = positions.get(0);
    float posX = position.x;
    float posY = position.y;
    float posZ = position.z;
    noStroke();
    fill(blueberriesColors.get(0));
    translate(posX, posY, posZ + 2.5);
    sphere(1.5);
    popMatrix();
  }
}
