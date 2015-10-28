Cell[][] board;

int cols = 3;
int rows = 3;
int player = 0; //0 = player1
int win = 0;  // 1 = player1   2 = player2;
int game = 0;  // 1 = game started
int full = 9;

void setup() {
  size(400, 400);
  smooth(); 
  player = (int) random(2);
  board = new Cell[cols][rows];
  
  for (int i = 0; i< cols; i++) {
    for ( int j = 0; j < rows; j++) {
      board[i][j] = new Cell(width/3*i, height/3*j, width/3, height/3);
    }
  }
}
 
void draw() {
  background(0);
  // intro
  if (game == 0) {
    fill(255);
    textSize(20);
    text("Press ENTER to Start", width/2-width/4, height/2);
  }
 
  //game start!
  if (game == 1) {
    checkGame();  // check if  player win
    for (int i = 0; i<cols; i++) { //marca el tablero
      for (int j = 0; j<rows; j++) {
        board[i][j].display();
      }
    }
    //robot player
   if(win == 0 && player == 1){
    
        board[ (int)random(3)][ (int)random(3)].robot_click();
     }  
    
  } 
}
 
//mouse & key functions
void mousePressed() {
  if (game == 1) { //<>//
    if (win == 0 && player == 0) {
      for (int i = 0; i<cols; i++) {

        for (int j = 0; j<rows; j++) {
          board[i][j].click(mouseX, mouseY);
        }
      }
    }
  }
}
 
//no tocar
void keyPressed() {
  if (game == 0) {
    if ( key == ENTER) { //primera vez que se juega
      game =1; //let's play
      full = 9;
    }
  }
  else if (game == 1 && win == 0 && full == 0 ) { //nadie ha ganado
    if ( key == ENTER) {
      game = 0; // start again
      for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          board[i][j].clean();
          win = 0;
          full = 9;
        }
      }
    }
  }
  else if ( game == 1 && (win == 1 || win ==2)) { //alguien gano
    if ( key == ENTER) {
      game = 0; // start again
      for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          board[i][j].clean();
          win = 0;
          full = 9;
        }
      }
    }
  }
}
 
void checkGame() {
  int row = 0;
  //check vertical & horizontal
  for (int col = 0; col< cols; col++) {
    if (board[col][row].checkState() == 1 && board[col][row+1].checkState() == 1 && board[col][row+2].checkState() == 1) {
      //println("vertical 0 win!");
      win = 1;
    }
    else if (board[row][col].checkState() == 1 && board[row+1][col].checkState() == 1 && board[row+2][col].checkState() == 1) {
      //println("Horizontal 0 win!");
      win = 1;
    }
    else if (board[row][col].checkState() == 2 && board[row+1][col].checkState() == 2 && board[row+2][col].checkState() == 2) {
      //println("Horizontal X win!");
      win = 2;
    }
    else if (board[col][row].checkState() == 2 && board[col][row+1].checkState() == 2 && board[col][row+2].checkState() == 2) {
      //println("vertical X win!");
      win = 2;
    }
  }
 
  //check diagonals
  if (board[row][row].checkState() == 1 && board[row+1][row+1].checkState() == 1 && board[row+2][row+2].checkState() == 1) {
    //print(" diagonal 0 O win! ");
    win = 1;
  }
  else if (board[row][row].checkState() == 2 && board[row+1][row+1].checkState() == 2 && board[row+2][row+2].checkState() == 2) {
    //println("diagonal 0 x win!");
    win = 2;
  }
  else if (board[0][row+2].checkState() == 1 && board[1][row+1].checkState() == 1 && board[2][row].checkState() == 1) {
    //println("diagonal 1 O win!");
    win = 1;
  }
  else if (board[0][row+2].checkState() == 2 && board[1][row+1].checkState() == 2 && board[2][row].checkState() == 2) {
    //println("diagonal 1 X win!");
    win = 2;
  }
 
 
  //write text
  fill(255);
  textSize(20);
  for (int i = 0; i<cols; i++) {
    for (int j = 0; j<rows; j++) {
      if ( win == 1) {
        text("Player 1 \n WINS!", board[i][j].checkX()+40, board[i][j].checkY()+50);
      }
      else if ( win == 2) {
        text("Player 2 \n WINS!", board[i][j].checkX()+40, board[i][j].checkY()+50);
      }
    }
  }
 
 
  if (win == 1 || win == 2) {
    fill(0, 255, 0);
    textSize(35);
    text("ENTER to Start Again", width/2-width/2+23, height/2-height/6-20);
  }
 
  if ( win == 0 && full == 0) {  // no win ;(
    fill(0, 255, 0);
    textSize(35);
      text("ENTER to Start Again", width/2-width/2+23, height/2-height/6-20); //<>//
  }
}

//-1 no hay nada
// 0 = O
// 1 = x

int[][] devolverMatriz(){

 int[][] logica = new int[cols][rows]; 
 int estado = 0;
  
   for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          logica[i][j] = -1;
        }
      }
  
  
  for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          estado = board[i][j].state;
          
          if(estado==1){
            logica[i][j] = 0;
          }
          else if(estado==2){
            logica[i][j] = 1;
          
          }
          
        }
      }
  
  return logica;

}

void juego_robot(int[][] logica ){

  int estado = 0;
  
   for (int i = 0; i<cols; i++) {
        for (int j = 0; j<rows; j++) {
          estado =logica[i][j];
          
          if(estado==0){
            logica[i][j] = 0;
          }
          else if(estado==1){
            logica[i][j] = 1;
          
          }
          
        }
      }

}
 
 
 
 
 