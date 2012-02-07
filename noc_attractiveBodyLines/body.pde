class Body {
  PVector location;
  PVector acceleration;
  PVector velocity;
  float mass;
  float range;


  Body() {
    println(this+" is alive");
  }


  void create() {
    location = new PVector(width/2, height/2);
    mass = 50;
    range = 400;
  }

  void update() {
  }

  void render() {
    noStroke();
    fill(colours[4]);
    ellipse(location.x, location.y, mass/5, mass/5);
    noFill();
    //stroke(colours[2]);
    //ellipse(location.x, location.y, range, range);
  }


  PVector attract(Walker w) {
    //a function to attract any walkers that happen to stray by 

    //constantly look at the distance of the walker to me
    PVector force = PVector.sub(location, w.location); //subtract the location of me and the walker
    float distance = force.mag(); //how far away is the walker? get the magnitude of the vector 
    force.normalize(); //still not sure why this is needed, ask Dan Shiffman
    return(force);
  }
}

