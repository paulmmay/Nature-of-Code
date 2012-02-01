/*

 Simple Slider
 
 31st January 2012
 
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

