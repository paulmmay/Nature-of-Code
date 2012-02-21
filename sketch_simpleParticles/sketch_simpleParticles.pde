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

void setup() {
  mySlider = new Slider();
  size(700, 500);
  background(colours[0]);
  mySlider.setupSlider(120, 10, 100, 200, 100, 0, 5, 50, 50, "Noise");
  mySlider.render();
  smooth();
}

void draw() {
  background(colours[0]);
  mySlider.update();
  mySlider.render();
  fill(0);

  text(frameRate, width/2, height/2);
   
}

