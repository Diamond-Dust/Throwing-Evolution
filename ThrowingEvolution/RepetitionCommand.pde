class RepetitionCommand {
 
  Population test;
  Mediums mediums;
  int step = 1;
  float slowdown = MutationSlowdown;    //  Tightening of mutation rate by step
  float baseRange = MutationBaseRange;
  
  RepetitionCommand(int size) {
     test = new Population(size); 
     mediums = new Mediums();
     mediums.add(new Medium(200, 1, 400, ScreenHeight-1, 0.01));      //////  Here we add Mediums to the field
     mediums.add(new Medium(400, 1, 500, 600, 0.02));
     mediums.add(new Medium(400, 600, 500, ScreenHeight-1, 0.03));
     mediums.add(new Medium(500, 1, 600, 750, 0.03));
     mediums.add(new Medium(500, 650, 600, ScreenHeight-1, 0.01));
     mediums.add(new Medium(700, 1, 800, 550, 0.02));
     mediums.add(new Medium(700, 650, 850, ScreenHeight-1, 0.04));
  }
  
  void commenceThrows() {
    mediums.show();
     if (test.allDotsDead()) 
     {
       print("\n\n");
       print(test.gen, ". generation, Mutation range: +/- ");
       print(MutationBaseRange * (slowdown+step) / step   *  180);
       print(" degrees.\n");
       
       //genetic algorithm
       test.calculateFitness();
       test.naturalSelection();
       test.Mutate(MutationBaseRange * (slowdown+step) / step);  //  range of mutation 
       step++;
     } 
     else  //if any of the balls are still alive then update and then show them
     {
        test.update(mediums);
        test.show();
     } 
  }
  
}
