class Grille {
  int[][] gr;
  int tailleX, tailleY;
  color[] couleurs ={#000000, #FF0000, #00FF00, #FFFF00, #0000FF, #FF00FF, #00FFFF, #FFA000};
  int[] scores = {0, 40, 100, 300, 1200};
  Forme formeCourante, formeSuivante ;
  public Grille(int x, int y) {
    init(x, y);
  }
  private void init(int x, int y) {
    tailleX=constrain(x, 10, 15);
    tailleY=constrain(y, 22, 25);
    gr = new int[tailleX][tailleY+1];
    for (int i=0; i<tailleX; i++) gr[i][tailleY]=8;
    formeCourante = new Forme(0);
    formeCourante.place(tailleX);
    formeSuivante = new Forme(0);
  }
  public void trace() {
    int lignes=0;
    stroke(255);
    for (int y=tailleY-1; y>=0; y--) {
      boolean plein = true ;
      for (int x=0; x<tailleX; x++) {
        if (gr[x][y]==0) plein = false ;
        fill(couleurs[constrain(gr[x][y], 0, 7)]);
        rect(20+x*20, 20+y*20, 20, 20);
      }
      if (plein) {
        for (int i=0; i<tailleX; i++) {
          for (int j=y; j>0; j++) {
            gr[i][j]=gr[i][j-1];
          }
          gr[i][0]=0;
        }
        lignes++;
      }
    }
    int tx, ty;
    for (int y=0; y<formeCourante.getY(); y++) {
      for (int x=0; x<formeCourante.getX(); x++) 
        if (formeCourante.getMatrix(x, y)!=0) {
          tx = x+formeCourante.getPosX();
          ty = y+formeCourante.getPosY();
          if (tx>=0 && tx<tailleX && ty>=0 && ty<=tailleY) {
            fill(couleurs[constrain(formeCourante.getMatrix(x, y), 0, 7)]);
            rect(20+(tx)*20, 20+(ty)*20, 20, 20);
          }
        }
    }
    score+=(lvl+1)*scores[constrain(lignes, 0, 4)];
  }
  public void gauche() {
    int x = max(0, formeCourante.getPosX()-1);
    int y = formeCourante.getPosY();
    bouge(x, y);
  }
  public void droite() {
    int x = min(tailleX-formeCourante.getX(), formeCourante.getPosX()+1);
    int y = formeCourante.getPosY();
    bouge(x, y);
  }
  public void tourne() {
    int x = formeCourante.getPosX();
    int y = formeCourante.getPosY();
    formeCourante.rotMatrix();
    if (collision(x, y)) formeCourante.unRotMatrix();
  }
  public void bas() {
    int x = formeCourante.getPosX();
    int y = formeCourante.getPosY()+1;
    if (!bouge(x, y)) {
      int c;
      y--;
      for (int i=0; i<formeCourante.getX(); i++)
        for (int j=0; j<formeCourante.getY(); j++) {
          c=formeCourante.getMatrix(i, j);
          if (c!=0) gr[x+i][y+j]=c;
        }
      formeCourante=formeSuivante;
      formeCourante.place(tailleX);
      formeSuivante = new Forme(0);
    }
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
          if ((px+i)>=tailleX || (py+j)>=tailleY) return true;
          if (gr[px+i][py+j]*formeCourante.getMatrix(i, j)!=0) return true;
        }
    return false;
  }
}