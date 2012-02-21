class otherParticle extends Particle {

  otherParticle() {
    println(this+" is alive");
  }


  void render() {
    noStroke();
    fill(colours[3]);
    ellipse(location.x, location.y, 10, 10);
  }
}

