class Creature {
  PVector location;
  PVector velocity;
  PVector acceleration;

  Creature() {
  }

  void create() {
    location = new PVector(random(width), random(height));
    velocity= new PVector(random(0, 0.1), random(0, 0.1));
  }

  void render() {
    noStroke();
    fill(colours[1]);
    ellipseMode(CENTER);
    ellipse(0, 0, 20, 20);
    stroke(colours[4]);
    line(0, 0, 8, 0);
  }

  void update() {

    translate(location.x, location.y);
    location.add(velocity);
  }
}

