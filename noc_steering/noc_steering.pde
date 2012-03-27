

Threat t;
//Food f;
Config conf;
ArrayList<Something> allThings = new ArrayList();
ArrayList<Vehicle> allVehicles = new ArrayList();
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8, #B0D748, #DB4050
};

void setup() {
  conf = new Config();
  size(1000, 600);
  //make 5
  for (int i=0;i<9;i++) {
    Vehicle v = new Vehicle(random(width), random(height));
    allVehicles.add(v);
  }

  smooth();
  t = new Threat();
  // f = new Food();
  allThings.add(t);
  // allThings.add(f);
}

void draw() {


  background(colours[0]);

  //update everything

  //render everything
  for (Something s:allThings) {
    s.render();
    for (Vehicle v:allVehicles) {
      v.decide(s);
      v.boundaries();
      v.update();
      v.display();
    }
  }
}

void keyPressed() {
  int time = millis();
  save(time+"_steering.png");
}

