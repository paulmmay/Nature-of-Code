
/*

 working through example Walker code by Daniel Shiffman to understand what's going on
 
 */

class Walker {
  PVector location;
  PVector velocity;
  PVector offset;
  ArrayList<PVector> footprints = new ArrayList();

  Walker() {
    println(this+" is alive");
  }

  void create() {
    location = new PVector(width/2, height/2);
    velocity = new PVector(4, 3.5);
    offset = new PVector(random(1000), random(1000));
  }

  void render() {

    location.add(velocity);
    //reset if we wander off screen


    //draw the wiggly footprint line
    beginShape();
    stroke(colours[2]);
    noFill();
    for (PVector v: footprints) {
      vertex(v.x, v.y); //never used this before, nifty
    }
    endShape();
    noStroke();
    fill(colours[1]);
    ellipse(location.x, location.y, 20, 20);
  }

  void update() {
    location.x = map(noise(offset.x), 0, 1, 0, width); //not sure I understand Perlin noise just yet
    location.y = map(noise(offset.y), 0, 1, 0, height);
    offset.add(mySlider.sliderVal/1000, mySlider.sliderVal/1000, 0); //add a little bit to the noise offset. 

    //create a little trail behind the walker
    footprints.add(location.get());
    if (footprints.size() > 2000) {
      footprints.remove(0);
    }
  }
}

