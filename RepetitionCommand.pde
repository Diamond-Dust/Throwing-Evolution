class RepetitionCommand {
 
  Population test;
  Mediums mediums;
  int step = 1;
  float slowdown = 9;    //////  Tightening of mutation rate by step
  
  RepetitionCommand(int size) {
     test = new Population(size); 
     mediums = new Mediums();
     mediums.add(new Medium(200, 1, 400, 799, 0.01));      //////  Here we add Mediums to the field
     mediums.add(new Medium(400, 1, 500, 600, 0.02));
     mediums.add(new Medium(400, 600, 500, 799, 0.03));
     mediums.add(new Medium(500, 1, 600, 750, 0.03));
     mediums.add(new Medium(500, 650, 600, 799, 0.01));
     mediums.add(new Medium(700, 1, 800, 550, 0.02));
     mediums.add(new Medium(700, 650, 850, 799, 0.04));
  }
  
  void commenceThrows() {
    mediums.show();
     if (test.allDotsDead()) 
     {
       print("\n");
       print("\n");
       print(test.gen);
       print(". generation, Mutation rate: ");
       print(0.05/(step/slowdown));
       print("\n");
       
       //genetic algorithm
       test.calculateFitness();
       test.naturalSelection();
       test.Mutate(0.05/(step/slowdown));  //////  Spread of mutation - keep under |0.5|
       step++;
     } 
     else  //if any of the dots are still alive then update and then show them
     {
        test.update(mediums);
        test.show();
     } 
  }
  
}
