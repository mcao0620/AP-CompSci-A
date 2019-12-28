public void settings() {
  size(500, 500); 
}

public void setup() {
  noStroke(); 
  
  for(int i = 10; i > 0; i-=1) {
    fill(250-(25*i), 0, 0);
    rect(250-(25*i), 250-(25*i), 50*i, 50*i);
  }
}
