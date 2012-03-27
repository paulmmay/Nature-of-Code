class Something {
  PVector location;
  color myColour;
  String type;

  Something() {
    //location = new PVector(random(width), random(height));
    location = new PVector(width/2, height/2);
    println(location);
  }

  void render() {
    noStroke();
    fill(myColour);
    ellipse(location.x, location.y, 10, 10);
    noFill();
    stroke(#eeeeee);
    ellipse(location.x, location.y, conf.scent_r*2, conf.scent_r*2);
  }
}

