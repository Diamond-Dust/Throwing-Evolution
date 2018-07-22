RepetitionCommand Throws;

void setup() {
  size(1600, 800);                       //////   Size of the window
  frameRate(300);
  Throws = new RepetitionCommand(50);    //////   Creates a new population with 50 members
}


void draw() { 
  background(255);

  strokeWeight(4);
  line(1, 800-1, 1600-1, 800-1);
  strokeWeight(1);
  fill(0);
  point(1,799);

  Throws.commenceThrows();
  
}
