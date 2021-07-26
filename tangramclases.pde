import java.io.*;

float epsilon = 0.001;
final float tam = 300;
int menuprincipal = 1;   
PImage img, win;
int playing = 0;
int vel = 200;
int lev = 1;
int flag = 0;
int max_level = 0;
PrintWriter output;

Game[] games = new Game[20];
Challenge_mode cmode;
Free_mode fmode;

void calc_levels(){
   for (int level = 0; level < max_level; ++level) {
      String cur_file = "level_" + String.valueOf(level) + ".txt";
      BufferedReader reader = createReader(cur_file);
      Square sq = new Square();
      Triangle[] triangles = new Triangle[5];
      Paral pl = new Paral();
      for (int j = 0; j < 7; ++j) {
        String []cur;
        try{
         cur = (reader.readLine().split(" "));
        }catch(IOException e){
         e.printStackTrace();
         cur = null;
        }
        if (cur == null) {
         noLoop(); 
        }
        else {
          float rx = float(cur[0]), ry = float(cur[1]);
          int angle_of_r = parseInt(cur[2]);
          int reflected=0;
          if (j == 6) reflected=parseInt(cur[3]);
          if (j == 0) sq = new Square(new Point(rx, ry), tam/(2*sqrt(2)), 255, tam*tam/8, angle_of_r);
          else if (j == 6) pl = new Paral(new Point(rx,ry), tam, 255, tam*tam - tam*tam/2 - tam*tam/4 - tam*tam/8, angle_of_r,reflected);
          else if (j == 1) triangles[j-1] = new Triangle(new Point(rx,ry), tam, 255, tam*tam/4, angle_of_r);
          else if (j == 2) triangles[j-1] = new Triangle(new Point(rx,ry), tam, 255, tam*tam/4, angle_of_r);
          else if (j == 3) triangles[j-1] = new Triangle(new Point(rx,ry), tam/sqrt(2), 255, tam*tam/8, angle_of_r);
          else if (j == 4) triangles[j-1] = new Triangle(new Point(rx,ry), tam/2, 255, tam*tam/16, angle_of_r);
          else triangles[j-1] = new Triangle(new Point(rx,ry), tam/2, 255, tam*tam/16, angle_of_r);
        }
      }
      games[level] = new Game(sq, triangles, pl);
   } 
}

void setup() {
   size(1000,1000);
   frameRate(200);
   img = loadImage("tangr.png");
   win = loadImage("winner.jpg");
   String cur_file;
   BufferedReader reader = createReader("curlevel.txt");
   String[] cur;
   try{
     cur = (reader.readLine().split(" "));
    }catch(IOException e){
     e.printStackTrace();
     cur = null;
    }
    if (cur == null) {
     noLoop(); 
    }
    else{
      max_level = parseInt(cur[0]);
    }
   calc_levels();
}

Game initial_config(){
   Square sq = new Square(new Point(300,300), tam/(2*sqrt(2)), color (144,190,171), tam*tam/8, 0);
   Triangle[] triangles = new Triangle[5];
   Paral pl = new Paral(new Point(300,300), tam, color (0,255,16), tam*tam - tam*tam/2 - tam*tam/4 - tam*tam/8, 0,0);
   triangles[0] = new Triangle(new Point(300,300), tam, color (144,93,171), tam*tam/4, 0);
   triangles[1] = new Triangle(new Point(300,300), tam, color (200,90,171), tam*tam/4, 0);
   triangles[2] = new Triangle(new Point(300,300), tam/sqrt(2), color (144,108,56), tam*tam/8, 0);
   triangles[3] = new Triangle(new Point(300,300), tam/2, color (0,0,255), tam*tam/16, 0);
   triangles[4] = new Triangle(new Point(300,300), tam/2, color (255,0,0), tam*tam/16, 0);
   return new Game(sq, triangles, pl);
}

int yaa = 0;
int yaa2 = 0;
int winning_state = 0;
int chek = 0;

void draw() { 
  calc_levels();
  if (lev == max_level && max_level > 0){
       background(255);
       image(win, 200, 150, 600, 600);
   }
   else{
     if (menuprincipal == 1) {
       playing = 0;
       background(255);
       image(img, 200, 150, 600, 600);
       PFont ff;
       ff = createFont("Arial", 16, true);
       fill(0,255,255);
       textFont(ff, 36);
       noFill();
       rect(550, 550, 320, 100);
       fill(0);
       text("Modo libre", 600,600);
       stroke(0);
       noFill();
       rect(150, 550, 320, 100);
       fill(0);
       text("Modo desafio", 200, 600);
       yaa=0;
       yaa2=0;
     }
     else if(menuprincipal == 0 && lev < max_level){
       playing = 1;
       background(0);
       if (yaa2==0) cmode = new Challenge_mode (initial_config().sq,initial_config().triangles, initial_config().pl, lev);
       yaa2=1;
       PFont ff;
       
       cmode.draw_intended();
       cmode.draw_player();
       ff = createFont("Arial", 16, true);
       fill(0,255,255);
       textFont(ff, 36);
       stroke(0,255,255);
       noFill();
       rect(20, 750, 180, 60);
       fill(0,255,255);
       text("Salir", 50, 800);
       if(chek>0 || winning_state > 0) {
         chek=0;
         if (cmode.validate()==true || winning_state > 0) {
           winning_state=1;
           playing = 0;
           background(0);
           ff = createFont("Arial", 16, true);
           fill(0,255,255);
           textFont(ff, 36);
           text("Felicidades, sos un crack!", 300, 400);
           stroke(0,255,255);
           noFill();
           rect(550, 550, 320, 100);
           fill(0,255,255);
           text("Siguiente nivel", 600,600);
           stroke(0,255,255);
           noFill();
           rect(150, 550, 180, 100);
           fill(0,255,255);
           text("Salir", 200, 600);
           if (menuprincipal>0 || flag > 0) {
             lev++;
             yaa2=0;
             winning_state=0;
           }
           flag=0;
         }
       }
       
       yaa=0;
     }
     else {
        if(yaa==0)
          fmode = new Free_mode(initial_config().sq,initial_config().triangles, initial_config().pl);
        yaa=1;
        yaa2=0;
        background(0);
        fmode.draw_player();
        PFont ff;
        ff = createFont("Arial", 16, true);
        fill(0,255,255);
        textFont(ff, 36);
        stroke(0,255,255);
        noFill();
        rect(20, 750, 180, 60);
        fill(0,255,255);
        text("Salir", 50, 800);
     }
   }
}

void mouseReleased() {
  chek=1;
}

void mouseDragged() {
  if (cmode!=null) {
    if(cmode.sq.relocate(mouseX, mouseY)){}
    else{
     if (cmode.pl.relocate(mouseX, mouseY)){}
     else {
       for (int i = 0; i < 5; ++i) {
        if(cmode.triangles[i].relocate(mouseX, mouseY))break;
       }
     }
    }
  }
  if (fmode!=null){
    if(fmode.sq.relocate(mouseX, mouseY)){}
    else{
     if (fmode.pl.relocate(mouseX, mouseY)){}
     else {
       for (int i = 0; i < 5; ++i) {
        if(fmode.triangles[i].relocate(mouseX, mouseY))break;
       }
     }
    }
  }
}

void mouseClicked() {
    if (playing == 0 && mouseX >= 150 && mouseX <= 150+320 && mouseY >= 550 && mouseY <= 650) {
       if(menuprincipal == 0) menuprincipal = 1;
       else if (menuprincipal == 1) menuprincipal = 0;
    }
    if (playing == 0 && mouseX >= 550 && mouseX <= 550+320 && mouseY >= 550 && mouseY <= 650) {
       if(menuprincipal == 0) flag = 1;
       else if (menuprincipal == 1) menuprincipal = 2;
    }
    if (mouseX >= 20 && mouseX <= 20+180 && mouseY >= 750 && mouseY <= 750+60 && menuprincipal != 1) menuprincipal = 1;
}

void keyPressed() {
   if (key == ' ' && fmode!=null) 
      fmode.export_state();
   if (key == 'r' && cmode!=null) 
      cmode.pl.reflected=1-cmode.pl.reflected;
   if (key == 'r' && fmode!=null)
      fmode.pl.reflected=1-fmode.pl.reflected;
   if (key == CODED && keyCode == RIGHT) {
      if (cmode!=null){if(cmode.sq.increment_angle(mouseX, mouseY, 5)){}
      else {
        if(cmode.pl.increment_angle(mouseX, mouseY, 5)){}
        else {
         for (int i = 0; i < 5; ++i) if(cmode.triangles[i].increment_angle(mouseX, mouseY, 5)) break;
        }
      }}
      if (fmode!=null){if(fmode.sq.increment_angle(mouseX, mouseY, 5)){}
      else {
        if(fmode.pl.increment_angle(mouseX, mouseY, 5)){}
        else {
         for (int i = 0; i < 5; ++i) if(fmode.triangles[i].increment_angle(mouseX, mouseY, 5)) break;
        }
      }}
   }
   else if (key == CODED && keyCode == LEFT) {
      if(cmode!=null){if(cmode.sq.increment_angle(mouseX, mouseY, -5)){}
      else {
        if(cmode.pl.increment_angle(mouseX, mouseY, -5)){}
        else {
         for (int i = 0; i < 5; ++i) if(cmode.triangles[i].increment_angle(mouseX, mouseY, -5)) break;
        }
      }}
      if(fmode!=null){if(fmode.sq.increment_angle(mouseX, mouseY, -5)){}
      else {
        if(fmode.pl.increment_angle(mouseX, mouseY, -5)){}
        else {
         for (int i = 0; i < 5; ++i) if(fmode.triangles[i].increment_angle(mouseX, mouseY, -5)) break;
        }
      }}
   }
}
///then make menu.. then join all(inicializate and implement)
