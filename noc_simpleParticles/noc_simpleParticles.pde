/*

 Nature of Code - Experiments in Simple Motion: Particle System
 
 14th February 2012
 
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
  mySlider.setupSlider("Particles");
  mySlider.render();

  smooth();
}

void draw() {
  background(colours[0]);
  mySlider.update();
  mySlider.render();
  for (System sys:allSystems) {
    sys.render();
  }

  fill(0);
  text(frameRate, width-60, height-20);
}

void mousePressed(){
  System sys = new System();
  sys.create(new PVector(mouseX,mouseY));
  allSystems.add(sys);

}

