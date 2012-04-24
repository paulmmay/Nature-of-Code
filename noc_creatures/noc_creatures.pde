/*

 Creatures
 A little world of creatures and food and weather
 
 Paul May
 ITP 2012
 
 */


String sketchname = "creatures";

boolean debug;
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8, #B0D748, #DB4050, #222222
};

PFont font;

World w;
Creature c;
void setup() {
  font = loadFont("HelveticaNeue-Medium-12.vlw"); 
  size(1166, 700);
  //size(900, 400);
  smooth();
  w = new World(); //create the world and set basic parameters
  w.makeThings(5, false); //make food
  w.makeThings(3, true); //make threats
  w.makeHerds(4, 2);
  debug = true;
}

void draw() {
  background(colours[0]);
  w.render(); //render the world
  //saveFrame("movie/feedingfleeing_creatures####.png");
}


/* ---------------- ADMIN FUNCTIONS ---------------------- */

void keyPressed() {
  screenShot();
}

void screenShot() {
  //take a timestamped screenshot
  Date d = new Date();
  save("screenshots/"+d.toString()+"_"+sketchname+".png");
}


