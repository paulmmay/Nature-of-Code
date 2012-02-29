/*

 Nature of Code - Jetsom
 
 28th February 2012
 
 Paul May
 paulmay.org
 
 */

import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;


ArrayList<Particle> allParticles;
VerletPhysics2D physics;
String data[];

void setup() {  
  physics = new VerletPhysics2D ();
  allParticles = new ArrayList();
  //load data - off in a function, returns an array of strings, for us to split. 
  parseCSV(getCSV("remote"));
}

void draw() {
}

//pass each row of data into fresh new objects.
void parseCSV(String[] _data) { 
  for (int i=1;i<_data.length;i++) {
    Particle p = createParticle(random(width), random(height));
    p.processCsvRow(_data[i]);
    allParticles.add(p);
   // println(p.description);
  }
}

//a generic createParticle method
Particle createParticle(float _x, float _y) {
  Particle p = new Particle(new Vec2D(_x, _y));
  return p;
}

