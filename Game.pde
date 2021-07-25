class Game {
   Square sq;
   Triangle[] triangles;
   Paral pl; 
   
   Game (Square sq, Triangle[] triangles, Paral pl) {
       this.sq = sq;
       this.triangles = triangles;
       this.pl = pl;
   }
   
   void calc_coordinates() {
      sq.coordinates();
      for (int i = 0; i < 5; ++i) {
       triangles[i].coordinates(); triangles[i].rotate_figure();}
      pl.coordinates();
      
      if(pl.reflected>0)pl.reflect();
      sq.rotate_figure();
      pl.rotate_figure();
   }
   
   void draw_player() { 
     calc_coordinates();
     sq.draw_figure();
     for (int i = 0; i < 5; ++i) triangles[i].draw_figure();
     pl.draw_figure();
   }
}
