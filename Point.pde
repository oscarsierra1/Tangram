public class Point {
  float x, y;
  Point(float x, float y) {
     this.x = x;
     this.y = y;
  }
  
  void rotate_point (float alpha, Point ref) {
     x -= ref.x;
     y -= ref.y;
     float aux = x;
     x = ref.x + x * cos(alpha) - y * sin(alpha);
     y = ref.y + y * cos(alpha) + aux * sin(alpha);
  }
  
  void reflect_respect_y (float y) {
      this.y = y - (this.y - y);
  }
  
  Point minus (Point B) {
     return new Point(x - B.x,y-B.y); 
  }
  
  float cross (Point r) {
     return x * r.y - y * r.x; 
  }
}
