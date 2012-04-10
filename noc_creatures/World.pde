class World {

  //has species
  ArrayList<Species> allHerds = new ArrayList();
  //has physical features

  //has terrain, some of it edible
  ArrayList<Something> allThings = new ArrayList();

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




  void render() {

    //draw the objects in our world - food, threats etc.
    for (Something s:allThings) {
      s.render();
    }
  }
}

