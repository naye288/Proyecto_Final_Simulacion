class Estaciones {
  boolean pos; //  sur(true) o norte(false)
  int temperatura;
  String nubes;
  float mapX; //el mitad ancho del mapa
  float mapY;//el mitad largo del mapa
  String estacion; // primavera - verano - otoño - invierno
  //PImage[] imagenes;
  int[] x; // Arreglo para las posiciones x
  int[] y; // Arreglo para las posiciones y
  int cant = 15;

  PImage nubeImage;

  Estaciones (int temp, String estacion, boolean pos) {
    temperatura = temp;
    this.estacion = estacion;
    this.pos = pos;
  }

  //para invierno y otoño
  Estaciones (int temp, String estacion, float mapX, float mapY, boolean pos) {
    //imagenes =  new PImage[cant];
    x = new int[cant];
    y = new int[cant];
    this.pos = pos;
    temperatura = temp;
    this.estacion = estacion;
    this.mapX = mapX;
    this.mapY = mapY;
    nubes = "resources\\images\\nubes.png";
    crearNubes();
  }

  void crearNubes() {

    nubeImage = loadImage(nubes);
    nubeImage.resize(150, 100);

    for (int i = 0; i < cant; i++) {
      int posX, posY;
      if (pos) { // sur de NorteAmérica
        posX = (int) random(-mapY / 2, mapX / 4);
        posY = (int) random(mapY / 6, mapX / 4);
      } else { // norte de NorteAmérica
        posX = (int) random(-mapX / 4, mapY / 3);
        posY = (int) random(-mapX / 4, mapY / 6);
      }
      //imagenes[i] = loadImage(nubes);
      //imagenes[i].resize(300, 200);
      x[i] = posX; // Asignar posición x a la imagen en el arreglo x
      y[i] = posY; // Asignar posición y a la imagen en el arreglo y
    }
  }

  void changeTemp(int temp) {
    temperatura = temp;
  }

  void mostrarTexto() {
    textSize(36);
    fill(0);
    String mens= "Estación: " ;
    String mens1= "Temperatura: ";
    if (pos) {// sur de NorteAmérica
      text(mens + estacion, -img.width/2 + 100, img.height/2 - 120);
      text(mens1 + str(temperatura), -img.width/2 + 100, img.height/2 - 75);
    } else {
      text(mens + estacion, img.width/2 - 375, -img.height/2 + 120);
      text(mens1 + str(temperatura), img.width/2 - 375, -img.height/2 + 170);
    }
  }

  void display() {
    if (estacion == "Invierno" | estacion == "Otoño") {
      for (int i =0; i < cant; i++) {
        tint(255, 200);
        image(nubeImage, x[i], y[i]);
      }
    }
    tint(255);
    mostrarTexto();
  }
}
