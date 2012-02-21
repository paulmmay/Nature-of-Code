class Creature {
  PVector location;
  PVector velocity;
  PVector acceleration;
  Float heading;

  Creature() {
  }

  void create() {
    heading = 0.0;
    location = new PVector(width/2, height/2);
    velocity= new PVector();
    acceleration = new PVector();
  }

  void update() {
    velocity.add(acceleration);
      velocity.limit(1);
    location.add(velocity);
  
  }

  void render() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(heading);
    noStroke();
    fill(colours[1]);
    ellipseMode(CENTER);
    ellipse(0, 0, 20, 20);
    stroke(colours[4]);
    line(0, 0, 8, 0);
    popMatrix();
  }



  void turn(float a) {
    heading += a;
  }

  void applyForce(PVector _force) {
    //pass by reference - so create an instance
    PVector force = _force.get();
    acceleration.add(force);
  }

  void forward() {
    float angle = heading - 2*PI;
    PVector force = new PVector(cos(angle), sin(angle));
    force.mult(0.1);
    applyForce(force);
  }

  void brake() {
    velocity.mult(0.5);
  }
}

