/*

 Nature of Code - Jetsom
 
 1st March 2012
 
 Paul May
 paulmay.org
 
 */

import pbox2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Particle> allParticles;


String data[];
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8, #191919
};
PBox2D box2d;
ArrayList<Boundary> boundaries;


void setup() {  
  size(700, 500);
  smooth();

  box2d = new PBox2D(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);


  allParticles = new ArrayList();
  //load data - off in a function, returns an array of strings, for us to split. 
  parseCSV(getCSV("local"));
  
  //boundaries
    boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(width/2,height-5,width,10));
}


void draw() {

  background(colours[0]);
  box2d.step();
  for (Particle p:allParticles) {
    p.render();
  }
  
    // Display all the boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
}

//pass each row of data into fresh new objects.
void parseCSV(String[] _data) { 
  for (int i=1;i<_data.length;i++) {
    Particle p = createParticle(random(width), random(height));
    p.processCsvRow(_data[i]);
    p.create();
    allParticles.add(p);
    // println(p.description);
  }
}

//a generic createParticle method
Particle createParticle(float _x, float _y) {
  Particle p = new Particle();
  return p;
}

void keyPressed() {
  save(millis()+".png");
}

