class Obstacle {
  PVector location;
  PVector velocity;
  PVector acceleration;

  Obstacle() {
  }

  void create() {
    location = new PVector(random(width), random(height));
  }

  void render() {
    noStroke();
    fill(colours[4]);
    ellipseMode(CENTER);
    ellipse(0, 0, 40, 40);
  }
  
  
}

