// Minesweeper

import processing.sound.*;
public int cols, rows; 
public int numberOfMines; 
private int w; 
public int uncoverCount;
public Cell[][] board; 
public boolean gameRunning;
public int win; 
public int time; 
public int startDelay; 
SoundFile clickSound; 

public void settings() {
  size(600, 700); 
}

public void setup() {
  // initialize variables
  w = 50;
  cols = 12; 
  rows = 12; 
  numberOfMines = 20;
  uncoverCount = 0;
  gameRunning = false; 
  win = 0; 
  time = 0; 
  clickSound = new SoundFile(this, "MouseClick.mp3"); 
  // makes 2D array board
  board = new Cell[cols][rows];
  
 // make cells in each space
 for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      board[i][j] = new Cell(i, j, w);
      }
  }
  // place mines randomly
  placeMines();

}

public void draw() {  
  // bottom panel
  fill(0, 200, 220);
  rect(0, 600, 600, 100);
  /*
  //reset button
  fill(0,255,0);
  rect(499,665,90,25);
  fill(0);
  textSize(17);
  text("RESET",544,685);
  */
  // flag counter
  textAlign(CENTER);
  textSize(20);
  fill(0);
  text(numberOfMines - countFlags(), 30, 650);   
  Flag flagCounter = new Flag(30, 620); 
  flagCounter.display();
  
  // start delay for timer
  int tempDelay = millis(); 
  if (gameRunning == false && time == 0) {
    startDelay = tempDelay; 
  }
  // timer
  int tempTime = time; 
  if (gameRunning) {
  time = (millis() - startDelay) / 1000;
  text(time, 545, 650); 
  } else {
  text(tempTime, 545, 650);
  }
  
  // display cells
  for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        board[i][j].display();
    }
  } 
  // win or loss text
  if (win == 1) {
     textAlign(CENTER);
     textSize(40);
     fill(0);
     text("YOU WIN!!", 300, 650);
  } else if (win == -1) {
     textAlign(CENTER);
     textSize(40);
     fill(0);
     text("TRY AGAIN...", 300, 650);
  }
}

public void placeMines() {
    // ArrayList of Arrays to distribute mines 
  ArrayList<int[]> distribute = new ArrayList<int[]>();
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int[] temp = new int[2];
      temp[0] = i;
      temp[1] = j;
      distribute.add(temp);
    }
  }
   // sets a Mine at a given [c,r] coordinate and removes that coordinate from the ArrayList
  for (int k = 0; k < numberOfMines; k++) {
    int index = (int) random(distribute.size()); 
    int[] selection = distribute.get(index); 
    //temp stuff
    int c = selection[0];
    int r = selection[1]; 
    board[c][r].setMine(true); 
    distribute.remove(index);
  }

   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      board[i][j].countSurroundingMines();
    }
  }
 
}

public void gameOver() {
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        // uncovers all cells to show solution
        board[i][j].setUncovered(true); 
    }
   }
   // stops game and changes win to -1 to represent losing
   gameRunning = false; 
   win = -1; 
}

public void youWin() {
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        board[i][j].setUncovered(true); 
    }
   }
   // stops game and changes win to 1 to represent winning
   gameRunning = false; 
   win = 1; 
}

public void mousePressed() { 
  // starts timer upon first click
  if (time == 0) {
    gameRunning = true; 
  }
  if (mouseButton == LEFT) {
    clickSound.play(); 
  }
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // checks if mouse was located in the cell
      if (board[i][j].hover(mouseX, mouseY)) {
        // uncovers cell upon left-click; flag must not be placed in cell
        if (mouseButton == LEFT && board[i][j].getFlaggy() == false) {
        board[i][j].setUncovered(true);       
        // player wins game once they uncover all cells except for mines
        if (uncoverCount == rows * cols - numberOfMines) {
          youWin();
        }
        // player loses when they uncover a mine
        if (board[i][j].getMine() == true) {
         gameOver();
        }
      } else if (mouseButton == RIGHT && board[i][j].getUncovered() == false) {
          board[i][j].toggleFlaggy(); 
        }
      }
    }
  }
}

public int countFlags() {
  int flagCount = 0; 
  // checks each cell for both whether a flag is placed as well as if it's uncovered or not 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) { 
      if (board[i][j].getFlaggy() == true && board[i][j].getUncovered() == false) {
        flagCount++; 
      }
    }
  }
      return flagCount; 
}
