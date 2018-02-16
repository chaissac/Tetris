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
    gr = new int[tailleX][tailleY];
    formeCourante = new Forme(0);
    formeCourante.place(tailleX);
    formeSuivante = new Forme(0);
  }
  public int getC(int x, int y) {
    if (x<0 || x>=tailleX || y>=tailleY) return 9;
    if (y<0) return 0;
    return gr[x][y];
  }
  public void setC(int x, int y, int c) {
    if (x>=0 && x<tailleX && y>=0 && y<tailleY) gr[x][y]=c;
  }
  public void trace() {
    int lgn=0;
    stroke(127);  
    for (int y=tailleY-1; y>=0; y--) {
      boolean plein = true ;
      for (int x=0; x<tailleX; x++) {
        fill(couleurs[constrain(getC(x, y), 0, 7)]);
        rect(x*20+40, 20+y*20, 20, 20);
        if (getC(x, y)==0) plein = false ;
        else {
        tint(couleurs[constrain(getC(x, y), 0, 7)]);
        image(carre, x*20+40, 20+y*20, 20, 20);
        }
      }
      if (plein) {
        for (int i=0; i<tailleX; i++) {
          for (int j=y; j>1; j--) {
            setC(i, j, getC(i, j-1));
          }
          setC(i, 0, 0);
        }
        lgn++;
        y++;
      }
    }
    lignes+=lgn;
    score+=(lvl+1)*scores[constrain(lgn, 0, 4)];
    lvl = max(0, round(sqrt((lignes-5)/4))-1);
    maxScore=max(score, maxScore);
  }
  public void formesTrace() {
    stroke(255);
    formeCourante.trace(40+20*formeCourante.getPosX(), 20+20*formeCourante.getPosY());
    formeSuivante.trace(330, 200);
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
          c=formeCourante.getC(i, j);
          if (c!=0) setC(x+i, y+j, c);
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
        if (getC(px+i, py+j)*formeCourante.getC(i, j)!=0) return true;
    return false;
  }
}