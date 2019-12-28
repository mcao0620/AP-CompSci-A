public void settings() {
  size(500, 500); 
}

public void setup() {
  background(255, 255, 255);
  noFill();
  for (int i=0; i < 36; i++) {
    ellipse(250 + 150 * cos((PI/18)*i), 250 - 150 * sin((PI/18)*i), 100, 100); 
  }
}
