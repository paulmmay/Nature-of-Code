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
    core = 5;
  }


  void update() {
    range = mySlider.sliderVal*5;
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
    ellipse(location.x, location.y, range, range);
  }
}

