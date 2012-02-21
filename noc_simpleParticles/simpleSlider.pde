/*

 Simple Slider
 
 14th February 2012
 
 Paul May
 paulmay.org
 
 */

class Slider {

  int startWidth;
  int startHeight;
  color fillColor;
  int sliderColor;
  float clickedVal;
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
    fill(0, 8, 8);
    //format our sliderValue to make it presentable for rendering
    DecimalFormat df = new DecimalFormat("#");
    String formattedVal = df.format(sliderVal);
    text(label+": "+formattedVal, xPos, yPos-startHeight/2);
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
      clickedVal = mouseX-xPos; //the relative value of the mouse click to the position of the slider on the screen. we only care about the x val.
      sliderVal = map(clickedVal, 0, startWidth, minVal, maxVal); //map the position of the click inside the slider to our min and max vals
      render();
    }
  }

  void render() {
    noStroke();
    fill(fillColor);
    rect(xPos, yPos, startWidth, startHeight);
    fill(sliderColor);
    rect(xPos, yPos, clickedVal, startHeight);
  }

  //a full setup method
  void setupSlider(int _startWidth, int _startHeight, int _fillColor, int _sliderColor, float _maxVal, float _minVal, float _clickedVal, int _xPos, int _yPos, String _label) {
    startWidth = _startWidth;
    startHeight = _startHeight;
    fillColor = _fillColor;
    sliderColor = _sliderColor;
    maxVal = _maxVal;
    minVal = _minVal;
    clickedVal = _clickedVal;
    xPos = _xPos;
    yPos = _yPos;
    label = _label;
    font = createFont("Georgia", 14); 
    textSize(14);
    textFont(font);
    sliderVal = map(clickedVal, 0, startWidth, minVal, maxVal); //map the position of the click inside the slider to our min and max vals
  }


  // a simpler setup method
  void setupSlider(String _label) {
    startWidth = 200;
    startHeight = 10;
    fillColor = 120;
    sliderColor = 200;
    maxVal = 100;
    minVal = 0;
    clickedVal = 50;
    xPos = 50;
    yPos = 50;
    label = _label;
    font = createFont("Georgia", 14); 
    textSize(14);
    textFont(font);
    sliderVal = map(clickedVal, 0, startWidth, minVal, maxVal); //map the position of the click inside the slider to our min and max vals
  }
}

