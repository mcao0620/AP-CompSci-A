public class Flag{
  int x,y;
  boolean flagged;
  
  public Flag(int xPos, int yPos) {
    x = xPos;
    y = yPos;
  }
  
  public void toggle(){
    // switches between true/false
    if(flagged) {
     flagged = false; 
    }
    else {
      flagged = true;
    }
  }
  
  public void display(){
    // draws a red flag
    fill(255,0,0);
    triangle(x + 20, y + 10, x + 20, y + 30, x + 40, y + 20);
    fill(0);
    line(x + 20, y + 10, x + 20, y + 40);
  }  
  
  // getter methods 
  public boolean getFlagged(){
    return flagged;
  }
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
