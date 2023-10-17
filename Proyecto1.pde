import peasy.*;

PeasyCam cam;
PImage img;
boolean debug = false;
boolean showGrid = true;
Path path;
int gridSize = 20;
ForestManager forests = new ForestManager();
PImage treeImage;

void setup() {
  size(1200, 720, P3D);
  cam = new PeasyCam(this, 100);
  img = loadImage("resources\\images\\_map.png");
  treeImage = loadImage("resources\\images\\tree_1.png");
  
  path = new Path();
  path.addPointByGrid(0,0,1,1);
  path.addPointByGrid(1,1,2,1);
  forests.addForest(1, 0, 2, 1, 50);
  forests.addForest(2, 1, 3, 2, 15);
  forests.addForest(1, 3, 2, 4, 100);

  setCamAngle();
}
void setCamAngle() {
  cam.setRotations(-0.7211126, 7.4951706E-4, 0.0048639337);
  cam.lookAt(23.127522, 487.21622, 1671.39);
}
void drawAxes(float len) {
  strokeWeight(4);
  // Eje X (rojo)
  stroke(255, 0, 0);
  line(0, 0, 0, len, 0, 0);

  // Eje Z (verde)
  stroke(0, 255, 0);
  line(0, 0, 0, 0, img.height, 0);
  // Eje -X (naranja)
  stroke(#D39B2B);
  line(0, 0, 0, -len, 0, 0);

  // Eje -Z (Violeta)
  stroke(#E97EFF);
  line(0, 0, 0, 0, -img.height, 0);
}
void keyPressed() {
  if (keyPressed && Character.toLowerCase(key) == 'r') {
    cam.reset();
    //setCamAngle();
  }
  if (keyPressed && Character.toLowerCase(key) == 'd') {
    debug = !debug;
  }
  if (keyPressed && Character.toLowerCase(key) == 'g') {
    showGrid = !showGrid;
  }
  if (keyPressed && key == 'T' || key == 't') {
    float[] rotations = cam.getRotations();
    println("Angulo: " + "x: " + rotations[0] + ", y: " + rotations[1] + ", z: " + rotations[2]);

    float[] position = cam.getPosition();
    println("Posición: " + "x: " + position[0] + ", y: " + position[1] + ", z: " + position[2]);
  }
}


void draw() {
  background(0);
  pushMatrix();
  translate(0, 0, 0);
  image(img, -img.width/2, -img.height);
  popMatrix();
  if (showGrid) drawGrid();
  if (debug) drawAxes(2000);

  forests.display();
  path.display();
}

void drawGrid() {
  int numRows = ceil(img.height / float(gridSize));
  int numCols = ceil(img.width / float(gridSize));
  
  float startX = -img.width / 2;
  float startY = -img.height;

  stroke(#6c79a6);
  strokeWeight(2);

  for (int i = 0; i <= numRows; i++) {
    float y = startY + i * gridSize;
    line(startX, y, startX + img.width, y);
  }
  for (int i = 0; i <= numCols; i++) {
    float x = startX + i * gridSize;
    line(x, startY, x, startY + img.height);
  }
}