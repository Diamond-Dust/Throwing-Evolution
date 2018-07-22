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

  //show all dots
  void show() {
    if(gen != 1)
      shape(lastBestBallPath);            //show the path of the last best ball
    for (int i = 1; i< balls.length; i++) 
      balls[i].show();
    balls[0].show();
  }

  //update all dots 
  void update(Mediums mediums) {
    for (int i = 0; i< balls.length; i++) 
    {
      mediums.checkCollision(balls[i]);
      balls[i].update();
    }
  }

  //calculate all the fitnesses
  void calculateFitness() {
    for (int i = 0; i< balls.length; i++) 
      balls[i].calculateFitness();
  }

  //returns whether all the dots are either dead or have reached the goal
  boolean allDotsDead() {
    for (int i = 0; i< balls.length; i++) 
      if (!balls[i].dead) 
        return false;

    return true;
  }

  //gets the next generation of dots
  void naturalSelection() {
    Ball[] newDots = new Ball[balls.length];         //next gen
    
    print("Best old ball. Angles: ");
    for(int i=0; i<balls[0].numOfArcs; i++)
      print(balls[0].arcs[i].heading() / (2*PI) * -360, " ");
    print(" Fitness: ");
    print(balls[0].fitness);
    print(" Distance: ");
    print(balls[0].pos.x, " ");
    print("\n");
    
    setBestDot();
    calculateFitnessSum();

    //the champion lives on 
    newDots[0] = balls[bestBall].Birth();
    newDots[0].isBest = true;
    
    for (int i = 1; i< newDots.length; i++) 
    {
      Ball parent = selectParent();                  //select parent based on fitness
      newDots[i] = parent.Birth();                   //get baby from them
    }
    
    balls = newDots.clone();
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
  void Mutate(float rate) {
    for (int i = 1; i < balls.length; i++) 
      balls[i].Mutate(rate);
  }

  //finds the dot with the highest fitness and sets it as the best dot
  void setBestDot() {
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
    lastBestBallPath.setStroke(color(0, 255, 0));
  }
  
  void restoreStart() {
    for (int i = 0; i< balls.length; i++) 
      balls[i].Restore();
  }
}
