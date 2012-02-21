/*

 Nature of Code - Experiments in Simple Motion: Searching Creatures. 
 
 4th February 2012
 
 Paul May
 paulmay.org
 
 */

ArrayList<Creature> allCreatures;
ArrayList<Obstacle> allObstacles;

Creature cre;
color[] colours = {
  #F2f2f2, #ADDAEA, #cccccc, #FAFAFA, #6F0D0D, #E8E8E8
};

void setup() {
  smooth();
  size(700, 500);
  background(colours[0]);
  cre = new Creature();
  cre.create();
  cre.update();
  cre.render();
}



void draw() {
  background(colours[0]);
  cre.update();
  cre.render();
}

