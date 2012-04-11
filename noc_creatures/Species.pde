class Species {

  ArrayList<Creature> allCreatures; 

  //all the creatures in this herd share the same basic attributes
  //colour
  //speed


  Species() {
    println("Herd "+this+" is alive");
    allCreatures = new ArrayList();
  }


  void makeCreatures(int _creatures, float _x, float _y) {
    //make a group of creatures with a number of creatures
    for (int i=0;i<=_creatures-1;i++) {
      Creature c = new Creature(_x, _y);
      allCreatures.add(c);
    }
  }
}

