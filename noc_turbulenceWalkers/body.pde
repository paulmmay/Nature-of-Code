class Body {
  //a body is something with a mass that exerts a force on our walkers.
  PVector location;
  PVector velocity;
  PVector acceleration;
  float range;
  float core;

  Body() {
    println(this +" is alive");
  }

  void create() {
    location = new PVector(400, 250);
    velocity = new PVector(0.1,0.1);
    core = 5;
  }


  void update() {
    range = 100; //effectively this is the radius
  }


  void render() {

    

    //the dense core of our body
    fill(colours[4]);
    noStroke();
    ellipse(location.x, location.y, core, core);
    //the outer range of the body's force
    noFill();
    strokeWeight(1);
    stroke(colours[2]);
    ellipse(location.x, location.y, range*2, range*2); //we doulbe range because ellipse uses width and not a radius
  }
}

