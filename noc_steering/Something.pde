class Something {
  PVector location;
  color myColour;
  String type;

  Something() {
    //location = new PVector(random(width), random(height));
    location = new PVector(random(conf.bound,width-conf.bound), random(conf.bound,height-conf.bound));
    println(location);
  }

  void render() {
    noStroke();
    fill(myColour);
    ellipse(location.x, location.y, 10, 10);
    noFill();
    stroke(colours[2]);
    ellipse(location.x, location.y, conf.scent_r*2, conf.scent_r*2);
    ellipse(location.x, location.y, conf.sight_r*2, conf.sight_r*2);
  }
}

