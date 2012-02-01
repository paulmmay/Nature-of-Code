/*

 Nature of Code - Experiments in Simple Motion: a walker that uses external data as an input
 
 24th January 2012
 
 Paul May
 paulmay.org
 
 */

Slider mySlider;
ArrayList<Slider> allSliders = new ArrayList();
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc,#FAFAFA
};

ArrayList<Walker> allWalkers = new ArrayList();




void setup() {
  //get data
  handleData();
  
  
  //create three walkers
  for (int i=0;i<=2;i++) {
    Walker newWalker = new Walker();
    allWalkers.add(newWalker);
    newWalker.create(i);
  }

  //add all the walkers into all the walkers - is this the best way to do it?
  for (Walker w:allWalkers) {
    //hmm...this is a pointer to the global list of walkers, need to add all walkers into the internal list of walkers. will come back to it. 
    w.allWalkers = allWalkers;
  }

  size(700, 500);
  background(colours[0]);
  mySlider = new Slider();
  allSliders.add(mySlider);
  //setupSlider takes these args
  //int _startWidth, int _startHeight, int _fillColor, int _sliderColor, int _maxVal, int _minVal, int _sliderVal, int _xPos, int _yPos, String label) 
  mySlider.setupSlider(120, 10, 100, 200, 100, 0, 5, 50, 50, "Noise");
  mySlider.render();
  smooth();
}

void draw() {
  background(colours[0]);
  //continually update all sliders
  for (Slider s:allSliders) {
    s.update();
    s.render();
  }

  //update and render all walkers
  for (Walker w:allWalkers) {
    w.update();
    w.render();
  }
}

void keyPressed(){
  save(millis()+".png");
}

