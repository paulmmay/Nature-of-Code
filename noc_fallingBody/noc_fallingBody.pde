/*

 Nature of Code - Experiments in Simple Motion: Falling Body with Poorly Programmed Gravity
 
 6th February 2012
 
 Paul May
 paulmay.org
 
 */


ArrayList<Faller> allFallers;
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8
};
PVector wind;
PVector gravity;

void setup() {
  size(700, 500);
  allFallers = new ArrayList();
  wind = new PVector(0.005, 0);
  gravity = new PVector(0, 0.01);
  background(colours[0]);
  for (int i=0;i<5;i++) {
    Faller w = new Faller();
    w.create(i);
    allFallers.add(w);
  }
}

void draw() {
  smooth();
  background(colours[0]);
  //for all bodies, attraact all Fallers within range

  for (Faller f:allFallers) {
    f.applyForce(gravity); 
    f.checkEdges();
    f.update();
    f.render();
  }
  //saveFrame("output/frame####.png");
}

void keyPressed() {
  for (Faller f:allFallers) {
    f.applyForce(wind);
  }
}

