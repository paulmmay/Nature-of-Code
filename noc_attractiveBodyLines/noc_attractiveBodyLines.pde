/*

 Nature of Code - Experiments in Simple Motion: Simple Attractive Body with Lines
 
 4th February 2012
 
 Paul May
 paulmay.org
 
 */

ArrayList<Body> allBodies;
ArrayList<Walker> allWalkers;
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8
};

void setup() {
  size(700, 500);
  allBodies = new ArrayList();
  allWalkers = new ArrayList();
  Body b = new Body();
  b.create();
  allBodies.add(b);
  background(colours[0]);
  for(int i=0;i<10;i++){
  Walker w = new Walker();
  w.create(i);
  allWalkers.add(w);
  }
}

void draw() {
  smooth();
  background(colours[0]);
  //for all bodies, attraact all walkers within range
  for (Body b:allBodies) {
    b.render();
    //create our walkers
    for (Walker w:allWalkers) {
      w.update();
      w.render();
      PVector force = b.attract(w);
      w.applyForce(force);
    }
  }
//saveFrame("output/orbit####.png");
}

void keyPressed() {
  save(millis()+".png");
}

