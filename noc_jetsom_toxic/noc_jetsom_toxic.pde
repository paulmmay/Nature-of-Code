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
ArrayList<Cluster> allClusters;

//maybe create a hash of clusters, rather than a string, int key value pair
Map<String, Cluster> clusterMap = new HashMap<String, Cluster>();

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
  allClusters = new ArrayList();
  //load data - off in a function, returns an array of strings, for us to split. 
  parseCSV(getCSV("local"));

  //cluster = new Cluster(40,300,new Vec2D(width/2,height/2));
}


void draw() {
  physics.update();
  background(colours[0]);
  //connectAll();
  for(Cluster c:allClusters){
  
    
    c.connectParticles();
    c.render();
  }
}


void parseCSV(String[] _data) {
  float middle = width/2;
  //pass each row of data into fresh new Particle objects.
  Vec2D c = new Vec2D(middle, height/2);
  for (int i=1;i<_data.length;i++) {
    Particle p = new Particle(c.add(Vec2D.randomVector()));
    p.processCsvRow(_data[i]);
    p.create();
    findCluster(p);
    allParticles.add(p);
    middle = random(width);
  }
}

void findCluster(Particle p) {
  //check for the feeling in the hash, increment if you find it, add if you don't 
  if (clusterMap.containsKey(p.category)) {  
    //http://stackoverflow.com/questions/4157972/how-to-update-a-value-given-a-key-in-a-java-hashmap
    //http://stackoverflow.com/questions/81346/most-efficient-way-to-increment-a-map-value-in-java
    Cluster c = clusterMap.get(p.category);
    println("I've seen "+ p.category +" "+c.allParticles.size()+" times");
    c.allParticles.add(p);
  }
  else {
    println("creating hash for "+p.category);  
    Cluster c = new Cluster();
    allClusters.add(c);
    clusterMap.put(p.category, c);
    c.create();
    c.allParticles.add(p);
    //this is where we create a new cluster
  }
}

void connectAll() {
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

