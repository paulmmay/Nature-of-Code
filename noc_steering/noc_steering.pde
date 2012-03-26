

Vehicle v;
Threat t;
Food f;
ArrayList<Something> allThings = new ArrayList();
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8, #B0D748, #DB4050
};

void setup() {
  size(700, 450);
  v = new Vehicle(width/2, height/2);
  smooth();
  t = new Threat();
  f = new Food();
  allThings.add(t);
  allThings.add(f);
}

void draw() {


  background(255);

  //update everything

  //render everything
  for (Something s:allThings) {
    s.render();
    v.decide(s.location);
  }
  v.update();
  v.display();
}

void keyPressed() {
  int time = millis();
  save(time+"_steering.png");
}

