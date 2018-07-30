final int ScreenWidth = 1600;    //Must be separately changed in size() command in ThrowingEvlution.pde
final int ScreenHeight = 800;    //Must be separately changed in size() command in ThrowingEvlution.pde

final int GoalFramerate = 300;        //  Framerate that the programme tries to achieve

final int NumberOfBalls = 50;         //  How many balls are thrown
final int NumberOfThrows = 2;         //  How many times the balls are thrown
final float ThrowStrength = 7;        //  How strongly the balls are thrown

//  Colours for ease of use
final int WHITE = 255;
final int BLACK = 0;
final color RED = color(255, 0, 0);
final color GREEN = color(0, 255, 0);
final color BLUE = color(0, 0, 255);

//  Ball sizes on the screen
final int BestBallSize = 8;            
final int NormalBallSize = 4;

final float GravityValue = 0.05;       //  Value of the gravitational force

//  Range of mutation - keep  (MutationSlowdown * MutationBaseRange)  under |0.5|
final float MutationSlowdown = 9;
final float MutationBaseRange = 0.05;  
