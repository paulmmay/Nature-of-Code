class World {

  //has species
  ArrayList<Species> allHerds = new ArrayList();

  //has terrain, some of it edible
  ArrayList<Something> allThings = new ArrayList();
  PFont font = loadFont("HelveticaNeue-Medium-12.vlw"); 
  //has weather



  World() {
  }

  void makeThings(int _num, boolean _threat) { //bloated
    for (int i=0;i<=_num-1;i++) {
      //make a food
      //should probably be in "clusters", so will make this noisy, not random

      /* float x = random(width);
       float y = random(height);
       float angle = random(TWO_PI);
       float r = random(10); // use perlin noise based on the angle?
       Food f = new Food(x+r*cos(angle),y+sin(angle));*/

      if (_threat == false) {
        //pick a point and pick points within an offset
        Food f = new Food(random(40, width-40), random(40, height-40));
        allThings.add(f);
      }
      else
      {
        Threat t = new Threat(random(40, width-40), random(40, height-40));
        allThings.add(t);
      }
    }
  }


  void makeHerds(int _herds, int _creatures) {
    //make herds with a number of creatures
    for (int i=0;i<=_herds-1;i++) {
      Species s = new Species();
      allHerds.add(s);
      Float startx = random(width); //doing this to start the herd at one x-loc
      s.makeCreatures(_creatures, startx, height/2,1);
    }
  }


  void render() {
    int total = 0;
    //draw the objects in our world - food, threats etc.
    for (Something s:allThings) {
      s.render();
    }
    //pass all the objects to all the creatures - right approach?
    for (Species h:allHerds) {
      //for (Creature c:h.allCreatures) { //for each herd, each creature in the herd
      for (int i = 0; i< h.allCreatures.size(); i++) { 
        Creature c = (Creature)h.allCreatures.get(i);
        if (c.alive == true) { //creatures can die, when they do - don't show them anymore
          c.update();
          c.age();
          c.render();
          if (flag) {
            c.flag();
          }
          c.wander();
          c.boundaries();
          c.decide(allThings);
          c.friendly(h.allCreatures);
        }
      }
    }
  }
}

