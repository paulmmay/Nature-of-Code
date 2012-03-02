/*

 Nature of Code - Jetsom
 
 1st March 2012
 
 Paul May
 paulmay.org
 
 */

import toxi.geom.*;
import toxi.physics2d.*;
// Reference to physics world
VerletPhysics2D physics;

ArrayList<Particle> allParticles;


String data[];
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8, #191919
};


void setup() {  
  size(700, 500);
  smooth();

  // Initialize the physics
  physics=new VerletPhysics2D();
  physics.setWorldBounds(new Rect(10, 10, width-20, height-20));

  allParticles = new ArrayList();
  //load data - off in a function, returns an array of strings, for us to split. 
  parseCSV(getCSV("local"));

  //cluster = new Cluster(40,300,new Vec2D(width/2,height/2));
}


void draw() {
  physics.update();
  background(colours[0]);
    connect();
  for (Particle p:allParticles) {
    p.render();
  }

}


void parseCSV(String[] _data) {
  //pass each row of data into fresh new Particle objects.
  Vec2D c = new Vec2D(width/2, height/2);
  for (int i=1;i<_data.length;i++) {
    Particle p = new Particle(c.add(Vec2D.randomVector()));
    p.processCsvRow(_data[i]);
    p.create();
    allParticles.add(p);
  }
}


void connect() {
  // Connect all the nodes with a Spring
  for (int i = 0; i < allParticles.size()-1; i++) {
    VerletParticle2D ni = allParticles.get(i);
    for (int j = i+1; j < allParticles.size(); j++) {
      VerletParticle2D nj = allParticles.get(j);
      // A Spring needs two particles, a resting length, and a strength
      physics.addSpring(new VerletSpring2D(ni, nj, 300, 0.01));
      stroke(0, 30);
      line(ni.x, ni.y, nj.x, nj.y);
    }
  }
}

void keyPressed() {
  save(millis()+".png");
}

