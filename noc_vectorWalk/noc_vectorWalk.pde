/*

 Nature of Code - Experiments in Simple Motion: Vector Walk
 
 24th January 2012
 
 Paul May
 paulmay.org
 
 */

Slider mySlider;
ArrayList<Slider> allSliders = new ArrayList();
color[] colours = {
  #F2f2f2, #ADDAEA
};
Walker theWalker;


void setup() {
  size(700, 500);
  background(colours[0]);
  mySlider = new Slider();
  allSliders.add(mySlider);
  //setupSlider takes these args
  //int _startWidth, int _startHeight, int _fillColor, int _sliderColor, int _maxVal, int _minVal, int _sliderVal, int _xPos, int _yPos, String label) 
  mySlider.setupSlider(120, 10, 100, 200, 100, 0, 50, 50, 50, "Curiosity");
  mySlider.render();
  smooth();
  theWalker = new Walker();
  theWalker.create();
}

void draw() {
  background(colours[0]);
  //continually update all sliders
  for (Slider s:allSliders) {
    s.update();
    s.render();
  }

  theWalker.velocity.x=random(-1*mySlider.sliderVal/50,mySlider.sliderVal/50);
  theWalker.velocity.y=random(-1*mySlider.sliderVal/50,mySlider.sliderVal/50);
  
  theWalker.draw();
}

