class Medium {
   float frictionCoefficient;
   int xdownleft, ydownleft, xupperright, yupperright;
   int blueness;
   
   Medium(int xd, int yd, int xu, int yu, float f) {
     frictionCoefficient = f;
     xdownleft = xd;
     ydownleft = yd;
     xupperright = xu;
     yupperright = yu;
     blueness = 255-(int)(f*255)%255;
   }
   
   void show() {
     fill(blueness);
     stroke(0, 0, 255-blueness);
     rectMode(CORNERS);
     rect(xdownleft, ydownleft, xupperright, yupperright);
   }
   
   void applyFriction(Ball ball) {
     ball.acc.add(ball.vel.copy().rotate(PI).mult(frictionCoefficient)); 
   }
   
   boolean checkForCollision(float[] Vector) {
     if( (xdownleft <= Vector[0]) && (xupperright >= Vector[0]) && (ydownleft <= Vector[1]) && (yupperright >= Vector[1]) )
       return true;
     else
       return false;
   }
}
