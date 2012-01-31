
/*

 working through example Walker code by Daniel Shiffman to understand what's going on
 
 */

class Walker {
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector offset;
  int tag;
  //ArrayList<PVector> footprints = new ArrayList();
  ArrayList<Walker> allWalkers = new ArrayList();

  Walker() {
    println(this+" is alive");
  }

  void create(int _tag) {
    tag = _tag;
    location = new PVector(width/2, height/2);
    velocity = new PVector(4, 3.5);
    offset = new PVector(random(1000), random(1000));
    acceleration = new PVector(0, 0);
  }

  void render() {

    //calculate my distance from all the other walkers
    stroke(colours[2]);
    for (Walker w:allWalkers) {
      line(location.x, location.y, w.location.x, w.location.y);
    }

    //draw the ellipse and the tag
    noStroke();
    fill(colours[1]);
    ellipse(location.x, location.y, 20, 20);
    //give the walkers a little tag on their back
    fill(0);
    text(tag, location.x-4, location.y+3);
  }

  void update() {
    //philosophically - should the body check for walkers and pull them, or should the walkers check for bodies?
    for (Body b:allBodies) {
      //println(b.location.dist(location));
      if (location.dist(b.location) <= b.range) {
        println("within range of body");
      }
    }

    location.add(velocity);
    velocity.add(acceleration);
    location.x = map(noise(offset.x), 0, 1, 0, width); //not sure I understand Perlin noise just yet
    location.y = map(noise(offset.y), 0, 1, 0, height);
    offset.add(0.005, 0.005, 0); //add a little bit to the noise offset.
  }
}

