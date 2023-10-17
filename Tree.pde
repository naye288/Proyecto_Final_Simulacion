class Tree {
  float x;
  float y;
  int sizeTree;
  int leafRadius;
  //int nFruits;
  //ArrayList<PVector> fruitPositions;

  Tree(float x, float y) {
    this.x = x;
    this.y = y;
    //nFruits = (int) random(1, 5);
    sizeTree = (int) random(2, 8);
    leafRadius = (int) random(2, 6);
    //fruitPositions = new ArrayList<PVector>();
    //for (int i = 0; i < nFruits; i++) {
    //  float angle = random(0, TWO_PI); // Ángulo aleatorio en radianes
    //  float distance = random(0, leafRadius); // Distancia aleatoria dentro de la copa
    //  float fruitX = cos(angle) * distance; // Calcula la posición X basada en el ángulo y la distancia
    //  float fruitY = sin(angle) * distance; // Calcula la posición Y basada en el ángulo y la distancia
    //  float fruitZ = random(sizeTree, sizeTree + leafRadius); // Posición Z aleatoria en la copa

    //  fruitPositions.add(new PVector(x + fruitX, y + fruitY, fruitZ)); // Agrega la posición a la lista
    //}

    //for (int i = 0; i < nFruits; i++) {
    //  float fruitX = random(-leafRadius, leafRadius); // Posición X aleatoria dentro de la copa
    //  float fruitY = random(-leafRadius, leafRadius); // Posición Y aleatoria dentro de la copa
    //  float fruitZ = random(sizeTree, sizeTree + leafRadius); // Posición Z aleatoria en la copa

    //  fruitPositions.add(new PVector(x + fruitX, y + fruitY, fruitZ)); // Agrega la posición a la lista
    //}
  }
  void display_img() {
    pushMatrix();
    translate(x, y, 0);
    rotateX(PI/2);
    rotateZ(PI);
    image(treeImage, -treeImage.width / 2, -treeImage.height); // Muestra la imagen del árbol
    popMatrix();

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
    fill(34, 139, 34); 
    noStroke();
    sphere(leafRadius); 
    popMatrix();

    // Dibuja los frutos
    //for (PVector position : fruitPositions) {
    //  float fruitX = position.x;
    //  float fruitY = position.y;
    //  float fruitZ = position.z;

    //  pushMatrix();
    //  translate(fruitX, fruitY, fruitZ);
    //  fill(255, 0, 0); // Color rojo para los frutos (ajusta el color)
    //  noStroke();
    //  ellipse(0, 0, 2, 2); // Dibuja un círculo como fruto (ajusta el tamaño)
    //  popMatrix();
    //}
  }
}
