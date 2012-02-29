class Particle extends VerletParticle2D {

  //data related to our image

  PImage theImage;
  color theColor;

  //data from our CSV
  String date, imageName, description, location, person, category;
  Float dollarValue;


  Particle (Vec2D loc) {
    //don't understand this
    super(loc);
  }

  void display () {
  }


  /*I like the idea that objects have internal machinery to handle with data passed to them, 
   feels more true to the idea of OOP than having an external puppetteer.*/

  void processImage(PImage _image) {
  }

  void processCsvRow(String _row) {
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
  
  void report(){
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
