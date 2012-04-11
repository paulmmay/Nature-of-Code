

Threat t;
Food f;
Config conf;
ArrayList<Something> allThings = new ArrayList();
ArrayList<Vehicle> allVehicles = new ArrayList();
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8, #B0D748, #DB4050, #222222
};
//Slider mySlider;
PFont helv;
void setup() {
  helv = loadFont("verdana.vlw");
 // mySlider = new Slider();
  //mySlider.setupSlider("Radius");
  conf = new Config();
  size(1166, 668);
  //make 5
  for (int i=0;i<30;i++) {
    Vehicle v = new Vehicle(random(width), random(height));
    allVehicles.add(v);
  }

  smooth();
  t = new Threat();
  f = new Food();
  allThings.add(t);
  //allThings.add(f);
}

void draw() {
  //saveFrame("hires_flee####.png");
  background(colours[0]);
  //mySlider.update();
  //mySlider.render();
  //update everything

  //render everything
  for (Something s:allThings) {
    if (s.alive == true) {
      s.render();
    }
  }

  for (Vehicle v:allVehicles) {
    v.decide();
    v.boundaries();
    v.update();
    v.display();
  }
}


void keyPressed() {
  int time = millis();
  save(time+"_steering.png");
}

