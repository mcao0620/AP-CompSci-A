public class Cell {
  private int whatRow, whatCol; 
  private int x, y; 
  private int w; 
  private int surroundingMines; 
  private boolean isMine; 
  private boolean isUncovered; 
  private Flag flaggy;
  
   public Cell(int c, int r, int w) {
    whatCol = c;
    whatRow = r; 
    this.w = w; 
    x = c * w;
    y = r * w; 
    surroundingMines = 0; 
    isMine = false;
    isUncovered = false; 
    flaggy = new Flag(x, y);
  }
  
  public void display() {
    stroke(0);
    // checkerboard effect
    if ((whatRow + whatCol) % 2 == 0) {
    fill(240);
    rect(x, y, w, w); 
    } else {
    fill(225);
    rect(x, y, w, w);
    }
    // hover effect
    if (hover(mouseX, mouseY)) {
      fill(random(255), random(255), random(255), 200);
      rect(x, y, w, w);
    }
    // places flag
    if(flaggy.getFlagged()){
      flaggy.display();
    }
    // case where player uncovers mine
    if (isUncovered) {
      if (isMine) {
        noStroke();
        fill(100);
        rect(x, y, w, w);
        fill(200, 0, 0);
        ellipse(x + 0.5 * w, y + 0.5 * w, 0.5 * w, 0.5 * w); 
      } else {
        fill (180);
        rect(x, y, w, w);
       // prints number of surrounding mines
        if (surroundingMines > 0) {
          textAlign(CENTER);
          textSize(20);
          fill(0);
          text(surroundingMines, x + 0.5 * w, y + 0.5 * w + 6);
        }
      }
    }
  }
  
  public void countSurroundingMines() {
    if (isMine) {
      surroundingMines = -1;
      return;
    }
    
    int counter = 0; 
    
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        // checks if cells are in bounds
        if (i + whatCol > -1 && i + whatCol < cols && j + whatRow > -1 && j + whatRow < rows) {
          if (board[i + whatCol][j + whatRow].getMine()) {
            counter++;
          }
        }
      }
    }
    surroundingMines = counter; 
  }
  
  public void chainReaction() {
        // uncovers adjacent cells
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
             if (i + whatCol > -1 && i + whatCol < cols && j + whatRow > -1 && j + whatRow < rows) {
                if (board[whatCol + i][whatRow + j].getUncovered() == false) {
                    board[whatCol + i][whatRow + j].setUncovered(true);
                }
        }
      }
    }
  }
   
  public boolean hover(int x, int y) {
    return (this.x > x - w && this.x < x && this.y > y - w && this.y < y);
  }
  
  // setter methods 
  public void toggleFlaggy() {
    flaggy.toggle(); 
  }
  
  public void setMine(boolean b) {
    isMine = b; 
  }
  
  public void setUncovered(boolean b) {
    uncoverCount++;
    isUncovered = b; 
    if (b) {
      if (surroundingMines == 0) {
        chainReaction(); 
      }
    }  
  }
  
  // getter methods
  public boolean getFlaggy() {
    return flaggy.getFlagged(); 
  }
  
    public boolean getMine() {
    return isMine;
  }
  
  public boolean getUncovered() {
    return isUncovered; 
  }
  
  public int getSurroundingMines() {
    return surroundingMines;
  }
  
}
