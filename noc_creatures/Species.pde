class Species {

  ArrayList<Creature> allCreatures; 
  color colour;
  //all the creatures in this herd share the same basic attributes
  //colour
  //speed
  color[] possibleColours = {
    #9BD49D, #F6BA40, #DD5F22, #BF282D, #3C7B37, #42445D, #498A3E, #66C256,#C0CC8B,#C4B0C3,#5A8991,#E65A65
  };


  Species() {
    println("Herd "+this+" is alive");
    allCreatures = new ArrayList();
    //pick a random colour for the herd
    int colRand = int(floor(random(possibleColours.length)));
    println(colRand);
    colour = possibleColours[colRand];
  }


  void makeCreatures(int _creatures, float _x, float _y) {
    //make a group of creatures with a number of creatures
    for (int i=0;i<=_creatures-1;i++) {
      Creature c = new Creature(_x, _y, this);
      allCreatures.add(c);
    }
  }
}

