class Something {
  PVector location;
  color myColour;

  Something() {
    location = new PVector(random(width), random(height));
    println(location);
  }




  void render() {
    noStroke();
    fill(myColour);
    ellipse(location.x, location.y, 30, 30);
    
  }
}

