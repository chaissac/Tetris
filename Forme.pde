class Forme { //<>//
  String tetra = "";
  int x, y, posX, posY, type, tailleX ;
  int[][] matrix ;

  public Forme(int t) {
    if (t==0) t=int(random(7))+1;
    type=t;
    switch(type) {
    case 1 : 
      tetra = "110011000"; 
      x=y=3 ;
      break; // Z Rouge
    case 2 : 
      tetra = "022220000"; 
      x=y=3;
      break; // S Vert
    case 3 : 
      tetra = "3333"; 
      x=y=2; 
      break; // O Jaune
    case 4 : 
      tetra = "400444000"; 
      x=y=3;
      break; // J Bleu
    case 5 : 
      tetra = "050555000"; 
      x=y=3; 
      break; // T Magenta
    case 6 : 
      tetra = "000066660000"; 
      x=4; 
      y=3 ;
      break; // I Cyan
    case 7 : 
      tetra = "007777000"; 
      x=y=3; 
      break; // L Orange
    }
    matrix = new int[x][y];
    for (int i=0; i<x; i++)
      for (int j=0; j<y; j++)
        matrix[i][j]=Integer.parseInt(str(tetra.charAt(i+x*j)));
  }
  public void place(int tx) {
    tailleX = tx;
    posX = int(tx/2-x/2);
    posY = 0 ;
  }
  void trace(int px, int py) {
    int tx, ty, c;
    stroke(200);
    for (int j=0; j<y; j++) {
      for (int i=0; i<x; i++) 
        if (getC(i, j)!=0) {
          tx = i+posX;
          ty = j+posY;
          c=constrain(getC(i, j), 0, 7);
          if (c>0) {
            tint(couleurs[c]);
            image(carre, px+i*20, py+j*20, 20, 20);
          }
        }
    }
  }  
  void contour(int px, int py) {
    int tx, ty, c;
    for (int j=0; j<y; j++) {
      for (int i=0; i<x; i++) 
        if (getC(i, j)!=0) {
          tx = i+posX;
          ty = j+posY;
          c=constrain(getC(i, j), 0, 7);
          if (c>0) {
            fill(couleurs[c], 0);
            stroke(couleurs[c]);
            rect(px+i*20, py+j*20, 20, 20);
          }
        }
    }
  }
  public int getX() {
    return x;
  }
  public int getY() {
    return y;
  }
  public int getPosX() {
    return posX;
  }
  public int getPosY() {
    return posY;
  }
  public void setPosX(int t) {
    posX=t;
  }
  public void setPosY(int t) {
    posY=t;
  }
  public void setPosXY(int i, int j) {
    posX = i;
    posY = j;
  }
  public int getC(int i, int j) {
    return matrix[i][j];
  }
  public void rotR() {
    int[][] rot = new int[y][x];
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        rot[y-1-j][i] = matrix[i][j];
      }
    }
    matrix=rot;
    int tmp=x; 
    x=y; 
    y=tmp;
  }
  public void rotL() {
    int[][] rot = new int[y][x];
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        rot[j][x-1-i] = matrix[i][j];
      }
    }
    matrix=rot;
    int tmp=x; 
    x=y; 
    y=tmp;
  }
}