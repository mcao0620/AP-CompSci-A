void settings() {
  size(600, 600); 
}

void setup() {
  background(0); 

}

void draw() {
  stroke(0, 255, 0); 
  drawFractal(0, 300, 600, 300); 
}

public void makeBent(float x1, float y1, float x2, float y2) {
  float slope = (y2 - y1) / (x2 - x1); 
  float xAvg = (x2 + x1) / 2; 
  float yAvg = (y2 + y1) / 2; 
  float rootThreeOverTwo = sqrt(3) / 2; 
  float s = ((float) 1/3) * sqrt(pow(y2-y1, 2) + pow(x2-x1, 2)); 
  
  line(x1, y1, (x2 - x1) / 3 + x1, (y2 - y1) / 3 + y1); 
  line(((x2 - x1) / 3) + x1, ((y2 - y1) / 3) + y1, xAvg + s * ((y2 - y1) / (3*s)) * rootThreeOverTwo, yAvg + -1 * ((x2 - x1) / (3*s)) * (rootThreeOverTwo) * s);
  line(xAvg + s * ((y2 - y1) / (3*s)) * rootThreeOverTwo, yAvg + -1 * ((x2 - x1) / (3*s)) * (rootThreeOverTwo) * s, 2 * (x2 - x1) / 3 + x1, 2 * (y2 - y1) / 3 + y1); 
  line(2*(x2 - x1) / 3 + x1, 2*(y2 - y1) / 3 + y1, x2, y2);
  
}

public void drawFractal(float x1, float y1, float x2, float y2) {
  float slope = (y2 - y1) / (x2 - x1); 
  float xAvg = (x2 + x1) / 2; 
  float yAvg = (y2 + y1) / 2; 
  float rootThreeOverTwo = sqrt(3) / 2; 
  float s = ((float) 1/3) * sqrt(pow(y2-y1, 2) + pow(x2-x1, 2)); 
  
  makeBent(x1, y1, x2, y2);
  if (s < 0.1) {
    return; 
  } else {
    drawFractal(x1, y1, (x2 - x1) / 3 + x1, (y2 - y1) / 3 + y1); 
    drawFractal(((x2 - x1) / 3) + x1, ((y2 - y1) / 3) + y1, xAvg + s * ((y2 - y1) / (3*s)) * rootThreeOverTwo, yAvg + -1 * ((x2 - x1) / (3*s)) * (rootThreeOverTwo) * s); 
    drawFractal(xAvg + s * ((y2 - y1) / (3*s)) * rootThreeOverTwo, yAvg + -1 * ((x2 - x1) / (3*s)) * (rootThreeOverTwo) * s, 2 * (x2 - x1) / 3 + x1, 2 * (y2 - y1) / 3 + y1); 
    drawFractal(2*(x2 - x1) / 3 + x1, 2*(y2 - y1) / 3 + y1, x2, y2); 
  }
}
