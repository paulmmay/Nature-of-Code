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
  Gene g;

  int h = 9;
  //birthday and age and lifespan
  //attributes - these should be from species?
  float maxspeed = 0; //can we change this based on how much feeding the creature has done?
  float maxforce = 0; //
  //speeds and forces based on current state
  float calculatedMaxSpeed = 0;
  int birthday;
  float calculatedMaxForce = 0;
  Species mySpecies;

  //speeds should be a factor of my age and g.energy

  float wandertheta;
  String mode;
  int colourIndex;

  //states
  Boolean wander = true;
  Boolean alive = true;
  Boolean seek = false;
  Boolean fleeing = false;

  /* ---------------- CONSTRUCTOR---------------------- */

  Creature(float _x, float _y, int _generation, Species _s) {
    g = new Gene(_generation);
    mySpecies = _s;
    println(this+ " Hi, I'm a creature");
    location = new PVector(_x, _y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    //set up basic parameters / reset
    report();
    mode = "w";
    println(mySpecies);
    birthday = millis();
    //println(birthday);
  }

  // a constructor where we're given a gene
  Creature(float _x, float _y, Gene _n, Species _s) {
    g = _n;
    mySpecies = _s;
    println(this+ " Hi, I'm a creature");
    location = new PVector(_x, _y);
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    //set up basic parameters / reset
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
        ", g.energy:"+g.energy);
    }
  }

  void update() {
    calculatedMaxSpeed = maxspeed*g.energy/200;
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
    int space = 12;
    fill(colours[8]); 
    text(mode, location.x+offset, location.y);
    fill(colours[2]); 
    text(g.generation, location.x+offset, location.y-3*space);
    fill(colours[8], 120);
    //text(Float.toString(g.energy), location.x+offset, location.y+3*space);


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
      //if (flag && myAge <= 10 && g.generation > 1) {
      if (myAge <= 10 && g.generation > 1) {
        noFill();
        stroke(colours[9], 100);
        strokeWeight(3);
        ellipse(0, 0, 35, 35);
      }
      noStroke();
      float r = g.energy/25;
      if (r>=7) {
        r=7;
      }
      fill(mySpecies.colour);
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
   
   next: tie speed and agility to g.energy level
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
    //my g.energy depletes over time
    //this needs to actually kill the creature - need to decouple age and energy
    if (g.energy > g.minenergy) {
      g.energy-=g.agespeed;
    }
    else {
      alive = false;
      println("i died");
    }
  }

  void tire() {
    //my g.energy depletes over time
    if (g.energy > g.minenergy) {
      g.energy-=g.tirespeed;
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

      //make sure this isn't me
      if (_allCreatures.indexOf(this) != i) {
        //calculate the distance between me and the other creature - if it's alive
        float distance = PVector.dist(location, c.location);
        // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
        if (c.alive && getAge(1000) > 20 && distance < 25) { //some sort of sexy distance
          if (flag) {
            stroke(colours[3]);
            strokeWeight(1);
            line(location.x, location.y, c.location.x, c.location.y);
          };


          if (calculateFitness(g, c.g)) { //if the parents have sufficient energy
            // if (random(1)<0.01) { //there is about a one in a hundred chance
            if (random(1)<0.05) { //there is about a one in twenty chance
              println("hey there - let's mate");
              seek(c.location);
              Gene n = combine(g, c.g);
              mySpecies.makeCreatures(1, location.x, location.y, n); //that a new creature will be created                       
              g.energy-=g.reprocost; //and giving birth is tiring
              c.g.energy-=c.g.reprocost;
            }
          }
        }
      }
    }
  }


  boolean calculateFitness(Gene _g, Gene _cg) {
    //could look at age
    //could look at ability to find food
    if ((_g.energy+_cg.energy/2) >150) {
      return true;
    }
    else {
      return false;
    }
  }

  Gene combine(Gene _x, Gene _y) {
    Gene n = new Gene();
    n.energy = (_x.energy+_y.energy)/2;
    n.maxenergy= (_x.energy+_y.energy)/2;
    n.lifespan= (_x.lifespan+_y.lifespan)/2;
    n.wander_maxspeed= (_x.wander_maxspeed+_y.wander_maxspeed)/2;
    n.wander_maxforce= (_x.wander_maxforce+_y.wander_maxforce)/2;
    n.flee_maxspeed= (_x.flee_maxspeed+_y.flee_maxspeed)/2;
    n.flee_maxforce= (_x.flee_maxforce+_y.flee_maxforce)/2;
    n.minenergy= (_x.minenergy+_y.minenergy)/2;
    n.farvisiondistance= (_x.farvisiondistance+_y.farvisiondistance)/2;
    n.nearvisiondistance= (_x.nearvisiondistance+_y.nearvisiondistance)/2;
    n.agespeed= (_x.agespeed+_y.agespeed)/2;
    n.tirespeed= (_x.tirespeed+_y.tirespeed)/2;
    n.wanderR= (_x.wanderR+_y.wanderR)/2;
    n.wanderD= (_x.wanderD+_y.wanderD)/2;
    n.change= (_x.change+_y.change)/2;
    n.reprocost= (_x.reprocost+_y.reprocost)/2;
    n.fertility= (_x.fertility+_y.fertility)/2;
    n.generation = _x.generation+_y.generation;
    //n = mutate(n);
    return n;
  }

  void wander() {
    //if I am wandering, I am getting tired
    tire();
    fleeing = false;
    if (wander == true && fleeing == false) {
      //wander
      maxspeed = g.wander_maxspeed;
      maxforce = g.wander_maxforce;
      mode = "w";
      wandertheta += random(-g.change, g.change);     // Randomly change wander theta
      // Now we have to calculate the new location to steer towards on the wander circle
      PVector circleloc = velocity.get();    // Start with velocity
      circleloc.normalize();            // Normalize to get heading
      circleloc.mult(g.wanderD);          // Multiply by distance
      circleloc.add(location);               // Make it relative to boid's location
      float h = velocity.heading2D();        // We need to know the heading to offset wandertheta
      PVector circleOffSet = new PVector(g.wanderR*cos(wandertheta+h), g.wanderR*sin(wandertheta+h));
      PVector target = PVector.add(circleloc, circleOffSet);
      //println("wander");
      seek(target);
    }
  }

  void boundaries() {
    //there must less verbose way of doing this - like distance from the center or something?
    PVector desired = null;

    if (location.x < g.nearvisiondistance) {
      mode = "!";
      desired = new PVector(calculatedMaxSpeed, velocity.y);
    } 
    else if (location.x > width - g.nearvisiondistance) {
      mode = "!";
      desired = new PVector(-calculatedMaxSpeed, velocity.y);
    } 

    if (location.y < g.nearvisiondistance) {
      mode = "!";
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (location.y > height- g.nearvisiondistance) {
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
      if (targetDistance < g.farvisiondistance && s.active == true) { //outer threshold
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
        if (targetDistance < g.farvisiondistance && targetDistance > g.nearvisiondistance && !knownThreats.contains(whichThing)) { //within sight but not at arrive
          /*
          //draw a line between me and the thing i seek. very handy to see the changes in creatures' range of vision
           strokeWeight(1);
           stroke(200);
           line(this.location.x, this.location.y, whichThing.location.x, whichThing.location.y);*/
          seek(whichThing.location);
          //when else should I seek? when I am hungry
        }
        //it's food
        if (targetDistance <= g.nearvisiondistance && whichThing.threat ==false) {
          mode = "f";
          if (!knownFoods.contains(whichThing)) {
            knownFoods.add(whichThing);
          }
          arrive(whichThing.location);
          g.energy+=whichThing.deplete();
          //println("feeding");
        }

        //it's a threat - i already know about it or I can see it up close
        else if ((targetDistance < g.farvisiondistance && knownThreats.contains(whichThing)) || (targetDistance <= g.nearvisiondistance && whichThing.threat == true)) {
          //fleeing = true;
          g.energy = whichThing.injur(g.energy);
          maxspeed = g.flee_maxspeed;
          maxforce = g.flee_maxforce;
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

