class Forme { //<>//
  String tetra = "";
  int x, y, posX, posY, type, tailleX ;
  int[][] matrix ;
  public Forme(int t) {
    if (t==0) t=int(random(7))+1;
    type=t;
    switch(type) {
    case 1 : 
      tetra = "110011"; 
      x=3; 
      y=2 ;
      break; // Z Rouge
    case 2 : 
      tetra = "022220"; 
      x=3; 
      y=2;
      break; // S Vert
    case 3 : 
      tetra = "3333"; 
      x=2; 
      y=2; 
      break; // O Jaune
    case 4 : 
      tetra = "444004"; 
      x=3; 
      y=2;
      break; // J Bleu
    case 5 : 
      tetra = "555050"; 
      x=3; 
      y=2; 
      break; // T Magenta
    case 6 : 
      tetra = "6666"; 
      x=1; 
      y=4 ;
      break; // I Cyan
    case 7 : 
      tetra = "777700"; 
      x=3; 
      y=2; 
      break; // J Orange
    }
    matrix = new int[x][y];
    for (int i=0; i<x; i++)
      for (int j=0; j<y; j++) {
        matrix[i][j]=Integer.parseInt(str(tetra.charAt(i+x*j)));
      }
    println("NEW ! "+type+" : "+x+","+y+" - "+tetra);
  }
  public void place(int tx) {
    tailleX = tx;
    posX = int(tx/2-x/2);
    posY = 8 ;
    println("Placé en "+posX);
  }
  public void rotL() {
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
  public int getMatrix(int i, int j) {
    return matrix[i][j];
  }
  public void rotMatrix() {
    int[][] rot = new int[y][x];
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        rot[y-1-j][i] = matrix[i][j];
      }
    }
    matrix=rot;
    posX+=floor((x-y)/2);
    posY+=floor((y-x)/2);
    int tmp=x; x=y; y=tmp;
  }
  public void unRotMatrix() {
    int[][] rot = new int[y][x];
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        rot[j][x-1-i] = matrix[i][j];
      }
    }
    matrix=rot;
    posX+=floor((x-y)/2);
    posY+=floor((y-x)/2);
    int tmp=x; x=y; y=tmp;
  }
}