// Seek_Arrive
// Daniel Shiffman <http://www.shiffman.net>

// The "Vehicle" class

//decision making - Paul May

class Vehicle {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float d = conf.bound;
  float wandertheta;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  color moodColour;
  String flag;
  color edgeColour;
  boolean fleeing;


  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    location = new PVector(x, y);
    r = 5.0;
    maxspeed = 3;
    maxforce = 0.1;
    flag = "?";
  }



  // Method to update location
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }



  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }



  // A method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  void seek(PVector _target) {
    PVector desired = PVector.sub(_target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }


  //wander around the place
  void wander() {


    float wanderR = 25;         // Radius for our "wander circle"
    float wanderD = 40;         // Distance for our "wander circle"
    float change = 0.3;
    wandertheta += random(-change, change);     // Randomly change wander theta
    // Now we have to calculate the new location to steer towards on the wander circle
    PVector circleloc = velocity.get();    // Start with velocity
    circleloc.normalize();            // Normalize to get heading
    circleloc.mult(wanderD);          // Multiply by distance
    circleloc.add(location);               // Make it relative to boid's location
    float h = velocity.heading2D();        // We need to know the heading to offset wandertheta
    PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h), wanderR*sin(wandertheta+h));
    PVector target = PVector.add(circleloc, circleOffSet);
    seek(target);
  }  


  //what behaviour should I carry out based on the location and type of object?
  void decide(Something _s) {
    //how far am I from the Something
    float targetDistance = dist(location.x, location.y, _s.location.x, _s.location.y);
   // println(targetDistance);
    //if I'm out of range just wander
    if (targetDistance>conf.scent_r) {
      //indicate our state
      moodColour = colours[1];
      flag = "w";
      wander();
    }
    else if (targetDistance>conf.sight_r && targetDistance < conf.scent_r) {
      //change the speed of approach if we're within visual range
      //this needs scale depending on target distance
      maxspeed = 1.5;
      maxforce = 0.03;
      moodColour = colours[6];
      flag = "s";
      seek(_s.location);
    }
    else{
      //moodColour = colours[6];
      flag = "r";
    }
  }



  void boundaries() {
    //there must less verbose way of doing this - like distance from the center or something?
    PVector desired = null;

    if (location.x < d) {
      flag = "!";
      desired = new PVector(maxspeed, velocity.y);
    } 
    else if (location.x > width -d) {
      flag = "!";
      desired = new PVector(-maxspeed, velocity.y);
    } 

    if (location.y < d) {
      flag = "!";
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (location.y > height-d) {
      flag = "!";
      desired = new PVector(velocity.x, -maxspeed);
    } 

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }  


  void display() {

    //a little visual indicator to show what the vehicle is doing, nicer than println

    fill(0);
    textSize(14);
    text(flag, location.x+20, location.y-20);
    beginShape();
    stroke(0);
    endShape();
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + PI/2;
    fill(moodColour);
    stroke(100);
    pushMatrix();
    translate(location.x, location.y);
    stroke(colours[2]);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}

