float R = 180; 
float G = 120; 
float B = 210; 

public void settings() {
  size(600, 600); 
}

public void setup() {
  stroke(255); 
  
  drawFrac(300, 300, 288, 108, 5); 
}

public void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

public void drawFrac(float x, float y, float rad1, float rad2, int n) {
  fill(R, G, B); 
  star(x, y, rad1, rad2, n); 
  if (rad1 < 1) {
    return; 
  } else {
    R *= 0.8;
    G *= 0.8;
    B *= 0.8;
    drawFrac(x, y, 3*rad2/8, 3*rad1/8, n); 
  }
  
  
}
