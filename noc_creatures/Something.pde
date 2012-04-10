class Something {
  PVector location;
  color myColour;
  Boolean threat;
  Boolean alive;
  float foodSupply;
  float mySize;

  Something() {
    //location = new PVector(random(width), random(height));
    //location = new PVector(random(conf.bound, width-conf.bound), random(conf.bound, height-conf.bound));
    alive = true;
  }


  void render() {
    fill(myColour);
    ellipse(location.x, location.y, mySize, mySize);
  }
}

