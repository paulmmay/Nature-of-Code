class Particle extends VerletParticle2D {



  //data related to our image
  color imgColour;
  int imgWidth, imgHeight, imgArea;

  //data from our CSV
  String date, imageName, description, location, person, category;
  Float dollarValue;
  float r;
  int renderScale = 20;


  Particle(Vec2D pos) {
    super(pos);
  }

  /*I like the idea that objects have internal machinery to handle with data passed to them, 
   feels more true to the idea of OOP than having an external puppetteer; still getting better at this.*/

  void create() {
    //set up images
    processImage(loadImage("data/images/"+imageName+".jpeg"));
  }

  

  void render() {
    rectMode(CENTER);
    pushMatrix();
    //translate(pos.x, pos.y);
    //rotate(-a);
    fill(imgColour);
    noStroke();
    rect(x, y, imgWidth/renderScale, imgHeight/renderScale);
    popMatrix();
  }

  void processImage(PImage _image) {
    //find widths, colours etc. 
    imgWidth = _image.width;
    imgHeight = _image.height;
    imgArea = imgWidth * imgHeight;
    float r = 0.0;
    float g = 0.0;
    float b = 0.0;
    _image.loadPixels(); 
    //find the average colour of the image - we can use this as a fill
    for (int x = 0; x < _image.width; x++) {
      for (int y = 0; y < _image.height; y++ ) {
        int loc = x + y*_image.width;
        r+= red(_image.pixels[loc]);
        g+= green(_image.pixels[loc]);
        b+= blue(_image.pixels[loc]);
      }
    }
    imgColour = color(r/imgArea, g/imgArea, b/imgArea);
  }

  void processCsvRow(String _row) {
    //take a row of data from the CSV and parse it
    String[] data = split(_row, ",");
    imageName = data[1];
    description = data[2];
    date = data[3];
    location = data[4];
    try {
      dollarValue = Float.parseFloat(data[5]);
    }
    catch(Exception e) {
      //println(e);
    }
    person = data[6];
    category = data[7];
    //should do some error checking here, but for now ignore
  }


  void report() {
    //who are ya?
    println(date+", "+imageName+", "+description+", "+location+", "+person+", "+category);
  }
}

/*
0 Timestamp
 1 Image Name
 2 Description
 3 Date
 4 Location
 5 Monetary Value
 6 Person
 7 Category
 */
