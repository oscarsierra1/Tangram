
class Representation {
    Game _g;
    int[][] _pixel = new int[702][602];
    Point origin;
    Representation (Game _g) {
       this._g = _g; 
       float lft = min(_g.sq.min_over_x(), _g.pl.min_over_x());
       float up = min(_g.sq.min_over_y(), _g.pl.min_over_y());
       for (int i = 0; i < 5; ++i) lft = min(lft, _g.triangles[i].min_over_x());
       for (int i = 0; i < 5; ++i) up = min(up, _g.triangles[i].min_over_y());
       origin = new Point(lft, up);
    }
    
    void transform (Point origin) {
      for (int i = 0; i < 700; ++i) {
        for (int j = 0; j < 600; ++j) {
            _pixel[i][j] = 0;
            if (_g.sq.inside(new Point(i,j), origin)) _pixel[i][j] = 1; 
            if (_g.pl.inside(new Point(i,j), origin)) _pixel[i][j] = 1; 
            for (int h = 0; h < 5; ++h) { 
                if (_g.triangles[h].inside(new Point(i,j), origin)) _pixel[i][j] = 1;
                
            }
        }
      }
    }
    
    boolean check(Representation R) { 
      transform(origin);
      R.transform(origin);
      int diff = 0;
      int positions=0;
      for (int i = 0; i < 700; ++i) {
         for (int j = 0; j < 600; ++j) {
            if(_pixel[i][j]==0)continue;
            
            if (_pixel[i][j] != R._pixel[i][j]) {             
               diff++;
            }
            positions++;
         }
      }
      float percent = 100.0-(diff*100.0)/positions;
      println(percent + "% correct");
      if (percent < 98.8) return false;
      return true;
    }
}
