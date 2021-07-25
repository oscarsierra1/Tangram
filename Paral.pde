class Paral extends Figure {
  int reflected;
  Paral(){}
  Paral (Point ref, float len, color col, float area,float angle_of_rotation, int reflected) { 
      super(ref, 4, len, col, area,angle_of_rotation); 
      this.reflected=reflected;
   }
   
   void coordinates() {
       coordinates[0] = new Point(ref.x-len/8, ref.y+len/8);
       coordinates[1] = new Point(ref.x-3*len/8, ref.y-len/8);
       coordinates[2] = new Point(ref.x+len/8, ref.y-len/8);
       coordinates[3] = new Point(ref.x+3*len/8, ref.y+len/8);
   }
}
