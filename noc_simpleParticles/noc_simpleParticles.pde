/*

 Nature of Code - Experiments in Simple Motion: Particle System
 
 21st February 2012
 
 Paul May
 paulmay.org
 
 */

color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8
};
Slider mySlider;
ArrayList<System> allSystems;


void setup() {
  allSystems = new ArrayList();
  mySlider = new Slider();
  size(700, 500);
  background(colours[0]);
  //mySlider.setupSlider("Particles");
  mySlider.setupSlider(120, 10, 100, 200, 50, 0, 35, 50, 50, "Particles");
  mySlider.render();

  smooth();
}

void draw() {
  background(colours[0]);
  mySlider.update();
  mySlider.render();

  //iterate through the systems, remove them when they're done
  Iterator<System> it = allSystems.iterator();
  while (it.hasNext ()) {
    System s = it.next();
    s.render();

    /*just a thought - if you don't understand that Java deletes objects from 
     memory when all references to that object have been removed - you might
     not undertand this, or the benefit of it */

    if (s.allParticles.size()==0) {
      println("system "+it +" is dead");
      it.remove();
    }
  }

  fill(0);
  text(floor(frameRate), width-60, height-20);
}

void mousePressed() {
  System sys = new System(); 
  //hacky hack - the slider is a float, will figure out later
  sys.create(ceil(mySlider.sliderVal)-1, new PVector(mouseX, mouseY));
  allSystems.add(sys);
//  println(allSystems.size());
}

