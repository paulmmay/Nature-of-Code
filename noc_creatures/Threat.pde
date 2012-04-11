class Threat extends Something {

  /* ---------------- CONSTRUCTOR---------------------- */
  Threat(Float _x, Float _y) {
    location = new PVector(_x, _y);
    myColour = colours[7];
    mySize = 10; 
    threat = true;
    println(this+ " Hi, I'm a threatening object - you'd better stay away");
  }

  /* ---------------- ATRIBUTES---------------------- */

  //see parent class

  /* ---------------- BEHAVIOUR FUNCTIONS ---------------------- */

  //see parent class

  /* ---------------- ADMIN FUNCTIONS ---------------------- */

  //see parent class
}

