class System {
  int numParticles;
  PVector location;
  ArrayList<Particle> allParticles;
  System() {
  }

  void create(PVector _location) {
    location = _location.get();
    allParticles = new ArrayList();
    numParticles = 10;
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

