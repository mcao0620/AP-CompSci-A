public void settings() {
  size(500, 500); 
}

public void setup() {
  background(255, 255, 255);
  noFill();
  for (int i=0; i < 144; i++) {
    if(((double) i / 2.0) % 1.0 == 0) {
    stroke(151,163,253);
    ellipse(250 + 150 * cos((PI/72)*i), 250 - 150 * sin((PI/72)*i), 150, 150); 
    } else {
    stroke(138,208,253);
    }
    ellipse(250 + 150 * cos((PI/72)*i), 250 - 150 * sin((PI/72)*i), 150, 150); 
  }
}
