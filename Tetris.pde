int ecran ; //<>//
final int MENU  = 0 ;
final int JOUE  = 1 ;
final int PAUSE = 2 ;
final int OVER  = 3 ;
final int HELP  = 4 ;

final int VITESSE = 120 ;
final color[] couleurs ={#000000, #FF0000, #00FF00, #FFFF00, #0000FF, #FF00FF, #00FFFF, #FFA000};

int lvl, score, maxScore, lignes, frames ;

Grille grille ;

PFont fTitle, fMain ;

void setup() {
  size(500, 480);
  frameRate(VITESSE);
  fTitle = createFont("Arial Bold", 48, true);
  String[] lines = loadStrings("highscores.dat");
  if (lines==null) {
    lines = new String[1];
    lines[0]="0";
    saveStrings("highscores.dat", lines);
  }
  maxScore = Integer.parseInt(lines[0]);
  grille = new Grille(10, 22);
  ecran = MENU ;
}
void draw() {
  frames = (frames+1)%int(VITESSE/max(1,lvl+1)) ;
  decor();
  switch(ecran) {
  case MENU :
    menu(); 
    break;
  case JOUE :
    joue(); 
    break;
  case PAUSE :
    pause(); 
    break;
  case OVER :
    over(); 
    break;
  case HELP : 
    help();
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
    case 100 :
      grille.gauche();
      break;
    case RIGHT :
    case 99 :
      grille.droite();
      break;
    case 87 :
    case 97 :
      grille.tourneL();
      break;
    case 88 :
    case 105 :
      grille.tourneR();
      break;
    case DOWN :
    case 101 :
      grille.bas();
      break;
    case UP :
    case 104 :
      while (grille.bas()) {
        // nop...
      };
      break;
    default :
      println(keyCode);
    }
    break;
  }
}
public void keyReleased() {
  switch (ecran) {
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
    case "h" :
    case "H" :
      ecran=HELP;
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
  case OVER :
    ecran=MENU;
    break;
  case HELP :
    ecran=JOUE;
    break;
  }
}
void decor() {
  background(0);
  fill(255);
  stroke(255);
  textFont(fTitle, 48);
  textAlign(CENTER);
  text("TETRIS", (width-220)/2+220, 55) ;
  textFont(fTitle, 16);
  text("Score : "+score, (width-220)/2+220, 100);
  text("Lignes : "+lignes, (width-220)/2+220, 130);
  text("Level : "+lvl, (width-220)/2+220, 160);
  text("HighScore : "+maxScore, (width-220)/2+220, 300);
  grille.trace();
}
void menu() {
  textAlign(CENTER);
  textFont(fTitle, 24);
  fill(200, 200, 0);
  noStroke();
  text("S to start", 360, height/2-30);
}
void newGame() {
  score = 0;
  lvl = 0;
  lignes = 0;
  grille = new Grille(10, 22);
  ecran=JOUE;
}
void joue() {
  grille.formesTrace();
  if (frames==0) {
    grille.bas();
  }
}
void pause() {
  grille.formesTrace();
  noStroke();
  fill(16, 224);
  rect(20, height/2-30, width-40, 60);
  fill(255);
  textFont(fTitle, 32);
  textAlign(CENTER);
  text("P A U S E", width/2, height/2+10);
}
void help() {
  grille.formesTrace();
  noStroke();
  fill(16, 232);
  rect(20, 20, width-40, height-40);
  fill(255);
  textFont(fTitle, 48);
  textAlign(CENTER);
  text("A I D E", width/2, 90);
  textFont(fTitle, 18);
  text("[←] et [→] pour déplacer\n[↓] pour descendre plus vite\n[↑] pour descendre d'un coup\n[W] et [X] pour rotation\n\n[P] pour pause\n\n[Q] pour quitter", width/2, 170);
}
void over() {
  noStroke();
  fill(16, 224);
  rect(20, height/2-30, width-40, 60);
  fill(255);
  textFont(fTitle, 32);
  textAlign(CENTER);
  text("GAME OVER !", width/2, height/2+10);
}