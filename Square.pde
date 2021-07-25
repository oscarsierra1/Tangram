class Square extends Figure {
   Square(){}
   Square (Point ref, float len, color col, float area, float angle_of_rotation) { 
      super(ref, 4, len, col, area, angle_of_rotation); 
   }
   
   void coordinates() {
      coordinates[0] = new Point(ref.x-len/2, ref.y-len/2);
      coordinates[1] = new Point(ref.x-len/2, ref.y+len/2);
      coordinates[2] = new Point(ref.x+len/2, ref.y+len/2);
      coordinates[3] = new Point(ref.x+len/2, ref.y-len/2);
   }
}  
