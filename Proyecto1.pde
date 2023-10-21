import peasy.*;

PeasyCam cam;
PImage img;
boolean debug = false;
boolean showGrid = false;
Path path  = new Path();
int gridSize = 40;
FoodManager foodManager = new FoodManager();
float pathY = 25;
PImage treeImage;
void setup() {
  size(1200, 720, P3D);
  cam = new PeasyCam(this, 100);
  img = loadImage("resources\\images\\_map.png");

  foodManager.addFood(53, 58, 54, 59, 100, "Wheat");
  foodManager.addFood(54, 58, 55, 59, 100, "Rice");
  foodManager.addFood(55, 58, 56, 59, 100, "Tree");
  foodManager.addFood(56, 58, 57, 59, 100, "Fly");
  foodManager.addFood(57, 58, 58, 59, 100, "Corn");
  foodManager.addFood(58, 58, 59, 59, 100, "Blueberries");
  //setCamAngle();
  loadJSONFromFile("pacific");
  loadJSONFromFile("mississippi");
  loadJSONFromFile("central");
}

void loadJSONFromFile(String fileName) {
  String filePath = "resources\\data\\" + fileName + ".json";

  JSONObject json = loadJSONObject(filePath);

  if (json != null) {
    int index = 1;
    while (json.hasKey("path_" + index)) {
      JSONObject pathData = json.getJSONObject("path_" + index);
      JSONArray casilla1 = pathData.getJSONArray("casilla1");
      JSONArray casilla2 = pathData.getJSONArray("casilla2");

      int x1 = casilla1.getInt(0);
      int y1 = casilla1.getInt(1);
      int x2 = casilla2.getInt(0);
      int y2 = casilla2.getInt(1);

      path.addPointByGrid(x1, y1, x2, y2);

      index++;
    }
  } else {
    println("Failed to load JSON file: resources\\data\\" + fileName + ".json");
  }
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

  foodManager.display();
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
