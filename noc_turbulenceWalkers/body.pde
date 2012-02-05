class Body {
  //a body is something with a mass that exerts a force on our walkers.
  PVector location;
  PVector velocity;
  PVector acceleration;
  float range;
  float mass;

  Body() {
    println(this +" is alive");
  }

  void create() {
    location = new PVector(400, 250);
    velocity = new PVector(0.1, 0.1);
    mass = 5;
    
  }


  void update() {
    range = 75; //effectively this is the radius
  }


  void render() {

    //the dense core of our body
    fill(colours[4]);
    noStroke();
    ellipse(location.x, location.y, mass, mass);
    //the outer range of the body's force
    noFill();
    strokeWeight(1);
    stroke(colours[2]);
    ellipse(location.x, location.y, range*2, range*2); //we double range because ellipse uses width and not a radius
  }

  //taking a hint from Dan Shiffman's examples; where the body has a function to attract a mover.
  PVector attract(Walker w) {
    PVector force = PVector.sub(location, w.location);             // Calculate direction of force
    float distance = force.mag();                                 // Distance between objects
    distance = constrain(distance, 5.0, 25.0);                      // Limiting the distance to eliminate "extreme" results for very close or very far objects
    force.normalize();                                            // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float strength = (G * mass * w.mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mult(strength);                                         // Get force vector --> magnitude * direction
    return force;
  }
}

