 WhiteBall b = new WhiteBall(60,60);
    Cue c = new Cue(b);
    PVector x = new PVector(220,220);
void setup() {
  size(500,700);
  frameRate(7);
 
}

void draw() {
  b.setPosition(x);
  background(100,200,50);  
  b.render();
  c.render();
  //x.x += 10*Math.random()-5;  x.y += 10*Math.random()-5;
}
void mousePressed(){
  c.setPower();
}
