class World {

  //has species
  ArrayList<Species> allHerds = new ArrayList();

  //has terrain, some of it edible
  ArrayList<Something> allThings = new ArrayList();
  PFont font = loadFont("HelveticaNeue-Medium-12.vlw"); 
  //has weather



  World() {
  }

  void makeThings(int _num, boolean _threat) {
    for (int i=0;i<=_num-1;i++) {
      //make a food
      //should probably be in "clusters", so will make this noisy, not random
      if (_threat == false) {
        Food f = new Food(random(width), random(height));
        allThings.add(f);
      }
      else
      {
        Threat t = new Threat(random(width), random(height));
        allThings.add(t);
      }
    }
  }


  void makeHerds(int _herds, int _creatures) {
    //make herds with a number of creatures
    for (int i=0;i<=_herds-1;i++) {
      Species s = new Species();
      allHerds.add(s);
      s.makeCreatures(10, width/2, height/2);
    }
  }


  void render() {
    //draw the objects in our world - food, threats etc.
    for (Something s:allThings) {
      s.render();
    }
    //pass all the objects to all the creatures - right approach?
    for (Species h:allHerds) {
      for (Creature c:h.allCreatures) { //for each herd, each creature in the herd
        c.update();
        c.render();
        c.wander();
        c.decide(allThings);
      }
    }
  }
}

