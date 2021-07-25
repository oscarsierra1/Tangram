class Figure {
   Point ref;
   int vertices;
   Point[] coordinates;
   float len;
   color col;
   float angle_of_rotation;
   float area;
   
   Figure(){}
   
   Figure (Point ref, int vertices, float len, color col, float area, float angle_of_rotation) {
       this.ref = ref;
       this.vertices = vertices;
       this.len = len;
       this.col = col;
       this.coordinates = new Point[vertices];
       this.angle_of_rotation = angle_of_rotation;
       this.area = area;
   }
   
   void rotate_figure () {
       for (int i = 0; i < vertices; ++i) 
         coordinates[i].rotate_point(radians(angle_of_rotation), ref);
   }
   
   void reflect () {
       for (int i = 0; i < vertices; ++i) coordinates[i].reflect_respect_y (ref.y);
   }
   
   boolean relocate(int x, int y) { 
       if (dist(ref.x, ref.y, x, y) <= 15) {
         ref.x = x;
         ref.y = y;
         return true;
       }
       return false;
   }
   
   void draw_figure () {
       
       stroke(255);
       fill(col);
       beginShape();
       for (int i = 0; i <= vertices; ++i) vertex(coordinates[i % vertices].x, coordinates[i % vertices].y);
       endShape();
       circle(ref.x, ref.y, 12);
   }
   
   boolean inside (Point P, Point origin) {
       Point A = coordinates[0].minus(origin);
       Point B = coordinates[1].minus(origin);
       boolean side = (P.minus(A)).cross(B.minus(A)) <= -epsilon;
       for (int k = 0; k < vertices; ++k) {
         A = coordinates[k].minus(origin);
         B = coordinates[(k+1)%vertices].minus(origin);
         boolean cur = (P.minus(A)).cross(B.minus(A)) <= -epsilon;
         if (cur != side) return false;
       }
       return true;
   }
   
   float min_over_x(){
      float mn = coordinates[0].x;
      for (int i = 1; i < vertices; ++i) mn = min(mn, coordinates[i].x);
      return mn;
   }
   
   float min_over_y(){
      float mn = coordinates[0].y;
      for (int i = 1; i < vertices; ++i) mn = min(mn, coordinates[i].y);
      return mn;
   }
   
   boolean increment_angle(int x, int y, int add) { 
       if (dist(ref.x, ref.y, x, y) <= 15) {
           angle_of_rotation += add;
           return true;
       }  
       return false;
   }
   
   void coordinates() {}
   
}
