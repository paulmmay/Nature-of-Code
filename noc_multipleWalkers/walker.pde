
/*

 working through example Walker code by Daniel Shiffman to understand what's going on
 
 */

class Walker {
  PVector location;
  PVector velocity;
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
  }

  void render() {
    location.add(velocity);
    //reset if we wander off screen

    //calculate my distance from all the other walkers
    stroke(colours[2]);
    for (Walker w:allWalkers) {
      line(location.x, location.y, w.location.x, w.location.y); 
      // text(dist(location.x, location.y, w.location.x, w.location.y),location.x-10, location.y-20); //where to position distance

      /*can we make a decision on what to do if we're too close to the other walkers?
      the problem is that this walker exists in the arraylist, so it'll always be a distance of 0 between itself and itself
      (a one point through the loop w points to this walker)
      */
      if (PVector.dist(this.location, w.location) <=10.0) { 
       // println(PVector.dist(this.location, w.location));
      }
      
      
    }

      /*draw the wiggly footprint line
       beginShape();
       stroke(colours[3]);
       noFill();
       for (PVector v: footprints) {
       vertex(v.x, v.y); //never used this before, nifty
       }  
       endShape();*/



      //draw the ellipse and the tag
      noStroke();
      fill(colours[1]);
      ellipse(location.x, location.y, 20, 20);
      //give the walkers a little tag on their back
      fill(0);
      text(tag, location.x-4, location.y+3);
    }

    void update() {
      location.x = map(noise(offset.x), 0, 1, 0, width); //not sure I understand Perlin noise just yet
      location.y = map(noise(offset.y), 0, 1, 0, height);
      offset.add(mySlider.sliderVal/1000, mySlider.sliderVal/1000, 0); //add a little bit to the noise offset. 

      /*create a little trail behind the walker
       footprints.add(location.get());
       if (footprints.size() > 2000) {
       footprints.remove(0);
       }*/
    }
  }

