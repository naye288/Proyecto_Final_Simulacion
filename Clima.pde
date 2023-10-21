class Clima {
  boolean estacion; //  True->otoño ? False->primavera
  int temperatura;
  PImage nubes; 
  PImage sol;
  PShape rectShape; // Variable para la figura
  PShape[] imageShapes; // Arreglo de figuras
  float scaleFactor;
  float mapX; //el mitad ancho del mapa
  float mapY;//el mitad largo del mapa
  int numImages;
  
  
  Clima(float mitX, float mitY) { // primavera por defecto ya que 
                                  //la migración inicia desde el norte( en otoño) al sur
    estacion = false;
    numImages = 40;
    temperatura = (int)random(-11, 25);
    imageShapes = new PShape[numImages]; // Inicializa el arreglo de figuras
    sol = loadImage("resources\\images\\sol.png");
    nubes = loadImage("resources\\images\\nubes.png");
    scaleFactor = 0.3;
    this.mapX = mitX;
    this.mapY = mitY;
    this.createClouds();
  }
  
  private void createClouds(){
    // Crea figuras con texturas y escala para cada imagen
    float x;
    float y;
    for (int i = 0; i < numImages; i++) {
      boolean unique = false;
      PShape shape = null;
      while (!unique) {
        // Crea una nueva forma (en este caso, un rectángulo) con coordenadas aleatorias
        if (estacion){
          x = random(-mapX/7 , mapY/3 );
          y = random(-mapX/4 , mapY/5);
        }else {
          x = random(-mapY/4 , mapX/3 );
          y = random(-mapY/4, mapX/59);
        }
        float z = random(50,100);
        noStroke();
        shape = createShape(RECT, -nubes.width * scaleFactor / 2, -nubes.height * scaleFactor, nubes.width * scaleFactor, nubes.height * scaleFactor);
        shape.setTexture(nubes);
        shape.translate(x, y, z);
        unique = true;
        // Verifica si la nueva forma ya existe en el arreglo
        for (int j = 0; j < i; j++) {
          float otherX = imageShapes[j].getVertex(0).x;
          float otherY = imageShapes[j].getVertex(0).y;
          
          if (x == otherX && y == otherY) {
            unique = false;
            break;
          }
        }
      }
      imageShapes[i] = shape;
    }
  }
  
  void changeStation(boolean station) {
    // hace el cambio de estación 
    estacion = station;
    //cambia la imagen y temperatura
    if (estacion){//True->otoño
      temperatura = (int)random(-1, 26);//resurces
      //sol abajo
      
    }
    else {//False->primavera
      temperatura = (int)random(-11, 25);
      //sol arriba
    }
  }
  
  void display() {
    pushMatrix();
    translate(0, 0, 0);
    for (PShape shape : imageShapes) {
      shape(shape);
    }
    popMatrix();  
  }
}
