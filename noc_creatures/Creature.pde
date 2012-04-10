/*

 A creature that roams the land
 
 */

class Creature {

  /* ---------------- CONSTRUCTOR---------------------- */

  Creature(float _x, float _y) {
    location = new PVector(_x, _y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    //set up basic parameters / reset
    birthday = new Date();
    energy = 100;
    water = 100;
    mass = 100;
    report();
  }


  /* ---------------- ATRIBUTES---------------------- */

  //my memory
  //how do we make this fallible - have locations drift over time, have things pop out of memory randomly?
  //places where there is food
  //ArrayList<Something> knownFood = new ArrayList();
  //places i am scared of
  //ArrayList<Something> knownThreats = new ArrayList();
  //creatures i know and trust - from my herd

  //direct relatives - maybe a little useless?
  //ArrayList<Creature> family = new ArrayList();

  //where am i
  PVector location, velocity, acceleration;
  //health
  int energy, water, mass; //how much energy do i have
  //birthday and age and lifespan
  Date birthday;
  //attributes - these should be from species?
  float maxspeed = 5; //can we change this based on how much feeding the creature has done?
  float maxforce = 1; //


  /* ---------------- ADMIN FUNCTIONS ---------------------- */
  int getAge() {
    //get the creature's age in seconds
    Date now = new Date();
    int age = int((now.getTime()-birthday.getTime())/1000);
    return age;
  }

  void report() {
    //spit out information about me
    if (debug) {
      println(this+" (Creature)"+
        " age:"+getAge()+
        ", energy:"+energy+
        ", water:"+water);
    }
  }
  
  void update() {
    // add acceleration to velocity and 
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

  /* ---------------- BEHAVIOUR FUNCTIONS ---------------------- */


  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  void seek(PVector _target) {
    //line(location.x,location.y,_target.x,_target.y);
    PVector desired = PVector.sub(_target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }
  
  
  



  void render() {
    int r = 5;

    if (debug) {
      //draw the trangular creature boid 
      beginShape();
      endShape();
      // Draw a triangle rotated in the direction of velocity
      float theta = velocity.heading2D() + PI/2;
      noStroke();
      pushMatrix();
      translate(location.x, location.y);
      fill(colours[7]);
      rotate(theta);
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      popMatrix();
    }
    else {
      //draw something fancier
    }
  }
}

