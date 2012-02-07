/*

 Nature of Code - Experiments in Simple Motion: Vector Walk with Perlin Noise
 
 24th January 2012
 
 Paul May
 paulmay.org
 
 */

Slider mySlider;
ArrayList<Slider> allSliders = new ArrayList();
color[] colours = {
  #F2f2f2, #ADDAEA,#cccccc
};
Walker theWalker;


void setup() {
  size(700, 500);
  background(colours[0]);
  mySlider = new Slider();
  allSliders.add(mySlider);
  //setupSlider takes these args
  //int _startWidth, int _startHeight, int _fillColor, int _sliderColor, int _maxVal, int _minVal, int _sliderVal, int _xPos, int _yPos, String label) 
  mySlider.setupSlider(120, 10, 100, 200, 100, 0, 5, 50, 50, "Curiosity");
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

  theWalker.update();
  theWalker.render();
}

void keyPressed(){
  save(millis()+".png");
}
/*

 Simple Slider
 
 24th January 2012
 
 Paul May
 paulmay.org
 
 */

class Slider {

  int startWidth;
  int startHeight;
  color fillColor;
  int sliderColor;
  float sliderVal;
  float maxVal; 
  float minVal;
  int xPos;
  int yPos;
  boolean inside;
  String label;

  PFont font;


  Slider() {
  }

  void update() {
    fill(0,8,8);
    text(label+": "+sliderVal, xPos, yPos-startHeight/2);
    //if the mouse is inside
    if (mouseX>this.xPos & mouseX<this.xPos+startWidth & mouseY>this.yPos & mouseY<this.yPos+startHeight) {
      inside = true;
    }
    else {
      inside = false;
    }

    //is the mouse down
    if (mousePressed && inside == true) {
      //println("button click");
      sliderVal = mouseX-xPos;
      //println(this+" "+sliderVal);
      render();
    }
  }

  void render() {
    noStroke();
    pushMatrix();
    translate(xPos, yPos);
    fill(fillColor);
    rect(0, 0, startWidth, startHeight);
    fill(sliderColor);
    rect(0, 0, sliderVal, startHeight); 
    popMatrix();
  }

  void setupSlider(int _startWidth, int _startHeight, int _fillColor, int _sliderColor, float _maxVal, float _minVal, float _sliderVal, int _xPos, int _yPos, String _label) {
    startWidth = _startWidth;
    startHeight = _startHeight;
    fillColor = _fillColor;
    sliderColor = _sliderColor;
    maxVal = _maxVal;
    minVal = _minVal;
    sliderVal = _sliderVal;
    xPos = _xPos;
    yPos = _yPos;
    label = _label;
    font = createFont("Georgia", 14); 
    textSize(14);
    textFont(font);
  }
}


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


