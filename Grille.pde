class Grille {
  int[][] gr;
  int tailleX, tailleY;
  int[] scores = {0, 40, 100, 300, 1200};
  Forme formeCourante, formeSuivante ;
  public Grille(int x, int y) {
    init(x, y);
  }
  private void init(int x, int y) {
    tailleX=constrain(x, 10, 15);
    tailleY=constrain(y, 22, 25);
    gr = new int[tailleX+4][tailleY+2];
    for (int i=0; i<tailleX+4; i++) {
      gr[i][tailleY]=8;
      gr[i][tailleY+1]=8;
    }
    for (int j=0; j<tailleY+2; j++) {
      gr[0][j]=8;
      gr[1][j]=8;
      gr[tailleX+2][j]=8;
      gr[tailleX+3][j]=8;
    }
    formeCourante = new Forme(0);
    formeCourante.place(tailleX);
    formeSuivante = new Forme(0);
  }
  public void trace() {
    int lgn=0;
    stroke(255);
    for (int y=tailleY-1; y>=0; y--) {
      boolean plein = true ;
      for (int x=2; x<tailleX+2; x++) {
        if (gr[x][y]==0) plein = false ;
        fill(couleurs[constrain(gr[x][y], 0, 7)]);
        rect(x*20, 20+y*20, 20, 20);
      }
      if (plein) {
        for (int i=2; i<tailleX+2; i++) {
          for (int j=y; j>1; j--) {
            gr[i][j]=gr[i][j-1];
          }
          gr[i][0]=0;
        }
        lgn++;
        y++;
      }
    }
    lignes+=lgn;
    score+=(lvl+1)*scores[constrain(lgn, 0, 4)];
    lvl = int(sqrt((lignes-5)/5))-1;
    maxScore=max(score, maxScore);
  }
  public void formesTrace() {
    stroke(255);
    formeCourante.trace(40+20*formeCourante.getPosX(), 20+20*formeCourante.getPosY());
    formeSuivante.trace(320, 200);
  }
  public void gauche() {
    int x = formeCourante.getPosX()-1;
    int y = formeCourante.getPosY();
    bouge(x, y);
  }
  public void droite() {
    int x = formeCourante.getPosX()+1;
    int y = formeCourante.getPosY();
    bouge(x, y);
  }
  public void tourneR() {
    int x = formeCourante.getPosX();
    int y = formeCourante.getPosY();
    formeCourante.rotR();
    if (collision(x, y)) formeCourante.rotL();
  }
  public void tourneL() {
    int x = formeCourante.getPosX();
    int y = formeCourante.getPosY();
    formeCourante.rotL();
    if (collision(x, y)) formeCourante.rotR();
  }
  public boolean bas() {
    int x = formeCourante.getPosX();
    int y = formeCourante.getPosY()+1;
    if (!bouge(x, y)) {
      int c;
      y--;
      for (int i=0; i<formeCourante.getX(); i++)
        for (int j=0; j<formeCourante.getY(); j++) {
          c=formeCourante.getMatrix(i, j);
          if (c!=0) gr[x+i+2][y+j]=c;
        }
      formeCourante=formeSuivante;
      formeCourante.place(tailleX);
      if (collision(formeCourante.getPosX(), formeCourante.getPosY())) {
        ecran=OVER;
        String[] lines =  {maxScore+""};
        saveStrings("highscores.dat", lines);
      }
      formeSuivante = new Forme(0);
      trace();
      formesTrace();
      return false;
    } else return true;
  }
  private boolean bouge(int px, int py) {
    if (!collision(px, py)) {
      formeCourante.setPosXY(px, py);
      return true;
    } else return false;
  }
  private boolean collision(int px, int py) {
    for (int i=0; i<formeCourante.getX(); i++)
      for (int j=0; j<formeCourante.getY(); j++) 
        if ((py+j)>=0) {
          if (px+i+2<tailleX+4 && py+j<tailleY+2) {
            if (gr[px+i+2][py+j]*formeCourante.getMatrix(i, j)!=0) return true;
          } else return true;
        }
    return false;
  }
}