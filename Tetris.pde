int ecran ;
final int DEPART = 0 ;
final int MENU  = 1 ;
final int JOUE  = 2 ;
final int PAUSE = 3 ;
final int OVER  = 4 ;

final int VITESSE = 120 ;

int lvl, score, maxScore ;
Grille grille ;

PFont fTitle, fMain ;
int frames ;

void setup() {
  size(500, 480);
  frameRate(VITESSE);
  fTitle = createFont("Arial Bold", 32, true);
  ecran = MENU ;
}
void draw() {
  frames = (frames+1)%VITESSE ;
  switch(ecran) {
  case DEPART :
    depart();
    break;
  case MENU :
    menu();
    break;
  case JOUE :
    joue();
    break;
  case PAUSE :
    //pause();
    break;
  case OVER :
    //over();
    break;
  }
}
public void clavier() {
  if (keyPressed)
    switch (ecran) {
    case JOUE :
      switch (keyCode) {
        case DOWN :
        
        break;
      }
      break;
    }
}
public void keyPressed() {
    switch (ecran) {
    case JOUE :
      switch (keyCode) {
      case LEFT : 
        grille.gauche();
        break;
      case RIGHT :
        grille.droite();
        break;
      case UP :
        grille.tourne();
        break;
      }
      break;
    }
}
public void keyReleased() {
  switch (ecran) {
  case DEPART :
    ecran=MENU;
    break;
  case MENU :
    switch (key+"") {
    case "s" :
    case "S" :
      newGame();
      break;
    }
    break;
  case JOUE :
    switch (key+"") {
    case "P" :
    case "p" :
    case " " :
      ecran=PAUSE;
      break;
    case "q" :
    case "Q" :
      ecran=MENU;
      break;
    }
    break;
  case PAUSE :
    switch (key+"") {
    case "P" :
    case "p" :
    case " " :
      ecran=JOUE;
      break;
    }
    break;
  }
}
void depart() {
  background(0);
  fill(random(255), random(255), random(255));
  stroke(255);
  textAlign(CENTER);
  textFont(fTitle, 64);
  text("TETRIS", width/2, height/2);
  textFont(fTitle, 24);
  fill(200);
  text("press a key to start", width/2, height/2+50);
}
void menu() {
  background(0);
  fill(255, 255, 200);
  stroke(255);
  textFont(fTitle, 48);
  textAlign(CENTER);
  text("TETRIS", width/2, 60) ;
  textFont(fTitle, 24);
  fill(200);
  text("press S to start", width/2, height/2+50);
}
void newGame() {
  score = 0;
  lvl = 0;
  grille = new Grille(10, 22);
  ecran=JOUE;
}
void joue() {
  background(0);
  fill(255);
  stroke(255);
  textFont(fTitle, 48);
  textAlign(CENTER);
  text("TETRIS", (width-220)/2+220, 55) ;
  textFont(fTitle, 16);
  text("Score : "+score, (width-220)/2+220, 100);
  text("Level : "+lvl, (width-220)/2+220, 140);
  if (frames==0) {
      //grille.bas();
      if (keyPressed) if (keyCode==DOWN) grille.bas();
  }
  grille.trace();
}