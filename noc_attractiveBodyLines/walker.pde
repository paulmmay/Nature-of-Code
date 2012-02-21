class Walker {
  PVector location;
  PVector velocity;
  PVector acceleration;
  Float mass;
  int grayCol;
  int tag;
  ArrayList<PVector> footprints = new ArrayList();

  Walker() {
    println(this+" is alive");
  }

  void create(int _tag) {
    tag = _tag;
    grayCol = int(random(60, 130));
    location = new PVector(random(width), random(height));
    velocity = new PVector(2, 2);
    acceleration = new PVector(0, 0);
    mass = random(2, 4);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    footprints.add(location.get());
    if (footprints.size() > 20000) {
      footprints.remove(0);
    }
  }



  void render() {
    noStroke();
    fill(grayCol);
    ellipse(location.x, location.y, 3, 3);
    //give the walkers a little tag on their back
    fill(0);
    //text(tag, location.x-4, location.y+3);

    //trails

    //draw the wiggly footprint line
    beginShape();
    stroke(grayCol);
    noFill();
    for (PVector v: footprints) {
      vertex(v.x, v.y); //never used this before, nifty
    }
    endShape();
  }

  void applyForce(PVector _force) {
    PVector f = PVector.div(_force, mass);
    acceleration.add(f);
  }
}

