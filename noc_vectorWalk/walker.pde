

class Walker {
  PVector location;
  PVector velocity;

  Walker() {
    println(this+" is alive");
  }

  void create() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(4, 3.5);
  }

  void draw() {
    noStroke();
    fill(colours[1]);
    location.add(velocity);
    //reset if we wander off screen

    ellipse(location.x, location.y, 20, 20);
  }
}

