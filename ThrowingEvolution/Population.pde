class Population {
  Ball[] balls;

  float fitnessSum;
  int gen = 1;

  int bestBall = 0;//the index of the best ball in the balls[]
  
  PShape lastBestBallPath;

  Population(int size) {
    balls = new Ball[size];
    for (int i = 0; i< size; i++) 
      balls[i] = new Ball();
    lastBestBallPath = null;
  }

  //show all balls
  void show() {
    if(gen != 1)
      shape(lastBestBallPath);            //show the path of the last best ball
    for (int i = 1; i< balls.length; i++) 
      balls[i].show();
    balls[0].show();
  }

  //update all balls 
  void update(Mediums mediums) {
    for (int i = 0; i< balls.length; i++) 
    {
      balls[i].update();
      mediums.checkCollision(balls[i]);
    }
  }

  //calculate all the fitnesses
  void calculateFitness() {
    for (int i = 0; i< balls.length; i++) 
      balls[i].calculateFitness();
  }

  //returns whether all the balls are on the ground
  boolean allDotsDead() {
    for (int i = 0; i< balls.length; i++) 
      if (!balls[i].dead) 
        return false;

    return true;
  }

  //gets the next generation of dots
  void naturalSelection() {
    Ball[] newBalls = new Ball[balls.length];         //next gen
    
    setBestBall();
    calculateFitnessSum();

    //the champion lives on 
    newBalls[0] = balls[bestBall].Birth();
    newBalls[0].isBest = true;
    
    for (int i = 1; i< newBalls.length; i++) 
    {
      Ball parent = selectParent();                   //select parent based on fitness
      newBalls[i] = parent.Birth();                   //get baby from them
    }
    
    balls = newBalls.clone();
    gen++;
  }

  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i< balls.length; i++) {
      fitnessSum += balls[i].fitness;
    }
  }

  //chooses dot from the population to return randomly(considering fitness)
  Ball selectParent() {
    float rand = random(fitnessSum);


    float runningSum = 0;

    for (int i = 0; i< balls.length; i++) {
      runningSum += balls[i].fitness;
      if (runningSum > rand) {
        return balls[i];
      }
    }

    return null;
  }

  //mutates all the babies
  void Mutate(float range) {
    for (int i = 1; i < balls.length; i++) 
      balls[i].Mutate(range);
  }

  //finds the ball with the highest fitness and sets it as the best ball
  void setBestBall() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i< balls.length; i++) 
      if (balls[i].fitness > max) 
      {
        max = balls[i].fitness;
        maxIndex = i;
      }

    bestBall = maxIndex;
    
    print("Best ball. Angles: ");
    for(int i=0; i<balls[bestBall].numOfArcs; i++)
      print(balls[bestBall].arcs[i].heading() / (2*PI) * -360, " ");
    print(" Fitness: ");
    print(balls[bestBall].fitness);
    print(" Distance: ");
    print(balls[bestBall].pos.x, " ");
    print("\n");
    
    lastBestBallPath = balls[bestBall].path;      //acquire the path of the best ball
    lastBestBallPath.setStroke(GREEN);
  }
  
  void restoreStart() {
    for (int i = 0; i< balls.length; i++) 
      balls[i].Restore();
  }
}
