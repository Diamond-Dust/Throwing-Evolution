RepetitionCommand Throws;



void setup() {
  size(1600, 800);                       //////   Size of the window
  frameRate(GoalFramerate);
  Throws = new RepetitionCommand(NumberOfBalls);    //  Creates a new population with 50 members
}


void draw() { 
  background(WHITE);

  strokeWeight(4);
  line(1, ScreenHeight-1, ScreenWidth-1, ScreenHeight-1);
  strokeWeight(1);
  fill(BLACK);
  point(1, ScreenHeight-1);

  Throws.commenceThrows();
  
}
