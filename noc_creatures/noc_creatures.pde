/*

 Creatures
 A little world of creatures and food and weather
 
 Paul May
 ITP 2012
 
 */


String sketchname = "creatures";
import java.util.*;
boolean debug;
boolean flag;
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8, #B0D748, #DB4050, #222222, #98B8E0
};

PFont font;
PFont bigfont;

World w;
Information i;
Creature c;
void setup() {
  font = loadFont("HelveticaNeue-Medium-12.vlw");
  bigfont = loadFont("HelveticaNeue-24.vlw");
  //size(1920, 1080); //FHD
  size(1360, 768); //HD
  //size(1280,720); //720p
  //size(1093, 614); //QFHD
  smooth();
  w = new World(); //create the world and set basic parameters
  w.makeThings(20, false); //make food
  w.makeThings(20, true); //make threats
  w.makeHerds(5, 20);
  debug = true;
  flag = false;
}

void draw() {
  background(colours[0]);
  w.render(); //render the world
  //saveFrame("movie/"+sketchname+"_"+"reproduction"+"####.png");
}


/* ---------------- ADMIN FUNCTIONS ---------------------- */

void keyPressed() {
  screenShot();
}

void mousePressed() {
  flag = !flag;
}

void screenShot() {
  //take a timestamped screenshot
  Date d = new Date();
  save("screenshots/"+d.toString()+"_"+sketchname+".png");
}

//do you have a favourite pixel

