class Clima {
  boolean estacion; //  True->otoño ? False->primavera
  int temperatura;
  PImage img; // nubes ? sol
  PShape rectShape; // Variable para la figura
  PShape[] imageShapes; // Arreglo de figuras
  float scaleFactor;
  float mapX; //el mitad ancho del mapa
  float mapZ;//el mitad largo del mapa
  
  
  Clima(float mitX, float mitZ) { // primavera por defecto ya que 
                                  //la migración inicia desde el norte( en otoño) al sur
    estacion = false;
    temperatura = (int)random(-11, 25);
    imageShapes = new PShape[50]; // Inicializa el arreglo de figuras
    createClouds();
    scaleFactor = 0.3;
    mapX = mitX;
    mapZ = mitZ;
  }
  
  void  createClouds(){
    // Crea figuras con texturas y escala para cada imagen
    for (int i = 0; i < 50; i++) {
      float x = random(-mapX / 2, mapZ / 2);
      float y = random(-mapX / 2, mapZ / 2);
      float z = random(-mapX / 2, mapZ / 2);
      
      PShape shape = createShape(RECT, -img.width * scaleFactor / 2, -img.height * scaleFactor, img.width * scaleFactor, img.height * scaleFactor);
      shape.setTexture(img);
      shape.translate(x, y, z);
      imageShapes[i] = shape;
    }
  }
  
  void changeStation(boolean station) {
    // hace el cambio de estación 
    estacion = station;
    //cambia la imagen y temperatura
    if (estacion){//True->otoño
      temperatura = (int)random(-1, 26);
      img = loadImage("C:\\Users\\Nayeli\\Desktop\\Simulacion de sistemas naturales\\progra1_clima_tiempo_temperatura\\imagenes\\nubes.png");
    }
    else {//False->primavera
      temperatura = (int)random(-11, 25);
      img = loadImage("C:\\Users\\Nayeli\\Desktop\\Simulacion de sistemas naturales\\progra1_clima_tiempo_temperatura\\imagenes\\sol.png");
    }
  }
  
  void display() {
    background(0);
    if (estacion) {
      //dibujar nubes
      pushMatrix();
      translate(0, 0, 0);
      for (PShape shape : imageShapes) {
        shape(shape);
      }
      popMatrix();
    } else {
      //dibujar sol
    }  
  }
}
