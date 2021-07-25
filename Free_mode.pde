
class Free_mode extends Game {
    Free_mode (Square sq, Triangle[] triangles, Paral pl) { 
       super(sq,triangles,pl);
    }
    
    void export_state() {
       int i = max_level;
       String ths = "level_" + String.valueOf(i) + ".txt";
        output = createWriter(ths);
        output.println(sq.ref.x + " " + sq.ref.y + " " + sq.angle_of_rotation);
        for (int j = 0; j < 5; ++j) 
          output.println(triangles[j].ref.x + " " + triangles[j].ref.y + " " + triangles[j].angle_of_rotation);
        output.println(pl.ref.x + " " + pl.ref.y + " " + pl.angle_of_rotation + " " + pl.reflected);
       output.flush();
       output.close();
       max_level++;
        output = createWriter("curlevel.txt");
        output.println(max_level);
        output.flush();
        output.close();    
    }
}
