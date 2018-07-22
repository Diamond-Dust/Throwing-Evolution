class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector[] arcs;

  boolean dead = false;
  boolean isBest = false;//true if this dot is the best dot from the previous generation

  float fitness = 0;
  int strength = 7;     //////  Strength of every throws
  int step = 0;
  int numOfArcs = 2;    //////  Number of throws the ball will do
  int currentArc = 0;

  Ball() {

    //start the dots at the bottom of the window with a no velocity or acceleration
    pos = new PVector(1, 799);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    arcs = new PVector[numOfArcs];
    
    for(int i=0; i<numOfArcs; i++)
      arcs[i] = PVector.fromAngle(random(PI/2)-PI/2);    //random arc
     
  }

  //draws the dot on the screen
  void show() {
    if (isBest)   //if this dot is the best dot from the previous generation then draw it as a big green dot
    {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } 
    else          //all other dots are just smaller black dots
    {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  //moves the dot according to the brains directions
  void move() {
    
    if(step == 0)
    {
      step++;
      acc = arcs[currentArc].copy();
      acc.mult(strength);
    }
    else
    {
      step++;
      acc = acc.add(PVector.fromAngle(PI/2).mult(0.05));      //////  Set gravity in .mult(X)
    }

    //apply the acceleration and move the dot
    vel.add(acc);
    pos.add(vel);
    acc = new PVector(0,0);
  }

  //calls the move function and check for collisions
  void update() {
    if (!dead) 
    {
      move();
      if ( (pos.y>=800-1) && (currentArc == numOfArcs-1) ) //if falls then kill it
      {
        dead = true;
        vel = new PVector(0,0);
      }
      else if (pos.y>=800-1)
        {
          vel = new PVector(0, 0);
          acc = new PVector(0, 0);
          step = 0;
          currentArc++;
        }
    }
  }

  //calculates the fitness
  void calculateFitness() {
     fitness += pos.x*pos.x;
  }
  
  //mutates
  void Mutate(float rate) {
    for(int i=0; i<numOfArcs; i++)
      arcs[i].rotate(random(-rate,rate)*PI);    //random arc
  }

  //clone it 
  Ball Birth() {
    Ball baby = new Ball();
    for(int i=0; i<numOfArcs; i++)
      baby.arcs[i] = arcs[i].copy();
    return baby;
  }
  
  void Restore() {
     pos = new PVector(1, 799);
     vel = new PVector(0, 0);
     acc = new PVector(0, 0);
     dead = false;
     step = 0;
     currentArc = 0;
  }
}
