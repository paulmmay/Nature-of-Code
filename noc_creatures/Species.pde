class Species {

  ArrayList<Creature> allCreatures; 
  color colour;
  //all the creatures in this herd share the same basic attributes
  //colour
  //speed
  color[] possibleColours = {
    #9BD49D, #D4E1B5, #F6BA40, #DD5F22, #BF282D, #3C7B37, #42445D, #498A3E, #66C256,#C0CC8B,#E6E4CC,#C4B0C3,#E3D265,#5A8991,#E65A65
  };


  Species() {
    println("Herd "+this+" is alive");
    allCreatures = new ArrayList();
    //pick a random colour for the herd
    int colRand = int(floor(random(possibleColours.length)));
    colour = possibleColours[colRand];
    println(colour);
  }


  void makeCreatures(int _creatures, float _x, float _y) {
    //make a group of creatures with a number of creatures
    for (int i=0;i<=_creatures-1;i++) {
      Creature c = new Creature(_x, _y, this);
      allCreatures.add(c);
    }
  }
}

