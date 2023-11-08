import peasy.*;

PeasyCam cam;
PImage img;
PImage nubes; 
boolean debug = false;
boolean showGrid = false;
Path path  = new Path();
GeeseSystem geeseSystem;
int gridSize = 20;
FoodManager foodManager = new FoodManager();
float pathY = 25;
PImage treeImage;
ArrayList<SystemSeasons> clima;

void setup() {
  size(1200, 720, P3D);
  cam = new PeasyCam(this, 1000);
  img = loadImage("resources\\images\\_map.jpg");
  clima = new ArrayList<SystemSeasons>();
  clima.add(new SystemSeasons(true));//sur de norteamerica
  clima.add(new SystemSeasons(false));//norte de norteamerica
  geeseSystem = new GeeseSystem();
  sphereDetail(2);

  //setCamAngle();
  loadPathJSONFromFile("pacific");
  loadPathJSONFromFile("mississippi");
  loadPathJSONFromFile("central");
  loadPathJSONFromFile("atlantic");
  loadFoodJSONFromFile();
}

void loadFoodJSONFromFile() {
  String filePath = "resources\\data\\food.json";
  JSONArray jsonArray = loadJSONArray(filePath);

  if (jsonArray != null) {
    for (int i = 0; i < jsonArray.size(); i++) {
      JSONObject foodData = jsonArray.getJSONObject(i);

      String food = foodData.getString("food");
      JSONArray position = foodData.getJSONArray("position");
      int x = position.getInt(0);
      int y = position.getInt(1);
      int density = foodData.getInt("density");
      foodManager.addFood(x, y, density, food);
    }
  } else {
    println("Failed to load JSON file: resources\\data\\food.json");
  }
}

void loadPathJSONFromFile(String fileName) {
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
  
  // ------ -------SOLO PARA PRUEBA ---------------------
  if (keyPressed && key == '0') {
    geeseSystem.addAgent(img.width/20, img.height/20, 50, 50);
  }
  // ----------------------------------------------------
  
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
  if (key == 'z' || key == 'o') {//cambio estacion
    if (key == 'z') {
      clima.get(0).changeSeason();
    } else if (key == 'o') {
      clima.get(1).changeSeason();
    }
  } else if (key == 's' || key == 'p') {// cambio temperatura
    if (key == 's') {
      clima.get(0).changesTemp();
    } else if (key == 'p') {
      clima.get(1).changesTemp();
    }
  }
}


void draw() {
  background(0);
  pushMatrix();
  translate(0, 0, 0);
  image(img, -img.width/2, -img.height);
  popMatrix();
  for (SystemSeasons s : clima){
    s.display();
  }
  if (showGrid) drawGrid();
  if (debug) drawAxes(2000);

  foodManager.display();
  path.display();
  geeseSystem.update();
  
}

void drawGrid() {
  int numRows = ceil(img.height / float(gridSize));
  int numCols = ceil(img.width / float(gridSize));

  float startX = -img.width;
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
