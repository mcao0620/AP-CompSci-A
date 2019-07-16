// Created by Michael Cao and Vicky Li
// AP Computer Science A
import processing.sound.*;
public int cols, rows; 
public int numberOfMines; 
private int w; 
public int uncoverCount;
public Cell[][] warZone; 
public boolean gameRunning;
public int win; 
public int time; 
public int startDelay; 
SoundFile flagSound; 
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
  flagSound = new SoundFile(this, "Fart.wav"); 
  clickSound = new SoundFile(this, "MouseClick.mp3"); 
  // makes 2D array board
  warZone = new Cell[cols][rows];
  
 // make cells in each space
 for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      warZone[i][j] = new Cell(i, j, w);
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
  text(numberOfMines - countFlaggies(), 30, 650);   
  Flag flaggyCounter = new Flag(30, 620); 
  flaggyCounter.display();
  
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
        warZone[i][j].display();
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
    warZone[c][r].setMine(true); 
    distribute.remove(index);
  }

   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      warZone[i][j].countSurroundingMines();
    }
  }
 
}

public void gameOver() {
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        // uncovers all cells to show solution
        warZone[i][j].setUncovered(true); 
    }
   }
   // stops game and changes win to -1 to represent losing
   gameRunning = false; 
   win = -1; 
}

public void youWin() {
   for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
        warZone[i][j].setUncovered(true); 
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
  /*
  if(mouseX >= 499 && mouseX <= 589 && mouseY >= 665 && mouseY <= 690){
    reset(); 
  }
  */
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // checks if mouse was located in the cell
      if (warZone[i][j].hover(mouseX, mouseY)) {
        // uncovers cell upon left-click; flag must not be placed in cell
        if (mouseButton == LEFT && warZone[i][j].getFlaggy() == false) {
        warZone[i][j].setUncovered(true);       
        // player wins game once they uncover all cells except for mines
        if (uncoverCount == rows * cols - numberOfMines) {
          youWin();
        }
        // player loses when they uncover a mine
        if (warZone[i][j].getMine() == true) {
         gameOver();
        }
      } else if (mouseButton == RIGHT && warZone[i][j].getUncovered() == false) {
          warZone[i][j].toggleFlaggy(); 
          flagSound.play(); 
        }
      }
    }
  }
}

public int countFlaggies() {
  int flaggyCount = 0; 
  // checks each cell for both whether a flag is placed as well as if it's uncovered or not 
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) { 
      if (warZone[i][j].getFlaggy() == true && warZone[i][j].getUncovered() == false) {
        flaggyCount++; 
      }
    }
  }
      return flaggyCount; 
}
/*
public void reset() {
  gameRunning = true; 
  win = 0;
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) { 
        warZone[i][j].setUncovered(false); 
        warZone[i][j].setMine(false); 
      }
    }
    
  placeMines(); 
  
  }
*/
