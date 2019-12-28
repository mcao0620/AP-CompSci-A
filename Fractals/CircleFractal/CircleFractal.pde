float R = 160; 
float G = 40; 
float B = 90; 


public void settings() {
  size(600, 600); 
}

public void setup() {
  fill(R, G, B); 
  stroke(255); 
  
  drawFrac(width/2, height/2, 300); 
}

public void draw() {

}

public void circle(float xLoc, float yLoc, float rad) {
  ellipse(xLoc, yLoc, rad, rad);
}

public void drawFrac(float x, float y, float r) {
  circle(x, y, r); 
  if (r < 1) {
    return; 
  } else {
    drawFrac(x + r/2, y, r/2); 
    drawFrac(x - r/2, y, r/2); 
  }
  
  
}
