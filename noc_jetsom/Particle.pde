class Particle {



  //data related to our image
  color imgColour;
  int imgWidth, imgHeight, imgArea;

  //data from our CSV
  String date, imageName, description, location, person, category;
  Float dollarValue;
  Float x, y, r;

  //box2d gubbins
  Body body;

  Particle () {
  }

  /*I like the idea that objects have internal machinery to handle with data passed to them, 
   feels more true to the idea of OOP than having an external puppetteer; still getting better at this.*/

  void create() {
    //set up images
    processImage(loadImage("data/images/"+imageName+".jpeg"));
    x = (width/2)+random(50);
    y = random(height/2, height/2*1.5);

    // Define a body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;

    // Put the body at XY, requiring conversion between coords systems
    bd.position = box2d.coordPixelsToWorld(x, y);
    body = box2d.world.createBody(bd);

    //for now this is a circle, make it a rectangle later
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(imgWidth/60);
    float box2dH = box2d.scalarPixelsToWorld(imgHeight/60);
    sd.setAsBox(box2dW, box2dH);

    //define a fixture - bloody hell this is tedious
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    fd.density = 0.01;
    fd.friction = 10;
    fd.restitution = 0;
    body.createFixture(fd);

    //give it a nudge
    // body.setLinearVelocity(new Vec2(random(-2, 2), random(-2, 2)));
    body.setAngularVelocity(random(-0.5, 0.5));
  }

  Vec2 attract(Particle p) {
    //We pass in another particle - everything attracts to everything
    float g = imgArea/10000;
    Vec2 pos = body.getWorldCenter(); //this
    Vec2 ppos = p.body.getWorldCenter(); //that
    Vec2 force = ppos.sub(pos);
    float distance = force.length();
    distance = constrain(distance, 1, 5);
    force.normalize();
    float strength = (g*1*p.body.m_mass) / (distance*distance);
    force.mulLocal(strength);
    return force;
  }

  void render() {
    //draw a rectangle to an arbitrary scale
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(imgColour);
    stroke(0);
    strokeWeight(1);
    rect(0, 0, imgWidth/30, imgHeight/30);
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

  void applyForce(Vec2 v) {
    body.applyForce(v, body.getWorldCenter());
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
