class Ball {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector[] arcs;

  boolean dead = false;
  boolean isBest = false;//true if this dot is the best dot from the previous generation

  float fitness = 0;
  int step = 0;
  int currentArc = 0;
  
  int numOfArcs = NumberOfThrows;    //////  Number of throws the ball will do
  float strength = ThrowStrength;     //////  Strength of every throws
  
  PShape path;

  Ball() {

    //start the balls at the bottom of the window with no velocity or acceleration
    pos = new PVector(1, ScreenHeight-1);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    arcs = new PVector[numOfArcs];
    
    for(int i=0; i<numOfArcs; i++)
      arcs[i] = PVector.fromAngle(random(PI/2)-PI/2);    //random arc

    //start the path memory
    noFill();                  
    path = createShape();
    path.setStroke(RED);
  }

  //draws the dot on the screen
  void show() {
    if (isBest)   //if this dot is the best ball from the previous generation then draw it as a big green dot
    {
      fill(GREEN);
      ellipse(pos.x, pos.y, BestBallSize, BestBallSize);
    } 
    else          //all other dots are just smaller black dots
    {
      fill(BLACK);
      ellipse(pos.x, pos.y, NormalBallSize, NormalBallSize);
    }
  }

  //moves the ball according to the arcs and gravity
  void move() {
    
    if(step == 0)
    {
      step++;
      acc = arcs[currentArc].copy();
      acc.mult(strength);
      
      
      path.beginShape();  //start the shape
    }
    else
    {
      step++;
      acc = acc.add(PVector.fromAngle(PI/2).mult(GravityValue));      //  add gravity
      
      
      path.vertex(pos.x, pos.y);    //  add current position to the path
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
      if ( (pos.y >= ScreenHeight-1) && (currentArc == numOfArcs-1) ) //if falls then kill it
      {
        dead = true;
        vel = new PVector(0,0);
        
        path.endShape();  //stop recording the path when dead
        shape(path);      //show the path taken
      }
      else if (pos.y >= ScreenHeight-1)
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
     fitness += pos.x*pos.x*pos.x;
  }
  
  //mutates
  void Mutate(float range) {
    for(int i=0; i<numOfArcs; i++)
      arcs[i].rotate(random(-range, range) * PI);    //random arc
  }

  //clone it 
  Ball Birth() {
    Ball baby = new Ball();
    for(int i=0; i<numOfArcs; i++)
      baby.arcs[i] = arcs[i].copy();
    return baby;
  }
  
  void Restore() {
     pos = new PVector(1, ScreenHeight-1);
     vel = new PVector(0, 0);
     acc = new PVector(0, 0);
     dead = false;
     step = 0;
     currentArc = 0;
  }
}
