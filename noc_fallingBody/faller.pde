class Faller {
  PVector location;
  PVector velocity;
  PVector acceleration;

  Float mass;
  int tag;

  Faller() {
    println(this+" is alive");
  }

  void create(int _tag) {
    tag = _tag;
    location = new PVector(random(width), height/4);
    velocity = new PVector(0, 2);
    acceleration = new PVector(0, 0);
    mass = random(2, 4);
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
   
  }



  void render() {
    noStroke();
    fill(colours[1]);
    ellipse(location.x, location.y, mass*10, mass*10);
    //give the walkers a little tag on their back
    fill(0);
    text(tag, location.x-4, location.y+3);
  }

  void applyForce(PVector _force) {
    PVector f = PVector.div(_force, mass);
    acceleration.add(f);
  }

  //check edges - a straight copy from Dan Shiffman's "forces" example 

  void checkEdges() {

    if (location.x > width) {
      location.x = 0;
    } 
    else if (location.x < 0) {
      location.x = width;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
}

