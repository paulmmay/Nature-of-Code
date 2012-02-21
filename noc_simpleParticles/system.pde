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
    //change this to be an iterator
    Iterator<Particle> it = allParticles.iterator();
    while (it.hasNext ()) {
      Particle p = it.next();
      p.update();
      p.render();

      if (p.isDead()) {
        println(it +" is dead");
        it.remove();
      }
    }
  }
}

