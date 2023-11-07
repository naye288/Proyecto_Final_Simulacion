class Estaciones {
  boolean pos; //  sur(true) o norte(false)   
  int temperatura;
  String nubes; 
  float mapX; //el mitad ancho del mapa
  float mapY;//el mitad largo del mapa
  String estacion; // primavera - verano - otoño - invierno
  PImage[] imagenes;
  int[] x; // Arreglo para las posiciones x
  int[] y; // Arreglo para las posiciones y
  int cant = 15;
  
  Estaciones (int temp, String estacion, boolean pos){
    temperatura = temp;
    this.estacion = estacion;
    this.pos = pos;
  }
  
  //para invierno y otoño
  Estaciones (int temp, String estacion, float mapX, float mapY, boolean pos){
    imagenes =  new PImage[cant];
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
    for (int i = 0; i < cant; i++) {
      int posX, posY;
      if (pos) { // sur de NorteAmérica
        posX = (int) random(-mapY /5, mapX /3);
        posY = (int) random(-mapY / 3, -mapX / 10);
      } else { // norte de NorteAmérica
        posX = (int) random(-mapY /4, mapX /4);
        posY = (int) random(-mapX/2, -mapY/3);
      }
      imagenes[i] = loadImage(nubes);
      imagenes[i].resize(300, 200);
      x[i] = posX; // Asignar posición x a la imagen en el arreglo x
      y[i] = posY; // Asignar posición y a la imagen en el arreglo y
    }
  }
  
  void changeTemp(int temp) {
    temperatura = temp;
  }
  
  void mostrarTexto() {
    textSize(72);    
    fill(0);
    String mens= "Estación: " ;
    String mens1= "Temperatura: ";
    if (pos){// sur de NorteAmérica
      text(mens + estacion, -1800, -200);
      text(mens1 + str(temperatura), -1800, -100);
    }else{
      text(mens + estacion, 1400, -2200);
      text(mens1 + str(temperatura), 1400, -2100);
    }
    
  }
  
  void display() {
    if(estacion == "Invierno" | estacion == "Otoño"){
      for (int i =0; i < imagenes.length; i++){
        image(imagenes[i], x[i], y[i]); 
      }
    }
    mostrarTexto();
  }
  
}
