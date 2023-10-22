abstract class Food {
  float x;
  float y;
  ArrayList<PVector> positions;

  Food(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void display() {
  }
}

class FoodSystem {
  ArrayList<Food> foods;
  int x1;
  int y1;
  int x2;
  int y2;
  int density;

  FoodSystem(int x1, int y1, int x2, int y2, int density, String type) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    this.density = density;
    foods = new ArrayList<Food>();

    float startX = -img.width / 2;
    float startY = -img.height;
    float gx1 = startX + x1 * gridSize;
    float gy1 = startY + y1 * gridSize;
    float gx2 = (x2 - x1) * gridSize;
    float gy2 = (y2 - y1) * gridSize;

    ArrayList<Float> usedXPositions = new ArrayList<Float>();
    for (int i = 0; i < density; i++) {
      float randomX;
      do {
        randomX = gx1 + random(gx2);
      } while (usedXPositions.contains(randomX));
      usedXPositions.add(randomX);

      float randomY = gy1 + random(gy2);
      switch(type) {
      case "Wheat":
        foods.add(new Wheat(randomX, randomY));
        break;
      case "Rice":
        foods.add(new Rice(randomX, randomY));
        break;
      case "Tree":
        foods.add(new Tree(randomX, randomY));
        break;
      case "Fly":
        foods.add(new Fly(randomX, randomY));
        break;
      case "Corn":
        foods.add(new Corn(randomX, randomY));
        break;
      case "Blueberries":
        foods.add(new Blueberries(randomX, randomY));
        break;
      }
    }
  }

  void display() {
    for (Food food : foods) {
      food.display();
    }
  }
}

class FoodManager {
  ArrayList<FoodSystem> foodSystem;

  FoodManager() {
    foodSystem = new ArrayList<FoodSystem>();
  }
  
  void addFood(int x, int y, int density, String type) {
    FoodSystem fs = new FoodSystem(x, y, x+1, y+1, density, type);
    foodSystem.add(fs);
  }
  void addFood(int x1, int y1, int x2, int y2, int density, String type) {
    FoodSystem fs = new FoodSystem(x1, y1, x2, y2, density, type);
    foodSystem.add(fs);
  }

  void display() {
    for (FoodSystem fs : foodSystem) {
      fs.display();
    }
  }

  FoodSystem getFoodByCoordenate(int x, int y) {
    for (FoodSystem fs : foodSystem) {
      if (x >= fs.x1 && x <= fs.x2 && y >= fs.y1 && y <= fs.y2) {
        return fs;
      }
    }
    return null;
  }
}
