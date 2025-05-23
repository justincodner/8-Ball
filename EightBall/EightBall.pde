 WhiteBall b = new WhiteBall();
    Cue a = new Cue(b);
void setup() {
  size(500,500);
 
}

void draw() {
  background(100,200,50);
  a.render();  
  b.render();
}
