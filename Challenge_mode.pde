class Challenge_mode extends Game {
   int level;
   Game cur;
   
   Challenge_mode (Square sq, Triangle[] triangles, Paral pl, int level) { 
       super(sq,triangles,pl);
       this.level = level;
       this.cur = games[level];
   }
   
   void calc_coordinates_intended() {
      cur.calc_coordinates();
   }
   
   void draw_intended() { 
       cur.draw_player();
   }
   
   boolean validate() {
       calc_coordinates_intended();
       calc_coordinates();
       Representation R1 = new Representation(new Game(sq,triangles,pl));
       Representation R2 = new Representation(cur);
       return R2.check(R1);
   }
}
