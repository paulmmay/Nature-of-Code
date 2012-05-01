class Gene {
  //a storage medium for heritable traits
  float energy; //the amount of energy i have right now
  float maxenergy; //the maximum energy i can store
  float lifespan; //my maximum age in milliseconds
  float wander_maxspeed = 2; //the speed at which i wander
  float wander_maxforce = 0.3; //the force that can be applied when i am wandering
  float flee_maxspeed = 10; //the speed at which i can flee
  float flee_maxforce = 2; //the force that can be applied when i flee
  float minenergy = 10; //my minimum energy threshold - if i tire below here, i die
  float farvisiondistance = 50; //the distance at which i can see things in outline 
  float nearvisiondistance = 20; //the distance at which i can accurately see things
  float agespeed=0.004; //the speed at which I age
  float tirespeed=0.006; //the amount I tire each frame when i am wandering
  float wanderR = 10; // Radius for our "wander circle"
  float wanderD = 50; // Distance for our "wander circle"
  float change = 0.008; //very interesting - tie this to a gene?
  float reprocost = 50; //the energy cost of reproducing
  float fertility = 0.5; //the chance that i will reproduce when i encounter a suitable mate
  int generation;
  Gene(int _generation) {
    generation = _generation;
    energy = 100;
    maxenergy = 100; //what is the most energy I can have?
  }

  Gene() {
  }
}

