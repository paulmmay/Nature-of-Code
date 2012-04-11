class Food extends Something {

  /* ---------------- CONSTRUCTOR---------------------- */
  Food(Float _x, Float _y) {
    location = new PVector(_x, _y);
    foodSupply = 20;
    threat = false;
    myColour = colours[6];
    mySize = 10;  
    println(this+ " Hi, I'm some food - you should come and taste me");
  }

  /* ---------------- ATRIBUTES---------------------- */




  /* ---------------- BEHAVIOUR FUNCTIONS ---------------------- */





  /* ---------------- ADMIN FUNCTIONS ---------------------- */
}

