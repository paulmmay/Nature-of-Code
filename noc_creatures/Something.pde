class Something {
  PVector location;
  color myColour;
  Boolean threat;
  Boolean active;
  float foodSupply;
  float mySize;
  int number = 0;

  Something() {
    //location = new PVector(random(width), random(height));
    //location = new PVector(random(conf.bound, width-conf.bound), random(conf.bound, height-conf.bound));
    active = true;
  }


  void render() {
    if (active) { //don't draw me if I've been depleted
      fill(myColour);
      ellipse(location.x, location.y, mySize, mySize);
      fill(colours[8]);
      fill(colours[8]); 
      text(Float.toString(foodSupply), location.x+5, location.y-5, 10);
      stroke(colours[3]);
      noFill();
      ellipse(location.x, location.y, 100, 100); //twice the smell distance of the creature - hacky for now
    }
  }

  float deplete() {
    float chunk = 0.1;
    foodSupply=foodSupply-chunk;
    println(foodSupply);
    if (foodSupply < 0) {
      this.active = false;
    }
    return(chunk);
  }

  float injur(float _energy) {
    return _energy-1;
  }
}

