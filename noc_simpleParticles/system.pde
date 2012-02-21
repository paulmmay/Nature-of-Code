class System {
  int numParticles;
  PVector location;
  ArrayList<Particle> allParticles;
  System() {
  }

  void create(int _numParticles, PVector _location) {
    location = _location.get();
    numParticles = _numParticles;
    allParticles = new ArrayList();
   
    for (int i=0;i<numParticles;i++) {
      Particle p = new Particle();
      p.create(location);
      allParticles.add(p);
    }
  }

  void render() {
    for (Particle p:allParticles) {
      p.update();
      p.render();
    }
  }
}

