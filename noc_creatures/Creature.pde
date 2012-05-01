/*

 A creature that roams the land
 
 */

class Creature {
  /* ---------------- TRAITS ---------------------- */

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
  ArrayList<Something> knownThreats = new ArrayList();
  ArrayList<Something> knownFoods = new ArrayList();
  //health
  float energy, water, mass, maxenergy, lifespan; //how much energy do i have
  int h = 9;
  //birthday and age and lifespan
  //attributes - these should be from species?
  float maxspeed = 0; //can we change this based on how much feeding the creature has done?
  float maxforce = 0; //
  //speeds and forces based on current state
  float wander_maxspeed = 2;
  float wander_maxforce = 0.3;
  float flee_maxspeed = 10;
  float flee_maxforce = 2;
  float minenergy = 10;
  float calculatedMaxSpeed = 0;
  int birthday;
  float calculatedMaxForce = 0;
  Species mySpecies;

  //speeds should be a factor of my age and energy

  float wandertheta;
  String mode;
  int colourIndex;

  //states
  Boolean wander = true;
  Boolean alive = true;
  Boolean seek = false;
  Boolean fleeing = false;

  /* ---------------- CONSTRUCTOR---------------------- */

  Creature(float _x, float _y, Species _s) {
    mySpecies = _s;
    println(this+ " Hi, I'm a creature");
    location = new PVector(_x, _y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    //set up basic parameters / reset
    energy = 100;
    maxenergy = 100; //what is the most energy I can have? 
    water = 100;
    mass = 100;
    report();
    mode = "w";
    println(mySpecies);
    birthday = millis();
    //println(birthday);
  }

  /* ---------------- ADMIN FUNCTIONS ---------------------- */
  int getAge(int factor) {
    //get the creature's age in milliseconds divided by a factor. if the factor is 1000 we will return the age in seconds.
    int age = (millis()-birthday)/factor;
    return age;
  }

  void report() {
    //spit out information about me
    if (debug) {
      println(this+" (Creature)"+
        " age:"+getAge(1000)+
        ", energy:"+energy+
        ", water:"+water);
    }
  }

  void update() {
    calculatedMaxSpeed = maxspeed*energy/200;
    //  println(calculatedMaxSpeed);

    velocity.add(acceleration);
    // Limit speed
    velocity.limit(calculatedMaxSpeed);
    location.add(velocity);
    // Reset accelerationelertion to 0 each cycle
    acceleration.mult(0);
  }

  void flag() {
    //display useful information about the creature
    //abstracting this as it may be useful elsewhere
    textFont(font);
    int offset = 20;
    int space = 10;
    fill(colours[8]); 
    text(mode, location.x+offset, location.y);
    fill(colours[8], 120);
    //text(Float.toString(energy), location.x+offset, location.y+3*space);


    String threatChit = "";
    String foodChit="";
    for (int i=0;i<knownThreats.size();i++) {
      threatChit+="•";
    }
    for (int i=0;i<knownFoods.size();i++) {
      foodChit+="•";
    }

    fill(colours[7]); //red
    text(threatChit, location.x+offset, location.y-2*space);
    fill(colours[6]); //green
    text(foodChit, location.x+offset, location.y-1*space);
  }


  void render() {
    float r = energy/20;

    //max for r? cap at 7 hacky
    if (r>7) {
      r = 7.0;
    }

    if (debug) {
      //draw the trangular creature boid 
      beginShape();
      endShape();
      // Draw a triangle rotated in the direction of velocity
      float theta = velocity.heading2D() + PI/2;

      //flag
      //flag();
      noStroke();
      pushMatrix();
      translate(location.x, location.y);
      int myAge = getAge(1000);
      if (myAge>=12) {
        fill(mySpecies.colour);
      }
      else {
        fill(mySpecies.colour,100+myAge*10);
      };
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

  /* ---------------- BEHAVIOURS ---------------------- */

  /*
   Next:
   avoid other species
   follow own species
   food respawns
   better wandering
   reproduction 
   
   next: tie speed and agility to energy level
   */

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

  void arrive(PVector _target) {
    PVector desired = PVector.sub(_target, location);  // A vector pointing from the location to the target
    float d = desired.mag();
    // Normalize desired and scale with arbitrary damping within 100 pixels
    desired.normalize();
    float m = map(d, 0, 100, 0, calculatedMaxSpeed);
    desired.mult(m);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }

  void flee(PVector _target) {
    //println("flee");
    PVector desired = PVector.sub(_target, location);  // A vector pointing from the location to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(-1*random(1)*calculatedMaxSpeed);
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }

  void leave() {
    //leave the food source if I am full
  }

  void age() {
    //my energy depletes over time
    if (energy > minenergy) {
      energy-=0.004;
    }
    else {
      alive = false;
      println("i died");
    }
  }

  void tire() {
    //my energy depletes over time
    if (energy > minenergy) {
      energy-=0.006;
    }
    else {
      alive = false;
      println("i died");
    }
  }

  void friendly(ArrayList<Creature> _allCreatures) {
    //make a decision based on the locations of the other creatures
    // for (Creature c:_allCreatures) {
    for (int i = 0; i< _allCreatures.size(); i++) { 
      Creature c = (Creature)_allCreatures.get(i);
      if (c.alive) {
        //calculate the distance between me and the other creature - if it's alive
        float distance = PVector.dist(location, c.location);
        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        if (getAge(1000) > 30 && distance < 25 && (energy+c.energy) > 300) { //some sort of sexy distance
          //println(energy);
          //stroke(colours[3]);
          //strokeWeight(1);
          //line(location.x, location.y, c.location.x, c.location.y);
          //mate
          if (random(1)>0.9995) { //happenstance
            //stroke(colours[1]);
            //strokeWeight(1);
            //line(location.x, location.y, c.location.x, c.location.y);
            println("hey there - let's mate");
            seek(c.location);
            maxspeed = maxspeed/2;
            mySpecies.makeCreatures(1, location.x, location.y);
          }
        }
      }
    }
  }

  void wander() {
    //if I am wandering, I am getting tired
    tire();
    fleeing = false;
    if (wander == true && fleeing == false) {
      //wander
      maxspeed = wander_maxspeed;
      maxforce = wander_maxforce;

      mode = "w";
      float wanderR = 10;         // Radius for our "wander circle"
      float wanderD = 50;         // Distance for our "wander circle"
      float change = 0.008; //very interesting - tie this to a gene?
      wandertheta += random(-change, change);     // Randomly change wander theta
      // Now we have to calculate the new location to steer towards on the wander circle
      PVector circleloc = velocity.get();    // Start with velocity
      circleloc.normalize();            // Normalize to get heading
      circleloc.mult(wanderD);          // Multiply by distance
      circleloc.add(location);               // Make it relative to boid's location
      float h = velocity.heading2D();        // We need to know the heading to offset wandertheta
      PVector circleOffSet = new PVector(wanderR*cos(wandertheta+h), wanderR*sin(wandertheta+h));
      PVector target = PVector.add(circleloc, circleOffSet);
      //println("wander");
      seek(target);
    }
  }

  void boundaries() {
    //there must less verbose way of doing this - like distance from the center or something?
    PVector desired = null;

    if (location.x < 20) {
      mode = "!";
      desired = new PVector(calculatedMaxSpeed, velocity.y);
    } 
    else if (location.x > width - 20) {
      mode = "!";
      desired = new PVector(-calculatedMaxSpeed, velocity.y);
    } 

    if (location.y < 20) {
      mode = "!";
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (location.y > height- 20) {
      mode = "!";
      desired = new PVector(velocity.x, -maxspeed);
    } 

    if (desired != null) {
      desired.normalize();
      desired.mult(calculatedMaxSpeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }

  //what should I do in reference to all the things in the world - epic cheating, prefect knowledge
  void decide(ArrayList<Something> _allThings) {

    // Search for the closest (within threshold)
    Something whichThing = null;
    wander = true;
    float recordDistance = 1000000;

    //need to figure out how to not reset recordDistance to 1000000 if we're seeking a target

    //distance from all things
    for (Something s:_allThings) { //check dist to each thing - awareness
      float targetDistance = dist(location.x, location.y, s.location.x, s.location.y);
      if (targetDistance < 50 && s.active == true) { //outer threshold
        if (targetDistance < recordDistance) {
          //println("record distance is now "+recordDistance);
          recordDistance = targetDistance;
          whichThing = s;
          wander = false;
        }
      }
      // if you find something that is the closest
      // do all the stuff you need to do
      if (whichThing != null) {
        if (targetDistance < 50 && targetDistance > 20 && !knownThreats.contains(whichThing)) { //within sight but not at arrive
          /*
          //draw a line between me and the thing i seek. very handy to see the changes in creatures' range of vision
           strokeWeight(1);
           stroke(200);
           line(this.location.x, this.location.y, whichThing.location.x, whichThing.location.y);*/
          seek(whichThing.location);
          //when else should I seek? when I am hungry
        }
        //it's food
        if (targetDistance <= 20 && whichThing.threat ==false) {
          mode = "f";
          if (!knownFoods.contains(whichThing)) {
            knownFoods.add(whichThing);
          }
          arrive(whichThing.location);
          energy+=whichThing.deplete();
          //println("feeding");
        }

        //it's a threat - i already know about it or I can see it up close
        else if ((targetDistance < 50 && knownThreats.contains(whichThing)) || (targetDistance <= 20 && whichThing.threat == true)) {
          //fleeing = true;
          energy = whichThing.injur(energy);
          maxspeed = flee_maxspeed;
          maxforce = flee_maxforce;
          mode = "!";
          if (!knownThreats.contains(whichThing)) {
            knownThreats.add(whichThing);
          }
          // println("FLEE " + frameCount);
          flee(whichThing.location);
        }
      }
    }
  }
} //class ends

