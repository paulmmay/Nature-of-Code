class Particle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;


  Particle() {
    println(this+" is alive");
  }

  void create(PVector _location) {
    location = _location.get();
    location = new PVector(location.x, location.y);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0.05);
    lifespan = 200;
  }



  void render() {
    noStroke();
    fill(colours[1]);
    ellipse(location.x, location.y, 10, 10);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 1;
  }

  boolean isDead() {
    if (lifespan <0.0) {
      return true;
    }
    else {
      return false;
    }
  }
}

