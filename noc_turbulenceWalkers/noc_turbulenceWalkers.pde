/*

 Nature of Code - Experiments in Simple Motion: Walking with attractive bodies
 
 31st January 2012
 
 Paul May
 paulmay.org
 
 */

color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8
};

ArrayList<Walker> allWalkers = new ArrayList();
ArrayList<Body> allBodies = new ArrayList();



void setup() {
  //create three walkers
  for (int i=0;i<=4;i++) {
    Walker newWalker = new Walker();
    allWalkers.add(newWalker);
    newWalker.create(i);
  }

  //add all the walkers into all the walkers - except for the walker of course.
  for (Walker w:allWalkers) {
    for (Walker x:allWalkers) {
      //only add other walkers
      if (w != x) {
        w.allWalkers.add(x);
      }
    }
  }

  //create a body that exerts force over the walkers
  Body b = new Body();
  b.create();
  allBodies.add(b);

  size(700, 500);
  background(colours[0]);
  
}

void draw() {
  smooth();
  background(colours[0]);


  //update and render all walkers
  for (Walker w:allWalkers) {
    w.update();
    w.render();
  }

  //render all bodies (just one for now)
  for (Body b:allBodies) {
    b.update();
    b.render();
  }
}

void keyPressed() {
  save(millis()+".png");
}

