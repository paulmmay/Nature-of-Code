class Cluster {
  ArrayList<Particle> allParticles;
  Vec2D pos;
  
  Cluster() {
  }


  void create() {
    allParticles = new ArrayList();
    pos = new Vec2D (random(width),random(height));
  }
  
  void render(){
  
    for(Particle p:allParticles){
    p.render();
    }
  
  }

  void connectParticles() {
    /* Connect all the nodes with a Spring. 
    It'd be nice to use information about the particle to influence the 
    behaviour of the spring */
    
    for (int i = 0; i < allParticles.size()-1; i++) {
      VerletParticle2D ni = allParticles.get(i);
      for (int j = i+1; j < allParticles.size(); j++) {
        VerletParticle2D nj = allParticles.get(j);
        // A Spring needs two particles, a resting length, and a strength
        physics.addSpring(new VerletSpring2D(ni, nj, random(100,height-height/5), 0.01));
        stroke(0, 30);
        line(ni.x, ni.y, nj.x, nj.y);
      }
    }
  }
}

