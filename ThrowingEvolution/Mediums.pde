class Mediums {
 ArrayList<Medium> mediums;
 
 Mediums() {
   mediums = new ArrayList<Medium>();
 }
 
 void show() {
   for (Medium m : mediums) 
     m.show();
 }
 
 void add(Medium medium) {
   mediums.add(medium);
 }
 
 void checkCollision(Ball ball) {
   for (Medium m : mediums) 
     if(m.checkForCollision(ball.pos.array()))
       m.applyFriction(ball);
 }
 
}
