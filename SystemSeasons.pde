class SystemSeasons {
  ArrayList<Estaciones> seasons;
  int season;
  
  SystemSeasons(boolean pos) { 
    seasons = new ArrayList<Estaciones>();
    season = 0;
    seasons.add( new Estaciones((int)random(0, 11), "Invierno",img.width,img.height, pos));
    seasons.add( new Estaciones((int)random(15, 21), "Primavera", pos));
    seasons.add( new Estaciones((int)random(25, 36), "Verano", pos));
    seasons.add( new Estaciones((int)random(15, 26), "Otoño",img.width,img.height, pos));
  
  }
  
  void changeSeason(){
    season = (season + 1) % seasons.size();
  }
  
  void changesTemp(){
    Estaciones season = getSeason();
    int t = 0;
    if(season.estacion == "Invierno"){
      if(season.temperatura > 0 && season.temperatura <11){
        t = (int)random(0, season.temperatura);
      }else{
        t = (int)random(0, 11);
      }  
    }if(season.estacion == "Primavera"){
      if(season.temperatura > 15 && season.temperatura <21){
        t = (int)random(15, season.temperatura);
      }else{
        t = (int)random(15, 21);
      } 
    }if(season.estacion == "Verano"){
      if(season.temperatura > 25 && season.temperatura <36){
        t = (int)random(25, season.temperatura);
      }else{
        t = (int)random(25, 36);
      } 
    }if(season.estacion == "Otoño"){//otoño
      if(season.temperatura > 15 && season.temperatura <26){
        t = (int)random(15, season.temperatura);
      }else{
        t = (int)random(15, 26);
      } 
    }
    season.changeTemp(t);
  }
  
  private Estaciones getSeason() {
    return seasons.get(season);
  }
  
  void display() {
    Estaciones s = seasons.get(season);
    s.display();
  }
  
}
