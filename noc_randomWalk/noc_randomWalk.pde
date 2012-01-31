/*

 Nature of Code - Experiments in Simple Motion: Walk
 
 24th January 2012
 
 Paul May
 paulmay.org
 
 */

Slider mySlider;
ArrayList<Slider> allSliders = new ArrayList();
color[] colours = {
  #F2f2f2, #ADDAEA
};
Ball theBall;


void setup() {
  size(700, 500);
  background(colours[0]);
  mySlider = new Slider();
  allSliders.add(mySlider);
  //setupSlider takes these args
  //int _startWidth, int _startHeight, int _fillColor, int _sliderColor, int _maxVal, int _minVal, int _sliderVal, int _xPos, int _yPos, String label) 
  mySlider.setupSlider(120, 10, 120, 200, 100, 0, 50, 50, 50, "Maximum Step");
  mySlider.render();
  smooth();
  theBall = new Ball();
  theBall.create(width/2, 100, 0.1);
}

void draw() {
  background(colours[0]);
  //continually update all sliders
  for (Slider s:allSliders) {
    s.update();
    s.render();
  }
  
  //change the ball in some way
  theBall.xPos+=random(-1*mySlider.sliderVal,mySlider.sliderVal);
  theBall.yPos+=random(-1*mySlider.sliderVal,mySlider.sliderVal);
  theBall.update();
  theBall.render();
  
  if(abs(dist(theBall.xPos,theBall.yPos,width/2,height/2)) > width/2){
    theBall.create(width/2, 100, 0.1);
  }
  
}


class Ball {
  float xPos;
  float yPos;
  float ySpeed;
  float xSpeed;

  Ball() {
    println(this+" is alive");
  }

  void update() {
    xPos+=xSpeed;
    yPos+=ySpeed;
  }

  void create(float _xPos, float _yPos, float _ySpeed) {
    xPos = _xPos;
    yPos = _yPos;
    ySpeed = _ySpeed;
  }

  void render() {
    noStroke();
    fill(colours[1]);
    ellipse(xPos, yPos, 30, 30);
  }
}

void keyPressed(){
  save(millis()+".png");
}
